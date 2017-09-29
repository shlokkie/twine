# 02_20ng-build.R
# ------------------------------------------------------------------------------



# document collections ---------------------------------------------------------

n1_1	 <- alt_atheism             
n2_1	 <- alt_atheism             
n3_1	 <- alt_atheism             
n4_1	 <- comp_graphics           
n5_1	 <- comp_sys_ibm_pc_hardware
n6_1	 <- comp_sys_ibm_pc_hardware
n7_1	 <- comp_windows_x          
n8_1	 <- rec_autos               
n9_1	 <- sci_electronics         
n10_1 <- sci_med                 
n11_1 <- talk_politics_guns      
n12_1 <- talk_politics_guns      
n13_1 <- sci_space               
n14_1 <- rec_motorcycles         
n15_1 <- rec_autos               
n16_1 <- talk_religion_misc      
n17_1 <- sci_crypt               
n18_1 <- misc_forsale            
n19_1 <- comp_windows_x          
n20_1 <- sci_space               
n21_1 <- rec_sport_baseball      
n22_1 <- sci_electronics         
n23_1 <- misc_forsale            
n1_2	 <- comp_graphics           
n2_2	 <- soc_religion_christian  
n3_2	 <- soc_religion_christian  
n4_2	 <- comp_os_mswindows_misc 
n5_2	 <- comp_sys_mac_hardware   
n6_2	 <- comp_os_mswindows_misc 
n7_2	 <- misc_forsale            
n8_2	 <- sci_crypt               
n9_2	 <- comp_graphics           
n10_2 <- talk_politics_guns      
n11_2 <- talk_politics_mideast   
n12_2 <- talk_politics_mideast   
n13_2 <- rec_sport_baseball      
n14_2 <- rec_autos               
n15_2 <- alt_atheism             
n16_2 <- rec_sport_hockey        
n17_2 <- misc_forsale            
n18_2 <- rec_sport_baseball      
n19_2 <- alt_atheism             
n20_2 <- talk_religion_misc      
n21_2 <- rec_sport_hockey        
n22_2 <- sci_med                 
n23_2 <- alt_atheism             
n3_3	 <- talk_religion_misc      
n6_3	 <- comp_sys_mac_hardware   
n11_3 <- talk_politics_misc      
n19_3 <- sci_med                 
n20_3 <- misc_forsale            
n22_3 <- sci_space               



# merging ----------------------------------------------------------------------

n1  <- c(n1_1,  n1_2)
n2  <- c(n2_1,  n2_2)
n3  <- c(n3_1,  n3_2,  n3_3)
n4  <- c(n4_1,  n4_2)
n5  <- c(n5_1,  n5_2)
n6  <- c(n6_1,  n6_2,  n6_3)
n7  <- c(n7_1,  n7_2)
n8  <- c(n8_1,  n8_2)
n9  <- c(n9_1,  n9_2)
n10 <- c(n10_1, n10_2)
n11 <- c(n11_1, n11_2, n11_3)
n12 <- c(n12_1, n12_2)
n13 <- c(n13_1, n13_2)
n14 <- c(n14_1, n14_2)
n15 <- c(n15_1, n15_2)
n16 <- c(n16_1, n16_2)
n17 <- c(n17_1, n17_2)
n18 <- c(n18_1, n18_2)
n19 <- c(n19_1, n19_2, n19_3)
n20 <- c(n20_1, n20_2, n20_3)
n21 <- c(n21_1, n21_2)
n22 <- c(n22_1, n22_2, n22_3)
n23 <- c(n23_1, n23_2)


# documents per dataset --------------------------------------------------------

