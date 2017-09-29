# 09_abacus-cardboard.R
# ------------------------------------------------------------------------------





# time dataframe ---------------------------------------------------------------
cardboard <- data.frame(matrix(nrow = 0,ncol = 4))
colnames(cardboard) <- c("user", "data", "workflow", "algorithm")


# run abacus -------------------------------------------------------------------
# first 5 prep strategies: 2000 results
for (j in 1:40) { 
    for (i in 1:length(summer)) { 
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
        cardboard1 <- cbind( data.frame( user      = time[[1]]
                                       , data      = summer[i]
                                       , workflow  = workflow$w_id[j]
                                       , algorithm = workflow$algo[j]
                                       )
                           , accuracy
                           )  
        # adds a new line
        cardboard <- rbind(cardboard, cardboard1)
    }
}


# save time dataframe ----------------------------------------------------------
write.table( cardboard
           , file = "algorithm-time_1-40.csv"
           , sep = ";"
           , quote = TRUE
           , dec = "."
           , row.names = FALSE
           , col.names = TRUE
           )




# ------------------------------------------------------------------------------