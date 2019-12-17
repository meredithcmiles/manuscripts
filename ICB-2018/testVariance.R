# simulate some data:
# dependent variable
y <- c(rnorm(n = 100, mean = 0, sd = 10),
       rnorm(n = 100, mean = 0, sd = 2))

# the condition we're testing across
x <- c(rep("group1", times=100),
       rep("group2", times=100))

# random factor (individual identity)
individual <- rep(1:50, times=4)

# done simulating data.

library(nlme)

# fit your 'null' model
# by default, variance is assumed equal between the 2 groups
fit <- lme(y~x, random = ~1|individual)

# update the model to include a new weights argument,
# where we will call the varIdent function.
# it lets us split the variance across reference levels.

fit1 <- update(fit, weights = varIdent(form=~1|x))

# run the anova to test fit
anova(fit, fit1)

# fit1 has an extra degree of freedomfrom estimating a 2nd parameter!
# the model still contains significantly more information,
# because 'group 1' has sd=10 and 'group 2' has sd=2!
