# prep.strats.r 
# ------------------------------------------------------------------------------



# time dataframe ---------------------------------------------------------------
trabalhos <- data.frame(matrix(ncol = 3, nrow = 0))
colnames(trabalhos) <- c("elapsed", "data", "pstrat")

# number of terms file ---------------------------------------------------------
# stores the number of terms in the same order
write(c("no.terms"), "no_terms.txt")


for (j in 1:nrow(strats)) {
  for (i in 1:length(monty)) {
    time <- system.time(
      carga( corpus    = monty[[i]] 
           , corpname  = names(monty)[i]
           , prepstrat = strats$strategy[j]
           , stopvalue = strats$stopvalue[j]
           , stemvalue = strats$stemvalue[j]
           , sparvalue = strats$sparvalue[j]
           , labels    = montyclass[[i]]
      )
    )
    trabalhos1 <- data.frame( elapsed = time[[3]]
                            , data    = names(monty)[i]
                            , pstrat  = strats$strategy[j]
                            )
    trabalhos <- rbind(trabalhos, trabalhos1)
  }  
}

temp <- read.csv(file = "no_terms.txt")

trabalhos <- cbind(trabalhos, temp) 

# save time dataframe ----------------------------------------------------------
write.table(trabalhos
           , file      = "preprocessing-times.csv"
           , sep       = ";"
           , quote     = TRUE
           , dec       = "."
           , row.names = FALSE
           , col.names = TRUE
           )



# ------------------------------------------------------------------------------

