#Simulation Study #####

library(future)
library(future.apply)
library(MittagLeffleR)
library(dplyr)
library(TLMoments)
library(progress)
library(magrittr)
library(ggplot2)


plan(multiprocess)

tails <-seq(0.2,0.9,0.1)
scales <- 1
ns <-c(25,100,200)
m<-5000

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
  l<-c(tail_est,scale_est)
  return(l)
}



pb <- progress_bar$new(total = length(tails)*length(scales)*length(ns), format = "[:bar] tail: :tail, scale: :scale, n: :n")

estimates <- sapply(ns, function(n) sapply(tails, function(tail) sapply(scales, function(scale) {
  pb$tick(tokens = list(tail = tail, scale = scale, n = n))
  future_replicate(m, {


    x <- rml(n, tail = tail, scale = scale)
    cbind(
      logMom = MittagLeffleR::logMomentEstimator(x)[c(1,2)],
      ML = MittagLeffleR::mlmle(x)$par,
      hill = hill_scaletail(k=n-1,data=x)
    )

  })
}, simplify = "array"), simplify = "array"), simplify = "array")

save(estimates,file="estimates.RData")

reshape2::melt(estimates) %>%
  as.tbl %>%
  rename(param = Var1, method = Var2, rep = Var3, true.scale = Var4, true.tail = Var5, n = Var6) %>%
  mutate(true.scale = scales[true.scale], true.tail = tails[true.tail], n = ns[n]) %>%
  mutate(true.value = case_when(param == "tail" ~ true.tail, param == "scale" ~ true.scale)) %>%
  group_by(param, n, true.scale, true.tail, method) %>%
  summarise(
    rmse = sqrt(mean((value-true.value)^2)),
    bias = mean(value-true.value),
    var = var(value)
  ) ->
  tbl_ML_estim

save(tbl_ML_estim,file="tbl_ML_estim.RData")

# RMSE

tbl_ML_estim %>%
  ggplot(aes(true.tail,rmse, colour = method)) +
  geom_line() + geom_point() +
  facet_grid(param ~ n, scales = "free_y") +
  scale_colour_brewer("method", palette = "Set1")
