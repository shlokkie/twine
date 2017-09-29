# zzz_tests.R
# ------------------------------------------------------------------------------
ghost[[2]] 
names(ghost)[2]
prep_strats$p_id[4]

carga( corpus    = ghost[[2]] 
     , corpname  = names(ghost)[2]
     , labels    = nymeria[[2]]
     , prepstrat = prep_strats$p_id[22]
     , reprvalue = prep_strats$repr[22]
     , stopvalue = prep_strats$stop[22]
     , stemvalue = prep_strats$stem[22]
     , sparvalue = prep_strats$spar[22]
     , infovalue = prep_strats$info[22]
)

length(nymeria[[2]])
length(ghost[[2]])
# test
corpus <- ghost[[2]]
prep_strats[22,]
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, whitening, "\n") 
corpus <- tm_map(corpus, whitening, "/")
corpus <- tm_map(corpus, whitening, "@")
corpus <- tm_map(corpus, whitening, "\\|")  
corpus <- tm_map(corpus, whitening, "\\...")  
corpus <- tm_map(corpus, whitening, ".com") 

if (stopvalue == "default") {
    corpus <- tm_map(corpus, removeWords, stopwords("english"))
} 
if (stopvalue == "smart") {
    corpus <- tm_map(corpus, removeWords, smart)
}

corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)	

if (stemvalue == "simple") {
    corpus <- tm_map(corpus, stemDocument)	
}

corpus <- tm_map(corpus, stripWhitespace)

if (reprvalue == "tf_idf"){
    corpus <- DocumentTermMatrix( corpus
                                  , control = list(weighting = weightTfIdf))
}
if (reprvalue == "freq") {
    corpus <- DocumentTermMatrix( corpus
                                  , control = list(weighting = weightTf))
}


if (sparvalue == 0.99) {
    corpus <- removeSparseTerms(corpus, 0.99)
}
if (sparvalue == 0.98) {
    corpus <- removeSparseTerms(corpus, 0.98)
}

corpus  <- as.data.frame(as.matrix(corpus))


corpus <- cbind(corpus, topic = nymeria[[2]])

if (infovalue == ">0") {
    corpus <- corpus[, c(which(information.gain(topic~., corpus)$attr_importance > 0), ncol(corpus))]
    
}
    
    
