# 04_workflows.R
# ------------------------------------------------------------------------------




# preprocessing strats ---------------------------------------------------------

repr <- c( "tf_idf"
         # , "binary"
         , "freq"
         )
stop <- c( "none"
         , "default"
         , "smart"
         )
stem <- c( "none"
         , "simple"
         )
spar <- c( 0.99
         , 0.98
         )
info <- c("none"
         , ">0"
         # , ">0.03"
         )
p_id <- c(paste0("p",1:(length(repr)*length(stop)*length(stem)*length(spar)*length(info))))



# preprocessing strategies dataframe -------------------------------------------
prep_strats <- data.frame()
for( r in 1:length(repr)) {
    for( s in 1:length(stop)) {
        for( sm in 1:length(stem)) {
            for(sp in 1:length(spar)) {
                for( i in 1:length(info)) {
                    prep_strats <- rbind( prep_strats
                                        , data.frame( repr = repr[r]
                                                    , stop = stop[s]
                                                    , stem = stem[sm]
                                                    , spar = spar[sp]
                                                    , info = info[i]
                                                    )
                    )
                }
            }
        }
        
    }
}
prep_strats <- cbind(data.frame(p_id = p_id), prep_strats)

write.table(prep_strats
            , file      = "prep_strats.csv"
            , sep       = ";"
            , quote     = TRUE
            , dec       = "."
            , row.names = FALSE
            , col.names = TRUE
)


# algorithms -------------------------------------------------------------------
algo <- c("nnet"        # Neural Network
         , "J48"        # C4.5-like Trees
         # , "PART"       # Rule-Based Classifier
         , "JRip"       # Rule-Based Classifier (RIPPER)
         , "knn"        # Knn
         , "C5.0Tree"   # Single C5.0 Tree
         , "lda"        # Linear Discriminant Analysis
         , "svmLinear2" # Support Vector Machines with Linear Kernel
         , "ranger"     # Random Forest
         )

# workflows dataframe ----------------------------------------------------------
workflow <- data.frame()
for( r in 1:length(repr)) {
    for( s in 1:length(stop)) {
        for( sm in 1:length(stem)) {
            for(sp in 1:length(spar)) {
                for( i in 1:length(info)) {
                    for( a in 1: length(algo)){
                        workflow <- rbind( workflow
                                         , data.frame( repr = repr[r]
                                                     , stop = stop[s]
                                                     , stem = stem[sm]
                                                     , spar = spar[sp]
                                                     , info = info[i]
                                                     , algo = algo[a]
                                                     )
                                         )
                    }
                    
                }
            }
        }
        
    }
}



# id's -------------------------------------------------------------------------
# workflow_ids
w_id <- c(paste0("w",1:nrow(workflow)))


# preprocessing ids 
ps_id <- data.frame()
for( p in 1:length(p_id)) { 
    ps_id1 <- data.frame(p_id = rep(p_id[p], length(algo)))
    ps_id <- rbind(ps_id, ps_id1)
}


# final dataframe --------------------------------------------------------------
workflow <- cbind( data.frame(w_id = w_id, p_id = ps_id)
                 , workflow
                 )



# save -------------------------------------------------------------------------
write.table( workflow
           , file      = "workflows.csv"
           , sep       = ";"
           , quote     = TRUE
           , dec       = "."
           , row.names = FALSE
           , col.names = TRUE
)




