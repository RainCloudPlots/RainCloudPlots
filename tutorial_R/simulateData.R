## Short script to summarize data for the rainclouds tutorial.
## Simulates data drawn from two distribions of similar mean and SD,
## with group A being drawn from a random exponential distribution
## and group B drawn drawn from a random normal distribution.



# Simulate data ----

m <- 50 # mean
s <- 25 # sd
n <- 250 # drawsx

# Calculate log-normal parameters ----

location <- log(m^2 / sqrt(s^2 + m^2))
shape <- sqrt(log(1 + (s^2 / m^2)))

# Set seed to get same data everytime ----
set.seed(123)

# Create data by hand ----

simdat_group1 <- rlnorm(n, location, shape)
simdat_group2 <- rnorm(n, m, s)

simdat <- c(simdat_group1, simdat_group2)
simdat <- data.frame(c(rep("Group1", times = n), 
                       rep("Group2", times = n)), simdat)
colnames(simdat) <- c("group", "score")

# Calculate summary stats ----
summary_simdat <- summarySE(simdat, measurevar = "score", 
                                     groupvars = c("group"))
