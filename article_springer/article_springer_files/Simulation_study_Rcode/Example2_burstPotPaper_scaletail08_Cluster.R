#Simulationsstudy - Comparisions of Inference procedure and different estimation methods

# Author: Katharina Hees
# Created: 03/12/2018


library("CTRE")
library("MittagLeffleR")
library("magrittr")
library("dplyr")
library("ggplot2")
library("parallel")
library("ReIns")


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

###################################################

#Example One  - CTRE with Pareto distributed waiting times - tail=0.8
#1_1
n<-10000
tail<-0.8
C<-(1/gamma(1-tail))^{1/tail}
times<-cumsum(rpareto(n,shape=tail,scale=C))
magnitudes<-extRemes::revd(n, scale = 1, shape = 0)
sim_ctre<-ctre(data.frame(times, magnitudes))

ntasks <- 4
print(ntasks)

# Cluster initialisieren
cl <- makeCluster(ntasks)
clusterExport(cl, "sim_ctre")
clusterExport(cl, "hill_estim")
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
  cbind(
    logMoms=logMomentEstimator(ias)[c(1,2)],
    mles=mlmle(ias)$par[c(1,2)],
    hill_times=c(hill_estim(k=k,data=times),NA)
  )},simplify = "array")

stopCluster(cl = cl)


save(estimates_scaletail08, file=here("article_springer","article_springer_files","Simulation_results",paste("estimates_Example2_Pareto_scaletail08_", p, ".RData", sep="")))


#############################################################################################################
#############################################################################################################
#write simulation results in one tibble

n<-10000
ks<-30:500
for (i in 1:100){
  load(paste0("estimates_scaletail08_",i,".RData"))
  estimates_scaletail08[2,,]<-sapply(ks,function(k){estimates_scaletail08[2,,k-29]*(k/n)^{1/0.8}/(1/gamma(0.2))^{1/0.8}*1/(gamma(0.2))})
  estimates_scaletail08<-reshape2::melt(estimates_scaletail08) %>% as.tbl %>% rename(param = Var1 ,method = Var2, k=Var3) %>% mutate(k = ks[k]) %>% group_by(k,param,method)
  estimates_scaletail08<-mutate(estimates_scaletail08,rep=i)
  assign(paste0("estimates_scaletail08_",i),estimates_scaletail08)

}

tbl_estimates_scaletail08<-estimates_scaletail08_1
for(i in 2:100){
  estimates_scaletail08<-get(paste0("estimates_scaletail08_",i))
  tbl_estimates_scaletail08<-bind_rows(tbl_estimates_scaletail08,estimates_scaletail08)
}

saveRDS(tbl_estimates_scaletail08, file="tbl_estimates_scaletail08_Ex2.rds")



#Tail Parameter

#logMoms
tbl_estimates_scaletail08 %>% filter(param=="tail") %>% filter(method=="logMoms") -> tbl_estimates_Ex2_Pareto_tail08_logMoms
tbl_estimates_Ex2_Pareto_tail08_logMoms %>% summarise(mw = mean(value)) ->means.tbl_logMoms_Ex2

#mles
tbl_estimates_scaletail08 %>% filter(param=="tail") %>% filter(method=="mles") -> tbl_estimates_Ex2_Pareto_tail08_mles
tbl_estimates_Ex2_Pareto_tail08_mles %>% summarise(mw = mean(value)) -> means.tbl_mles_Ex2

#hill
tbl_estimates_scaletail08 %>% filter(param=="tail") %>% filter(method=="hill_times") -> tbl_estimates_Ex2_Pareto_tail08_hill_times
tbl_estimates_Ex2_Pareto_tail08_hill_times %>% summarise(mw = mean(value)) -> means.tbl_hill_times_Ex2

save(tbl_estimates_Ex2_Pareto_tail08_logMoms, file=here("article_springer","article_springer_files","Simulation_results","tbl_estimates_Ex2_Pareto_tail08_logMoms.RData"))
save(tbl_estimates_Ex2_Pareto_tail08_mles, file=here("article_springer","article_springer_files","Simulation_results","tbl_estimates_Ex2_Pareto_tail08_mles.RData"))
save(tbl_estimates_Ex2_Pareto_tail08_hill_times, file=here("article_springer","article_springer_files","Simulation_results","tbl_estimates_Ex2_Pareto_tail08_hill_times.RData"))
save(means.tbl_logMoms_Ex2, file=here("article_springer","article_springer_files","Simulation_results","means.tbl_logMoms_Ex2.RData"))
save(means.tbl_mles_Ex2, file=here("article_springer","article_springer_files","Simulation_results","means.tbl_mles_Ex2.RData"))
save(means.tbl_hill_times_Ex2, file=here("article_springer","article_springer_files","Simulation_results","means.tbl_hill_times_Ex2.RData"))

#Scale Parameter

#logMoms
tbl_estimates_scaletail08 %>% filter(param=="scale") %>% filter(method=="logMoms") -> tbl_scales_logMoms_Ex2
means.tbl %>% filter(param=="scale") %>% filter(method=="logMoms") -> means.tbl_scales_logMoms_Ex2
save(tbl_scales_logMoms_Ex2, file=here("article_springer","article_springer_files","Simulation_results","tbl_scales_logMoms_Ex2.RData"))
save(means.tbl_scales_logMoms_Ex2, file=here("article_springer","article_springer_files","Simulation_results","means.tbl_scales_logMoms_Ex2.RData"))

#mles
tbl_estimates_scaletail08 %>% filter(param=="scale") %>% filter(method=="mles") -> tbl_scales_mles_Ex2
means.tbl %>% filter(param=="scale") %>% filter(method=="mles") -> means.tbl_scales_mles_Ex2
save(tbl_scales_mles_Ex2, file=here("article_springer","article_springer_files","Simulation_results","tbl_scales_mles_Ex2.RData"))
save(means.tbl_scales_mles_Ex2, file=here("article_springer","article_springer_files","Simulation_results","means.tbl_scales_mles_Ex2.RData"))

