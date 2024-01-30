# Monte Carlo - Coun-data
library(ANOVABNPTestR)
library(ggplot2)
library(MASS) # negative binomial regression
source("extra/rberpo.R")
source("extra/dberpo.R")

# Design of the experiment
# Two factor with two levels
r1 <- 48  # factor 1 level 1
r2 <- 48 # factor 1 level 2
r3 <- 48  # factor 2 level 1
r4 <- 48  # factor 2 level 2
n <- r1 + r2 + r3 + r4

f1 <- as.factor(c(rep(1, r1), rep(1, r2), rep(2, r3), rep(2, r4)))
f2 <- as.factor(c(rep(1, r1), rep(2, r2), rep(1, r3), rep(2, r4)))
Xmat <- cbind(as.integer(f1), as.integer(f2))
group <-
  as.factor(
    (f1 == 1 & f2 == 1) * 1 +
    (f1 == 1 & f2 == 2) * 2 +
    (f1 == 2 & f2 == 1) * 3 +
    (f1 == 2 & f2 == 2) * 4
  )

# Simulation of the data
comp <- seq(1, 2)
nm <- 100
alpha <- 0.05
count_simple_f1 <- 0
count_simple_f2 <- 0
count_inter <- 0
f_sum <- 0
count_f1_pois <- 0
count_f2_pois <- 0
count_f1f2_pois <- 0
count_f1_nb <- 0
count_f2_nb <- 0
count_f1f2_nb <- 0


for( k in 1: nm) {
  # Experiment (1,1)_1
  y1 <- rberpo(n = r1, phi = 0.5, lambda = 0.5)

  # Experiment (1,2)_2
  y2 <- rberpo(n = r1, phi = 0.5, lambda = 1.0)

  # Experiment (2,1)_3
  y3 <- rberpo(n = r1, phi = 0.5, lambda = 1.5)

  # Experiment (2,2)_4
  y4 <- rberpo(n = r1, phi = 0.5, lambda = 2.0)

  # Fitting our model
  Y <- as.integer(c(y1, y2, y3, y4))
  data <- data.frame(Y, f1, f2, group)
  lb <- as.integer(0)
  ub <- as.integer(25)
  a1 <- as.numeric(round(mean(Y),0))  # solo acepta valores enteros, debería aceptar Float 64
  b1 <- as.numeric(1.0) # solo acepta valores enteros, debería aceptar Float 64

  fit <-
    anova_bnp_berpoi(
      Y,
      Xmat,
      iter = 10000L,
      warmup = 2000L,
      rho = 1.0,
      a = 0.1,
      b = 0.1,
      a1 = a1,
      b1 = b1,
      alpha0 = 1.0,
      beta0 = 1.0,
      lb = lb,
      ub = ub
    )
  f_pred <- fit$f_post
  simple <- hypothesis_post_simple(fit)
  inter <- hypothesis_post_interaction(fit)
  count_simple_f1 <- count_simple_f1 + (simple[1,2] > 0.5) * 1
  count_simple_f2 <- count_simple_f2 + (simple[2,2] > 0.5) * 1
  count_inter <- count_inter + (inter[1,3] > 0.5) * 1
  f_sum <- f_sum + f_pred$f

  # classical models
  # Poisson regression
  fit_glm1 <- summary(glm(Y ~ f1 * f2, data = data, family = poisson()))$coeff
  count_f1_pois <- count_f1_pois + (fit_glm1[2,4] <= alpha) * 1
  count_f2_pois <- count_f2_pois + (fit_glm1[3,4] <= alpha) * 1
  count_f1f2_pois <- count_f1f2_pois + (fit_glm1[4,4] <= alpha) * 1

  # Negative binomial regression
  fit_glm2 <- summary(glm.nb(Y ~ f1 + f2 + f1 * f2, data = data))$coeff
  count_f1_nb <- count_f1_nb + (fit_glm2[2, 4] <= alpha) * 1
  count_f2_nb <- count_f2_nb + (fit_glm2[3, 4] <= alpha) * 1
  count_f1f2_nb <- count_f1f2_nb + (fit_glm2[4, 4] <= alpha) * 1
  print(k)
}

