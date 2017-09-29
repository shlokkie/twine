# 06_carga-de-trabalhos.R 
# ------------------------------------------------------------------------------



# time dataframe ---------------------------------------------------------------
trabalhos <- data.frame(matrix(ncol = 3, nrow = 0))
colnames(trabalhos) <- c("user", "data", "pstrat")

# number of terms file ---------------------------------------------------------
# stores the number of terms in the same order
write(c("no.terms"), "no_terms.txt")


for (j in 1:nrow(prep_strats)) {
    for (i in 1:length(ghost)) {
        time <- system.time(
            carga( corpus    = ghost[[i]] 
                 , corpname  = names(ghost)[i]
                 , labels    = meow_cats[[i]]
                 , prepstrat = prep_strats$p_id[j]
                 , reprvalue = prep_strats$repr[j]
                 , stopvalue = prep_strats$stop[j]
                 , stemvalue = prep_strats$stem[j]
                 , sparvalue = prep_strats$spar[j]
                 , infovalue = prep_strats$info[j]
                 
            )
        )
        trabalhos1 <- data.frame( user = time[[1]]
                                , data    = names(ghost)[i]
                                , pstrat  = prep_strats$p_id[j]
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

