# 02_oshumed-build.R 
# ------------------------------------------------------------------------------


# document collections ---------------------------------------------------------
o1_1	 <- neoplasms
o2_1	 <- nervous_syst
o3_1	 <- digestive_syst
o4_1	 <- bacterial_infec_mycoses
o5_1	 <- bacterial_infec_mycoses
o6_1	 <- respiratory_tract
o7_1	 <- urologic_male_genital
o8_1	 <- musculoskeletal
o9_1	 <- female_genital_pregnancy
o10_1 <- musculoskeletal
o11_1 <- musculoskeletal
o12_1 <- virus
o13_1 <- virus
o14_1 <- eye
o15_1 <- eye
o16_1 <- otorhinolaryngologic
o17_1 <- stomatognathic
o18_1 <- parasitic
o19_1 <- parasitic
o20_1 <- parasitic
o21_1 <- digestive_syst
o22_1 <- virus
o1_2	 <- cardiovascular
o2_2	 <- immunologic
o3_2	 <- disorders_environmental
o4_2	 <- respiratory_tract
o5_2	 <- urologic_male_genital
o6_2	 <- urologic_male_genital
o7_2	 <- nutritional_metabolic
o8_2	 <- female_genital_pregnancy
o9_2	 <- skin_connective_tissue
o10_2 <- female_genital_pregnancy
o11_2 <- skin_connective_tissue
o12_2 <- hemic_and_lymphatic
o13_2 <- neonatal_abnormalities
o14_2 <- neonatal_abnormalities
o15_2 <- endocrine
o16_2 <- endocrine
o17_2 <- animal
o18_2 <- stomatognathic
o19_2 <- animal
o20_2 <- stomatognathic
o21_2 <- immunologic
o22_2 <- hemic_and_lymphatic
o10_3 <- skin_connective_tissue
o20_3 <- animal
o22_3 <- neonatal_abnormalities


# merging ----------------------------------------------------------------------
o1	<- c(o1_1, o1_2)
o2	<- c(o2_1, o2_2)
o3	<- c(o3_1, o3_2)
o4	<- c(o4_1, o4_2)
o5	<- c(o5_1, o5_2)
o6	<- c(o6_1, o6_2)
o7	<- c(o7_1, o7_2)
o8	<- c(o8_1, o8_2)
o9	<- c(o9_1, o9_2)
o10	<- c(o10_1, o10_2, o10_3)
o11	<- c(o11_1, o11_2)
o12	<- c(o12_1, o12_2)
o13	<- c(o13_1, o13_2)
o14	<- c(o14_1, o14_2)
o15	<- c(o15_1, o15_2)
o16	<- c(o16_1, o16_2)
o17	<- c(o17_1, o17_2)
o18	<- c(o18_1, o18_2)
o19	<- c(o19_1, o19_2)
o20	<- c(o20_1, o20_2, o20_3)
o21	<- c(o21_1, o21_2)
o22	<- c(o22_1, o22_2, o22_3)


