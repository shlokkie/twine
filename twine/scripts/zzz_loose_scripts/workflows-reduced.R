# workflows.R
# ------------------------------------------------------------------------------





# time dataframe ---------------------------------------------------------------
cardboard <- data.frame(matrix(nrow = 0,ncol = 4))
colnames(cardboard) <- c("elapsed", "data", "workflow", "algorithm")


# run abacus -------------------------------------------------------------------
for (j in 1:nrow(flows)) { 
  for (i in 1:length(python)) { 
    # saves the system.time to an object
    time <- system.time(
      # creates an object for the output of abacus
      accuracy <- (abacus( corpname  = python[i]
                         , prepstrat = flows$prepstrat[j]
                         , algorithm = flows$algorithm[j]
                         , workflow  = flows$workflow[j]
      )
      ) 
    )
    # creates a dataframe for the time object
    cardboard1 <- data.frame( elapsed = time[[3]]
                            , data = python[i]
                            , workflow  = flows$workflow[j]
                            , algorithm = flows$algorithm[j]
                            )
    # binds the results to the time dataframe
    cardboard1 <- cbind(cardboard1, accuracy)
    # adds a new line
    cardboard <- rbind(cardboard, cardboard1)
  }
}


# save time dataframe ----------------------------------------------------------
write.table( cardboard
           , file = "algorithm-time.csv"
           , sep = ";"
           , quote = TRUE
           , dec = "."
           , row.names = FALSE
           , col.names = TRUE
)




# ------------------------------------------------------------------------------