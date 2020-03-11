#Simulationsstudy - Comparisions of Inference procedure and different estimation methods

# Author: Katharina Hees
# Created: 01/03/2020

library("CTRE")
library("MittagLeffleR")
library("magrittr")
library("dplyr")
library("ggplot2")
library("parallel")
library(here)


p <- as.integer(Sys.getenv("PBS_ARRAYID"))
print(p)

###Functions########################################

hill_estim<-function(k,data){
  n<-length(data)
  data<-sort(data)
  data_thinned<-data[(n-k):n]
  r<-1/k * sum(log(data_thinned/data_thinned[1]))
  return(1/r)
}

hill_scaletail<-function(k,data){
  n<-length(data)
  data<-sort(data)
  tail_est<-hill_estim(k,data)
  scale_est<-k*data[n-k]^{tail_est}/n
  l<-list(tail=tail_est,scale=scale_est)
  return(l)
}

####################################################

#Example One  - CTRE with stable distributed waiting times - tail=0.8

n<-10000
tail<-0.8
sigma <- (cos(pi*tail/2))^(1/tail)

times<-stabledist::rstable(n,tail, 1, sigma, pm=1)
times_sum <- cumsum(times)
magnitudes <- extRemes::revd(n, scale = 1, shape = 0)
sim_ctre <- ctre(data.frame(times_sum, magnitudes))

ntasks <- 4
print(ntasks)

# Initialize Cluster
cl <- makeCluster(ntasks)
clusterExport(cl, "sim_ctre")
clusterExport(cl, "times")
clusterExport(cl, "hill_estim")
clusterExport(cl, "hill_scaletail")
clusterEvalQ(cl,library(MittagLeffleR))
clusterEvalQ(cl,library(CTRE))
clusterEvalQ(cl,library("magrittr"))

# Zufallszahlengeneratoren auf allen Workern des Clusters mit einem bestimmten
# seed initialisieren (verhindert Zyklen in den Zufallszahlen zwischen den
# Workern)
clusterSetRNGStream(cl,iseed=42)

#Code
ks<-c(30:500)
estimates_scaletail08<-parSapply(cl,ks, FUN = function(k){
  ias<-sim_ctre %>% thin(k=k) %>% interarrival
    hill_times=hill_scaletail(k=k,data=times)
  },simplify = "array")

stopCluster(cl = cl)


save(estimates_scaletail08, file=paste("estimates_scaletail08_", p, ".RData", sep=""))


#write simulation results in one tibble

n<-10000
ks<-30:500
for (i in 1:100){
  load(here("article_springer","article_springer_files","Hill_Scale",paste0("estimates_scaletail08_",i,".RData")))
  estimates_scaletail08<-as.data.frame(matrix(unlist(estimates_scaletail08),ncol=2,byrow=TRUE))
  estimates_scaletail08<-cbind(estimates_scaletail08,ks)
  colnames(estimates_scaletail08)<-c("tail","scale","k")
  estimates_scaletail08[,2]<-sapply(ks,function(k){estimates_scaletail08[k-29,2]*(k/n)^{1/0.8}})
  estimates_scaletail08<-reshape2::melt(estimates_scaletail08,id.vars=c("k")) %>% as.tbl %>% rename(k=k, param = variable) %>% group_by(k,param)
  estimates_scaletail08<-mutate(estimates_scaletail08,rep=i)
  assign(paste0("estimates_scaletail08_",i),estimates_scaletail08)
}

tbl_estimates_scaletail08<-estimates_scaletail08_1
for(i in 2:100){
  estimates_scaletail08<-get(paste0("estimates_scaletail08_",i))
  tbl_estimates_scaletail08<-bind_rows(tbl_estimates_scaletail08,estimates_scaletail08)
}

save(tbl_estimates_scaletail08, file=here("article_springer","article_springer_files","Hill_Scale",paste("tbl_estimates_scaletail08_Ex1_Hill_",".RData", sep="")))
load("tbl_estimates_scaletail08_Ex1_Hill_.RData")

#Hill estimator tail
tbl_estimates_scaletail08 %>% summarise(mw = mean(value)) -> means.tbl_estimates_scaletail08

ggplot()+ geom_line(data=tbl_estimates_scaletail08 %>% filter(param == "tail"),aes(x=k,y=value,group=rep),colour="lightgrey") +
  coord_cartesian(ylim = c(0.5, 1.5)) +
  geom_line(data=means.tbl_estimates_scaletail08 %>% filter(param == "tail"),aes(x=k, y=mw),colour="black") + ylab("Estimated tail") +  geom_hline(yintercept=0.8, linetype="dashed", color = "red")


#Hill estimator scale

ggplot()+ geom_line(data=tbl_estimates_scaletail08 %>% filter(param == "scale"),aes(x=k,y=value,group=rep),colour="lightgrey") +
  coord_cartesian(ylim = c(0,0.01)) +
  geom_line(data=means.tbl_estimates_scaletail08 %>% filter(param == "scale"),aes(x=k, y=mw),colour="black") + ylab("Estimated tail") +  geom_hline(yintercept=1, linetype="dashed", color = "red")
