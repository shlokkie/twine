# functions.R
# ------------------------------------------------------------------------------



# makewhitespace ---------------------------------------------------------------
# replaces some patterns with whitespace



makewhitespace <- content_transformer(function (x , pattern ) 
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
                 , labels
                 , savetodisk = FALSE
                 ) {
  # to follow up on the progress
  cat(paste0("Preprocessing: ",corpname, "; Strategy: ", prepstrat, "\n"))
  # common preprocessing -------------------------------------------------------
  
  # decapitalize words
  corpus <- tm_map(corpus, content_transformer(tolower))
  # substitute some patterns into whitespace
  corpus <- tm_map(corpus, makewhitespace, "/")
  corpus <- tm_map(corpus, makewhitespace, "@")
  corpus <- tm_map(corpus, makewhitespace, "\\|")  
  corpus <- tm_map(corpus, makewhitespace, "\\...")  
  corpus <- tm_map(corpus, makewhitespace, ".com") 
  
  # stopword removal settings --------------------------------------------------
  if (stopvalue == "default") {
    corpus <- tm_map(corpus, removeWords, stopwords("english"))
  } 
  if (stopvalue == "smart") {
    corpus <- tm_map(corpus, removeWords, SMART)
  }
  
  # common preprocessing -------------------------------------------------------
  # remove punctuation
  corpus <- tm_map(corpus, removePunctuation)
  # remove numbers
  corpus <- tm_map(corpus, removeNumbers)	
  
  # stemming setting -----------------------------------------------------------
  if (stemvalue == "simple") {
    corpus <- tm_map(corpus, stemDocument)	
  }
  
  # common preprocessing -------------------------------------------------------
  # remove extra whitespace
  corpus <- tm_map(corpus, stripWhitespace)
  
  # transform into a document term matrix --------------------------------------
  corpus <- DocumentTermMatrix( corpus
                                , control = list(weighting = weightTfIdf)
  )
  
  # sparsity setting ----------------------------------------------------------- 
  if (sparvalue == 0.95) {
    corpus <- removeSparseTerms( corpus, 0.95)
  }
  if (sparvalue == 0.99) {
    corpus <- removeSparseTerms( corpus, 0.99)
  }
  
  # turn into a data frame -----------------------------------------------------
  corpus  <- as.data.frame(as.matrix(corpus))
  
  # save the number of words ---------------------------------------------------
  cat( ncol(corpus)
     , file="no_terms.txt"
     , sep="\n"
     , append = TRUE
     )
  
  # save the dictionary --------------------------------------------------------
  lexicon <- colnames(corpus)   
  
  # add class column -----------------------------------------------------------
  corpus <- cbind(corpus, topic = labels)
  
  # save the dataframe in the disk ---------------------------------------------
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




# algorithm --------------------------------------------------------------------


abacus <- function( corpname
                  , prepstrat
                  , algorithm
                  , seed = 420
                  , workflow
                  ) {
  cat(paste0( "Data: "
            , corpname
            , "; Workflow: "
            , workflow
            , "; Prep-strategy: "
            , prepstrat, "; Algorithm: "
            , algorithm
            , "\n"
            )
    )
  # caret ----------------------------------------------------------------------
  require(caret)
  
  # cross validation -----------------------------------------------------------
  fitctrl <- trainControl( method = "cv"
                           , number = 10
  )
  # load file ------------------------------------------------------------------
  docs <- read.csv( file = paste0( "./dataframes/"
                                 , prepstrat
                                 , corpname
                                 , ".csv"
                                 )
                  , sep  = ";"
                  , dec  = "."
                  )
  
  # model settings -------------------------------------------------------------
  set.seed(seed)
  
  # svm
  if (algorithm == "svmLinear2") {
    grid <- expand.grid(cost  = c(1))
  }
  
  # rf fast
  if (algorithm == "ranger") {
    grid <- expand.grid( mtry = c(floor(sqrt(ncol(docs)-1))))
  }
  
  fit <- train( docs[, -ncol(docs)], docs[, ncol(docs)]
              , method    = algorithm
              , trControl = fitctrl
              , tuneGrid  = grid
              )
  # returns the model's accuracy to be added to the dataframe
  return(fit$results[, "Accuracy"])
}



# ------------------------------------------------------------------------------
