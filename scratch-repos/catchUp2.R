



biocLite(character(), suppressUpdates=TRUE)

if (!("RangesRNAseqTutorial" %in% installed.packages()))
{
    install.packages("RangesRNAseqTutorial",
      repos=c("http://bioconductor.org/scratch-repos/2.11",
      biocinstallRepos()))
}

if (packageVersion("qpgraph") < "1.13.30")
{
    install.packages("qpgraph", type="source",
      repos=("http://bioconductor.org/scratch-repos/2.11"))
    wd <- getwd()
    files <- c("qpgraphWorkshop.pdf", "qpgraphWorkshop.R",
               "yeastractRegTwoColTable.tsv", "YeastGG.RData")
    dir.create("~/qpgraphWorkshop") 
    setwd("~/qpgraphWorkshop")
    for (file in files)
    {
      download.file(paste(
       "http://bioconductor.org/help/course-materials/2012/BioC2012",
       file, sep="/"), destfile=file)
      rm(file)
    }
    setwd(wd) 
    rm(wd)
    rm(files)
}



