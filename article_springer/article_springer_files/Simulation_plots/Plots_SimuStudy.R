library(ggplot2)
library(gridExtra)
library(here)

path<-here("article_springer/article_springer_files/Simulation_results")
files<-list.files(path)
file_dirs<-paste(path,"/",files,sep="")
lapply(file_dirs,FUN=load,.GlobalEnv)

#Tail Parameter

# Example One

#logMoment estimator
logMom_Ex1_tail<-ggplot()+ geom_line(aes(x=k,y=value,group=rep),colour="lightgrey",data=tbl_estimates_tail08_logMoms_Ex1) +
  coord_cartesian(ylim = c(0.5, 1.5)) +
  geom_line(aes(x=k, y=mw),colour="black",data=means.tbl_logMoms_Ex1) + ylab("Estimated tail") + geom_hline(yintercept=0.8, linetype="dashed", color = "red")

#ml estimator
mle_Ex1_tail<-ggplot() + geom_line(aes(x=k,y=value,group=rep),colour="lightgrey",data=tbl_estimates_tail08_mles_Ex1) +
  coord_cartesian(ylim = c(0.5, 1.5)) +
  geom_line(aes(x=k, y=mw),colour="black",data=means.tbl_mles_Ex1) + ylab("Estimated tail") + geom_hline(yintercept=0.8, linetype="dashed", color = "red")

#Hill estimator
hill_Ex1_tail<-ggplot()+ geom_line(data=tbl_estimates_tail08_hill_Ex1,aes(x=k,y=value,group=rep),colour="lightgrey") +
  coord_cartesian(ylim = c(0.5, 1.5)) +
  geom_line(data=means.tbl_hill_Ex1,aes(x=k, y=mw),colour="black") + ylab("Estimated tail") +  geom_hline(yintercept=0.8, linetype="dashed", color = "red")


#Example Two

#logMoment estimator
logMom_Ex2_tail<-ggplot()+ geom_line(aes(x=k,y=value,group=rep),colour="lightgrey",data=tbl_estimates_Ex2_Pareto_tail08_logMoms) +
  coord_cartesian(ylim = c(0.5, 1.5)) +
  geom_line(aes(x=k, y=mw),colour="black",data=means.tbl_logMoms_Ex2) + ylab("Estimated tail") + geom_hline(yintercept=0.8, linetype="dashed", color = "red")

#ml estimator
mle_Ex2_tail<-ggplot() + geom_line(aes(x=k,y=value,group=rep),colour="lightgrey",data=tbl_estimates_Ex2_Pareto_tail08_mles) +
  coord_cartesian(ylim = c(0.5, 1.5)) +
  geom_line(aes(x=k, y=mw),colour="black",data=means.tbl_mles_Ex2) + ylab("Estimated tail") + geom_hline(yintercept=0.8, linetype="dashed", color = "red")

#Hill estimator
hill_Ex2_tail<-ggplot() + geom_line(aes(x=k,y=value,group=rep),colour="lightgrey",data=tbl_estimates_Ex2_Pareto_tail08_hill_times) +
  coord_cartesian(ylim = c(0.5, 1.5)) +
  geom_line(aes(x=k, y=mw),colour="black",data=means.tbl_hill_times_Ex2) + ylab("Estimated tail") +  geom_hline(yintercept=0.8, linetype="dashed", color = "red")

#Example Three

#logMoment estimator
logMom_Ex3_tail<-ggplot()+ geom_line(aes(x=k,y=value,group=rep),colour="lightgrey",data=tbl_estimates_Example3_Exp_logMoms) +
  coord_cartesian(ylim = c(0.5, 1.5)) +
  geom_line(aes(x=k, y=mw),colour="black",data=means.tbl_logMoms_Ex3) + ylab("Estimated tail") + geom_hline(yintercept=1, linetype="dashed", color = "red")

