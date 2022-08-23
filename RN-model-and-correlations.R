#### Code accompanying the manuscript:
#### Comparing direct (live-trapping) and indirect (camera-trapping) approaches to estimate
#### the abundance of weasels (Mustela nivalis)
rm(list=ls())

## load the data
load("weasel-data.RData")

## convert to unmarked data frame
library(unmarked)
umf.all <- unmarkedFrameOccu(y=data$y,siteCovs=data.frame(site=as.factor(data$site),
                                                          month=as.factor(data$month),
                                                          year=as.factor(data$year)))
## check data
summary(umf.all)
plot(umf.all)

## run the RN model
library(ubms)
options(mc.cores=3)

m.all <- stan_occuRN(~ month ~ year + (1|site), umf.all, chains=3, iter=2000)

## check model output
m.all

# check model fit
plot_marginal(m.all,"state")
plot_marginal(m.all,"det")
ranef(m.all,"state")
summary(m.all,"state")
summary(m.all,"det")
traceplot(m.all)

## extract posteriors for lambda
lambda.b0 <- unlist(extract(m.all,"beta_state[(Intercept)]"))
lambda.b1 <- unlist(extract(m.all,"beta_state[year2016]"))
lambda.b2 <- unlist(extract(m.all,"beta_state[year2017]"))
lambda.b3 <- unlist(extract(m.all,"beta_state[year2018]"))

lambda.15 <- exp(lambda.b0)
lambda.16 <- exp(lambda.b0+lambda.b1)
lambda.17 <- exp(lambda.b0+lambda.b2)
lambda.18 <- exp(lambda.b0+lambda.b3)

#### Testing the correlation between lambda, MNA and vole density ####

## create a data frame including the posteriors of lambda
test.df <- data.frame(lambda.15 = lambda.15, lambda.16 = lambda.16, 
                      lambda.17 = lambda.17, lambda.18 = lambda.18)

## create a data frame with the number of live-caught weasels
w.df <- data.frame(year = c(2015,2016,2017,2018),
                   weasels = c(3,3,7,6))

## create a data frame with the vole trapping index
v.df <- data.frame(year = c(2015,2016,2017,2018),
                   voles = c(15.3,22.5,30,21.1))

## create a data frame to store the correlation for each iteration of the MCMC
cor.df <- data.frame(cor.w = rep(NA,nrow(test.df)),
                     cor.v = rep(NA,nrow(test.df)))

## calculate the correlation for each iteration of the MCMC
for(i in 1:nrow(test.df)){
  temp.df <- cbind(w.df,v.df,data.frame(lambda = c(test.df[i,1],test.df[i,2],test.df[i,3],test.df[i,4])))
  cor.df[i,1] <- cor(temp.df$weasels,temp.df$lambda)
  cor.df[i,2] <- cor(temp.df$voles,temp.df$lambda)
}

## check if it worked
head(cor.df)

## get outputs for Pearson's correlation coefficient and 95% credible interval
mean(cor.df$cor.w)
quantile(cor.df$cor.w,probs=0.025)
quantile(cor.df$cor.w,probs=0.975)

mean(cor.df$cor.v)
quantile(cor.df$cor.v,probs=0.025)
quantile(cor.df$cor.v,probs=0.975)

## calculate correlation between number of caught weasels and capture rate from mostelas
cor.df2 <- data.frame(weasels = c(3,3,7,6),
                      capture.rate = c(3.8,3.8,12.4,2.9))
cor(cor.df2$weasels,cor.df2$capture.rate)

## calculate correlation between the number of caught weasels and vole index
cor(w.df$weasels,v.df$voles)
