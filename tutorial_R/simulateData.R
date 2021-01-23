## Short script to summarize data for the rainclouds tutorial.
## Simulates data drawn from two distribions of similar mean and SD,
## with group A being drawn from a random exponential distribution
## and group B drawn drawn from a random normal distribution.



# Simulate data ----

m <- 50 # mean
s <- 25 # sd
sim_n <- 250 # drawsx

# Calculate log-normal parameters ----

location <- log(m^2 / sqrt(s^2 + m^2))
shape <- sqrt(log(1 + (s^2 / m^2)))

# Set seed to get same data everytime ----
set.seed(123)

# Create data by hand ----

simdat_group1 <- rlnorm(sim_n, location, shape)
simdat_group2 <- rnorm(sim_n, m, s)

simdat <- c(simdat_group1, simdat_group2) %>% as_tibble() %>% rename(score = 1)
simdat <- simdat %>% mutate(group = 
                      fct_inorder(c(rep("Group1", times = sim_n),
                       rep("Group2", times = sim_n))))


# Calculate summary stats ----
summary_simdat <- fn_summary_SE(simdat, quo(score), group)
summary_simdat

# new fn_summary_SE

##   # This does the summary. For each group's data frame, return a vector with
# N, mean, median, and sd
