# 00_reuters-extract.R
# ------------------------------------------------------------------------------


# laptop -----------------------------------------------------------------------
dir <- "D:/Dropbox (Personal)/LIAAD16-17/twine"
setwd(dir)


# desktop ----------------------------------------------------------------------
dir <- "B:/Dropbox (Personal)/liaad-drop/twine"
setwd(dir)


# document collection ----------------------------------------------------------
r <- read.csv( "./data/r8.txt"
             , header    = FALSE
             , col.names = c("topic", "document")
             , sep       = "\t"
             )


# labels -----------------------------------------------------------------------
w <- read.csv("./data/r8-class-name.txt", header = F)
w <- as.vector(w$V1)



# ------------------------------------------------------------------------------