n_n11  <- length(n1_1)
n_n12  <- length(n1_2)
n_n21  <- length(n2_1)
n_n22  <- length(n2_2)
n_n31  <- length(n3_1)
n_n32  <- length(n3_2)
n_n33  <- length(n3_3)
n_n41  <- length(n4_1)
n_n42  <- length(n4_2)
n_n51  <- length(n5_1)
n_n52  <- length(n5_2)
n_n61  <- length(n6_1)
n_n62  <- length(n6_2)
n_n63  <- length(n6_3)
n_n71  <- length(n7_1)
n_n72  <- length(n7_2)
n_n81  <- length(n8_1)
n_n82  <- length(n8_2)
n_n91  <- length(n9_1)
n_n92  <- length(n9_2)
n_n101 <- length(n10_1)
n_n102 <- length(n10_2)
n_n111 <- length(n11_1)
n_n112 <- length(n11_2)
n_n113 <- length(n11_3)
n_n121 <- length(n12_1)
n_n122 <- length(n12_2)
n_n131 <- length(n13_1)
n_n132 <- length(n13_2)
n_n141 <- length(n14_1)
n_n142 <- length(n14_2)
n_n151 <- length(n15_1)
n_n152 <- length(n15_2)
n_n161 <- length(n16_1)
n_n162 <- length(n16_2)
n_n171 <- length(n17_1)
n_n172 <- length(n17_2)
n_n181 <- length(n18_1)
n_n182 <- length(n18_2)
n_n191 <- length(n19_1)
n_n192 <- length(n19_2)
n_n193 <- length(n19_3)
n_n201 <- length(n20_1)
n_n202 <- length(n20_2)
n_n203 <- length(n20_3)
n_n211 <- length(n21_1)
n_n212 <- length(n21_2)
n_n221 <- length(n22_1)
n_n222 <- length(n22_2)
n_n223 <- length(n22_3)
n_n231 <- length(n23_1)
n_n232 <- length(n23_2)



# labels -----------------------------------------------------------------------

topic_n1  <- c(rep("alt_atheism",n_n11),  rep("comp_graphics",n_n12))
topic_n2  <- c(rep("alt_atheism",n_n21),  rep("soc_religion_christian",n_n22))
topic_n3  <- c(rep("alt_atheism",n_n31),  rep("soc_religion_christian",n_n32),  rep("talk_religion_misc", n_n33))
topic_n4  <- c(rep("comp_graphics",n_n41),  rep("comp_os_mswindows_misc",n_n42))
topic_n5  <- c(rep("comp_sys_ibm_pc_hardware",n_n51),  rep("comp_sys_mac_hardware",n_n52))
topic_n6  <- c(rep("comp_sys_ibm_pc_hardware",n_n61),  rep("comp_os_mswindows_misc",n_n62),  rep("comp_sys_mac_hardware", n_n63))
topic_n7  <- c(rep("comp_windows_x",n_n71),  rep("misc_forsale",n_n72))
topic_n8  <- c(rep("rec_autos",n_n81),  rep("sci_crypt",n_n82))
topic_n9  <- c(rep("sci_electronics",n_n91),  rep("comp_graphics",n_n92))
topic_n10 <- c(rep("sci_med",n_n101), rep("talk_politics_guns",n_n102))
topic_n11 <- c(rep("talk_politics_guns",n_n111), rep("talk_politics_mideast",n_n112), rep("talk_politics_misc", n_n113))
topic_n12 <- c(rep("talk_politics_guns",n_n121), rep("talk_politics_mideast",n_n122))
topic_n13 <- c(rep("sci_space",n_n131), rep("rec_sport_baseball",n_n132))
topic_n14 <- c(rep("rec_motorcycles",n_n141), rep("rec_autos",n_n142))
topic_n15 <- c(rep("rec_autos",n_n151), rep("alt_atheism",n_n152))
topic_n16 <- c(rep("talk_religion_misc",n_n161), rep("rec_sport_hockey",n_n162))
topic_n17 <- c(rep("sci_crypt",n_n171), rep("misc_forsale",n_n172))
topic_n18 <- c(rep("misc_forsale",n_n181), rep("rec_sport_baseball",n_n182))
topic_n19 <- c(rep("comp_windows_x",n_n191), rep("alt_atheism",n_n192), rep("sci_med", n_n193))
topic_n20 <- c(rep("sci_space",n_n201), rep("talk_religion_misc",n_n202), rep("misc_forsale", n_n203))
topic_n21 <- c(rep("rec_sport_baseball",n_n211), rep("rec_sport_hockey",n_n212))
topic_n22 <- c(rep("sci_electronics",n_n221), rep("sci_med",n_n222), rep("sci_space", n_n223))
topic_n23 <- c(rep("misc_forsale",n_n231), rep("alt_atheism",n_n232))




# ------------------------------------------------------------------------------