#ml estimator
mle_Ex3_tail<-ggplot() + geom_line(aes(x=k,y=value,group=rep),colour="lightgrey",data=tbl_estimates_Example3_Exp_mles) +
  coord_cartesian(ylim = c(0.5, 1.5)) +
  geom_line(aes(x=k, y=mw),colour="black",data=means.tbl_mles_Ex3) + ylab("Estimated tail") + geom_hline(yintercept=1, linetype="dashed", color = "red")

#Hill estimator
hill_Ex3_tail<-ggplot() + geom_line(aes(x=k,y=value,group=rep),colour="lightgrey",data=tbl_estimates_Example3_Exp_hill_times) +
  coord_cartesian(ylim = c(0.5, 10)) +
  geom_line(aes(x=k, y=mw),colour="black",data=means.tbl_hill_times_Ex3) + ylab("Estimated tail") + geom_hline(yintercept=1, linetype="dashed", color = "red")

grid.arrange(logMom_Ex1_tail,mle_Ex1_tail,hill_Ex1_tail,logMom_Ex2_tail,mle_Ex2_tail,hill_Ex2_tail,logMom_Ex3_tail,mle_Ex3_tail,hill_Ex3_tail,ncol=3)

#Scale Parameter

#Example One
logMom_Ex1_scale<-ggplot()+ geom_line(aes(x=k,y=value,group=rep),colour="lightgrey",data=tbl_scales_logMoms_Ex1) +
  coord_cartesian(ylim = c(0, 2)) +
  geom_line(aes(x=k, y=mw),colour="black",means.tbl_scales_logMoms_Ex1) + ylab("Estimated scale") + geom_hline(yintercept=1, linetype="dashed", color = "red")

mle_Ex1_scale<-ggplot()+ geom_line(aes(x=k,y=value,group=rep),colour="lightgrey",data=tbl_scales_mles_Ex1) +
  coord_cartesian(ylim = c(0, 2)) +
  geom_line(aes(x=k, y=mw),colour="black",data=means.tbl_scales_mles_Ex1) + ylab("Estimated scale") + geom_hline(yintercept=1, linetype="dashed", color = "red")

#Example Two

logMom_Ex2_scale<-ggplot()+ geom_line(aes(x=k,y=value,group=rep),colour="lightgrey",data=tbl_scales_logMoms_Ex2) +
  coord_cartesian(ylim = c(0, 2)) +
  geom_line(aes(x=k, y=mw),colour="black",means.tbl_scales_logMoms_Ex2) + ylab("Estimated scale") + geom_hline(yintercept=1, linetype="dashed", color = "red")

mle_Ex2_scale<-ggplot()+ geom_line(aes(x=k,y=value,group=rep),colour="lightgrey",data=tbl_scales_mles_Ex2) +
  coord_cartesian(ylim = c(0, 2)) +
  geom_line(aes(x=k, y=mw),colour="black",data=means.tbl_scales_mles_Ex2) + ylab("Estimated scale") + geom_hline(yintercept=1, linetype="dashed", color = "red")

#Example Three

logMom_Ex3_scale<-ggplot()+ geom_line(aes(x=k,y=value,group=rep),colour="lightgrey",data=tbl_scales_logMoms_Ex3) +
  coord_cartesian(ylim = c(0, 2)) +
  geom_line(aes(x=k, y=mw),colour="black",means.tbl_scales_logMoms_Ex3) + ylab("Estimated scale") + geom_hline(yintercept=1, linetype="dashed", color = "red")

mle_Ex3_scale<-ggplot()+ geom_line(aes(x=k,y=value,group=rep),colour="lightgrey",data=tbl_scales_mles_Ex3) +
  coord_cartesian(ylim = c(0, 2)) +
  geom_line(aes(x=k, y=mw),colour="black",data=means.tbl_scales_mles_Ex3) + ylab("Estimated scale") + geom_hline(yintercept=1, linetype="dashed", color = "red")

grid.arrange(logMom_Ex1_scale,mle_Ex1_scale,logMom_Ex2_scale,mle_Ex2_scale,logMom_Ex3_scale,mle_Ex3_scale,ncol=2)
