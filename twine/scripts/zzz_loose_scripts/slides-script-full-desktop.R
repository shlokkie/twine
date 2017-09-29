# Data Source
# http://people.csail.mit.edu/jrennie/20Newsgroups/
dir = "D:/Dropbox (Personal)/LIAAD16-17/[5] Reduced Project/text-mining-slides"
dir2 = "F:/[NOT PROGRAMS]/Dropbox (Personal)/LIAAD16-17/[5] Reduced Project/text-mining-slides"
setwd(dir2)
library(tm)
library(SnowballC)
library(tm.plugin.mail)
sci.electr.test = Corpus(DirSource("./20news-bydate/20news-bydate-test/sci.electronics"), 
                         readerControl=list(reader=readMail, language="en"))
sci.electr.train = Corpus(DirSource("./20news-bydate/20news-bydate-train/sci.electronics"), 
                          readerControl=list(reader=readMail, language="en"))

talk.religion.train = Corpus(DirSource("./20news-bydate/20news-bydate-train/talk.religion.misc"), 
                             readerControl=list(reader=readMail, language="en"))
talk.religion.test = Corpus(DirSource("./20news-bydate/20news-bydate-train/talk.religion.misc"), 
                            readerControl=list(reader=readMail, language="en"))
length(sci.electr.train)
# [1] 591
sci.electr.train[[1]][[1]]
# [1] "From: et@teal.csn.org (Eric H. Taylor)"                                             
# [2] "Subject: Re: HELP_WITH_TRACKING_DEVICE"                                             
# [3] "Summary: underground and underwater wireless methods"                               
# [4] "Keywords: Rogers, Tesla, Hertz, underground, underwater, wireless, radio"           
# [5] "Nntp-Posting-Host: teal.csn.org"                                                    
# [6] "Organization: 4-L Laboratories"                                                     
# [7] "Expires: Fri, 30 Apr 1993 06:00:00 GMT"                                             
# [8] "Lines: 36"                                                                          
# [9] ""                                                                                   
# [10] "In article <00969FBA.E640FF10@AESOP.RUTGERS.EDU> mcdonald@AESOP.RUTGERS.EDU writes:"
# [11] ">[...]"                                                                             
# [12] ">There are a variety of water-proof housings I could use but the real meat"         
# [13] ">of the problem is the electronics...hence this posting.  What kind of"             
# [14] ">transmission would be reliable underwater, in murky or even night-time"            
preprocess <- function(z){
  z = tm_map(z, content_transformer(tolower))
  z = tm_map(z, removeWords, stopwords(kind = "en"))
  z = tm_map(z, removePunctuation, preserve_intra_word_dashes = TRUE)
  z = tm_map(z, removeNumbers)
  z = tm_map(z, stemDocument)
  z = tm_map(z, removeWords, stopwords(kind = "en"))
  z = tm_map(z, stripWhitespace)
  return(z)
}
sci.electr.train.p <- preprocess(sci.electr.train)
sci.electr.test.p <- preprocess(sci.electr.test)
talk.religion.train.p <- preprocess(talk.religion.train)
talk.religion.test.p <- preprocess(talk.religion.test)

sci.electr.train.p[[1]][[1]]





# > y[13]
# [1] "sci.electronics"
# > y[20]
# [1] "talk.religion.misc"
# The tags that are used in the slides are these ones.
sci.electronics = x[x$label == y[13],]
talk.religion.misc = x[x$label == y[20],]
# Test and train split (70%;30%)
set.seed(345)
sci.electronics.tindex = sample(1:nrow(sci.electronics), size = round(0.7*nrow(sci.electronics)), replace = FALSE)
sci.electr.train = sci.electronics[sci.electronics.tindex, ]
sci.electr.test = sci.electronics[-sci.electronics.tindex, ]

talk.religion.misc.tindex = sample(1:nrow(talk.religion.misc), size = round(0.7*nrow(talk.religion.misc)), replace = FALSE)
talk.religion.train = talk.religion.misc[talk.religion.misc.tindex,]
talk.religion.test = talk.religion.misc[-talk.religion.misc.tindex,]
# slide #8

sci.electr.train = Corpus(VectorSource(sci.electr.train$text), readerControl = list(reader = readPlain,language="en"))
# This is how it is on the slides:
# sci.electr.train <- Corpus(DirSource("sci.electronics"), readerControl=list(reader=readMail, language="en_US"))
sci.electr.test = Corpus(VectorSource(sci.electr.test$text), readerControl = list(reader = readPlain,language="en"))
talk.religion.train = Corpus(VectorSource(talk.religion.train$text), readerControl = list(reader = readPlain,language="en"))
talk.religion.test = Corpus(VectorSource(talk.religion.test$text), readerControl = list(reader = readPlain,language="en"))




length(sci.electr.train)
# [1] 591
length(talk.religion.train)
length(sci.electr.test)
length(talk.religion.test)
# slide #9
sci.electr.train[[1]]
docs <- c(sci.electr.train, talk.religion.train, sci.electr.test, talk.religion.test)
length(docs)
# [1] 1612
# slide #13
l1 <- length(sci.electr.train)  # (591 docs)
l2 <- length(talk.religion.train)  # (377 docs)
l3 <- length(sci.electr.tet)   #(393 docs)
l4 <- length(talk.religion.test)   #(251 docs)
# slide #14
docs.p <- docs
docs.p <- tm_map(docs.p, removeWords, stopwords(kind ="en")) 
docs.p <- tm_map(docs.p, content_transformer(tolower))
docs.p <- tm_map(docs.p, removePunctuation)
docs.p <- tm_map(docs.p, removeNumbers)
docs.p <- tm_map(docs.p, stemDocument) 
docs.p <- tm_map(docs.p, removeWords, stopwords(kind ="en"))
docs.p <- tm_map(docs.p, stripWhitespace)
stopwords(kind = "en")
docs[[1]]   # Same as sci.electr.train[[1]]

