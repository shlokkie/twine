# rank-a3r.R
# ------------------------------------------------------------------------------





# A3R --------------------------------------------------------------------------
# the N = 40


a3r <- accu/times^(1/40)



# save file
write.table(a3r, "a3r.csv", dec = ".", sep = ";")


# a3r rank ----------------------------------------------------------------------
# rank the workflows had for each dataset


# creating the object
rank_a3r <- matrix(rank(-a3r[, 1]))


# repeating for every column (dataset)
for(i in 2:ncol(a3r)) {
    rank_a3r <- cbind(rank_a3r, rank(-a3r[, i]) )
}


# naming rows and columns
row.names(rank_a3r) <- row.names(a3r)
colnames(rank_a3r) <- colnames(a3r)


# transform in dataframe
data.frame(rank_a3r)

write.csv2(rank_a3r, "rank_a3r.csv")

# average rank -----------------------------------------------------------------
# average rank every workflow obtained


# creating the vector
avgr <- mean(rank_a3r[1, ])


# repeating for every row (workflow)
for (j in 2:nrow(rank_a3r)) {
    avgr <- c(avgr, mean(rank_a3r[j, ]))
}


# the rank of the average of ranks per row (workflow)
avgrr <- rank(avgr, ties.method = "random")
rank_a3r <- cbind(rank_a3r, avgr, avgrr)
write.csv2(rank_a3r, "rank.csv")

order_a3r <- sort(rank_a3r[,ncol(rank_a3r)])
write.csv2(order_a3r, "rank_a3r_order.csv")
