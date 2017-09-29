# 10a_pstarts-workflow.R
# ------------------------------------------------------------------------------


# preprocessing strats ---------------------------------------------------------
# strategy ids
repr <- c( "tf_idf"
           # , "binary"
           , "freq"
)
stop <- c( "none"
           , "default"
           , "smart"
)
stem <- c( "none"
          , "simple"
)
spar <- c( 0.99
           , 0.98
)
info <- c("none"
          , ">0"
          # , ">0.03"
)
p_id <- c(paste0("p",1:(length(repr)*length(stop)*length(stem)*length(spar)*length(info))))


# column to be added -----------------------------------------------------------

pstrat <- c()
for (i in 1:length(p_id)) {
    pip <- rep(p_id[i], 8*50)
    pstrat <- c(pstrat, pip)
}


