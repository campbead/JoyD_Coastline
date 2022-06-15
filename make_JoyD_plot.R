# load requisite packages
library(ggplot2)
library(ggridges)
library(mapproj)

offset =20
my_scale = 15

DCC_transects <- read.csv(file="data/DCC_JOYD.csv",
                          header=TRUE, sep=",")

DCC_transects$rast_rec <- DCC_transects$rast_rec + offset
# view data frame and change column headers
head(DCC_transects)

DCC_basic <- ggplot(DCC_transects,
  aes(x = xcoord, y = ycoord, group = ycoord, height = rast_rec)) +
  geom_density_ridges(stat = "identity")

DCC_basic

# customize the appearance to mimic the Unknown Pleasures artwork
DCC_Joy <- ggplot(DCC_transects,
  aes(x = xcoord, y = ycoord, group = ycoord, height = rast_rec)) +
  geom_density_ridges(stat = "identity", scale = my_scale,
  fill="black", color = "white") +

# set the upper and lower y-axis limits
#  ylim(42.77, 43.15) +

# add a title to the bottom of the plot frame
  scale_x_continuous(name = " ") +

# use theme() to customize the background, axis labels, titles, etc.
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_rect(fill = "black"),
        axis.line = element_blank(),
        axis.text.x=element_blank(),
        plot.background = element_rect(fill = "black"),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        axis.title.x = element_text(colour = 'white', size = 18))

# projects the transect data to a specified PCS
  #coord_map()

DCC_Joy