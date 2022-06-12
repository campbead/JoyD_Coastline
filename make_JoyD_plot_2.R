# load requisite packages
library(ggplot2)
library(ggridges)
library(mapproj)
library(tidyverse)
library(zoo)

offset =20
my_scale = 3

# DCC Data

#DCC_transects <- read.csv(file="DCC_JOYD.csv",
#                          header=TRUE, sep=",")

#NZ DATA
setwd("C:/Users/ajcampbe/Documents/Explorations/rest_API_r")
DCC_transects <- read.csv(file="denseNZ.csv",
                          header=TRUE, sep=",")

DCC_transects <- DCC_transects  %>% 
  rename(
    xcoord = Var1,
    ycoord = Var2,
    rast_rec = elevation
  )


# fix stuff
DCC_transects["2053","rast_rec"] <- 22
DCC_transects["2054","rast_rec"] <- 22
DCC_transects["2055","rast_rec"] <- 22

DCC_transects["4027","rast_rec"] <- 21
DCC_transects["4028","rast_rec"] <- 21
DCC_transects["4069","rast_rec"] <- 320

DCC_transects["4635","rast_rec"] <- 140
DCC_transects["4636","rast_rec"] <- 140

DCC_transects["4679","rast_rec"] <- 69

DCC_transects["4720","rast_rec"] <- 158

DCC_transects["4763","rast_rec"] <- 275

DCC_transects["5246","rast_rec"] <- 600

DCC_transects["5286","rast_rec"] <- 250
DCC_transects["5287","rast_rec"] <- 225
DCC_transects["5288","rast_rec"] <- 200

DCC_transects["5371","rast_rec"] <- 170
DCC_transects["5372","rast_rec"] <- 180

DCC_transects["5414","rast_rec"] <- 400

DCC_transects["5898","rast_rec"] <- 250
DCC_transects["5899","rast_rec"] <- 250
DCC_transects["5900","rast_rec"] <- 250

DCC_transects["5940","rast_rec"] <- 200

DCC_transects["5982","rast_rec"] <- 400

DCC_transects["6024","rast_rec"] <- 430

DCC_transects["6067","rast_rec"] <- 460

DCC_transects["6551","rast_rec"] <- 140

DCC_transects["6591","rast_rec"] <- 181

DCC_transects["6633","rast_rec"] <- 475

DCC_transects["6675","rast_rec"] <- 200

DCC_transects["6718","rast_rec"] <- 208

DCC_transects["7242","rast_rec"] <- 1200
DCC_transects["7243","rast_rec"] <- 1100

DCC_transects["7284","rast_rec"] <- 1200
DCC_transects["7285","rast_rec"] <- 1100

DCC_transects["7326","rast_rec"] <- 650
DCC_transects["7327","rast_rec"] <- 500

DCC_transects["7370","rast_rec"] <- 1140
DCC_transects["7371","rast_rec"] <- 1100
DCC_transects["7372","rast_rec"] <- 995
DCC_transects["7373","rast_rec"] <- 870
DCC_transects["7374","rast_rec"] <- 380
DCC_transects["7375","rast_rec"] <- 280
DCC_transects["7376","rast_rec"] <- 360
DCC_transects["7377","rast_rec"] <- 490
DCC_transects["7378","rast_rec"] <- 640
DCC_transects["7379","rast_rec"] <- 620
DCC_transects["7380","rast_rec"] <- 520
DCC_transects["7381","rast_rec"] <- 510
DCC_transects["7382","rast_rec"] <- 580
DCC_transects["7383","rast_rec"] <- 740
DCC_transects["7384","rast_rec"] <- 550
DCC_transects["7385","rast_rec"] <- 500
DCC_transects["7386","rast_rec"] <- 250
DCC_transects["7387","rast_rec"] <- 300
DCC_transects["7388","rast_rec"] <- 250

DCC_transects["7938","rast_rec"] <- 308
DCC_transects["7939","rast_rec"] <- 308

DCC_transects["7980","rast_rec"] <- 750

DCC_transects["8547","rast_rec"] <- 950

DCC_transects["8590","rast_rec"] <- 1300

DCC_transects["8631","rast_rec"] <- 220

