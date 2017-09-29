require(ggplot2)
require(devEMF)
require(reshape)

Avg_Rank_Acc <- function(file_acc = "", file_time = "", convert_millis = F) {
  if (file_acc == "" | file_time == ""){return("ERROR: FILE PATH IS BLANK")} 
  
  #****************************************************************************************
  # The code below is used to calculate the average ranking using accuracy only as a measure 
  acca.lsample <- read.csv(file_acc, stringsAsFactors = F)
  time.lsample <- read.csv(file_time, stringsAsFactors = F)
  
  #substitute time = 0 by time = 1
  time.lsample[time.lsample==0] <- 0.001
  
  #Convert milliseconds to seconds
  if (convert_millis) {time.lsample[,-1] <- time.lsample[,-1]/1000}
  
  # Creating  empty dataframes "accs","accr" and accm with one column "setup_id"
  
  setups <- acca.lsample[,1] 
  accr <- data.frame(setup_id=setups, stringsAsFactors=FALSE)
  accm <- data.frame(setup_id=setups, stringsAsFactors=FALSE)
  
  # assigning levels to the column of our dataframe  
  
  accr$setup_id <-  factor(accr$setup_id,levels=setups)
  accm$setup_id <-  factor(accm$setup_id,levels=setups)
  
  # retrieving taskids and names from our auxiliary dataframe "asso.taskid
  task.ids <- colnames(acca.lsample)[-1]
  
  # Identify new task/dataset id and name
  for (j in 1:length(task.ids)){
    new.task.id <- task.ids[j] 
    remaining.tasks <- task.ids[-j] # Identify other tasks/datasets and the number of samples in each dataset
    acc.lsample.subset <- acca.lsample[,-(j+1)] # create subsets accuracy on last sample
    accs <- acc.lsample.subset # create subsets time on last sample
    for (k in 1:length(remaining.tasks )){
      accr1 <- rank(accs[,k+1]) # ranking our algorithms based on the type of task 
      accr[,k+1] <- accr1 # assigning the rank "accr1" to position k+1 in "accr" dataframe
    } 
    
    ncol <- colnames(accr)[2:length(colnames(accs))]  # calculating the mean rank and adding it to our dataframe "accm" 
    accr.mean <- rowMeans(subset(accr, select = ncol) )
    # cat(accr.mean,"\n")
    accm[,j+1] <- accr.mean
    colnames(accm)[j+1] <- new.task.id # add the name of the new task/dataset in position j+1
    # end of new dataset  cycle 
    
  }  
  #accm -> RESULT: Rankings of configs per dataset, using only the results of the remaining datasets.
  write.csv(x = accm, file = "./Outputs/Avg_Ranking/accm.csv")
  return(accm)
}

