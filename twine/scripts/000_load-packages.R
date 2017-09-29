# 000_load-packages.R
# ------------------------------------------------------------------------------

# function ---------------------------------------------------------------------
# checks if packages are installed and requires them
# https://gist.github.com/stevenworthington/3178163

ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

# packages ---------------------------------------------------------------------
packages = c( "slam" 
            , "NLP"
            , "tm"
            , "tm.plugin.mail"
            , "rJava"
            # ,"dplyr"
            ,"ggplot2"
            # ,"widyr"
            , "FSelector"
            , "RWeka"
            , "caret"
            , "kknn"
            , "nnet"
            , "klaR"
            , "MASS"
            , "e1071"
            , "C50"
            , "ranger"
            # , "kernlab"
            # , "pls"
            , "reshape2"
            )

# run --------------------------------------------------------------------------
ipak(packages)

