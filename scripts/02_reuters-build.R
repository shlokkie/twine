# 02_reuters-build.R
# ------------------------------------------------------------------------------



# r1 ---------------------------------------------------------------------------
# labels: earn	 acq
#         w[3]   w[1]

r1_1 <- r[r$topic == w[3], ]
r1_2 <- r[r$topic == w[1], ]

# r2 ---------------------------------------------------------------------------
# labels: crude	trade 
#         w[2]   w[8]

r2_1 <- r[r$topic == w[2], ]
r2_2 <- r[r$topic == w[8], ]


# r3 ---------------------------------------------------------------------------
# labels: crude	trade	money-fx 
#         w[2]   w[8]		w[6]

r3_1 <- r[r$topic == w[2], ]
r3_2 <- r[r$topic == w[8], ]
r3_3 <- r[r$topic == w[6], ]

# r4 ---------------------------------------------------------------------------
# labels: money-fx	interest 
#         w[6]   	w[5]

r4_1 <- r[r$topic == w[6], ]
r4_2 <- r[r$topic == w[5], ]

# r5 ---------------------------------------------------------------------------
# labels: trade	money-fx	interest
#         w[8]   w[6]			w[5]

r5_1 <- r[r$topic == w[8], ]
r5_2 <- r[r$topic == w[6], ]
r5_3 <- r[r$topic == w[5], ]




# Corpus -----------------------------------------------------------------------
# function 
corpusing  <- function(d){
    d <- VCorpus( VectorSource(d$document)
                , readerControl = list(reader    = readPlain
                                      , language = "en"
                                      )
                )
    return(d)
}


# applying corpusing -----------------------------------------------------------
r1_1 <- corpusing(r1_1)
r1_2 <- corpusing(r1_2)
r2_1 <- corpusing(r2_1)
r2_2 <- corpusing(r2_2)
r3_1 <- corpusing(r3_1)
r3_2 <- corpusing(r3_2)
r3_3 <- corpusing(r3_3)
r4_1 <- corpusing(r4_1)
r4_2 <- corpusing(r4_2)
r5_1 <- corpusing(r5_1)
r5_2 <- corpusing(r5_2)
r5_3 <- corpusing(r5_3)



# merging ----------------------------------------------------------------------
r1 <- c(r1_1, r1_2)
r2 <- c(r2_1, r2_2)
r3 <- c(r3_1, r3_2, r3_3)
r4 <- c(r4_1, r4_2)
r5 <- c(r5_1, r5_2, r5_3)


# documents per dataset --------------------------------------------------------
n_r11 <- length(r1_1)
n_r12 <- length(r1_2)
n_r21 <- length(r2_1)
n_r22 <- length(r2_2)
n_r31 <- length(r3_1)
n_r32 <- length(r3_2)
n_r33 <- length(r3_3)
n_r41 <- length(r4_1)
n_r42 <- length(r4_2)
n_r51 <- length(r5_1)
n_r52 <- length(r5_2)
n_r53 <- length(r5_3)


# labels -----------------------------------------------------------------------
topic_r1 <- c(rep(w[3], n_r11), rep(w[1], n_r12))
topic_r2 <- c(rep(w[2], n_r21), rep(w[8], n_r22))
topic_r3 <- c(rep(w[2], n_r31), rep(w[8], n_r32), rep(w[6], n_r33))
topic_r4 <- c(rep(w[6], n_r41), rep(w[5], n_r42))
topic_r5 <- c(rep(w[8], n_r51), rep(w[6], n_r52), rep(w[5], n_r53))



# ------------------------------------------------------------------------------