Avg_Rank_A3R <- function(file_acc = "", file_time = "", file_defaults = "", file_best = "", convert_millis = F, P_AR = 1/64, P_AT = 1/16) {
  #browser()
  P <- as.numeric(P_AR)
  if (file_acc == "" | file_time == ""){return("ERROR: FILE PATH IS BLANK")} 
  
  #****************************************************************************************
  # The code below is used to obtain the global ranking of set of algorithms across different datasets using a combined 
  #  measure of accuracy and time (A3R).
  acca.lsample <- read.csv(file_acc, stringsAsFactors = F)
  time.lsample <- read.csv(file_time, stringsAsFactors = F)
  if(file_best!=""){Best.df <- read.csv(file_best, stringsAsFactors = F)}
  
  #substitute time = 0 by time = 1
  time.lsample[time.lsample==0] <- 0.001
  
  #Convert milliseconds to seconds
  if (convert_millis) {
    time.lsample[,-1] <- time.lsample[,-1]/1000
    if(file_best!=""){Best.df[,3] <- Best.df[,3]/1000}
  }
  
  # Creating  empty dataframes "accs","accr" and accm with one column "setup_id"
  
  setups <- acca.lsample[,1] 
  accr <- data.frame(setup_id=setups, stringsAsFactors=FALSE)
  accm.a3r <- data.frame(setup_id=setups, stringsAsFactors=FALSE)
  
  # assigning levels to the column of our dataframe  
  
  accr$setup_id <-  factor(accr$setup_id,levels=setups)
  accm.a3r$setup_id <-  factor(accm.a3r$setup_id,levels=setups)
  
  # retrieving taskids and names from our auxiliary dataframe "asso.taskid
  task.ids <- colnames(acca.lsample)[-1]
  
  #  creating a copy of the dataframe that contains rankings of algorithms across datasets using accuracy only
  accm.aux <- Avg_Rank_Acc(file_acc, file_time, convert_millis)
  
  # Identify new task/dataset id and name
  for (j in 1:length(task.ids)){
    #        for (j in 1:1){
    new.task.id <- task.ids[j]
    remaining.tasks <- task.ids[-j] # Identify other tasks/datasets and the number of samples in each dataset
    acc.lsample.subset <- acca.lsample[,-(j+1)] # create subsets accuracy on last sample
    time.lsample.subset <- time.lsample[,-(j+1)] # create subsets time on last sample
    accs <- acc.lsample.subset
    acct <- time.lsample.subset
    a3r.measure <- data.frame(setup_id= setups, stringsAsFactors=FALSE) # Creating a dataframe a3rmeasure to store our combined measure of accuracy and time
    a3r.measure$setup_id <-  factor( a3r.measure$setup_id,levels=setups) # adding levels to our dataframe and creating a vector
    a3r.vector <- c()    
    
    # Using our measure that combine accuracy and time to obtain a ranking      
    no.rtasks <- ncol(accs)-1 #number of remaining tasks?
    for (i in 1:no.rtasks){
      
      acc.all <- accs[,i+1]
      time.all <- acct[,i+1]
      
      accm.sub <- accm.aux[,j+1]
      best.rank <- max(accm.sub)
      idx.best.rank<- which.max(accm.sub)
      #brank.alg <- accm.aux[idx.best.rank,"setup_id"]
      acc.best <- acc.all[idx.best.rank]
      time.best <- time.all[idx.best.rank]
      
      # if (file_best=="") {
      #   accm.sub <- accm.aux[,j+1]
      #   best.rank <- max(accm.sub)
      #   idx.best.rank<- which.max(accm.sub)
      #   #brank.alg <- accm.aux[idx.best.rank,"setup_id"]
      #   acc.best <- acc.all[idx.best.rank]
      #   time.best <- time.all[idx.best.rank]
      # } else {
      #   acc.best<- Best.df[j, 2]
      #   time.best<- Best.df[j, 3]        
      # }
      
      
      for (k in 1:length(setups)){
        acc.other <- acc.all[k]
        time.other <-time.all[k]
        a3r <- (acc.other/acc.best)/(time.other/time.best)^P #default p = 1/64
        a3r.vector[k] <- a3r
        #  end of cycle a3r         
      } 
      
      a3r.measure <- cbind(a3r.measure, a3r.vector)
      accr1 <- rank(a3r.measure[,i+1]) # ranking our algorithms based on the type of task 
      accr[,i+1] <- accr1 # assigning the rank "accr1" to position k+1 in "accr" dataframe
      
      # end of cycle no.rtasks      
    } 
    
    # calculating the mean rank and adding it to our dataframe "accm" 
    ncol <- colnames(accr)[2:length(colnames(accs))]  
    accr.mean <- rowMeans(subset(accr, select = ncol) )
    accm.a3r[,j+1] <- accr.mean
    
    colnames(accm.a3r)[j+1] <- as.character(task.ids[j]) # add the name of the new task/dataset in position j+1
    # end of new dataset  cycle 
  }  
  
  # accm.a3r
  write.csv(accm.a3r, "./Outputs/Avg_Ranking/accm.a3r.csv", row.names=FALSE)
  
  #******************************************************************************
  # This code is used to generate the loss-time curve using the average ranking that uses A3R 
  
  setups <- acca.lsample[,1] 
  no.of.test <- 1:(2*length(setups)) #MAC: give sufficient size 
  Loss.AR.A3R64<- data.frame(no_of_test=no.of.test, stringsAsFactors=FALSE)
  Time.AR.A3R64 <- data.frame(no_of_test=no.of.test, stringsAsFactors=FALSE)
  # assigning levels to the column of our dataframe  
  Loss.AR.A3R64$no_of_test <-  factor(Loss.AR.A3R64$no_of_test,levels=no.of.test)
  Time.AR.A3R64$no_of_test <-  factor(Time.AR.A3R64$no_of_test,levels=no.of.test)
  
  z <- 1
  l <- 1
  
  for (j in 1:length(task.ids)){
    
    # create subsets of ranks, accuracy and the build cpu time 
    
    accm.subset <- accm.a3r[,c(1,j+1)] # ranking using combined measure of accuracy and time (A3R)
    acc.lsample.subset <- acca.lsample[,c(1,j+1)]
    time.subset <- time.lsample[,c(1,j+1)]
    
    # use leave-one-out strategy for each new task to calculate the loss 
    acc.lsample.vector <-acc.lsample.subset[,z+1]
    
    # add the above two vector to accm.subset to obtain a dataframe that contains ranks, accuracy and build cpu time
    merged.acc.time.rank <- accm.subset
    merged.acc.time.rank <- cbind(merged.acc.time.rank, acc.lsample.vector)
    
    # renames the columns in the above dataframe "merged.acc.time.rank"    
    colnames(merged.acc.time.rank)[z+1] <- "mean_global_rank"
    colnames(merged.acc.time.rank)[z+2] <- "predictive_accuracy"
    
    
    # order the rank column in the dataframe "merged.acc.time.rank"
    merged.acc.time.rank.ordered <-  merged.acc.time.rank[order(merged.acc.time.rank[,z+1], decreasing = TRUE), ] #it is decreasing because the ranking is descending
    
    # creating a copy of merged.acc.time.rank.ordered   
    merged.acc.time.rank.ordered.aux <- merged.acc.time.rank.ordered
    # calculate the accuracy loss
    # Initialize some counters
    k <- 1 
    m <- 1
    initial.build.cpu.time <- 0
    
    if (file_best=="") {
      best.acc <- max(merged.acc.time.rank.ordered.aux[,m+2])
    } else {
      best.acc <- Best.df[j,2] 
    }
    
    # Initialising loss to be the highest accuracy
    loss0 <-  best.acc  
    extra.l <- 0
    for (i in 1:length(setups)){
      
      # retrieving the accuracy and ranks from our merged  dataframe (merged.acc.time.rank.ordered.aux)  
      best.rank <- max(merged.acc.time.rank.ordered.aux[,m+1]) 
      idx.best.rank <- which.max(merged.acc.time.rank.ordered.aux[,m+1]) 
      best.rec.alg <- merged.acc.time.rank.ordered.aux[idx.best.rank,"setup_id"]
      new.acc <- merged.acc.time.rank.ordered.aux[idx.best.rank,m+2]
      loss1 <- best.acc - new.acc  
      if(loss1 < loss0) {
        new.loss <- loss1
      } else {
        new.loss <- loss0   
      }
      # obtain the time for the test   
      build.cpu.time <-  time.subset[time.subset$setup_id==best.rec.alg,2]
      sum.build.cpu.time <- build.cpu.time + initial.build.cpu.time
      # test to see if the  loss1 is less than the loss0 and store the previous loss and time of the test     
      if(loss1 < loss0) {
        Loss.AR.A3R64[k+extra.l,l+1] <- loss0
        Time.AR.A3R64[k+extra.l,l+1] <- sum.build.cpu.time 
        extra.l <- extra.l+1
      }
      
      # store the new loss and time of the test with a small multiplier     
      Loss.AR.A3R64[k+extra.l,l+1] <- new.loss
      Time.AR.A3R64[k+extra.l,l+1] <- sum.build.cpu.time*1.00001   
      # update the default loss with the value of the new loss    
      loss0 <- new.loss 
      
      # incrementing the position where the new loss will be added in "acc.loss.time"
      k <- k+1  
      # set the previous best rank to 0      
      merged.acc.time.rank.ordered.aux[idx.best.rank,m+1] <- 0 #MAC: beacuse ranks are in ascedning order (higher -> better)
      initial.build.cpu.time <- sum.build.cpu.time
      # end of setup cycle  
    }
    
    # incrementing the column counter in our new dataframe "ranking.acc.loss"
    l <- l + 1          
  }
  
  # change the  NAs generated in the loss dataframe to 0s  
  Loss.AR.A3R64[is.na(Loss.AR.A3R64)] <- 0
  #Time.AR.A3R64[is.na(Time.AR.A3R64)] <- 0
  
  # Remove the default loss for the task and replaced with the actual default loss calculated
  #  Note that this is done next
  Loss.AR.A3R64 <- Loss.AR.A3R64[-1,]
  Time.AR.A3R64 <- Time.AR.A3R64[-1,]
  write.csv(Loss.AR.A3R64 , "./Outputs/Avg_Ranking/Loss.AR.A3R64.csv" , row.names=FALSE)
  write.csv(Time.AR.A3R64,  "./Outputs/Avg_Ranking/Time.AR.A3R64.csv" , row.names=FALSE)
  #************************************************************************************************************************
  
  # This code is used to aggregate different time and losses generated
  # obtain the loss of one of the tasks
  matrix_zeros_L <- matrix(rep(0,length(task.ids)), nrow = 1)
  matrix_zeros_T <- matrix(rep(0,length(task.ids)), nrow = 1)
  matrix_names_L <- paste("L",seq(1:length(task.ids)), sep = "")
  matrix_names_T <- paste("T",seq(1:length(task.ids)), sep = "")
  colnames(matrix_zeros_L) <- matrix_names_L
  colnames(matrix_zeros_T) <- matrix_names_T
  Loss.AR.A3R64.red  <- data.frame(matrix_zeros_L)
  Time.AR.A3R64.red  <- data.frame(matrix_zeros_T)
  # cycle for all tasks  
  for (j in 1:length(task.ids)){
    
    reduced.loss <- Loss.AR.A3R64[,j+1][Loss.AR.A3R64[,j+1] > 0]
    reduced.loss <- c(reduced.loss,0)
    loss.length <- length(reduced.loss)
    
    # obtain the test time of one of the tasks
    test.time <- Time.AR.A3R64[,j+1]
    test.time <- test.time[1:loss.length]
    # cycle for all tests    
    for (k in 1:loss.length){ 
      l <- reduced.loss[k]
      t <- test.time[k]
      Loss.AR.A3R64.red [k,j] <- l
      Time.AR.A3R64.red [k,j] <- t 
      # end of cycle tests 
    }
    
    # end of all tasks
  }
  
  Loss.AR.A3R64.red [is.na(Loss.AR.A3R64.red)] <- 0
  #Time.AR.A3R64.red [is.na(Time.AR.A3R64.red)] <- 0
  
  write.csv(Loss.AR.A3R64.red,"./Outputs/Avg_Ranking/Loss.AR.A3R64.red.csv", row.names=FALSE)
  write.csv(Time.AR.A3R64.red,"./Outputs/Avg_Ranking/Time.AR.A3R64.red.csv", row.names=FALSE)
  
  #*************************************************************************************
  # This code is use to aggregate the loss and time using the concept of interpolation
  
  loss <-  Loss.AR.A3R64.red
  time <-  Time.AR.A3R64.red
  ######################################################################################  
  #browser()
  # read the default loss dataframe    
  dflt.acc     <- read.csv(file_defaults) #original code imported losses; MAC changed to import accuracies
  best_by_task <- apply(acca.lsample[,-1],2,max)
  dflt.acc[,3] <- best_by_task - dflt.acc[,3]
  
  # Add the default loss to the Loss dataframe 
  r <- 1
  newrow <- dflt.acc[,3] 
  insertRow <- function(loss, newrow, r) {
    loss[seq(r+1,nrow(loss)+1),] <- loss[seq(r,nrow(loss)),]
    loss[r,] <- newrow
    return(loss)
  }
  loss <- insertRow(loss, newrow, r)
  #  # Edit the start time of the start to be at 1 second at which we have the default loss 
  newrow1 <-  rep(0,length(task.ids))
  r <- 1
  insertRow <- function(time, newrow2, r) {
    time[seq(r+1,nrow(time)+1),] <- time[seq(r,nrow(time)),]
    time[r,] <- newrow1
    return(time)
  }
  
  time <- insertRow(time, newrow1, r)
  
  write.csv(loss,"./Outputs/Avg_Ranking/LOSSFS_MAC.csv", row.names=FALSE)
  write.csv(time,"./Outputs/Avg_Ranking/TIMEFS_MAC.csv", row.names=FALSE)    
  
  ###################################################################################### 
  # This code is use to aggregate the loss and time using the concept of interpoloation
  
  # create empty dataframes
  
  matrix_zeros_L <- matrix(rep(0,length(task.ids)), nrow = 1)
  matrix_zeros_T <- matrix(rep(0,length(task.ids)), nrow = 1)
  matrix_names_L <- paste("L",seq(1:length(task.ids)), sep = "")
  matrix_names_T <- paste("T",seq(1:length(task.ids)), sep = "")
  colnames(matrix_zeros_L) <- matrix_names_L
  colnames(matrix_zeros_T) <- matrix_names_T
  trans.loss.df   <- data.frame(matrix_zeros_L)
  trans.time.df <- data.frame(matrix_zeros_T)
  
  # Cycle for all tasks
  
  for(l in 1: length(task.ids)){
    max.exponent <- 6
    std.time1 <- seq(0,max.exponent,0.1)
    std.time <- 10^std.time1
    
    # obtain the losses 
    loss.sub <- loss[,l]
    time.sub <- time[,l]
    time.sub <- time.sub[!is.na(time.sub)]
    length.time <- length(time.sub)
    loss.sub <- loss.sub[1:length.time]
    time.sub <- append(time.sub,(10^max.exponent)*2) #tinha 200 000
    loss.sub <- append(loss.sub,0)
    
    # Tranformation using interpolation( use constant or linear interpoltaion)
    trans.loss.time <- approx(time.sub,loss.sub, xout = std.time, method = "const")
    
    
    # Obtain the interpolated loss and time     
    trans.loss <- trans.loss.time$y
    trans.time <- trans.loss.time$x
    
    # Obtain the length of the losses  
    trans.loss.length <- length(trans.loss) 
    
    # put the results one by one to our trans.loss.df and trans.time.df dataframes
    for(m in 1:trans.loss.length){
      p <- trans.loss[m]
      q <- trans.time[m]
      trans.loss.df[m,l] <- p
      trans.time.df[m,l] <- q 
      # end of cycle for m
      
    }
    
    # end of cycle new task
  }
  
  #Added by MAC to export individual loss curves
  trans.loss.df_export <- trans.loss.df*100
  stand.time <- trans.time.df[,1]
  trans.loss.df_export <- cbind(stand.time,trans.loss.df_export)
  trans.loss.df_export <- data.frame(trans.loss.df_export)
  write.csv(x = trans.loss.df_export, file = "./Outputs/Avg_Ranking/Individual.Loss.Curves.csv")
  #End added by mac
  
  # calculating the meann loss
  mean.loss <- as.numeric(rowMeans(trans.loss.df, na.rm = TRUE))
  # retrieve one of the standard time  
  stand.time <- trans.time.df[,1]
  mean.loss <- cbind(stand.time,mean.loss)
  mean.loss <- data.frame(mean.loss)
  # calculate the MIL using time interval from 10s to 1000s
  mean.loss.r <- mean.loss[mean.loss$stand.time >=10 & mean.loss$stand.time <= 10000, ]
  # convert to 100%
  mean.loss.r.all <- mean(mean.loss.r[,2])*100
  mean.loss[,2]   <- mean.loss[,2]*100
  #mean.loss.r.all
  
  write.csv(mean.loss,"./Outputs/Avg_Ranking/Agreg_Loss-Curve.csv", row.names=FALSE)
  write.csv(mean.loss.r.all,"./Outputs/Avg_Ranking/MIL.csv", row.names=FALSE)
  
  #******************************************************************************************************  
  return(list("Loss-curve" = mean.loss, "MIL" = mean.loss.r.all, "A3R_ranks" = accm.a3r))
}

