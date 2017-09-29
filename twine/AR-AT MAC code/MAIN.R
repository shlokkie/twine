# extrafont::font_import("C:/Windows/Fonts/", pattern = "FiraSans-Regular.ttf")

extrafont::loadfonts(device="win")
require(ggthemes)
require(ggplot2)
require(reshape)
source("Functions.R")

# DEFINE EXPERIMENTS 
# 
# c("curve function",  -> name of the funtion as defined in the file "Functions.R" 
#   "file accuracies", 
#   "file times", 
#   "file defaults", -> file with default accuracies per dataset
#   "file best", -> file with best accuracies per dataset (depends on each set of curves being compared)
#   convert milliseconds to seconds T/F,
#   P_AR, -> P value used in Average Ranking
#   P_AT, -> P value used in Active Testing
#   "curve_name") -> define the name/title of the curve
#
# Curve functions currently available:
# "Avg_Rank_A3R"
# "AT_Simple"
# 

#########################################################
# Curves for different ranks

Chart_1_1 <- c("Avg_Rank_A3R",
               "./Data/twine/acc.csv",
               "./Data/twine/time.csv",
               "./Data/twine/default-acc.csv",
               "./Data/twine/best-acc.csv",
               F,
               0,
               1/16,
               "AR-ACC")

Chart_1_2 <- c("Avg_Rank_A3R",
               "./Data/twine/acc.csv",
               "./Data/twine/time.csv",
               "./Data/twine/default-acc.csv",
               "./Data/twine/best-acc.csv",
               F,
               1/5,
               1/16,
               "AR-A3R*5")

Chart_1_3 <- c("Avg_Rank_A3R",
               "./Data/twine/acc.csv",
               "./Data/twine/time.csv",
               "./Data/twine/default-acc.csv",
               "./Data/twine/best-acc.csv",
               F, 
               1/22,
               1/16,
               "AR-A3R*22")

Chart_1_4 <- c("Avg_Rank_A3R",
               "./Data/twine/acc.csv",
               "./Data/twine/time.csv",
               "./Data/twine/default-acc.csv",
               "./Data/twine/best-acc.csv",
               F, 
               1/40,
               1/16,
               "AR-A3R*40")

Chart_1_5 <- c("Avg_Rank_A3R",
               "./Data/twine/acc.csv",
               "./Data/twine/time.csv",
               "./Data/twine/default-acc.csv",
               "./Data/twine/best-acc.csv",
               F, 
               1/50,
               1/16,
               "AR-A3R*50")

Chart_1_6 <- c("Avg_Rank_A3R",
               "./Data/twine/acc.csv",
               "./Data/twine/time.csv",
               "./Data/twine/default-acc.csv",
               "./Data/twine/best-acc.csv",
               F, 
               1/75,
               1/16,
               "AR-A3R*75")

Chart_2_1 <- c("AT_Simple",
               "./Data/twine/acc.csv",
               "./Data/twine/time.csv",
               "./Data/twine/default-acc.csv",
               "./Data/twine/best-acc.csv",
               F,
               1/40,
               1/1,
               "AT-A3R*1")

Chart_2_2 <- c("AT_Simple",
               "./Data/twine/acc.csv",
               "./Data/twine/time.csv",
               "./Data/twine/default-acc.csv",
               "./Data/twine/best-acc.csv",
               F,
               1/40,
               1/34,
               "AT-A3R*34")

Chart_2_3 <- c("AT_Simple",
               "./Data/twine/acc.csv",
               "./Data/twine/time.csv",
               "./Data/twine/default-acc.csv",
               "./Data/twine/best-acc.csv",
               F,
               1/40,
               1/90,
               "AT-A3R*90")

Chart_2_4 <- c("AT_Simple",
               "./Data/twine/acc.csv",
               "./Data/twine/time.csv",
               "./Data/twine/default-acc.csv",
               "./Data/twine/best-acc.csv",
               F,
               1/40,
               1/233,
               "AT-A3R*233")



#LIST OF CURVES TO DRAW IN THE SAME CHARTS
Chart1 <- list(
  Chart_1_1 ,
  # Chart_1_2 ,
  # , Chart_1_3
  Chart_1_4 ,
  # , Chart_1_5
  # Chart_1_6
  # , Chart_1_7
  # , Chart_1_8
  # Chart_2_1
  # , Chart_2_2
   Chart_2_3
  # , Chart_2_4
              )

# PREPARE THE CURVES OF A LIST
LC <- Loss_curves(Curves = Chart1)

MIL <- LC[[2]]
MIL

#PLOT

#emf_file = "loss-curve_test.emf"
#emf(file = emf_file, pointsize = 30)
plot(draw_curve(loss_curves_df = LC[[1]]))
#dev.off()