# documents per dataset --------------------------------------------------------
n_o11  <- length(o1_1)	  
n_o21  <- length(o2_1)	 	 
n_o31  <- length(o3_1)	 	 
n_o41  <- length(o4_1)	 	 
n_o51  <- length(o5_1)	 	 
n_o61  <- length(o6_1)	 	 
n_o71  <- length(o7_1)	 	 
n_o81  <- length(o8_1)	 	 
n_o91  <- length(o9_1)	 
n_o101 <- length(o10_1) 
n_o111 <- length(o11_1) 
n_o121 <- length(o12_1) 
n_o131 <- length(o13_1) 
n_o141 <- length(o14_1) 
n_o151 <- length(o15_1) 
n_o161 <- length(o16_1) 
n_o171 <- length(o17_1) 
n_o181 <- length(o18_1) 
n_o191 <- length(o19_1) 
n_o201 <- length(o20_1) 
n_o211 <- length(o21_1) 
n_o221 <- length(o22_1) 
n_o12  <- length(o1_2)	 	 
n_o22  <- length(o2_2)	 	 
n_o32  <- length(o3_2)	 	 
n_o42  <- length(o4_2)	 	 
n_o52  <- length(o5_2)	 	 
n_o62  <- length(o6_2)	 	 
n_o72  <- length(o7_2)	 	 
n_o82  <- length(o8_2)	 	 
n_o92  <- length(o9_2)	 	 
n_o102 <- length(o10_2) 
n_o112 <- length(o11_2) 
n_o122 <- length(o12_2) 
n_o132 <- length(o13_2) 
n_o142 <- length(o14_2) 
n_o152 <- length(o15_2) 
n_o162 <- length(o16_2) 
n_o172 <- length(o17_2) 
n_o182 <- length(o18_2) 
n_o192 <- length(o19_2) 
n_o202 <- length(o20_2) 
n_o212 <- length(o21_2) 
n_o222 <- length(o22_2) 
n_o103 <- length(o10_3) 
n_o203 <- length(o20_3) 
n_o223 <- length(o22_3) 

# labels -----------------------------------------------------------------------
topic_o1  <- c(rep("neoplasms",                n_o11) , rep("cardiovascular"		  , n_o12))	
topic_o2  <- c(rep("nervous_syst", 			   n_o21) , rep("immunologic"			  , n_o22))	
topic_o3  <- c(rep("digestive_syst", 		   n_o31) , rep("disorders_environmental" , n_o32))	
topic_o4  <- c(rep("bacterial_infec_mycoses",  n_o41) , rep("respiratory_tract"		  , n_o42))	
topic_o5  <- c(rep("bacterial_infec_mycoses",  n_o51) , rep("urologic_male_genital"   , n_o52))	
topic_o6  <- c(rep("respiratory_tract", 	   n_o61) , rep("urologic_male_genital"   , n_o62))	
topic_o7  <- c(rep("urologic_male_genital",    n_o71) , rep("nutritional_metabolic"   , n_o72))	
topic_o8  <- c(rep("musculoskeletal", 		   n_o81) , rep("female_genital_pregnancy", n_o82))	
topic_o9  <- c(rep("female_genital_pregnancy", n_o91) , rep("skin_connective_tissue"  , n_o92))	
topic_o10 <- c(rep("musculoskeletal",          n_o101), rep("female_genital_pregnancy", n_o102) , rep("skin_connective_tissue", n_o103))	
topic_o11 <- c(rep("musculoskeletal", 		   n_o111), rep("skin_connective_tissue"  , n_o112))	
topic_o12 <- c(rep("virus", 				   n_o121), rep("hemic_and_lymphatic"     , n_o122))	
topic_o13 <- c(rep("virus", 				   n_o131), rep("neonatal_abnormalities"  , n_o132))	
topic_o14 <- c(rep("eye", 				       n_o141), rep("neonatal_abnormalities"  , n_o142))	
topic_o15 <- c(rep("eye", 					   n_o151), rep("endocrine"				  , n_o152))	
topic_o16 <- c(rep("otorhinolaryngologic", 	   n_o161), rep("endocrine"			      , n_o162))	
topic_o17 <- c(rep("stomatognathic", 		   n_o171), rep("animal"				  , n_o172))	
topic_o18 <- c(rep("parasitic", 			   n_o181), rep("stomatognathic"		  , n_o182))	
topic_o19 <- c(rep("parasitic", 			   n_o191), rep("animal"				  , n_o192))	
topic_o20 <- c(rep("parasitic", 			   n_o201), rep("stomatognathic"		  , n_o202) , rep("animal", n_o203))
topic_o21 <- c(rep("digestive_syst", 		   n_o211), rep("immunologic"			  , n_o212))	
topic_o22 <- c(rep("virus", 				   n_o221), rep("hemic_and_lymphatic"     , n_o222) , rep("neonatal_abnormalities", n_o223))



# ------------------------------------------------------------------------------