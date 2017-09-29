# 00_get-data.R
# ------------------------------------------------------------------------------



# oshumed ----------------------------------------------------------------------
# directory
setwd("D:/Dropbox (Personal)/LIAAD16-17/d = data/[1] Datasets/ohsumed-all")


# extract data -----------------------------------------------------------------

c1  <- Corpus(DirSource("./C01"), readerControl=list(reader=readPlain, language="en"))
c2  <- Corpus(DirSource("./C02"), readerControl=list(reader=readPlain, language="en"))
c3  <- Corpus(DirSource("./C03"), readerControl=list(reader=readPlain, language="en"))
c4  <- Corpus(DirSource("./C04"), readerControl=list(reader=readPlain, language="en"))
c5  <- Corpus(DirSource("./C05"), readerControl=list(reader=readPlain, language="en"))
c6  <- Corpus(DirSource("./C06"), readerControl=list(reader=readPlain, language="en"))
c7  <- Corpus(DirSource("./C07"), readerControl=list(reader=readPlain, language="en"))
c8  <- Corpus(DirSource("./C08"), readerControl=list(reader=readPlain, language="en"))
c9  <- Corpus(DirSource("./C09"), readerControl=list(reader=readPlain, language="en"))
c10 <- Corpus(DirSource("./C10"), readerControl=list(reader=readPlain, language="en"))
c11 <- Corpus(DirSource("./C11"), readerControl=list(reader=readPlain, language="en"))
c12 <- Corpus(DirSource("./C12"), readerControl=list(reader=readPlain, language="en"))
c13 <- Corpus(DirSource("./C13"), readerControl=list(reader=readPlain, language="en"))
c14 <- Corpus(DirSource("./C14"), readerControl=list(reader=readPlain, language="en"))
c15 <- Corpus(DirSource("./C15"), readerControl=list(reader=readPlain, language="en"))
c16 <- Corpus(DirSource("./C16"), readerControl=list(reader=readPlain, language="en"))
c17 <- Corpus(DirSource("./C17"), readerControl=list(reader=readPlain, language="en"))
c18 <- Corpus(DirSource("./C18"), readerControl=list(reader=readPlain, language="en"))
c19 <- Corpus(DirSource("./C19"), readerControl=list(reader=readPlain, language="en"))
c20 <- Corpus(DirSource("./C20"), readerControl=list(reader=readPlain, language="en"))
c21 <- Corpus(DirSource("./C21"), readerControl=list(reader=readPlain, language="en"))
c22 <- Corpus(DirSource("./C22"), readerControl=list(reader=readPlain, language="en"))
c23 <- Corpus(DirSource("./C23"), readerControl=list(reader=readPlain, language="en"))


# new topic encoding -----------------------------------------------------------
bacterial_infec_mycoses <- c1
virus <- c2
parasitic <- c3
neoplasms <- c4
musculoskeletal <- c5
digestive_syst <- c6
stomatognathic <- c7
respiratory_tract <- c8
otorhinolaryngologic <- c9
nervous_syst <- c10
eye <- c11
urologic_male_genital <- c12
female_genital_pregnancy <- c13
cardiovascular <- c14
hemic_and_lymphatic <- c15
neonatal_abnormalities <- c16
skin_connective_tissue <- c17
nutritional_metabolic <- c18
endocrine <- c19
immunologic <- c20
disorders_environmental_origin <- c21
animal <- c22
pathological_cond_signs <- c23