DCC_transects["8672","rast_rec"] <- 1200

DCC_transects["8714","rast_rec"] <- 50

DCC_transects["9198","rast_rec"] <- 700
DCC_transects["9199","rast_rec"] <- 800

DCC_transects["9283","rast_rec"] <- 800
DCC_transects["9284","rast_rec"] <- 770
DCC_transects["9285","rast_rec"] <- 600
DCC_transects["9286","rast_rec"] <- 720
DCC_transects["9287","rast_rec"] <- 610
DCC_transects["9288","rast_rec"] <- 530
DCC_transects["9289","rast_rec"] <- 460
DCC_transects["9290","rast_rec"] <- 380
DCC_transects["9291","rast_rec"] <- 600
DCC_transects["9292","rast_rec"] <- 730
DCC_transects["9293","rast_rec"] <- 800
DCC_transects["9294","rast_rec"] <- 820
DCC_transects["9295","rast_rec"] <- 600
DCC_transects["9296","rast_rec"] <- 740
DCC_transects["9297","rast_rec"] <- 670
DCC_transects["9298","rast_rec"] <- 730
DCC_transects["9299","rast_rec"] <- 920
DCC_transects["9300","rast_rec"] <- 820
DCC_transects["9301","rast_rec"] <- 1060
DCC_transects["9302","rast_rec"] <- 1710
DCC_transects["9303","rast_rec"] <- 1800
DCC_transects["9304","rast_rec"] <- 1860
DCC_transects["9305","rast_rec"] <- 1740
DCC_transects["9306","rast_rec"] <- 1290
DCC_transects["9307","rast_rec"] <- 900
DCC_transects["9308","rast_rec"] <- 1190
DCC_transects["9309","rast_rec"] <- 950
DCC_transects["9310","rast_rec"] <- 960
DCC_transects["9311","rast_rec"] <- 900
DCC_transects["9312","rast_rec"] <- 1210
DCC_transects["9313","rast_rec"] <- 1840
DCC_transects["9314","rast_rec"] <- 1630
DCC_transects["9315","rast_rec"] <- 1610
DCC_transects["9316","rast_rec"] <- 1450
DCC_transects["9317","rast_rec"] <- 1300
DCC_transects["9318","rast_rec"] <- 1240
DCC_transects["9319","rast_rec"] <- 1190

DCC_transects["9324","rast_rec"] <- 540
DCC_transects["9325","rast_rec"] <- 700

DCC_transects["9366","rast_rec"] <- 100

DCC_transects["9893","rast_rec"] <- 1200
DCC_transects["9894","rast_rec"] <- 1200

DCC_transects["9935","rast_rec"] <- 1000

DCC_transects["9976","rast_rec"] <- 840

DCC_transects["10017","rast_rec"] <- 150

DCC_transects["10545","rast_rec"] <- 200

DCC_transects["10586","rast_rec"] <- 620

DCC_transects["10627","rast_rec"] <- 400

DCC_transects["10586","rast_rec"] <- 620

DCC_transects["10668","rast_rec"] <- 160

DCC_transects["11238","rast_rec"] <- 1400
DCC_transects["11239","rast_rec"] <- 1490
DCC_transects["11240","rast_rec"] <- 1080
DCC_transects["11241","rast_rec"] <- 1010
DCC_transects["11242","rast_rec"] <- 1540
DCC_transects["11243","rast_rec"] <- 1770
DCC_transects["11244","rast_rec"] <- 830
DCC_transects["11245","rast_rec"] <- 650
DCC_transects["11246","rast_rec"] <- 480
DCC_transects["11247","rast_rec"] <- 980
DCC_transects["11248","rast_rec"] <- 1720
DCC_transects["11249","rast_rec"] <- 2120
DCC_transects["11250","rast_rec"] <- 1960
DCC_transects["11251","rast_rec"] <- 1110
DCC_transects["11252","rast_rec"] <- 1560
DCC_transects["11253","rast_rec"] <- 1720
DCC_transects["11254","rast_rec"] <- 1350

DCC_transects["11279","rast_rec"] <- 680

DCC_transects["11930","rast_rec"] <- 990

