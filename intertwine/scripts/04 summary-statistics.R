# 04 summary-statistics.R
# ------------------------------------------------------------------------------

View(reg_data)

sum_data <- data.frame(reg_data$data, reg_data$workflow, reg_data$accuracy, reg_data$time)
View(sum_data)

colnames(sum_data) <- c(colnames(reg_data)[1], colnames(reg_data)[3], colnames(reg_data)[12], colnames(reg_data)[15])



# install.packages("psych", dependencies = TRUE)
# install.packages("plyr", dependencies = TRUE)
install.packages("data.table", dependencies = TRUE)
# library(psych)
library(data.table)
# describeBy(sum_data$accuracy, group = sum_data$data)
# describeBy(sum_data$time, group = sum_data$data, digits = 10)
# 
# fivenum(sum_data$accuracy)
# fivenum(sum_data$time)
# View(sum_data)
# colnames(reg_data)
# length(colnames(reg_data))
# fivenum(sum_data$accuracy)

# write.table(acc_data, file ="acc_data.csv")


# acc_data <- describeBy(sum_data$accuracy, group = sum_data$data)
# time_data <- describeBy(sum_data$time, group = sum_data$data)
# acc_work <- describeBy(sum_data$accuracy, group = sum_data$workflow)
# time_work <- describeBy(sum_data$time, group = sum_data$workflow)


mean(sum_data$accuracy)
mean(sum_data$time)
range(sum_data$accuracy)


# absolute best result
reg_data[which.max(reg_data$accuracy), ]

# absolute worst result
reg_data[which.min(reg_data$accuracy), ]


dt <- data.table(sum_data)
setkey(dt, data)
acc_data <- dt[,list( mean   = mean(accuracy)
                    , sd     = sd(accuracy)
                    , min    = min(accuracy)
                    , max    = max(accuracy)
                    , median = median(accuracy)
                    )
               , by = data]

time_data <- dt[,list( mean   = mean(time)
                     , sd     = sd(time)
                     , min    = min(time)
                     , max    = max(time)
                     , median = median(time)
                     )
                     , by = data]

acc_flow <- dt[,list( mean   = mean(accuracy)
                    , sd     = sd(accuracy)
                    , min    = min(accuracy)
                    , max    = max(accuracy)
                    , median = median(accuracy)
                    )
                    , by = workflow]

time_flow <- dt[,list( mean   = mean(time)
                     , sd     = sd(time)
                     , min    = min(time)
                     , max    = max(time)
                     , median = median(time)
                     )
                     , by = workflow]


write.table((acc_data), file = "acc_data.csv", sep = ";", dec = ".")
write.table((acc_flow), file = "acc_flow.csv", sep = ";", dec = ".")
write.table((time_data), file = "time_data.csv", sep = ";", dec = ".")
write.table((time_flow), file = "time_flow.csv", sep = ";", dec = ".")