AT_Simple <- function(file_acc = "", file_time = "", file_defaults = "", file_best = "", convert_millis = F, P_AR = 1/64, P_AT = 1/16) {
  
  P_AR <- as.numeric(P_AR)
  P_AT <- as.numeric(P_AT)
  if (file_acc == "" | file_time == ""){return("ERROR: FILE PATH IS BLANK")} 
  
  #*****************************************************************************************************************
  # The code below implements the active testing method that uses sample-based test
  accm.a3r64.rank.new <- Avg_Rank_A3R(
    file_acc = file_acc,
    file_time = file_time,
    file_defaults = file_defaults,
    file_best = file_best,
    convert_millis = convert_millis,
    P_AR = P_AR,
    P_AT = P_AT
  )[[3]] #Get A3R Avg_Ranking rankings from function
  acca.lsample <- read.csv(file_acc, stringsAsFactors = F)
  time.lsample <- read.csv(file_time, stringsAsFactors = F)
  task.ids <- colnames(acca.lsample)[-1]
  if(file_best!=""){Best.df <- read.csv(file_best, stringsAsFactors = F)}
  
  #substitute time = 0 by time = 1
  time.lsample[time.lsample == 0] <- 0.001
  
  #Convert milliseconds to seconds
  if (convert_millis) {
    time.lsample[,-1] <- time.lsample[,-1] / 1000
    if(file_best!=""){Best.df[,3] <- Best.df[,3]/1000}
  }
  
  #browser()
  # Creating  dataframes  to store our results
  setups <- accm.a3r64.rank.new[, 1]
  no.of.test <- 1:(2 * length(setups)) #MAC: give sufficient size
  accs <- data.frame(setup_id = setups, stringsAsFactors = FALSE)
  acct <- data.frame(setup_id = setups, stringsAsFactors = FALSE)
  Loss.AT.A3R <-
    data.frame(no_of_test = no.of.test, stringsAsFactors = FALSE)
  Time.AT.A3R <-
    data.frame(no_of_test = no.of.test, stringsAsFactors = FALSE)
  # assigning levels to the column of our dataframe
  Loss.AT.A3R$no_of_test <-
    factor(Loss.AT.A3R$no_of_test, levels = no.of.test)
  Time.AT.A3R$no_of_test <-
    factor(Time.AT.A3R$no_of_test, levels = no.of.test)
  accs$setup_id <-  factor(accs$setup_id, levels = setups)
  acct$setup_id <-  factor(acct$setup_id, levels = setups)
  
  # Creating a copy of "accm" that contains the average ranks
  accm.aux <- accm.a3r64.rank.new
  
  # Creating some vectors that will be used to store some results
  current.best.vector <- c()
  diff.accuracy  <- c()
  loss.vector <- c()
  time.vector <- c()
  tested_setups_df <- data.frame("remove" = rep(0, length(setups))) #Added by MAC
  
  # cycle for new task
  
  for (z in 1:length(task.ids)) {
    # for (z in 1:1){
    new.task.id <- task.ids[z]
    remaining.tasks <- task.ids[-z]
    
    # Identify how many samples in new task/dataset
    # new.task.res <- merged.res[merged.res$"task_id"==new.task.id,]
    # no.samples.new <- dim(table((new.task.res$sample)))
    # obtain small dataframe that contains average rankings, accuracy and time for the new task
    
    time.subset <- time.lsample[, c(1, z + 1)]
    acca.subset <-  acca.lsample[, c(1, z + 1)]
    accm.aux.subset <- accm.aux[, c(1, z + 1)]
    
    # Merging some columns of acca and accm
    result.subset <-
      merge(acca.subset,
            accm.aux.subset,
            by.x = "setup_id",
            by.y = "setup_id")
    m <- 1
    
    # identify best setups in the new task
    #best.acc <- max(result.subset[, m + 1])
    
    if (file_best=="") {
      best.acc <- max(result.subset[, m + 1])
    } else {
      best.acc <- Best.df[z,2] 
    }    
    
    
    # Initialize loss to be the highest accuracy
    loss0 <-  best.acc
    # Identify the top most algorithm (current best) from the average ranking
    best.rank <- max(result.subset[, 3])
    idx.best.rank <- which.max(result.subset[, 3])
    current.best <- result.subset[idx.best.rank, "setup_id"]
    
    # cycle construct a dataframe with the accuracies of the remaining tasks
    
    # create subsets accuracy on last sample
    
    accs <- acca.lsample[,-(z + 1)]
    
    # create subsets time on last sample
    acct <- time.lsample[,-(z + 1)]
    
    
    # Implements the active testing method which uses performance estimates (relative landmarks)
    
    # obtain the remaining setups that does not contain the current best
    other.setups <- setups[setups != current.best]
    current.best.vector <- c()
    sum.diff <- c()
    sum.diff.df <- data.frame()
    
    
    # Implements the active testing method which uses relative landmarks
    
    # Creating a dataframe a3rmeasure to store our combined measure of accuracy and time
    
    a3r.measure <-
      data.frame(setup_id = setups, stringsAsFactors = FALSE)
    
    # adding levels to our dataframe and creating a vector
    a3r.measure$setup_id <-
      factor(a3r.measure$setup_id, levels = setups)
    a3r.vector <- c()
    # Using our measure that combine accuracy and time to obtain a ranking
    
    # cycle for all the remaining tasks
    no.rtasks <- ncol(accs) - 1
    
    for (i in 1:no.rtasks) {
      acc.all <- accs[, i + 1]
      time.all <- acct[, i + 1]
      accm.sub <- accm.aux[, i + 1]
      best.rank <- max(accm.sub)
      idx.best.rank2 <- which.max(accm.sub)
      brank.alg <- accm.aux[idx.best.rank2, "setup_id"]
      
      acc.best <- acc.all[idx.best.rank2]
      time.best <- time.all[idx.best.rank2]
      
      for (j in 1:length(setups)) {
        acc.other <- acc.all[j]
        time.other <- time.all[j]
        
        a3r1 <-
          (acc.other / acc.best) / (time.other / time.best) ^ P_AT
        # a3r1 <- (acc.best/acc.other)/(time.best/time.other)^(1/8)
        
        
        # check to see whether a3r1 is greater than 1
        if (a3r1 > 1) {
          a3r <- a3r1 - 1
          
        } else {
          a3r <- 0
          
        }
        
        a3r1 <- unlist(a3r)
        a3r.vector[j] <- a3r1
        
        # end of cycle a3r for each setup
        
      }
      a3r.measure <- cbind(a3r.measure, a3r.vector)
      colnames(a3r.measure)[i+1] <- colnames(accs)[i+1]
      
      # end of cycle no.rtasks
      
    }
    
    
    # calculate the of the relative landmarks across all tasks
    
    # droping the current best algorithm from the relative landmarks
    # a3r.measure1 <- a3r.measure[-idx.best.rank,]
    a3r.measure1 <- a3r.measure[-idx.best.rank2,]
    setups.60 <- a3r.measure1$"setup_id"
    
    #POTENTIAL PLACE TO INCLUDE SIMILARITY!
    
    for (k in 1:length(setups.60)) {
      a3r.sum <- a3r.measure1[k,]
      a3r.sum <- as.matrix(sapply(a3r.sum, as.numeric))
      a3r.sum  <- a3r.sum [-1]
      a3r.sum <- sum(a3r.sum)
      
      
      sum.diff.df[k, "setup_id"] <- setups.60[k]
      sum.diff.df[k, "a3r_value"] <- a3r.sum
      
      # end of cycle calculate the of the relative landmarks across all tasks
    }
    #  sum.diff.df[apply(sum.diff.df[2],1,function(z) !any(z==0)),]
    #  init.sum.diff.df <- sum.diff.df
    sum.diff.df1 <- sum.diff.df
    
    
    # Initialising loss to be the highest accuracy
    loss0 <-  best.acc
    
    # Identify the top most algorithm (current best) from the average ranking
    best.rank <- max(result.subset[, 3])
    idx.best.rank <- which.max(result.subset[, 3])
    current.best <- result.subset[idx.best.rank, "setup_id"]
    acc.current.best <- result.subset[idx.best.rank, 2]
    loss.current.best <- best.acc - acc.current.best
    
    #create some vector to store results
    time.vector  <-    c()
    loss.vector  <-    c()
    tested.setups <-   c()
    RG <- result.subset
    
    # set initial loss and time
    initial.current.best <- current.best
    initial.loss <- loss.current.best
    initial.time.c.best <-
      time.subset[time.subset$setup_id == initial.current.best, 2]
    initial.build.cpu.time <-
      time.subset[time.subset$setup_id == current.best, 2]
    
    # create a counter to loss and time dataframes
    extra.l <- 0
    
    # Identify the best competitor/setup using the performance estimates(relative landmark)
    
    for (f in 1:length(other.setups)) {
      #    for (f in 1:1){
      max.sum.diff <- max(sum.diff.df1[, 2])
      idx.best.compete <- which.max(sum.diff.df1[, 2])
      best.compete <- sum.diff.df1[idx.best.compete, "setup_id"]
      best.compete <- as.vector(best.compete)
      
      # obtain the performance of the best competitor and the current best using a sample based test
      
      acc.new.current.best <-
        result.subset[result.subset$"setup_id" == current.best, 2]
      acc.new.best.compete <-
        result.subset[result.subset$"setup_id" == best.compete, 2]
      
      # Identify the new current best
      
      if (acc.new.best.compete > acc.new.current.best) {
        current.best <- best.compete
        acc.new.current.best <-
          result.subset[result.subset$"setup_id" == best.compete, 2]
      } else {
        current.best <- current.best
        acc.new.current.best <-
          result.subset[result.subset$"setup_id" == current.best, 2]
      }
      
      current.best <- as.vector(current.best)
      
      #    cat( "current best",current.best,"\n")
      
      #    current.best.vector[f] <- current.best
      
      # comparing our loss1 with the initial loss which is associated with the first top algorithm from the global ranking
      #    acc.new.current.best <- result.subset[result.subset$"setup_id"==current.best,2]
      loss1 <- best.acc -  acc.new.current.best
      
      
      #  compare the initial loss(associated with top most algoirthm) and the new loss (associated with new current best)
      
      if (loss1 > initial.loss) {
        loss1 <- initial.loss
      }
      # compare the loss with the default acccuracy
      
      if (loss1 < loss0) {
        new.loss <- loss1
      } else {
        new.loss <- loss0
      }
      # record the time for the test
      build.cpu.time <-
        time.subset[time.subset$setup_id == best.compete, 2] # Initial bug: Had "time.subset[time.subset$setup_id == current.best, 2]" Changed by MAC
      sum.build.cpu.time <- build.cpu.time + initial.build.cpu.time
      
      #   check to see if the loss has changed
      if (loss1 < loss0) {
        loss.vector[f + extra.l] <- loss0
        time.vector[f + extra.l] <- sum.build.cpu.time
        extra.l <- extra.l + 1
      }
      
      loss.vector[f + extra.l] <- new.loss
      time.vector[f + extra.l] <- sum.build.cpu.time * 1.00001
      
      # update the loss our performance estimates dataframe and initial time
      loss0 <- new.loss
      sum.diff.df1[idx.best.compete, 2] <- -1
      initial.build.cpu.time <- sum.build.cpu.time
      
      
      # tracking the algorithms that were tested already
      
      tested.setups[f] <- as.vector(best.compete)
      tested.setups <- unique(as.integer(tested.setups))
      reduced.setups <-
        other.setups[!other.setups %in% tested.setups]
      length.reduced.setups <- length(reduced.setups)
      
      if (length.reduced.setups > 0) {
        # test whether the current best has changed and recomputes the performance estimates using the reamining algorithms.
        if (current.best == best.compete) {
          # recomputes the performance estimates
          
          # Creating a dataframe a3rmeasure to store our combined measure of accuracy and time
          
          
          a3r.measure1 <-
            data.frame(setup_id = reduced.setups, stringsAsFactors = FALSE)
          
          # adding levels to our dataframe and creating a vector
          a3r.measure1$setup_id <-
            factor(a3r.measure1$setup_id, levels = reduced.setups)
          a3r.vector <- c()
          # Using our measure that combine accuracy and time to obtain a ranking
          
          # cycle for all the remaining tasks
          no.rtasks <- ncol(accs) - 1
          
          for (i in 1:no.rtasks) {
            acc.all <- accs[reduced.setups, i + 1] #MAC Had: "accs[, i + 1]" (all setups, not reduced)
            time.all <- acct[reduced.setups, i + 1] #MAC Had: "acct[, i + 1]" (all setups, not reduced)
            
            
            acc.best  <-  accs[accs$"setup_id" == current.best, i + 1]
            time.best <-  acct[acct$"setup_id" == current.best, i + 1]
            
            
            for (j in 1:length(reduced.setups)) {
              acc.other <- acc.all[j]
              time.other <- time.all[j]
              
              a3r1 <-
                (acc.other / acc.best) / (time.other / time.best) ^ P_AT
              #  a3r1 <- (acc.best/acc.other)/(time.best/time.other)^(1/8)
              
              
              # check to see whether a3r1 is greater than 1
              if (a3r1 > 1) {
                a3r <- a3r1 - 1
                
              } else {
                a3r <- 0
                
              }
              
              a3r1 <- unlist(a3r)
              a3r.vector[j] <- a3r1
              
              # end of cycle a3r for each setup
              
            }
            a3r.measure1 <- cbind(a3r.measure1, a3r.vector)
            colnames(a3r.measure1)[i+1] <- colnames(accs)[i+1]
            
            # end of cycle no.rtasks
            
          }
          
          sum.diff <- c()
          sum.diff.df <- data.frame()
          
          # calculate the of the relative landmarks across all tasks
          
          setups.60 <- a3r.measure1$"setup_id"
          for (k in 1:length(setups.60)) {
            a3r.sum <- a3r.measure1[k,]
            a3r.sum <- as.matrix(sapply(a3r.sum, as.numeric))
            a3r.sum  <- a3r.sum [-1]
            a3r.sum <- sum(a3r.sum)
            
            
            sum.diff.df[k, "setup_id"] <- setups.60[k]
            sum.diff.df[k, "a3r_value"] <- a3r.sum
            
            # end of cycle calculate the of the relative landmarks across all tasks
          }
          
          sum.diff.df1 <- sum.diff.df
          
          
        } else {
          sum.diff.df1 <- sum.diff.df1
          
          # end if test to see whether the current best has changed
        }
        
      } else{
        #  end of cycle identify the best competitor
        
      }
      
      # end if
    }
    
    tested_setups_df[,new.task.id] <- c(as.numeric(levels(brank.alg)[brank.alg]), tested.setups) #added by MAC
    
    time.vector <-  time.vector[-1]
    loss.vector <-  loss.vector[-1]
    
    initial.time.c.best <-
      time.subset[time.subset$setup_id == initial.current.best, 2]
    current.best.vector <- unique(as.integer(current.best.vector))
    loss.vector.final <- c(initial.loss, loss.vector)
    time.vector.final <- c(initial.time.c.best, time.vector)
    l.loss <- length(loss.vector.final)
    k <- 1
    for (h in 1:l.loss) {
      Loss.AT.A3R[k, z + 1] <- loss.vector.final[h]
      Time.AT.A3R[k, z + 1] <- time.vector.final[h]
      k <- k + 1
    }
    
    
    # end cycle for new task.ids
    
  }
  Loss.AT.A3R[is.na(Loss.AT.A3R)] <- 0
  write.csv(Loss.AT.A3R,
            "./Outputs/Active_Testing/Loss.AT.A3R.csv",
            row.names = FALSE)
  write.csv(Time.AT.A3R,
            "./Outputs/Active_Testing/Time.AT.A3R.csv",
            row.names = FALSE)
  write.csv(tested_setups_df[,-1],
            "./Outputs/Active_Testing/SetupList.AT.A3R.csv",
            row.names = FALSE) #added by MAC
  
  
  #**************************************************************************************************************
  # This code is used to aggregate different time and losses generated
  # obtain the loss of one of the tasks
  matrix_zeros_L <- matrix(rep(0, length(task.ids)), nrow = 1)
  matrix_zeros_T <- matrix(rep(0, length(task.ids)), nrow = 1)
  matrix_names_L <- paste("L", seq(1:length(task.ids)), sep = "")
  matrix_names_T <- paste("T", seq(1:length(task.ids)), sep = "")
  colnames(matrix_zeros_L) <- matrix_names_L
  colnames(matrix_zeros_T) <- matrix_names_T
  Loss.AT.A3R.red  <- data.frame(matrix_zeros_L)
  Time.AT.A3R.red  <- data.frame(matrix_zeros_T)
  
  
  for (j in 1:length(task.ids)) {
    #  for (j in 1:2){
    reduced.loss <- Loss.AT.A3R[, j + 1][Loss.AT.A3R[, j + 1] > 0]
    reduced.loss <- c(reduced.loss, 0)
    loss.length <- length(reduced.loss)
    
    # obtain the test time of one of the tasks
    test.time <- Time.AT.A3R[, j + 1]
    test.time <- test.time[1:loss.length]
    
    for (k in 1:loss.length) {
      l <- reduced.loss[k]
      t <- test.time[k]
      Loss.AT.A3R.red [k, j] <- l
      Time.AT.A3R.red [k, j] <- t
      # end of cycle
    }
    
    # end of cycle new dataset
  }
  
  Loss.AT.A3R.red[is.na(Loss.AT.A3R.red)] <- 0
  #    Time.AT.A3R.red[is.na(Time.AT.A3R.red)] <- 0
  
  write.csv(Loss.AT.A3R.red,
            "./Outputs/Active_Testing/Loss.AT.A3R64.red.csv",
            row.names = FALSE)
  write.csv(Time.AT.A3R.red,
            "./Outputs/Active_Testing/Time.AT.A3R64.red.csv",
            row.names = FALSE)
  
  #*****************************************************************
  
  #*****************************************************************************************************************************
  # This code is use to aggregate the loss and time using the concept of interpoloation
  
  # read the data
  
  loss <-  Loss.AT.A3R.red
  time <-  Time.AT.A3R.red
  ######################################################################################
  # Add the default loss to the Loss dataframe
  dflt.acc     <-
    read.csv(file_defaults) #original code imported losses; MAC changed to import accuracies
  best_by_task <- apply(acca.lsample[,-1], 2, max)
  dflt.acc[, 3] <- best_by_task - dflt.acc[, 3]
  
  r <- 1
  newrow <- dflt.acc[, 3]
  insertRow <- function(loss, newrow, r) {
    loss[seq(r + 1, nrow(loss) + 1),] <- loss[seq(r, nrow(loss)),]
    loss[r,] <- newrow
    return(loss)
  }
  loss <- insertRow(loss, newrow, r)
  # Edit the start time of the start to be at 1 second at which we have the default loss
  newrow1 <-  rep(0, length(task.ids))
  r <- 1
  insertRow <- function(time, newrow2, r) {
    time[seq(r + 1, nrow(time) + 1),] <- time[seq(r, nrow(time)),]
    time[r,] <- newrow1
    return(time)
  }
  
  time <- insertRow(time, newrow1, r)
  ######################################################################################
  # This code is use to aggregate the loss and time using the concept of interpoloation
  
  # create empty dataframes
  matrix_zeros_L <- matrix(rep(0, length(task.ids)), nrow = 1)
  matrix_zeros_T <- matrix(rep(0, length(task.ids)), nrow = 1)
  matrix_names_L <- paste("L", seq(1:length(task.ids)), sep = "")
  matrix_names_T <- paste("T", seq(1:length(task.ids)), sep = "")
  colnames(matrix_zeros_L) <- matrix_names_L
  colnames(matrix_zeros_T) <- matrix_names_T
  trans.loss.df   <- data.frame(matrix_zeros_L)
  trans.time.df <- data.frame(matrix_zeros_T)
  
  # Cycle for all tasks
  
  for (l in 1:length(task.ids)) {
    #     for(l in 1:1){
    # std.time1 <- seq(min.time,max.time,0.1)
    max.exponent <- 6
    std.time1 <- seq(0, max.exponent, 0.1)
    std.time <- 10 ^ std.time1
    
    # obtain the losses
    loss.sub <- loss[, l]
    time.sub <- time[, l]
    time.sub <- time.sub[!is.na(time.sub)]
    length.time <- length(time.sub)
    loss.sub <- loss.sub[1:length.time]
    time.sub <-
      append(time.sub, (10 ^ max.exponent) * 2) #tinha 200 000
    loss.sub <- append(loss.sub, 0)
    
    # Tranformation using interpolation( use constant or linear interpoltaion)
    trans.loss.time <-
      approx(time.sub, loss.sub, xout = std.time, method = "const")
    
    
    # Obtain the interpolated loss and time
    trans.loss <- trans.loss.time$y
    trans.time <- trans.loss.time$x
    
    # Obtain the length of the losses
    trans.loss.length <- length(trans.loss)
    
    # put the results one by one to our trans.loss.df and trans.time.df dataframes
    for (m in 1:trans.loss.length) {
      p <- trans.loss[m]
      q <- trans.time[m]
      trans.loss.df[m, l] <- p
      trans.time.df[m, l] <- q
      # end of cycle for m
      
    }
    
    # end of cycle new task
  }
  
  #Added by MAC to export individual loss curves
  trans.loss.df_export <- trans.loss.df * 100
  stand.time <- trans.time.df[, 1]
  trans.loss.df_export <- cbind(stand.time, trans.loss.df_export)
  trans.loss.df_export <- data.frame(trans.loss.df_export)
  write.csv(x = trans.loss.df_export, file = "./Outputs/Active_Testing/Individual.Loss.Curves.csv")
  #End added by mac
  
  # calculating the mean
  mean.loss <- as.numeric(rowMeans(trans.loss.df, na.rm = TRUE))
  # retrieve one of the standard time
  stand.time <- trans.time.df[, 1]
  mean.loss <- cbind(stand.time, mean.loss)
  mean.loss <- data.frame(mean.loss)
  # calculate the MIL using time interval from 10s to 1000s
  mean.loss.r <-
    mean.loss[mean.loss$stand.time >= 10 &
                mean.loss$stand.time <= 10000, ]
  # convert to 100%
  mean.loss.r.all <- mean(mean.loss.r[, 2]) * 100
  mean.loss[, 2]   <- mean.loss[, 2] * 100
  #mean.loss.r.all
  
  write.csv(mean.loss,
            "./Outputs/Active_Testing/Agreg_Loss-Curve.csv",
            row.names = FALSE)
  write.csv(mean.loss.r.all,
            "./Outputs/Active_Testing/MIL.csv",
            row.names = FALSE)
  #*************************************************************************************************
  mean.loss.r.all
  #************************************************************************************************* 
  return(list("Loss-curve" = mean.loss, "MIL" = mean.loss.r.all))
}

