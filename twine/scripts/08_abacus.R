# 08_abacus.R
# ------------------------------------------------------------------------------


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
                           , number = 4
    )
    # load file ------------------------------------------------------------------
    docs <- read.csv( file = paste0( "C:/Users/Shlokk!/Documents/dataframes/"
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
        fit <- train( docs[, -ncol(docs)], docs[, ncol(docs)]
                    , method    = algorithm
                    , trControl = fitctrl
                    , tuneGrid  = expand.grid(cost  = c(1))
                    )
    }
    
    # rf fast
    if (algorithm == "ranger") {
        fit <- train( docs[, -ncol(docs)], docs[, ncol(docs)]
                    , method    = algorithm
                    , trControl = fitctrl
                    , tuneGrid  = expand.grid(mtry = c(floor(sqrt(ncol(docs)-1))))
                    )
    }
    
    # nnet
    if (algorithm == "nnet") {
        fit <- train( docs[, -ncol(docs)], docs[, ncol(docs)]
                    , method    = algorithm
                    , trControl = fitctrl
                    , tuneGrid  = expand.grid( decay  = c(0)
                                             , size = (c(1))
                                             )
                    , MaxNWts   = 2900
        )
    }
    
    # J48
    if (algorithm == "J48") {
        fit <- train( docs[, -ncol(docs)], docs[, ncol(docs)]
                    , method    = algorithm
                    , trControl = fitctrl
                    , tuneGrid  = expand.grid( C = c(0.25)
                                             , M = c(2)
                                             )
                    )
    }
    
    # knn
    if (algorithm == "knn") {
        fit <- train( docs[, -ncol(docs)], docs[, ncol(docs)]
                    , method    = algorithm
                    , trControl = fitctrl
                    , tuneGrid  = expand.grid(k = c(1))
                    )
    }
    
    # PART
    if (algorithm == "JRip") {
        fit <- train( docs[, -ncol(docs)], docs[, ncol(docs)]
                    , method    = algorithm
                    , trControl = fitctrl
                    , tuneGrid = expand.grid( NumOpt = c(2)
                                            , NumFolds = c(3)
                                            , MinWeights = c(2.0)
                                            )
                    )
    }
    
    # C5.0Tree
    if (algorithm == "C5.0Tree") {
        fit <- train( docs[, -ncol(docs)], docs[, ncol(docs)]
                    , method    = algorithm
                    , trControl = fitctrl
                    )
    }
    
    # lda
    if (algorithm == "lda") {
        fit <- train( docs[, -ncol(docs)], docs[, ncol(docs)]
                    , method    = "lda"
                    , trControl = fitctrl
                    , tol       = 0.000004
                    , CV        = FALSE
                    )
    }
    
    # returns the model's accuracy to be added to the dataframe
    return(fit$results[, "Accuracy"])
}
