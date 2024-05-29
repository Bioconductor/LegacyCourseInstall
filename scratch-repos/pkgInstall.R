## TODO: update this to use Bioconductor package???

source("http://bioconductor.org/biocLite.R")

major <- as.numeric(R.Version()$major)
minor <- as.numeric(R.Version()$minor)

if (major == 2 && (minor >= 12 && minor < 13)) {
  ##ok
} else {
##  stop("You must be running R version 2.12")
}


bioc_version <- NULL
if (exists("biocVersion")) 
{
	bioc_version <- as.character(biocVersion())
} else {
	try(bioc_version <- as.character(BiocInstaller:::BIOC_VERSION), silent=TRUE)
}

if (is.null(bioc_version))
{
	if (rversion == "2.12")
	{
        	bioc_version <- "2.7"
	} else if (rversion == "2.13")
	{
        	bioc_version <- "2.8"
	} else if (rversion == "2.14")
	{
        	bioc_version <- "2.9"
	} else if (rversion == "2.15")
	{
		isDevel <- NULL
		try (isDevel <- BiocInstaller:::.isDevel(),
			silent=TRUE)
		if (is.null(isDevel))
		{
			stop("I don't know what version of Bioconductor you're running.")
		}
        	if (isDevel)
        	{
        	        bioc_version <- "2.11"
        	} else {
                	bioc_version <- "2.10"
       	 }
	} else {
        	stop("I don't know what version of Bioconductor you're running.")
	}
}
rversion <- paste(R.Version()$major, as.integer(R.Version()$minor), sep=".")
##bioc_version <- character(0)


scratchRepos <- paste("http://bioconductor.org/scratch-repos/",
  bioc_version, sep="")
allRepos <- c(scratchRepos, biocinstallRepos())

pkgInstall <- function (package, ...) {
        install.packages(package, repos = allRepos, ...)
}