draw_curve <- function (loss_curves_df = NULL, col_line = "blue", dash_line = "solid") {
  
  loss <- melt(loss_curves_df, id.vars = "Time")
  
  
  curve_chart <- ggplot(loss, 
                        aes(# x = log2(Time),
                            # x = Time,
                            # x = log(Time),
                            x = log10(Time),
                            y = value, 
                            colour = variable, 
                            linetype = variable)) + 
    # Type of plot: graph
    geom_step(cex = 0.85) +
    scale_color_manual(values=c("mediumspringgreen"
                              , "hotpink1"
                              , "dodgerblue1"
                              , "orange1"
                              , "firebrick2"
                              , "mediumpurple1")) +
    scale_linetype_manual(values=c("solid"
                                  , "solid"
                                  , "twodash"
                                  , "dotdash"
                                  , "longdash"
                                  , "twodash")) +
    labs(
      x = "log10(Time) (seconds)",
      # x = "ln(Time) (seconds)",
      # x = "Time (seconds)",
      y = "Mean loss (percentage points)") + 
    # To make background without grid and not grey
    theme_classic() +
    scale_y_continuous(breaks=seq(0,max(loss$value)*1.1, 2.5),  
                       # breaks=seq(0,max(loss$value)*1.1, 0.5)
                       labels = function(y) sprintf("%.1f", y),
                       expand = c(0, 0),
                       limits = c(0, max(loss$value)*1.1)) + 
    scale_x_continuous(# breaks=seq(0, max(log2(loss$Time)),1),
                      # breaks=seq(0, max(loss$Time),1),
                      # breaks=seq(0, max(log(loss$Time)),1), 
                      breaks=seq(0, max(log10(loss$Time)),1),
                      # labels = function(x) x,
                      labels = function(x) paste("1e+", x, sep = ""),
                      expand = c(0, 0),
                      # limits = c(0, max(log2(loss$Time))*1.1)) + 
                      # limits = c(0, max(loss$Time)*1.1)) +
                      # limits = c(0, max(log(loss$Time))*1.1)) + 
                      limits = c(0, max(log10(loss$Time))*1.1)) +
    theme(legend.justification=c(1,0)  
          , legend.title = element_blank() 
          , legend.position=c(1,0.75) #CHANGED
          , legend.background = element_rect(fill=alpha("gray90", 0))
          , legend.text = element_text(family = "Fira Sans"
                                       , size = 14
                                       , face = "bold")
          , axis.title.x = element_text(family = "Fira Sans"
                                        , size = 14
                                        , face = "bold")
          , axis.title.y = element_text(angle = 90
                                        , vjust = 0.5
                                        , family = "Fira Sans"
                                        , size = 14
                                        , face = "bold")
          # Change the font in the plot
          # , text = element_text(family = "Fira Sans", size = 16)
    ) 
  
  return(curve_chart)
}

