# 04_for-loop-lists.R
# ------------------------------------------------------------------------------



# datasets ---------------------------------------------------------------------
ghost <- list( o1  = o1		
             , o2  = o2		
             , o3  = o3		
             , o4  = o4		
             , o5  = o5		
             , o6  = o6		
             , o7  = o7		
             , o8  = o8		
             , o9  = o9		
             , o10 = o10
             , o11 = o11
             , o12 = o12
             , o13 = o13
             , o14 = o14
             , o15 = o15
             , o16 = o16
             , o17 = o17
             , o18 = o18
             , o19 = o19
             , o20 = o20
             , o21 = o21
             , o22 = o22
			 , n1  = n1 
             , n2  = n2 
             , n3  = n3 
             , n4  = n4 
             , n5  = n5 
             , n6  = n6 
             , n7  = n7 
             , n8  = n8 
             , n9  = n9 
             , n10 = n10
             , n11 = n11
             , n12 = n12
             , n13 = n13
             , n14 = n14
             , n15 = n15
             , n16 = n16
             , n17 = n17
             , n18 = n18
             , n19 = n19
             , n20 = n20
             , n21 = n21
             , n22 = n22
             , n23 = n23
			 , r1  = r1
             , r2  = r2
             , r3  = r3
             , r4  = r4
             , r5  = r5
			 )



# labels of datasets -----------------------------------------------------------
meow_cats <- list( topic_o1 
                 , topic_o2 
                 , topic_o3 
                 , topic_o4 
                 , topic_o5 
                 , topic_o6 
                 , topic_o7 
                 , topic_o8 
                 , topic_o9 
                 , topic_o10
                 , topic_o11
                 , topic_o12
                 , topic_o13
                 , topic_o14
                 , topic_o15
                 , topic_o16
                 , topic_o17
                 , topic_o18
                 , topic_o19
                 , topic_o20
                 , topic_o21
                 , topic_o22
			     , topic_n1 
                 , topic_n2 
                 , topic_n3 
                 , topic_n4 
                 , topic_n5 
                 , topic_n6 
                 , topic_n7 
                 , topic_n8 
                 , topic_n9 
                 , topic_n10
                 , topic_n11
                 , topic_n12
                 , topic_n13
                 , topic_n14
                 , topic_n15
                 , topic_n16
                 , topic_n17
                 , topic_n18
                 , topic_n19
                 , topic_n20
                 , topic_n21
                 , topic_n22
                 , topic_n23
			     , topic_r1
                 , topic_r2
                 , topic_r3
                 , topic_r4
                 , topic_r5
			     )



# names of datasets ------------------------------------------------------------
# this object allows me to save a lot of memory - after creating the datasets
# that are preprocessed, I can just use this object for the abacus function

summer <- list( "o1" 
              , "o2" 
              , "o3" 
              , "o4" 
              , "o5" 
              , "o6" 
              , "o7" 
              , "o8" 
              , "o9" 
              , "o10"
              , "o11"
              , "o12"
              , "o13"
              , "o14"
              , "o15"
              , "o16"
              , "o17"
              , "o18"
              , "o19"
              , "o20"
              , "o21"
              , "o22"
              , "n1" 
              , "n2" 
              , "n3" 
              , "n4" 
              , "n5" 
              , "n6" 
              , "n7" 
              , "n8" 
              , "n9" 
              , "n10"
              , "n11"
              , "n12"
              , "n13"
              , "n14"
              , "n15"
              , "n16"
              , "n17"
              , "n18"
              , "n19"
              , "n20"
              , "n21"
              , "n22"
              , "n23"
              , "r1" 
              , "r2" 
              , "r3" 
              , "r4" 
              , "r5" 
              )




	  
# ------------------------------------------------------------------------------