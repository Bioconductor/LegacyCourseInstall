## Bioconductor.R

## TODO: change this to bioconductor.org when we go live
repos <- "http://bioconductor.org/scratch-repos/"
options("Bioconductor_package_repos" = repos)

.msg <-
    function(fmt, ..., width=0.9 * getOption("width"))
    ## Use this helper to format all error / warning / message text
{
    txt <- strwrap(sprintf(fmt, ...), width=width, indent=4)
    paste(sub("^ +", "", txt), collapse="\n")
}

.isPackageInstalled <- function() 
{
  library(utils)
  ip <- installed.packages()
  pkgInfo <- ip[ip[,1] == "Bioconductor"]
  length(pkgInfo)
}


.getContribUrl <-
    function(repos)
{
    rVerStr <- paste(R.Version()$major, as.integer(R.Version()$minor), sep=".")
    seg = "src"
    rVerCopy <- ""
    if (getOption("pkgType") == "mac.binary.leopard") {
        seg = "bin/macosx/leopard"
        rVerCopy <- rVerStr
    } else if (getOption("pkgType") == "win.binary") {
        seg = "bin/windows"
        rVerCopy <- rVerStr
    }

    biocPackageRepo <- 
        paste(repos, "/",rVerStr,
              "/", seg, "/contrib/", rVerCopy,
              sep="")
    
    packagesFile <- paste(biocPackageRepo, "PACKAGES", sep="/")
    tempfile <- tempfile()
    res <- suppressMessages(suppressWarnings({
        try(download.file(packagesFile, tempfile, quiet=TRUE), silent=TRUE)
    }))
    if (inherits(res, "try-error")) {
        msg <- .msg("Bioconductor package does not yet exist in repository
                     '%s'. Using newest existing repository.",
                      biocPackageRepo)
        message(msg)
        biocPackageRepo <- gsub(rVerStr, .lowerRVer(), biocPackageRepo)
    } else {
        unlink(tempfile)
    }
    biocPackageRepo
}

.lowerRVer <-
    function() 
{
    major <- R.Version()$major;
    minor <- as.integer(R.Version()$minor) -1
    paste(major, minor, sep=".")
}



if (.isPackageInstalled())
{
  if (!"Bioconductor" %in% search())
  {
    library(Bioconductor)
  }
} else
{
  suppressMessages(install.packages("Bioconductor", repos=NULL, contriburl=.getContribUrl(repos)))
  suppressPackageStartupMessages(library(Bioconductor))
}
rm(".isPackageInstalled", ".getContribUrl", ".lowerRVer", ".msg", "repos", envir=globalenv())