Loss_curves <- function(Curves) {
  MIL <- c()
  for (i in 1:length(Curves)) {
    FUN <- match.fun(Curves[[i]][1]) #get type of curve
    loss_curve_tmp <- FUN(file_acc = Curves[[i]][2],
                          file_time = Curves[[i]][3],
                          file_defaults = Curves[[i]][4],
                          file_best = Curves[[i]][5],
                          convert_millis = Curves[[i]][6],
                          P_AR = Curves[[i]][7],
                          P_AT = Curves[[i]][8])
    loss_curve_tmp_df <- loss_curve_tmp[[1]]
    
    if (is.null(MIL)) {
      loss_curves_df            <- data.frame(loss_curve_tmp_df[,1])
      colnames(loss_curves_df)  <- "Time"
    }
    
    loss_curves_df              <- cbind(loss_curves_df, loss_curve_tmp_df[,2])
    MIL                         <- c(MIL, loss_curve_tmp[[2]])
    names(MIL)[i]               <- Curves[[i]][9]
    colnames(loss_curves_df)[i+1] <- Curves[[i]][9]
  }
  
  loss_curves_df[is.na(loss_curves_df)] <- 0
  write.csv(loss_curves_df,"./Outputs/Loss-Curves.csv", row.names=FALSE)
  return(list(loss_curves_df, MIL))
}


