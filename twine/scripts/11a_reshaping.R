# PROBLEM:
# ------------------------------------------------------------------------------



# input: -----------------------------------------------------------------------

# setup task  acc
#     1    1 0.90
#     2    1 0.98
#     1    2 0.80
#     2    2 0.78
#     1    3 0.67
#     2    3 0.99


# desired: ---------------------------------------------------------------------

# 1 setup 1.00 2.00 3.00
# 2     1 0.90 0.80 0.67
# 3     2 0.98 0.78 0.99

# ------------------------------------------------------------------------------


# input ------------------------------------------------------------------------
df <- matrix( data = c( 1, 1, 0.9
                      , 2, 1, 0.98
                      , 1, 2, 0.8
                      , 2, 2, 0.78
                      , 1, 3, 0.67
                      , 2, 3, 0.99
                      )
                , byrow = TRUE
                , nrow = 6
                , ncol = 3
                )

colnames(df) <- c("setup", "task", "acc")
as.data.frame(df)


library(reshape2)

new_df <- melt(df, id.vars = c("setup", "task"))
new_df$variable <- NULL
new_df <- aggregate(. ~ setup, new_df, list)

final_df <- cbind(
    new_df$setup,
    as.data.frame(do.call(rbind, new_df$value))
)
colnames(final_df) <- c("setup",new_df$task[[1]])
final_df

library(reshape2)

# input ------------------------------------------------------------------------
df <- matrix( data = c( 1, 1, 0.9
                        , 2, 1, 0.98
                        , 1, 2, 0.8
                        , 2, 2, 0.78
                        , 1, 3, 0.67
                        , 2, 3, 0.99
)
, byrow = TRUE
, nrow = 6
, ncol = 3
)

colnames(df) <- c("setup", "task", "acc")
df <- as.data.frame(df) 

new_df <- melt(df, id.vars = c("setup", "task"))
new_df$variable <- NULL
new_df <- aggregate(. ~ setup, new_df, list)

final_df <- cbind(
    new_df$setup,
    as.data.frame(do.call(rbind, new_df$value))
)
colnames(final_df) <- c("setup",new_df$task[[1]])
final_df


