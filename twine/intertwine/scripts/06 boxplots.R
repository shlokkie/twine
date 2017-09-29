# 06 boxplots.R
# ------------------------------------------------------------------------------


require(ggplot2)

#  BOX PLOT WITH GGPLOT2
# http://t-redactyl.io/blog/2016/04/creating-plots-in-r-using-ggplot2-part-10-boxplots.html
fill <- "darkslategray3"
line <- "darkslategray4"
extrafont::font_import("C:/Windows/Fonts/", pattern = "FiraSans-Regular.ttf")
extrafont::font_import("C:/Windows/Fonts/", pattern = "FiraSans-Black.ttf")

extrafont::font_import("C:/Windows/Fonts/", pattern = "DecimaMonoPro.ttf")
extrafont::font_import("C:/Windows/Fonts/", pattern = "DecimaMonoPro.ttf")
extrafont::loadfonts(device="win")

p1 <- ggplot(dt, aes(x = dt$data, y = dt$accuracy)) +
    geom_boxplot(fill = fill, colour = line) + 
    # scale_x_discrete(name = "Dataset") +
    # scale_y_continuous(name = "Accuracy") + 
    # ggtitle("Boxplot of accuracy for each dataset")
    # theme_bw() +
    theme_grey() +
    # theme_minimal() +
    labs(title="Boxplot of accuracy for each dataset",
         # subtitle="Arranged from East to West",
         # caption="Data: Zubrow(1974)",
         x = "Dataset",
         y = "Accuracy") +
    theme(
        # strip.background = element_rect(colour = "white", fill = "white"),
        text = element_text(family = "Fira Sans", size = 14, face = "bold"),
        # strip.text.x = element_text(colour = "black", size = 7, face = "bold", family = "Roboto"),
        # panel.margin = unit(0, "lines"),
        # panel.border = element_rect(colour = "gray90"),
        axis.text.x = element_text(angle = 90, size = 11, family = "Fira Sans"),
        axis.text.y = element_text(size = 11, family = "Fira Sans"),
        axis.title = element_text(size = 12, family = "Fira Sans")
    )

p1
ggsave(filename = "box-acc.png")

p2 <- ggplot(dt, aes(x = dt$data, y = dt$time)) +
    geom_boxplot(fill = fill, colour = line) + 
    # scale_x_discrete(name = "Dataset") +
    # scale_y_continuous(name = "Time (in secs)") + 
    # ggtitle("Boxplot of time for each dataset") 
    # +  geom_jitter(colour = line)
    theme_grey() +
    # theme_minimal() +
    labs(title="Boxplot of runtime for each dataset",
         # subtitle="Arranged from East to West",
         # caption="Data: Zubrow(1974)",
         x = "Dataset",
         y = "Runtime") +
    theme(
        # strip.background = element_rect(colour = "white", fill = "white"),
        text = element_text(family = "Fira Sans", size = 14, face = "bold"),
        # strip.text.x = element_text(colour = "black", size = 7, face = "bold", family = "Roboto"),
        # panel.margin = unit(0, "lines"),
        # panel.border = element_rect(colour = "gray90"),
        axis.text.x = element_text(angle = 90, size = 11, family = "Fira Sans"),
        axis.text.y = element_text(size = 11, family = "Fira Sans"),
        axis.title = element_text(size = 12, family = "Fira Sans")
    )

p2

ggsave(filename = "box-tim.png")
