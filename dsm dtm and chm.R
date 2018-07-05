library(raster)
library(rgdal)
library(ForestTools)

#DSM
path_DSM <- "I:/Rapeseed phynotyping/rapeseed phynotyping 3d model test flight 20180226/3_dsm_ortho/1_dsm"
rapeseed_DSM_20180226 <- raster(file.path(path_DSM, "rapeseed phynotyping 3d model test flight 20180226_dsm.tif"))
plot(rapeseed_DSM_20180226)

#DTM
path_DTM <- "I:/Rapeseed phynotyping/rapeseed phynotyping 3d model test flight 20180226/3_dsm_ortho/extras/dtm"
rapeseed_DTM_20180226 <- raster(file.path(path_DTM, "rapeseed phynotyping 3d model test flight 20180226_dtm.tif"))
plot(rapeseed_DTM_20180226)

#Resample DSM and DTM
rapeseed_DSM_20180226_resample <- resample(x = rapeseed_DSM_20180226, y = rapeseed_DTM_20180226, method = "bilinear")
rapeseed_DTM_20180226_resample <- resample(x = rapeseed_DTM_20180226, y = rapeseed_DSM_20180226)

#Calculate the difference
CHM_20180226_16 <- rapeseed_DSM_20180226 - rapeseed_DTM_20180226_resample #res = 0.01596m
CHM_20180226_80 <- rapeseed_DSM_20180226_resample - rapeseed_DTM_20180226 #res = 0.07978m
plot(CHM_20180226_16)
plot(CHM_20180226_80)

#write the raster of the resampled DSM and DTM and the CHMs 
path_output <- "I:/Rapeseed phynotyping/Results"
writeRaster(rapeseed_DSM_20180226_resample, file.path(path_output, "rapeseed_DSM_20180226_res80.tif"))
writeRaster(rapeseed_DTM_20180226_resample, file.path(path_output, "rapeseed_DTM_20180226_res16.tif"))
writeRaster(CHM_20180226_16, file.path(path_output, "rapeseed_CHM_20180226_res16.tif"))
writeRaster(CHM_20180226_80, file.path(path_output, "rapeseed_CHM_20180226_res80.tif"))

#Resample chm to the the same plot of uav image
rapeseed_20180225 <- brick(file.path(path_output, "rapeseed_20180225.tif"))
CHM_20180226 <- resample(x = rapeseed_DSM_20180226, y = rapeseed_20180225) - resample(x = rapeseed_DTM_20180226, y = rapeseed_20180225)
writeRaster(CHM_20180226, file.path(path_output, "rapeseed_CHM_20180226.tif"))









