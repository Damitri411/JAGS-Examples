#Library
library(rjags)

#Data creation
N <- 1000
x <- rnorm(N, 0, 5)


#File path
fp="C:/Users/cssc/OneDrive/Desktop/Experiment JM/EXP_JAGS/Eg1"

write.table(x,
            file = paste(fp,'example1.data', sep="/"),
            row.names = FALSE,
            col.names = FALSE)

library('rjags')

#GIBBS Parameters
n_chain=4
n_adapt=100
#Total samples drawn post burn in
n_iter=1000
n_burn_in=100
n_thin=10

jags <- jags.model(paste(fp,'example1.model.txt', sep="/"),
                   data = list('x' = x,
                               'N' =length(x)),
                   n.chains = n_chain,
                   n.adapt = n_adapt)

#Burn in Process (ie, first run (update) upto Burn in and use it as initialization.)
update(jags, n.iter=n_burn_in )

#The sampling post burn in

#Obtaining statistics
j_samp=jags.samples(model=jags,
             variable.names=c('mu', 'tau'),
             n.iter=n_iter, thin = n_thin, force.list = F)


#Extraction of all n_chain number of chains for univariate parameter
as.matrix(j_samp$mu[1,,])

#Obtaining samples
c_samp=coda.samples(model=jags, variable.names=c('mu', 'tau'),
                    n.iter=n_iter, thin = n_thin)
#Extract for set of parameters in total , for each chain= (1,..,n_chain), say chain_no=1
chain_no=1
c_samp[[chain_no]]
