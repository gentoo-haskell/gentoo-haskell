# Ugly script for displaying distributions alogside with theoretical
# distribution.


view.dumps <- function() {
  # Load random data from dist
  load.d <- function(name) read.table(name)[,1]
  # Plots for continous distribution
  plot.d <- function(name, dens, rng) {
    smp <- load.d( name )
    plot( density(smp), xlim=rng, main=name, col='blue', lwd=2)
    hist( smp, probability=TRUE, breaks=100, add=TRUE)
    plot( dens, xlim=rng, col='red', add=TRUE, lwd=2)
  }
  # plots for discrete distribution
  plot.ds <- function( name, xs, prob) {
    smp <- load.d( name )
    h   <- hist( smp,
                 breaks = c( max(xs) + 0.5, xs - 0.5),
                 freq=FALSE, main = name
                )
    dh  <- sqrt( h$count ) / max( 1, sum( h$count ) )
    arrows( xs, h$density + dh,
            xs, h$density - dh,
            angle=90, code=3, length=0.2 )
    points( xs, prob(xs), pch='0', col='red', type='b')
  }
  ################################################################
  # Normal
  plot.d ("distr/normal-0-1",
          function(x) dnorm( x, 0, 1 ),
          c(-4,4) )
  readline()
  # 
  plot.d ("distr/normal-1-2",
          function(x) dnorm( x, 1, 2 ),
          c(-6,8) )
  readline();

  ################################################################
  # Gamma
  plot.d ("distr/gamma-1.0-1.0",
          function(x) dgamma( x, 1, 1 ),
          c(-1,8) )
  readline();
  #
  plot.d ("distr/gamma-0.3-0.4",
          function(x) dgamma( x, 0.3, scale=0.4 ),
          c(-0.25,2) )
  readline();
  #
  plot.d ("distr/gamma-0.3-3.0",
          function(x) dgamma( x, 0.3, scale=3.0 ),
          c(-1,5) )
  readline();
  #
  plot.d ("distr/gamma-3.0-0.4",
          function(x) dgamma( x, 3.0, scale=0.4 ),
          c(-1,6) )
  readline();
  #
  plot.d ("distr/gamma-3.0-3.0",
          function(x) dgamma( x, 3.0, scale=3.0 ),
          c(-1,32) )
  readline();
  ################################################################
  # Exponential
  plot.d ("distr/exponential-1",
          function(x) dexp(x,1),
          c(-0.5, 9) )
  readline()
  #
  plot.d ("distr/exponential-3",
          function(x) dexp(x,3),
          c(-0.5, 3) )
  readline()
  ################################################################
  # Poisson
  plot.ds( "distr/poisson-0.1", 0:6, function(x) dpois(x, lambda=0.1) )
  readline()
  #
  plot.ds( "distr/poisson-1.0", 0:10, function(x) dpois(x, lambda=1.0) )
  readline()
  #
  plot.ds( "distr/poisson-4.5", 0:20, function(x) dpois(x, lambda=4.5) )
  readline()
  #
  plot.ds( "distr/poisson-30", 0:100, function(x) dpois(x, lambda=30) )
  readline()
  #
  ################################################################
  # Binomial
  plot.ds( "distr/binom-4-0.5", 0:4, function(x) dbinom(x, 4, 0.5) )
  readline()
  #
  plot.ds( "distr/binom-10-0.1", 0:10, function(x) dbinom(x, 10, 0.1) )
  readline()
  #
  plot.ds( "distr/binom-10-0.6", 0:10, function(x) dbinom(x, 10, 0.6) )
  readline()
  #
  plot.ds( "distr/binom-10-0.8", 0:10, function(x) dbinom(x, 10, 0.8) )
  readline()
  #
}
