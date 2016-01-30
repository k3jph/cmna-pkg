gauss.hermite.5 <- read.delim("data-raw/gauss.hermite.5.txt", sep="")
gauss.hermite.10 <- read.delim("data-raw/gauss.hermite.10.txt", sep="")
gauss.hermite.15 <- read.delim("data-raw/gauss.hermite.15.txt", sep="")
gauss.hermite.20 <- read.delim("data-raw/gauss.hermite.20.txt", sep="")
gauss.laguerre.5 <- read.delim("data-raw/gauss.laguerre.5.txt", sep="")
gauss.laguerre.10 <- read.delim("data-raw/gauss.laguerre.10.txt", sep="")
gauss.laguerre.15 <- read.delim("data-raw/gauss.laguerre.15.txt", sep="")
gauss.laguerre.20 <- read.delim("data-raw/gauss.laguerre.20.txt", sep="")
gauss.legendre.5 <- read.delim("data-raw/gauss.legendre.5.txt", sep="")
gauss.legendre.10 <- read.delim("data-raw/gauss.legendre.10.txt", sep="")
gauss.legendre.20 <- read.delim("data-raw/gauss.legendre.20.txt", sep="")
gauss.legendre.40 <- read.delim("data-raw/gauss.legendre.40.txt", sep="")
gauss.legendre.80 <- read.delim("data-raw/gauss.legendre.80.txt", sep="")
devtools::use_data(gauss.hermite.5, gauss.hermite.10, gauss.hermite.15, gauss.hermite.20, 
                   gauss.laguerre.5, gauss.laguerre.10, gauss.laguerre.15, gauss.laguerre.20,
                   gauss.legendre.5, gauss.legendre.10, gauss.legendre.20, gauss.legendre.40, gauss.legendre.80,
                   internal = TRUE, overwrite = TRUE)