DCC_transects["12540","rast_rec"] <- 40

DCC_transects["13233","rast_rec"] <- 2220

DCC_transects["13314","rast_rec"] <- 310

DCC_transects["13965","rast_rec"] <- 500

DCC_transects["18523","rast_rec"] <- 150

DCC_transects["19253","rast_rec"] <- 540

DCC_transects["19904","rast_rec"] <- 400

DCC_transects["21284","rast_rec"] <- 230

DCC_transects["21322","rast_rec"] <- 210

DCC_transects["21935","rast_rec"] <- 60

DCC_transects["21973","rast_rec"] <- 200

DCC_transects["22624","rast_rec"] <- 320

DCC_transects["23312","rast_rec"] <- 100
DCC_transects["23313","rast_rec"] <- 50

DCC_transects["23963","rast_rec"] <- 68

DCC_transects["24576","rast_rec"] <- 300

DCC_transects["24614","rast_rec"] <- 150

DCC_transects["25226","rast_rec"] <- 290

DCC_transects["25839","rast_rec"] <- 270

DCC_transects["25877","rast_rec"] <- 650

DCC_transects["26490","rast_rec"] <- 380

DCC_transects["26566","rast_rec"] <- 290

DCC_transects["27102","rast_rec"] <- 470

DCC_transects["27178","rast_rec"] <- 1090

DCC_transects["27753","rast_rec"] <- 150

DCC_transects["27867","rast_rec"] <- 930

DCC_transects["27904","rast_rec"] <- 140

DCC_transects["27942","rast_rec"] <- 10

DCC_transects["28442","rast_rec"] <- 200

DCC_transects["28518","rast_rec"] <- 790

DCC_transects["28555","rast_rec"] <- 325

DCC_transects["29167","rast_rec"] <- 600

DCC_transects["29242","rast_rec"] <- 10

DCC_transects["29781","rast_rec"] <- 500

DCC_transects["29818","rast_rec"] <- 500

DCC_transects["29856","rast_rec"] <- 1000

DCC_transects["29893","rast_rec"] <- 100

DCC_transects["30394","rast_rec"] <- 310

DCC_transects["30432","rast_rec"] <- 220

DCC_transects["30507","rast_rec"] <- 500

DCC_transects["31119","rast_rec"] <- 560

DCC_transects["31156","rast_rec"] <- 40

DCC_transects["31733","rast_rec"] <- 130

DCC_transects["31826","rast_rec"] <- 130

DCC_transects["31845","rast_rec"] <- 630

DCC_transects["32384","rast_rec"] <- 50

DCC_transects["32409","rast_rec"] <- 50

DCC_transects["32495","rast_rec"] <- 340
DCC_transects["32496","rast_rec"] <- 330

DCC_transects["32034","rast_rec"] <- 15

DCC_transects["33636","rast_rec"] <- 70

DCC_transects["33685","rast_rec"] <- 10

DCC_transects["34336","rast_rec"] <- 240

DCC_transects["40075","rast_rec"] <- 70

DCC_transects["40120","rast_rec"] <- 40



sample_transect <- DCC_transects %>%
  group_by(ycoord) %>%
  mutate(rM=rollmean(rast_rec,3, na.pad=TRUE, align="right"))

#ggplot(sample_transect,
#       aes(x = xcoord, y = ycoord, group = ycoord, height = rast_rec)) +
#       geom_density_ridges(stat = "identity")
#ggplot(sample_transect,
#       aes(x = xcoord, y = rast_rec, group = ycoord, height = rast_rec)) +
#       geom_line(aes(y=rollmean(rast_rec, 5, na.pad=TRUE)))

#DCC_transects$rast_rec <- DCC_transects$rast_rec + offset
# view data frame and change column headers
#head(DCC_transects)

DCC_basic <- ggplot(DCC_transects,
  aes(x = xcoord, y = ycoord, group = ycoord, height = rast_rec)) +
  geom_density_ridges(stat = "identity")

#DCC_basic

# customize the appearance to mimic the Unknown Pleasures artwork
DCC_Joy <- ggplot(sample_transect,
  aes(x = xcoord, y = ycoord, group = ycoord, height = rM)) +
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
