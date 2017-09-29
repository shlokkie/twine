# 05_preprocessing-function.R
# ------------------------------------------------------------------------------



# make white space -------------------------------------------------------------
# replaces some patterns with whitespace



whitening <- content_transformer(function (x , pattern ) 
    gsub(pattern, " ", x))





# preprocessing ----------------------------------------------------------------
# arguments are the values given by the preprocessing strategy

# preprocessing function -------------------------------------------------------
carga <- function( corpus
                 , corpname
                 , prepstrat
                 , stopvalue
                 , stemvalue
                 , sparvalue
                 , reprvalue
                 , infovalue
                 , labels
                 , savetodisk = FALSE
) {
    # to follow up on the progress
    cat(paste0("Preprocessing: ", corpname, "; Strategy: ", prepstrat, "\n"))
    # common preprocessing -------------------------------------------------------
    
    # decapitalize words
    corpus <- tm_map(corpus, content_transformer(tolower))
    # substitute some patterns into whitespace
    corpus <- tm_map(corpus, whitening, "\n") 
    corpus <- tm_map(corpus, whitening, "/")
    corpus <- tm_map(corpus, whitening, "@")
    corpus <- tm_map(corpus, whitening, "\\|")  
    corpus <- tm_map(corpus, whitening, "\\...")  
    corpus <- tm_map(corpus, whitening, ".com") 
    
    # stopword removal settings ------------------------------------------------
    if (stopvalue == "default") {
        corpus <- tm_map(corpus, removeWords, stopwords("english"))
    } 
    if (stopvalue == "smart") {
        corpus <- tm_map(corpus, removeWords, smart)
    }
    
    # common preprocessing -----------------------------------------------------
    # remove punctuation
    corpus <- tm_map(corpus, removePunctuation)
    # remove numbers
    corpus <- tm_map(corpus, removeNumbers)	
    
    # stemming setting ---------------------------------------------------------
    if (stemvalue == "simple") {
        corpus <- tm_map(corpus, stemDocument)	
    }
    
    # common preprocessing -----------------------------------------------------
    # remove extra whitespace
    corpus <- tm_map(corpus, stripWhitespace)
    
    # representation setting ---------------------------------------------------
    # if (reprvalue == "binary") {
    #     corpus <- DocumentTermMatrix(corpus
    #                                  , control = list(weighting = weightBin))
    # }
    if (reprvalue == "tf_idf"){
        corpus <- DocumentTermMatrix( corpus
                                      , control = list(weighting = weightTfIdf))
    }
    if (reprvalue == "freq") {
        corpus <- DocumentTermMatrix( corpus
                                    , control = list(weighting = weightTf))
    }
    
    
    # sparsity setting ---------------------------------------------------------
    # if (sparvalue == 0.995) {
    #     corpus <- removeSparseTerms(corpus, 0.995)
    # }
    if (sparvalue == 0.99) {
        corpus <- removeSparseTerms(corpus, 0.99)
    }
    if (sparvalue == 0.98) {
        corpus <- removeSparseTerms(corpus, 0.98)
    }
    
    # turn into a data frame ---------------------------------------------------
    corpus  <- as.data.frame(as.matrix(corpus))
    
    
    # save the dictionary ------------------------------------------------------
    # lexicon <- colnames(corpus)   
    
    # add class column ---------------------------------------------------------
    corpus <- cbind(corpus, topic = labels)
    
    # information gain setting -------------------------------------------------
    if (infovalue == ">0") {
        corpus <- corpus[, c(which(information.gain(topic~., corpus)$attr_importance > 0), ncol(corpus))]
    }
    
    # save the number of words -------------------------------------------------
    cat( ncol(corpus)-1
         , file="no_terms.txt"
         , sep="\n"
         , append = TRUE
    )
    
    # if (infovalue == ">0.03") {
    #     corpus <- corpus[, c(which(information.gain(topic~., corpus)$attr_importance > 0.03), ncol(corpus))]
    # }
    
    # save the dataframe in the disk -------------------------------------------
    if (savetodisk == TRUE) {
        write.table(corpus
                    , file = paste0( "./dataframes/"
                                     # , prepstrat
                                     # , "/"
                                     # , deparse(substitute(corpus))
                                     , prepstrat
                                     , corpname
                                     , ".csv"
                    )
                    , sep       = ";"
                    , quote     = TRUE
                    , dec       = "."
                    , row.names = FALSE
                    , col.names = TRUE
                    , qmethod   = "double"
        )
    }
}



# ------------------------------------------------------------------------------