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
                                                          year=as.factor(data$year),
                                                          voles=data$voles))
## check data
summary(umf.all)
plot(umf.all)

## run the RN model
library(ubms)
options(mc.cores=3)

## base model
m.all <- stan_occuRN(~ month ~ year + (1|site), umf.all, chains=3, iter=4000)

## model including vole density
m.all2 <- stan_occuRN(~ month ~ voles + (1|site), umf.all2, chains=3, iter=4000)

## check model output
m.all
m.all2

# check model fit
plot_marginal(m.all,"state")
plot_marginal(m.all,"det")
ranef(m.all,"state")
summary(m.all,"state")
summary(m.all,"det")
traceplot(m.all)

plot_marginal(m.all2,"state")
plot_marginal(m.all2,"det")
ranef(m.all2,"state")
summary(m.all2,"state")
summary(m.all2,"det")
traceplot(m.all2)

## calculate goodness of fit statistic
gofm.all<- gof(m.all)
gofm.all2 <- gof(m.all2)
gofm.all
gofm.all2

## compare models
mods <- fitList(m.all,m.all2)
round(modSel(mods),3)
loo(m.all)
loo(m.all2)
