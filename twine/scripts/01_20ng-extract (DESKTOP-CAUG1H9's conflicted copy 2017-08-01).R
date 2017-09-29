# 00_20ng-extract.R
# ------------------------------------------------------------------------------


# directory --------------------------------------------------------------------

# laptop
setwd("D:/Dropbox (Personal)/LIAAD16-17/d = data/[1] Datasets/20ng")

# desktop
setwd("B:/Dropbox (Personal)/LIAAD16-17/d = data/[1] Datasets/20ng")


# extract data -----------------------------------------------------------------
alt_atheism              <- Corpus(DirSource("./alt.atheism"), readerControl=list(reader=readMail, language="en")) 
comp_graphics            <- Corpus(DirSource("./comp.graphics"), readerControl=list(reader=readMail, language="en")) 
comp_os_mswindows_misc   <- Corpus(DirSource("./comp.os.ms-windows.misc"), readerControl=list(reader=readMail, language="en"))
comp_sys_ibm_pc_hardware <- Corpus(DirSource("./comp.sys.ibm.pc.hardware"), readerControl=list(reader=readMail, language="en"))
comp_sys_mac_hardware    <- Corpus(DirSource("./comp.sys.mac.hardware"), readerControl=list(reader=readMail, language="en"))
misc_forsale             <- Corpus(DirSource("./misc.forsale"), readerControl=list(reader=readMail, language="en"))
comp_windows_x           <- Corpus(DirSource("./comp.windows.x"), readerControl=list(reader=readMail, language="en"))
rec_autos                <- Corpus(DirSource("./rec.autos"), readerControl=list(reader=readMail, language="en"))
rec_motorcycles          <- Corpus(DirSource("./rec.motorcycles"), readerControl=list(reader=readMail, language="en"))
rec_sport_baseball       <- Corpus(DirSource("./rec.sport.baseball"), readerControl=list(reader=readMail, language="en"))
rec_sport_hockey         <- Corpus(DirSource("./rec.sport.hockey"), readerControl=list(reader=readMail, language="en"))
sci_crypt                <- Corpus(DirSource("./sci.crypt"), readerControl=list(reader=readMail, language="en"))
sci_electronics          <- Corpus(DirSource("./sci.electronics"), readerControl=list(reader=readMail, language="en"))
sci_med                  <- Corpus(DirSource("./sci.med"), readerControl=list(reader=readMail, language="en"))
sci_space                <- Corpus(DirSource("./sci.space"), readerControl=list(reader=readMail, language="en"))
soc_religion_christian   <- Corpus(DirSource("./soc.religion.christian"), readerControl=list(reader=readMail, language="en"))
talk_politics_guns       <- Corpus(DirSource("./talk.politics.guns"), readerControl=list(reader=readMail, language="en"))
talk_politics_mideast    <- Corpus(DirSource("./talk.politics.mideast"), readerControl=list(reader=readMail, language="en"))
talk_politics_misc       <- Corpus(DirSource("./talk.politics.misc"), readerControl=list(reader=readMail, language="en"))
talk_religion_misc  	 <- Corpus(DirSource("./talk.religion.misc"), readerControl=list(reader=readMail, language="en"))



# ------------------------------------------------------------------------------