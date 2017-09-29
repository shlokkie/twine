# ------------------------------------------------------------------------------
# [9-16]
# p2; o2
summer[34]
workflow$p_id[]
workflow$w_id[]
workflow[7,]

abacus( corpname  = summer[34]
        , prepstrat = workflow$p_id[8]
        , algorithm = workflow$algo[8]
        , workflow  = workflow$w_id[8]
)



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

# test file:
docs <- read.csv(file = "C:/Users/Shlokk!/Documents/dataframes/p1o19.csv"
                 , sep  = ";"
                 , dec  = "."
)

# model settings -------------------------------------------------------------
set.seed(420)

# svm
if (algorithm == "svmLinear2") {
    fit <- train( docs[, -ncol(docs)], docs[, ncol(docs)]
                  , method    = "svmLinear2"
                  , trControl = fitctrl
                  , tuneGrid  = expand.grid(cost  = c(1))
    )
}

# rf fast
if (algorithm == "ranger") {
    fit <- train( docs[, -ncol(docs)], docs[, ncol(docs)]
                  , method    = "ranger"
                  , trControl = fitctrl
                  , tuneGrid  = expand.grid(mtry = c(floor(sqrt(ncol(docs)-1))))
    )
}

# nnet
if (algorithm == "nnet") {
    fit <- train( docs[, -ncol(docs)], docs[, ncol(docs)]
                  , method    = "nnet"
                  , trControl = fitctrl
                  , tuneGrid  = expand.grid( decay  = c(0)
                                             , size = (c(1)))
                  , MaxNWts   = 2900
    )
}

# J48
if (algorithm == "J48") {
    fit <- train( docs[, -ncol(docs)], docs[, ncol(docs)]
                  , method    = "J48"
                  , trControl = fitctrl
                  , tuneGrid  = expand.grid( C = c(0.25)
                                             , M = c(2)
                  )
    )
}

# knn
if (algorithm == "knn") {
    fit <- train( docs[, -ncol(docs)], docs[, ncol(docs)]
                  , method    = "knn"
                  , trControl = fitctrl
                  , tuneGrid  = expand.grid(k = c(1))
    )
}


# fit <- train( docs[, -ncol(docs)], docs[, ncol(docs)]
#               , method    = "lssvmLinear"
#               , trControl = fitctrl
#               # , tuneGrid  = expand.grid(tau = c(0.01))
# )
# PART
# if (algorithm == "PART") {
#     fit <- train( docs[, -ncol(docs)], docs[, ncol(docs)]
#                   , method    = "PART"
#                   , trControl = fitctrl
#                   , tuneGrid = expand.grid( threshold = c(0.25)
#                                           , pruned = "no")
#     )
# }

# C5.0Tree
if (algorithm == "C5.0Tree") {
    fit <- train( docs[, -ncol(docs)], docs[, ncol(docs)]
                  , method    = "C5.0Tree"
                  , trControl = fitctrl
    )
}

if (algorithm == "C5.0Rules") {
    fit <- train( docs[, -ncol(docs)], docs[, ncol(docs)]
                  , method    = "C5.0Rules"
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

fit <- train( docs[, -ncol(docs)], docs[, ncol(docs)]
              , method    = "JRip"
              , trControl = fitctrl
              , tuneGrid = expand.grid( NumOpt = c(2)
                                        , NumFolds = c(3)
                                        , MinWeights = c(2.0))
)



cardboard <- data.frame(matrix(nrow = 0,ncol = 4))
colnames(cardboard) <- c("user", "data", "workflow", "algorithm")


# run abacus -------------------------------------------------------------------
for (j in 42:43) { 
    for (i in 1:1) { 
        # saves the system.time to an object
        time <- system.time(
            # creates an object for the output of abacus
            accuracy <- (abacus( corpname  = summer[i]
                                 , prepstrat = workflow$p_id[j]
                                 , algorithm = workflow$algo[j]
                                 , workflow  = workflow$w_id[j]
            )
            ) 
        )
        # creates a dataframe for the time object
        cardboard1 <- data.frame( user      = time[[1]]
                                  , data      = summer[i]
                                  , workflow  = workflow$w_id[j]
                                  , algorithm = workflow$algo[j]
        )
        # binds the results to the time dataframe
        cardboard1 <- cbind(cardboard1, accuracy)
        # adds a new line
        cardboard <- rbind(cardboard, cardboard1)
    }
}




# ------------------------------------------------------------------------------
summer[26]
workflow[201,]
cardboard <- data.frame(matrix(nrow = 0,ncol = 4))
colnames(cardboard) <- c("user", "data", "workflow", "algorithm")


for (j in 202:203) { 
    for (i in 26:27) { 
        # saves the system.time to an object
        time <- system.time(
            # creates an object for the output of abacus
            accuracy <- (abacus( corpname  = names(ghost)[i]
                               , prepstrat = workflow$p_id[j]
                               , algorithm = workflow$algo[j]
                               , workflow  = workflow$w_id[j]
            )
            ) 
        )
        # creates a dataframe for the time object
        cardboard1 <- cbind( data.frame( user      = time[[1]]
                                       , data      = names(ghost)[i]
                                       , workflow  = workflow$w_id[j]
                                       , algorithm = workflow$algo[j]
                                       )
                           , accuracy
                           )  
        # binds the results to the time dataframe
        # cardboard1 <- cbind(cardboard1, accuracy)
        # adds a new line
        cardboard <- rbind(cardboard, cardboard1)
    }
}
