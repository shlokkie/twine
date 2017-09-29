# rank-acc.R
# ------------------------------------------------------------------------------




# accuracy rank ----------------------------------------------------------------



# creating the object
rank_acc <- matrix(rank(-accu[, 1]))


# repeating for every column (dataset)
for (i in 2:ncol(accu)) {
    rank_acc <- cbind(rank_acc, rank(-accu[, i]))
}

# naming rows and columns
row.names(rank_acc) <- row.names(accu)
colnames(rank_acc) <- colnames(accu)

# transform in dataframe
data.frame(rank_acc)

write.csv2(rank_acc, "rank_acc.csv")

# average rank -----------------------------------------------------------------
# average rank every workflow obtained


# creating the vector
avgr_acc <- mean(rank_acc[1, ])


# repeating for every row (workflow)
for (j in 2:nrow(rank_acc)) {
    avgr_acc <- c(avgr_acc, mean(rank_acc[j, ]))
}


# the rank of the average of ranks per row (workflow)
avgrr_acc <- rank(avgr_acc, ties.method = "random")

rank_acc <- cbind(rank_acc, avgr_acc, avgrr_acc)

write.csv2(rank_acc, "rank_acc.csv")

order_acc <- sort(rank_acc[,ncol(rank_acc)])
write.csv2(order_acc, "rank_acc_order.csv")


# # A3R --------------------------------------------------------------------------
# # the N = 40



# a3r <- accu/times^(1/40)

# write.table(a3r, "a3r.csv", dec = ".", sep = ";")


# # a3r rank ----------------------------------------------------------------------
# # rank the workflows had for each dataset


# # creating the object
# real.rank.a3r <- matrix(rank(-a3r[, 1]))


# # repeating for every column (dataset)
# for(i in 2:ncol(a3r)) {
#     real.rank.a3r <- cbind(real.rank.a3r, rank(-a3r[, i]) )
# }


# # naming rows and columns
# row.names(real.rank.a3r) <- row.names(a3r)
# colnames(real.rank.a3r) <- colnames(a3r)


# # transform in dataframe
# data.frame(real.rank.a3r)

# write.csv2(real.rank.a3r, "real.rank.a3r.csv")

# # average rank -----------------------------------------------------------------
# # average rank every workflow obtained


# # creating the vector
# avgr <- mean(real.rank.a3r[1, ])


# # repeating for every row (workflow)
# for (j in 2:nrow(real.rank.a3r)) {
#     avgr <- c(avgr, mean(real.rank.a3r[j, ]))
# }


# # the rank of the average of ranks per row (workflow)
# avgrr <- rank(avgr, ties.method = "random")
# rank <- cbind(real.rank.a3r, avgr, avgrr)
# write.csv2(rank, "rank.csv")

# order <- sort(rank[,ncol(rank)])
# write.csv2(order, "rank-order.csv")


# flows <- read.csv(file = "./data/flows.csv")
# flows <- class(flows[,1])

# sort(flows$workflow)

# # need to order flows in function to this "order"


# #this is kinda useless though.
# # ------------------------------------------------------------------------------