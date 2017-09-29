# 00_ohsumed-extract.R
# ------------------------------------------------------------------------------


# laptop -----------------------------------------------------------------------
setwd("D:/Dropbox (Personal)/LIAAD16-17/d = data/[1] Datasets/ohsumed-all")


# desktop ----------------------------------------------------------------------
setwd("B:/Dropbox (Personal)/LIAAD16-17/d = data/[1] Datasets/ohsumed-all")





# labels -----------------------------------------------------------------------
animal					 <- VCorpus(DirSource("./animal")				   , readerControl = list(reader = readPlain, language = "en"))
bacterial_infec_mycoses  <- VCorpus(DirSource("./bacterial_infec_mycoses") , readerControl = list(reader = readPlain, language = "en"))
cardiovascular           <- VCorpus(DirSource("./cardiovascular") 		   , readerControl = list(reader = readPlain, language = "en"))
digestive_syst           <- VCorpus(DirSource("./digestive_syst")		   , readerControl = list(reader = readPlain, language = "en"))
disorders_environmental  <- VCorpus(DirSource("./disorders_environmental") , readerControl = list(reader = readPlain, language = "en"))
endocrine                <- VCorpus(DirSource("./endocrine")			   , readerControl = list(reader = readPlain, language = "en"))
eye                      <- VCorpus(DirSource("./eye")					   , readerControl = list(reader = readPlain, language = "en"))
female_genital_pregnancy <- VCorpus(DirSource("./female_genital_pregnancy"), readerControl = list(reader = readPlain, language = "en"))
hemic_and_lymphatic      <- VCorpus(DirSource("./hemic_and_lymphatic")     , readerControl = list(reader = readPlain, language = "en"))
immunologic              <- VCorpus(DirSource("./immunologic")			   , readerControl = list(reader = readPlain, language = "en"))
musculoskeletal          <- VCorpus(DirSource("./musculoskeletal")         , readerControl = list(reader = readPlain, language = "en"))
neonatal_abnormalities   <- VCorpus(DirSource("./neonatal_abnormalities")  , readerControl = list(reader = readPlain, language = "en"))
neoplasms                <- VCorpus(DirSource("./neoplasms")     		   , readerControl = list(reader = readPlain, language = "en"))
nervous_syst             <- VCorpus(DirSource("./nervous_syst")  		   , readerControl = list(reader = readPlain, language = "en"))
nutritional_metabolic    <- VCorpus(DirSource("./nutritional_metabolic")   , readerControl = list(reader = readPlain, language = "en"))
otorhinolaryngologic     <- VCorpus(DirSource("./otorhinolaryngologic")	   , readerControl = list(reader = readPlain, language = "en"))
parasitic                <- VCorpus(DirSource("./parasitic")			   , readerControl = list(reader = readPlain, language = "en"))
pathological_cond_signs  <- VCorpus(DirSource("./pathological_cond_signs") , readerControl = list(reader = readPlain, language = "en"))
respiratory_tract        <- VCorpus(DirSource("./respiratory_tract")	   , readerControl = list(reader = readPlain, language = "en"))
skin_connective_tissue   <- VCorpus(DirSource("./skin_connective_tissue")  , readerControl = list(reader = readPlain, language = "en"))
stomatognathic           <- VCorpus(DirSource("./stomatognathic")		   , readerControl = list(reader = readPlain, language = "en"))
urologic_male_genital    <- VCorpus(DirSource("./urologic_male_genital")   , readerControl = list(reader = readPlain, language = "en"))
virus                    <- VCorpus(DirSource("./virus")				   , readerControl = list(reader = readPlain, language = "en"))




# ------------------------------------------------------------------------------