f_mean <- f_sum / nm
pred_mc <- data.frame(group = f_pred$group, y = f_pred$y, fy = f_mean)
#pdf(file=paste0("pred_size_",r1,".pdf"))
#plot(pred_mc$y[pred_mc$group == 1], pred_mc$fy[pred_mc$group==1], pch = 20, col=1, ylim=c(0,0.2), xlab = "y", ylab="pmf")
#lines(pred_mc$y[pred_mc$group == 1], pred_mc$fy[pred_mc$group==1], lty=1)
#points(pred_mc$y[pred_mc$group == 2], pred_mc$fy[pred_mc$group==2], pch = 20, col=2)
#lines(pred_mc$y[pred_mc$group == 2], pred_mc$fy[pred_mc$group==2], lty=1, col=2)
#points(pred_mc$y[pred_mc$group == 3], pred_mc$fy[pred_mc$group==3], pch = 20, col=3)
#lines(pred_mc$y[pred_mc$group == 3], pred_mc$fy[pred_mc$group==3], lty=1, col=3)
#points(pred_mc$y[pred_mc$group == 4], pred_mc$fy[pred_mc$group==4], pch = 20, col=4)
#lines(pred_mc$y[pred_mc$group == 4], pred_mc$fy[pred_mc$group==4], lty=1, col=4)
#legend(17,0.2, legend=c("E = (1,1)", "E = (1,2)", "E = (2,1)", "E = (2,2)"), lty = rep(1,4), col=c(1,2,3,4))
#dev.off()

names <- c("Q1", "Q2", "Q1Q2")
freq_bnp <- c(count_simple_f1, count_simple_f2, count_inter)
freq_pois <- c(count_f1_pois, count_f2_pois, count_f1f2_pois)
freq_nb <- c(count_f1_nb, count_f2_nb, count_f1f2_nb)


mc_result <- data.frame(names, freq_bnp, freq_pois, freq_nb)

write.table(x = mc_result, file=paste0("mc_size_", r1, ".csv"), row.names = FALSE,  sep=",")

# True pmf
grid <- seq(0, max(Y) + 3, 1)
pmf1 <- dberpo(x = grid, phi = 0.5, lambda = 0.5)
pmf2 <- dberpo(x = grid, phi = 0.5, lambda = 1.0)
pmf3 <- dberpo(x = grid, phi = 0.5, lambda = 1.5)
pmf4 <- dberpo(x = grid, phi = 0.5, lambda = 2.0)


pdf(file=paste0("pred_size_",r1,".pdf"))
plot(grid, pmf1, pch = 20, col = 1, ylim = c(0,0.8), xlab = "y", ylab="pmf")
lines(grid, pmf1, lty=1, col=1, lwd = 1.5)
points(grid, pmf2, pch = 20, col = 2)
lines(grid, pmf2, lty=1, col=2, lwd = 1.5)
points(grid, pmf3, pch = 20, col = 3)
lines(grid, pmf3, lty=1, col=3, lwd = 1.5)
points(grid, pmf4, pch = 20, col = 4)
lines(grid, pmf4, lty=1, col=4, lwd = 1.5)
points(pred_mc$y[pred_mc$group == 1], pred_mc$fy[pred_mc$group==1], pch = 20, col=1)
lines(pred_mc$y[pred_mc$group == 1], pred_mc$fy[pred_mc$group==1], lty=2, col=1, lwd=2)
points(pred_mc$y[pred_mc$group == 2], pred_mc$fy[pred_mc$group==2], pch = 20, col=2)
lines(pred_mc$y[pred_mc$group == 2], pred_mc$fy[pred_mc$group==2], lty=2, col=2, lwd=2)
points(pred_mc$y[pred_mc$group == 3], pred_mc$fy[pred_mc$group==3], pch = 20, col=3)
lines(pred_mc$y[pred_mc$group == 3], pred_mc$fy[pred_mc$group==3], lty=2, col=3, lwd=2)
points(pred_mc$y[pred_mc$group == 4], pred_mc$fy[pred_mc$group==4], pch = 20, col=4)
lines(pred_mc$y[pred_mc$group == 4], pred_mc$fy[pred_mc$group==4], lty=2, col=4, lwd=2)
legend(6,0.7, legend=c("E = (1,1) --> REF", "E = (1,2) --> Q2", "E = (2,1) --> Q1", "E = (2,2) --> Q1Q2"), lty = rep(2,4), lwd=rep(2,4), col=c(1,2,3,4))
text(7.0,0.19, labels=c(paste0("Replicates = ",r1)))
dev.off()


