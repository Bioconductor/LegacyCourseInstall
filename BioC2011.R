source("http://bioconductor.org/biocLite.R")

major <- as.numeric(R.Version()$major)
minor <- as.numeric(R.Version()$minor)

if (major == 2 && (minor == 14)) {
  ##ok
} else {
  stop("You must be running R version 2.14")
}

rversion <- paste(R.Version()$major, as.integer(R.Version()$minor), sep=".")
scratchRepos <- paste("http://bioconductor.org/scratch-repos/",
  rversion, sep="")
allRepos <- c(scratchRepos, biocinstallRepos())

pkgInstall <- function (package) {
        install.packages(package, repos = allRepos)
}

