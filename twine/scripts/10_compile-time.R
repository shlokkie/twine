# 10_compile-time.R
# ------------------------------------------------------------------------------



# read preprocessing time ------------------------------------------------------

time_1 <- read.table( file      = "preprocessing-time.csv"
                    , sep       = ";"
                    # , quote     = TRUE
                    , dec       = "."
                    # , row.names = FALSE
                    , header    = TRUE
                    )


# read algorithm time ----------------------------------------------------------

time_2 <- read.table( file    = "algorithm-time.csv"
                    , sep    = ";"
                    , dec    = "."
                    , header = TRUE
                    )


# add preprocessing strategy id ------------------------------------------------
# (ref 10a)
time_2 <- data.frame(cbind(time_2, pstrat))


# merging time -----------------------------------------------------------------

m_time <- merge( time_1, time_2
               , by =  c("data", "pstrat")
               )

# sum time ---------------------------------------------------------------------

time <- sm_time$user.x + sm_time$user.y
m_time <- cbind(m_time, time)


# make dataset with all information --------------------------------------------
full_data <- m_time[, c(1, 2, 8, 4, 6, 5, 3, 7, 9 )]

# dataset only accuracy and time information -----------------------------------
metadata <- full_data[, c(1, 4, 8, 9)]



# creating the .csv files ------------------------------------------------------

write.table( full_data
           , file = "full_dataset.csv"
           , sep = ";"
           , quote = TRUE
           , dec = "."
           , row.names = FALSE
           , col.names = TRUE
)

write.table( metadata
           , file = "metadata.csv"
           , sep = ";"
           , quote = TRUE
           , dec = "."
           , row.names = FALSE
           , col.names = TRUE
)

# only time data ---------------------------------------------------------------

time <- metadata[,c(1,2,4)]
write.table( time
           , file = "time.csv"
           , sep = ";"
           , quote = TRUE
           , dec = "."
           , row.names = FALSE
           , col.names = TRUE
           )

# only accuracy ----------------------------------------------------------------

accuracy <- metadata[, c(1,2,3)]
write.table( accuracy
           , file = "accuracy.csv"
           , sep = ";"
           , quote = TRUE
           , dec = "."
           , row.names = FALSE
           , col.names = TRUE
           )
