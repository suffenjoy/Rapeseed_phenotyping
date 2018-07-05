library(raster)
library(rgdal)
library(ForestTools)

#For detailed instruction: https://cran.r-project.org/web/packages/ForestTools/vignettes/treetopAnalysis.html
#Use library of ForestTools
##Read the CHM data
CHM_phynofield <- raster(file.path(path_output, "rapeseed_CHM_20180226_phynofield"))
CHM_biomefield <- raster(file.path(path_output, "rapeseed_CHM_20180226_biomefield"))
CHM_otherfield <- raster(file.path(path_output, "rapeseed_CHM_20180226_otherfield"))
##Read the UAV image data
otherfield_20180226 <- brick(file.path(path_output, "rapeseed_20180225_otherfield"))
biomefield_20180226 <- brick(file.path(path_output, "rapeseed_20180225_biomefield"))
phynofield_20180226 <- brick(file.path(path_output, "rapeseed_20180225_phynofield"))

#--------------------------------------------------#
#Otherfield (highest canopy)
##function for dynamic window size (not sure what parameter to use)
lin <- function(x){x*0.005+0.06} 
##find crop top
ptops_otherfield <- TreeTopFinder(CHM = CHM_otherfield, winFun = lin, minHeight = 0.05, maxWinDiameter = 125)
##plot the crop top
plot(CHM_otherfield, xlab = "", ylab  = "", xaxt = "n", yaxt = "n")
plot(ptops_otherfield, col = "blue", pch = 20, cex = 0.5, add = TRUE)
##Outline the crown of the crop
crowns_otherfield <- SegmentCrowns(treetops = ptops_otherfield, CHM = CHM_otherfield, format = "polygons", minHeight = 0.05, verbose =  FALSE)

#plot CHM 
plot(CHM_otherfield, xlab = "", ylab  = "", xaxt = "n", yaxt = "n")
#Add top of the plants
plot(ptops_otherfield, col = "blue", pch = 20, cex = 0.5, add = TRUE)
#Add crown outlines to the plot
plot(crowns_otherfield, border = "blue", lwd = 0.5, add = TRUE)

#plot RGB image
plotRGB(otherfield_20180226, 3,2,1, stretch = "lin")
#Add crown outlines to the plot
plot(crowns_otherfield, border = "white", lwd = 1, add = TRUE)
#Add top of the plants
plot(ptops_otherfield, col = "white", pch = 19, cex = 1, add = TRUE)


#--------------------------------------------------#
#biomefield (medium canopy)
##function for dynamic window size (not sure what parameter to use)
lin <- function(x){x*0.005+0.06} 
##find crop top
ptops_biomefield <- TreeTopFinder(CHM = CHM_biomefield, winFun = lin, minHeight = 0.05, maxWinDiameter = 125)
##plot the crop top
plot(CHM_biomefield, xlab = "", ylab  = "", xaxt = "n", yaxt = "n")
plot(ptops_biomefield, col = "blue", pch = 20, cex = 0.5, add = TRUE)
##Outline the crown of the crop
crowns_biomefield <- SegmentCrowns(treetops = ptops_biomefield, CHM = CHM_biomefield, format = "polygons", minHeight = 0.02, verbose =  FALSE)

#plot CHM 
plot(CHM_biomefield, xlab = "", ylab  = "", xaxt = "n", yaxt = "n")
#Add crown outlines to the plot
plot(crowns_biomefield, border = "blue", lwd = 0.5, add = TRUE)
#Add top of the plants
plot(ptops_biomefield, col = "blue", pch = 20, cex = 0.5, add = TRUE)

#plot RGB image
plotRGB(biomefield_20180226, 3,2,1, stretch = "lin")
#Add crown outlines to the plot
plot(crowns_biomefield, border = "white", lwd = 1, add = TRUE)
#Add top of the plants
plot(ptops_biomefield, col = "white", pch = 19, cex = 1, add = TRUE)


#--------------------------------------------------#
#phynofield (highest canopy)
##function for dynamic window size (not sure what parameter to use)
lin <- function(x){x*0.005+0.06} 
##find crop top
ptops_phynofield <- TreeTopFinder(CHM = CHM_phynofield, winFun = lin, minHeight = 0.05, maxWinDiameter = 125)
##plot the crop top
plot(CHM_phynofield, xlab = "", ylab  = "", xaxt = "n", yaxt = "n")
plot(ptops_phynofield, col = "blue", pch = 20, cex = 0.5, add = TRUE)
##Outline the crown of the crop
crowns_phynofield <- SegmentCrowns(treetops = ptops_phynofield, CHM = CHM_phynofield, format = "polygons", minHeight = 0.02, verbose =  FALSE)

#plot CHM 
plot(CHM_phynofield, xlab = "", ylab  = "", xaxt = "n", yaxt = "n")
#Add crown outlines to the plot
plot(crowns_phynofield, border = "blue", lwd = 0.5, add = TRUE)
#Add top of the plants
plot(ptops_phynofield, col = "blue", pch = 20, cex = 0.5, add = TRUE)

#plot RGB image
plotRGB(phynofield_20180226, 3,2,1, stretch = "lin")
#Add crown outlines to the plot
plot(crowns_phynofield, border = "white", lwd = 0.5, add = TRUE)
#Add top of the plants
plot(ptops_phynofield, col = "white", pch = 20, cex = 0.5, add = TRUE)

