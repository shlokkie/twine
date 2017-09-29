# 03 metaregression.R
# ------------------------------------------------------------------------------


reg_data <- read.table(file             = "./data/reg-data.csv"
                      , dec              = "."
                      , fill             = FALSE
                      , strip.white      = TRUE
                      , blank.lines.skip = TRUE
                      , header           = TRUE
                      , sep              = ";"
)



View(reg_data)

# make factors -----------------------------------------------------------------

colnames(reg_data)

class(reg_data$algorithm)
class(reg_data$repr)
class(reg_data$stop)
class(reg_data$stem)
class(reg_data$accuracy)
class(reg_data$a3r)
class(reg_data$info)
class(reg_data$no.terms)

class(reg_data$no_class)                                                        # were integer
reg_data$no_class <- as.factor(reg_data$no_class)

class(reg_data$similar)                                                         # were integer
reg_data$similar <- as.factor(reg_data$similar)

class(reg_data$spar)                                                            # were numeric
reg_data$spar <- as.factor(reg_data$spar)

cor( reg_data$algorithm
   , reg_data$repr
   , reg_data$stop)
levels(reg_data$no_class)


linearReg_A <- lm(formula = accuracy ~ algorithm + repr + stop + stem + no_class + similar + spar + info, data = reg_data)


summary(linearReg_A)


# logisticModel <- glm(formula = accuracy ~ algorithm + repr + stop + stem + no_class + similar + spar, data = reg_data)
# summary(logisticModel)


anovaA <- anova(linearReg_A, test = "Chisq")

anovaA

linearReg_B <- lm(formula = a3r ~ algorithm + repr + stop + stem + no_class + similar + spar, data = reg_data)


summary(linearReg_B)

anovaB <- anova(linearReg_B, test = "Chisq")

anovaB

plot(linearReg_A)

#get unstandardized predicted and residual values
unstandardizedPredicted <- predict(linearReg_A)
unstandardizedResiduals <- resid(linearReg_A)
#get standardized values
standardizedPredicted <- (unstandardizedPredicted - mean(unstandardizedPredicted)) / sd(unstandardizedPredicted)
standardizedResiduals <- (unstandardizedResiduals - mean(unstandardizedResiduals)) / sd(unstandardizedResiduals)
#create standardized residuals plot
plot(standardizedPredicted, standardizedResiduals, main = "Standardized Residuals Plot", xlab = "Standardized Predicted Values", ylab = "Standardized Residuals")
#add horizontal line
abline(0,0)



hist(standardizedResiduals, freq = FALSE)
curve(dnorm, add = TRUE)

probDist <- pnorm(standardizedResiduals)
plot(ppoints(length(standardizedResiduals)), sort(probDist), main = "PP Plot", xlab = "Observed Probability", ylab = "Expected Probability")
abline(0,1)



