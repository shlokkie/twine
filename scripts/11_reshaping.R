# 11_reshaping.R
# ------------------------------------------------------------------------------



# accuracy ---------------------------------------------------------------------

acc <- read.table( file = "./results/accuracy.csv"
                 , header = TRUE
                 , sep = ";"
                 , dec = ".")


# levels as numbers ------------------------------------------------------------

levels(acc$data) <- c(1:50)
acc$data <- as.numeric(acc$data)
levels(acc$workflow) <- c(1:384)
acc$workflow <- as.numeric(acc$workflow)


# reshape of df ----------------------------------------------------------------

library(reshape2)
acc1 <- melt(acc, id.vars = c("data", "workflow"))
acc1$variable <- NULL
acc1 <- aggregate(. ~ workflow, acc1, list)
accu <- cbind( acc1$workflow
             , as.data.frame(do.call(rbind, acc1$value))
             )
colnames(accu) <- c("workflow",acc1$data[[1]])


write.table( accu
           , file = "./results/acc.csv"
           , sep = ";"
           , quote = TRUE
           , dec = "."
           , row.names = FALSE
           , col.names = TRUE
           )



# time -------------------------------------------------------------------------

tim <- read.table( file = "./results/time.csv"
                 , header = TRUE
                 , sep = ";"
                 , dec = "."
                 )

# levels as numbers ------------------------------------------------------------

levels(tim$data) <- c(1:50)
tim$data <- as.numeric(tim$data)
levels(tim$workflow) <- c(1:384)
tim$workflow <- as.numeric(tim$workflow)

# reshape of df ----------------------------------------------------------------

library(reshape2)
tim1 <- melt(tim, id.vars = c("data", "workflow"))
tim1$variable <- NULL
tim1 <- aggregate(. ~ workflow, tim1, list)
time <- cbind( tim1$workflow
             , as.data.frame(do.call(rbind, tim1$value))
             )
colnames(time) <- c("workflow",acc1$data[[1]])


write.table( time
           , file = "./results/tempo.csv"
           , sep = ";"
           , quote = TRUE
           , dec = "."
           , row.names = FALSE
           , col.names = TRUE
           )



