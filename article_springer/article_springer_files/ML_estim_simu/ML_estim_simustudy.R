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

tails <-0.2# c(0.2,0.8) #seq(0.2,0.9,0.1)
scales <- 1 #c(0.1,1,10)
ns <-25# seq(25,200,25)
m<-1000

pb <- progress_bar$new(total = length(tails)*length(scales)*length(ns), format = "[:bar] tail: :tail, scale: :scale, n: :n")

estimates <- sapply(ns, function(n) sapply(tails, function(tail) sapply(scales, function(scale) {
  pb$tick(tokens = list(tail = tail, scale = scale, n = n))
  future_replicate(m, {


    x <- rml(n, tail = tail, scale = scale)
    cbind(
      logMom = MittagLeffleR::logMomentEstimator(x)[c(1,2)],
      ML = MittagLeffleR::mlmle(x)$par
    )

  })
}, simplify = "array"), simplify = "array"), simplify = "array")


reshape2::melt(estimates) %>%
  as.tbl %>%
  rename(param = Var1, method = Var2, rep = Var3, true.scale = Var4, true.tail = Var5, n = Var6) %>%
  mutate(true.scale = scales[true.scale], true.tail = tails[true.tail], n = ns[n]) %>%
  mutate(true.value = case_when(param == "tail" ~ true.tail, param == "scale" ~ true.scale)) %>%
  group_by(param, n, true.scale, true.tail, method) %>%
  summarise(
    mse = mean((value-true.value)^2),
    sqbias = mean(value-true.value)^2,
    var = var(value)
  ) ->
  tbl_ML_estim

save(tbl_ML_estim,file="tbl_ML_estim.RData")
