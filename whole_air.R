#WholeArea
#1 Calculating the Cumulative Air Dose Rate
#2 Establish the region
#3 Calculate the CED
#4 Make percentages of Region, Population and CED
library(dplyr)
library(ggplot2)
library(leaflet)
nukeicon <- makeIcon(iconUrl = "nukeicon.png",iconWidth = 18, iconHeight=18)
# Data source: http://emdb.jaea.go.jp/emdb/en/portals/b131/
# Source:NRA for 2011 and 2012 Datasets
air_2011 <- read.csv(file = "FukushimaJune2011.csv", header = TRUE) # 45,273 entries
names(air_2011) <- c("gridcode","pref","city","gridCenterNorthlat","gridCenterEastlng",
                     "gridCenterNorthlatDec","gridCenterEastlngDec","daichi_distance",
                     "no_samples","AvgAirDoseRate","NE_nLat","NE_eLong","NW_nLat","NW_eLong",
                     "SW_nLat","SW_eLong","SE_nLat","SE_eLong")
air_2011$gridcode <- gsub("_","",air_2011$gridcode)
#remove background radiations, jp govt sets at 0.04µSv/h
air_2011<- subset(air_2011, AvgAirDoseRate > 0.04) # 45,268 entries
#Calculate annual external dose rate
air_2011$AnnualExtDose <- (air_2011$AvgAirDoseRate - 0.04)*(8 + 16*0.4)*365/1000
air_2011$pref <- as.character(air_2011$pref)
air_2011$city <- as.character(air_2011$city)
air_2011$gridcode <- as.character(air_2011$gridcode)
#make cuts of Annual External Air Dose
air_2011$AnnualExDoseRange <- cut(air_2011$AnnualExtDose, c(0,1,3,5,10,20,50,100,200))
#calculate area
air_2011AnnualExDoseRange_summary <- data.frame(table(air_2011$AnnualExDoseRange))
air_2011AnnualExDoseRange_summary$Areakm2 <- 0.01 * air_2011AnnualExDoseRange_summary$Freq
sum(air_2011AnnualExDoseRange_summary$Areakm2) #452.68

####

iro2 <- colorFactor(
        palette = "PuRd",
        domain = air_2011$AnnualExDoseRange
)
air_2011_plot <- leaflet() %>%
        addTiles()%>%
        addRectangles(data = air_2011,lng1 = ~SW_eLong, lat1 = ~SW_nLat,
                      lng2 = ~NE_eLong, lat2 = ~NE_nLat,
                      color = ~iro2(air_2011$AnnualExDoseRange)) %>%
        addLegend("bottomright", pal = iro2, values = air_2011$AnnualExDoseRange,
                  title = "AnnualExDoseRange",
                  labFormat = labelFormat(prefix = "mSv/y "),
                  opacity = 1)%>%
        addMarkers(lat = 37.4211, lng = 141.0328,icon = nukeicon)
air_2011_plot



# FukushimaMarch2012
air_2012 <- read.csv(file = "FukushimaMarch2012.csv", header = TRUE) #38,741 entries
names(air_2012) <- c("gridcode","pref","city","gridCenterNorthlat","gridCenterEastlng",
                     "gridCenterNorthlatDec","gridCenterEastlngDec","daichi_distance",
                     "no_samples","AvgAirDoseRate","NE_nLat","NE_eLong","NW_nLat","NW_eLong",
                     "SW_nLat","SW_eLong","SE_nLat","SE_eLong")
air_2012$pref <- as.character(air_2012$pref)
air_2012$city <- as.character(air_2012$city)
air_2012$gridcode <- as.character(air_2012$gridcode)
#remove background radiations, jp govt sets at 0.04µSv/h
air_2012<- subset(air_2012, AvgAirDoseRate > 0.04) #38,740  entries
#Calculate annual external dose rate
air_2012$AnnualExtDose <- (air_2012$AvgAirDoseRate - 0.04)*(8 + 16*0.4)*365/1000

#make cuts of Annual External Air Dose
air_2012$AnnualExDoseRange <- cut(air_2012$AnnualExtDose, c(0,1,3,5,10,20,50,100,200))
#calculate area
air_2012AnnualExDoseRange_summary <- data.frame(table(air_2012$AnnualExDoseRange))
air_2012AnnualExDoseRange_summary$Areakm2 <- 0.01 * air_2012AnnualExDoseRange_summary$Freq
sum(air_2012AnnualExDoseRange_summary$Areakm2)  #387.4km²
View(air_2012AnnualExDoseRange_summary)
iro2 <- colorFactor(
        palette = "PuRd",
        domain = air_2012$AnnualExDoseRange
)
air_2012_plot <- leaflet() %>%
        addTiles()%>%
        addRectangles(data = air_2012,lng1 = ~SW_eLong, lat1 = ~SW_nLat,
                      lng2 = ~NE_eLong, lat2 = ~NE_nLat,
                      color = ~iro2(air_2012$AnnualExDoseRange)) %>%
        addLegend("bottomright", pal = iro2, values = air_2012$AnnualExDoseRange,
                  title = "AnnualExDoseRange",
                  labFormat = labelFormat(prefix = "mSv/y "),
                  opacity = 1)%>%
        addMarkers(lat = 37.4211, lng = 141.0328,icon = nukeicon)
air_2012_plot


# FukushimaMarch2013 
#Air Dose Rate Measurement Results from the Seventh Vehicle-borne Survey 
# ( From November 5, to December 12, 2013 ) [KURAMA Dataset]
air_2013k <- read.csv(file = "FukushimaDecember2013.csv", header = TRUE) #119,522 entries
names(air_2013k) <- c("gridcode","pref","city","gridCenterNorthlat","gridCenterEastlng",
                     "gridCenterNorthlatDec","gridCenterEastlngDec","daichi_distance",
                     "no_samples","AvgAirDoseRate","NE_nLat","NE_eLong","NW_nLat","NW_eLong",
                     "SW_nLat","SW_eLong","SE_nLat","SE_eLong")
air_2013k$pref <- as.character(air_2013k$pref)
air_2013k$city <- as.character(air_2013k$city)
air_2013k$gridcode <- as.character(air_2013k$gridcode)
#remove background radiations, jp govt sets at 0.04µSv/h
air_2013k<- subset(air_2013k, AvgAirDoseRate > 0.04) #118,348   entries
#Calculate annual external dose rate
air_2013k$AnnualExtDose <- (air_2013k$AvgAirDoseRate - 0.04)*(8 + 16*0.4)*365/1000

#make cuts of Annual External Air Dose
air_2013k$AnnualExDoseRange <- cut(air_2013k$AnnualExtDose, c(0,1,3,5,10,20,50,100,200))
#calculate area
air_2013kAnnualExDoseRange_summary <- data.frame(table(air_2013k$AnnualExDoseRange))
air_2013kAnnualExDoseRange_summary$Areakm2 <- 0.01 * air_2013kAnnualExDoseRange_summary$Freq
sum(air_2013kAnnualExDoseRange_summary$Areakm2)  # 1183.47km²
View(air_2013kAnnualExDoseRange_summary)
iro2 <- colorFactor(
        palette = "PuRd",
        domain = air_2013k$AnnualExDoseRange
)
air_2013k_plot <- leaflet() %>%
        addTiles()%>%
        addRectangles(data = air_2013k,lng1 = ~SW_eLong, lat1 = ~SW_nLat,
                      lng2 = ~NE_eLong, lat2 = ~NE_nLat,
                      color = ~iro2(air_2013k$AnnualExDoseRange)) %>%
        addLegend("bottomright", pal = iro2, values = air_2013k$AnnualExDoseRange,
                  title = "AnnualExDoseRange",
                  labFormat = labelFormat(prefix = "mSv/y "),
                  opacity = 1)%>%
        addMarkers(lat = 37.4211, lng = 141.0328,icon = nukeicon)
air_2013k_plot



# 2013 FUKUSHIMA [Bus Routes]
air_2013a <- read.csv(file = "10214700024_00_201303/10214700024_00_20130224.csv", header = TRUE)
air_2013b <- read.csv(file = "10214700024_00_201303/10214700024_00_20130303.csv", header = TRUE)
air_2013c <- read.csv(file = "10214700024_00_201303/10214700024_00_20130310.csv", header = TRUE)
air_2013d <- read.csv(file = "10214700024_00_201303/10214700024_00_20130317.csv", header = TRUE)
air_2013e <- read.csv(file = "10214700024_00_201303/10214700024_00_20130324.csv", header = TRUE)
air_2013f <- read.csv(file = "10214700024_00_201303/10214700024_00_20130331.csv", header = TRUE)

rbind(dim(air_2013a),dim(air_2013b),dim(air_2013c),dim(air_2013d),dim(air_2013e),dim(air_2013f))
#concanete all the dataframes of 2013
air_2013 <- Reduce(rbind, list(air_2013a,air_2013b,air_2013c,air_2013d,air_2013e,air_2013f)) #entries 24,328  
names(air_2013) <- c("mdate","gridcode","gridCenterNorthlat","gridCenterEastlng","gridScornerNorthlatDec",
                     "gridWcornerEastlngDec","gridNcornerNorthlatDec","gridEcornerEastlngDec",
                     "daichi_distance","no_samples1cm","AvgAirDoseRate")
# subset by removing duplicated gridcodes (joints where buses cross)
air_2013 <- subset(air_2013, !duplicated(gridcode)) # 6,921 entries

air_2013<- subset(air_2013, AvgAirDoseRate > 0.04) #6,913 entries
#Calculate annual external dose rate
air_2013$AnnualExtDose <- (air_2013$AvgAirDoseRate - 0.04)*(8 + 16*0.4)*365/1000
# Min.    1st Qu. Median    Mean     3rd Qu.  Max. 
# 0.07008 0.56060 1.19100   1.25000  1.68200  6.72800 
#make cuts of Annual External Air Dose
air_2013$AnnualExDoseRange <- cut(air_2013$AnnualExtDose, c(0,1,3,5,10,20,50,100,200))
#calculate area
air_2013AnnualExDoseRange_summary <- data.frame(table(air_2013$AnnualExDoseRange))
air_2013AnnualExDoseRange_summary$Areakm2 <- 0.01 * air_2013AnnualExDoseRange_summary$Freq
sum(air_2013AnnualExDoseRange_summary$Areakm2)  #69.13km²

iro2 <- colorFactor(
        palette = "PuRd",
        domain = air_2013$AnnualExDoseRange
)
air_2013_plot <- leaflet() %>%
        addTiles()%>%
        addRectangles(data = air_2013,lng1 = ~gridWcornerEastlngDec,lat1 = ~gridScornerNorthlatDec, 
                      lng2 = ~gridEcornerEastlngDec, lat2 = ~gridNcornerNorthlatDec,
                      color = ~iro2(air_2013$AnnualExDoseRange)) %>%
        addLegend("bottomright", pal = iro2, values = air_2013$AnnualExDoseRange,
                  title = "AnnualExDoseRange",
                  labFormat = labelFormat(prefix = "mSv/y "),
                  opacity = 1)%>%
        addMarkers(lat = 37.4211, lng = 141.0328,icon = nukeicon) 
air_2013_plot

#  Readings of Detailed Monitoring in the Areas to Which Evacuation Orders Have Been Issued 
# (17th Vehicle-borne Survey) ( From March 2014 to April 2014 ) [Bus Routes]
air_2014a <- read.csv(file = "10214700025_00_201403/10214700025_00_20140223.csv", header = TRUE)
air_2014b <- read.csv(file = "10214700025_00_201403/10214700025_00_20140302.csv", header = TRUE)
air_2014c <- read.csv(file = "10214700025_00_201403/10214700025_00_20140309.csv", header = TRUE)
air_2014d <- read.csv(file = "10214700025_00_201403/10214700025_00_20140316.csv", header = TRUE)
air_2014e <- read.csv(file = "10214700025_00_201403/10214700025_00_20140323.csv", header = TRUE)
air_2014f <- read.csv(file = "10214700025_00_201403/10214700025_00_20140330.csv", header = TRUE)

rbind(dim(air_2014a),dim(air_2014b),dim(air_2014c),dim(air_2014d),dim(air_2014e),dim(air_2014f))
#concanete all the dataframes of 2014
air_2014 <- Reduce(rbind, list(air_2014a,air_2014b,air_2014c,air_2014d,air_2014e,air_2014f)) #entries 20,049  
names(air_2014) <- c("mdate","gridcode","gridCenterNorthlat","gridCenterEastlng","gridScornerNorthlatDec",
                     "gridWcornerEastlngDec","gridNcornerNorthlatDec","gridEcornerEastlngDec",
                     "daichi_distance","no_samples1cm","AvgAirDoseRate")
# subset by removing duplicated gridcodes (joints where buses cross)
air_2014 <- subset(air_2014, !duplicated(gridcode)) # 7,253 entries

air_2014<- subset(air_2014, AvgAirDoseRate > 0.04) #7,148 entries
#Calculate annual external dose rate
air_2014$AnnualExtDose <- (air_2014$AvgAirDoseRate - 0.04)*(8 + 16*0.4)*365/1000
 
#make cuts of Annual External Air Dose
air_2014$AnnualExDoseRange <- cut(air_2014$AnnualExtDose, c(0,1,3,5,10,20,50,100,200))
#calculate area
air_2014AnnualExDoseRange_summary <- data.frame(table(air_2014$AnnualExDoseRange))
air_2014AnnualExDoseRange_summary$Areakm2 <- 0.01 * air_2014AnnualExDoseRange_summary$Freq
sum(air_2014AnnualExDoseRange_summary$Areakm2)  # 71.48km²

iro2 <- colorFactor(
        palette = "PuRd",
        domain = air_2014$AnnualExDoseRange
)
air_2014_plot <- leaflet() %>%
        addTiles()%>%
        addRectangles(data = air_2014,lng1 = ~gridWcornerEastlngDec,lat1 = ~gridScornerNorthlatDec, 
                      lng2 = ~gridEcornerEastlngDec, lat2 = ~gridNcornerNorthlatDec,
                      color = ~iro2(air_2014$AnnualExDoseRange)) %>%
        addLegend("bottomright", pal = iro2, values = air_2014$AnnualExDoseRange,
                  title = "AnnualExDoseRange",
                  labFormat = labelFormat(prefix = "mSv/y "),
                  opacity = 1)%>%
        addMarkers(lat = 37.4211, lng = 141.0328,icon = nukeicon) 
air_2014_plot


# FUKUSHIMA 2015 [Bus Routes]
air_2015a <- read.csv(file = "10214700026_00_201503/10214700026_00_20150301.csv", header = TRUE)
air_2015b <- read.csv(file = "10214700026_00_201503/10214700026_00_20150308.csv", header = TRUE)
air_2015c <- read.csv(file = "10214700026_00_201503/10214700026_00_20150315.csv", header = TRUE)
air_2015d <- read.csv(file = "10214700026_00_201503/10214700026_00_20150322.csv", header = TRUE)
air_2015e <- read.csv(file = "10214700026_00_201503/10214700026_00_20150329.csv", header = TRUE)


rbind(dim(air_2015a),dim(air_2015b),dim(air_2015c),dim(air_2015d),dim(air_2015e))
#concanete all the dataframes of 2015
air_2015 <- Reduce(rbind, list(air_2015a,air_2015b,air_2015c,air_2015d,air_2015e)) #entries 15,853 
names(air_2015) <- c("mdate","gridcode","gridCenterNorthlat","gridCenterEastlng","gridScornerNorthlatDec",
                     "gridWcornerEastlngDec","gridNcornerNorthlatDec","gridEcornerEastlngDec",
                     "daichi_distance","no_samples1cm","AvgAirDoseRate")
# subset by removing duplicated gridcodes (joints where buses cross)
air_2015 <- subset(air_2015, !duplicated(gridcode)) # 4,822 entries

air_2015<- subset(air_2015, AvgAirDoseRate > 0.04) #4,652 entries
#Calculate annual external dose rate
air_2015$AnnualExtDose <- (air_2015$AvgAirDoseRate - 0.04)*(8 + 16*0.4)*365/1000

#make cuts of Annual External Air Dose
air_2015$AnnualExDoseRange <- cut(air_2015$AnnualExtDose, c(0,1,3,5,10,20,50,100,200))
#calculate area
air_2015AnnualExDoseRange_summary <- data.frame(table(air_2015$AnnualExDoseRange))
air_2015AnnualExDoseRange_summary$Areakm2 <- 0.01 * air_2015AnnualExDoseRange_summary$Freq
sum(air_2015AnnualExDoseRange_summary$Areakm2)  # 46.52km²

iro2 <- colorFactor(
        palette = "PuRd",
        domain = air_2015$AnnualExDoseRange
)
air_2015_plot <- leaflet() %>%
        addTiles()%>%
        addRectangles(data = air_2015,lng1 = ~gridWcornerEastlngDec,lat1 = ~gridScornerNorthlatDec, 
                      lng2 = ~gridEcornerEastlngDec, lat2 = ~gridNcornerNorthlatDec,
                      color = ~iro2(air_2015$AnnualExDoseRange)) %>%
        addLegend("bottomright", pal = iro2, values = air_2015$AnnualExDoseRange,
                  title = "AnnualExDoseRange",
                  labFormat = labelFormat(prefix = "mSv/y "),
                  opacity = 1)%>%
        addMarkers(lat = 37.4211, lng = 141.0328,icon = nukeicon) 
air_2015_plot


### Search for rich data sources
# http://emdb.jaea.go.jp/emdb/en/portals/10420102/
# tepcodosi <- read.csv("2011-2015TEPCO-Dosimeter.csv")
# 10 Towns around Daichi, though data says 20km outsides

# Readings of the Eighth Fukushima Prefecture Environmental Radiation Monitoring in Mesh Survey 
air_2014p <- read.csv("fukprefMay-June2014.csv") #2904x7 dim, 58 NAME_2 level
names(air_2014p) <- c("mdate","pref","city","NorthlatDec","EastlngDec",
                           "daichi_distance","AvgAirDoseRate")
air_2014p$mdate <- as.Date(air_2014p$mdate)
air_2014p$pref <- as.character(air_2014p$pref)
air_2014p$city <- as.character(air_2014p$city)

#remove background radiations, jp govt sets at 0.04µSv/h
air_2014p<- subset(air_2014p, AvgAirDoseRate > 0.04) #2904    entries
#Calculate annual external dose rate
air_2014p$AnnualExtDose <- (air_2014p$AvgAirDoseRate - 0.04)*(8 + 16*0.4)*365/1000

#make cuts of Annual External Air Dose
air_2014p$AnnualExDoseRange <- cut(air_2014p$AnnualExtDose, c(0,1,3,5,10,20,50,100,200))
#calculate area
air_2014pAnnualExDoseRange_summary <- data.frame(table(air_2014p$AnnualExDoseRange))
air_2014pAnnualExDoseRange_summary$Areakm2 <- 0.01 * air_2014pAnnualExDoseRange_summary$Freq
sum(air_2014pAnnualExDoseRange_summary$Areakm2)  # 29.04km²
View(air_2014pAnnualExDoseRange_summary)
iro2 <- colorFactor(
        palette = "PuRd",
        domain = air_2014p$AnnualExDoseRange
)
air_2014p_plot <- leaflet() %>%
        addTiles()%>%
        addCircles(data = air_2014p,lng = ~EastlngDec, lat = ~NorthlatDec,
                      color = ~iro2(air_2014p$AnnualExDoseRange)) %>%
        addLegend("bottomright", pal = iro2, values = air_2014p$AnnualExDoseRange,
                  title = "AnnualExDoseRange",
                  labFormat = labelFormat(prefix = "mSv/y "),
                  opacity = 1)%>%
        addMarkers(lat = 37.4211, lng = 141.0328,icon = nukeicon)
air_2014p_plot

# ( From May 2015 to June 2015 ),FY 2011 - FY 2015   The Secretariat of the Nuclear Regulation Authority, and Fukushima Prefecture
air_2015p <- read.csv("fukprefMay-June2015.csv") #2871x7 dim, 58 NAME_2 level

names(air_2015p) <- c("mdate","pref","city","NorthlatDec","EastlngDec",
                      "daichi_distance","AvgAirDoseRate")
air_2015p$mdate <- as.Date(air_2015p$mdate)
air_2015p$pref <- as.character(air_2015p$pref)
air_2015p$city <- as.character(air_2015p$city)

#remove background radiations, jp govt sets at 0.04µSv/h
air_2015p<- subset(air_2015p, AvgAirDoseRate > 0.04) #2870    entries
#Calculate annual external dose rate
air_2015p$AnnualExtDose <- (air_2015p$AvgAirDoseRate - 0.04)*(8 + 16*0.4)*365/1000

#make cuts of Annual External Air Dose
air_2015p$AnnualExDoseRange <- cut(air_2015p$AnnualExtDose, c(0,1,3,5,10,20,50,100,200))
#calculate area
air_2015pAnnualExDoseRange_summary <- data.frame(table(air_2015p$AnnualExDoseRange))
air_2015pAnnualExDoseRange_summary$Areakm2 <- 0.01 * air_2015pAnnualExDoseRange_summary$Freq
sum(air_2015pAnnualExDoseRange_summary$Areakm2)  # 28.7km²

iro2 <- colorFactor(
        palette = "PuRd",
        domain = air_2015p$AnnualExDoseRange
)
air_2015p_plot <- leaflet() %>%
        addTiles()%>%
        addCircles(data = air_2015p,lng = ~EastlngDec, lat = ~NorthlatDec,
                   color = ~iro2(air_2015p$AnnualExDoseRange)) %>%
        addLegend("bottomright", pal = iro2, values = air_2015p$AnnualExDoseRange,
                  title = "AnnualExDoseRange",
                  labFormat = labelFormat(prefix = "mSv/y "),
                  opacity = 1)%>%
        addMarkers(lat = 37.4211, lng = 141.0328,icon = nukeicon)
air_2015p_plot





#PREPARING DATASET FOR MERGING WITH THE GADM SPATIALPOLYGONDATAFRAME
air_2011_ordered <- air_2011[order(air_2011$city),]

cities <- as.character(air_2011_ordered$city)
class(cities)

#try function
ag_extdose <- aggregate(AnnualExtDose~city, FUN = mean, data = air_2011)
length(ag_extdose)
ag_extdose$city_sp <- c("Ōtama", "Aizuwakamatsu" , "Date","Kawamata", "Kōri","Kunimi","Fukushima","Futaba","Hirono","Katsurao","Kawauchi","Namie",
                        "Naraha","Ōkuma", "Tomioka", "Hanawa","Samegawa","Tanagura","Yamatsuri","Asakawa","Furudono","Hirata","Ishikawa","Tamakawa",
                        "Iwaki","Kagamiishi","Ten'ei","Aizubange","Yanaizu","Yugawa","Kitakata","Kōriyama","Hinoemata","Minamiaizu","Shimogō","Tadami",
                        "Minamisōma","Motomiya","Nihonmatsu","Izumizaki","Nakajima","Nishigou","Yabuki","Aizumisato","Kaneyama","Mishima","Shōwa",
                        "Shirakawa","Sōma","Iitate","Shinchi","Sukagawa","Tamura","Miharu","Ono","Bandai","Inawashiro","Kitashiobara","Nishiaizu")
View(ag_extdose)
fu_adm$NAME_2 %in% ag_extdose$city_sp
#return rows that dont match
fu_adm$NAME_2[!fu_adm$NAME_2 %in% ag_extdose$city_sp]
# add zero ag_extdose for iino village
ag_extdose[nrow(ag_extdose) + 1, ] <- c(NA,"Iino")

#drop one column
ag_extdose$city <- NULL
#rename city to march NAME_2
ag_extdose <- rename(ag_extdose, NAME_2=city_sp)


### thinking of having min,max and ave of each town
library(dplyr)
df <- air_2011_ordered
df <- df %>% group_by(city) %>% mutate(MinADR = min(AnnualExtDose), MaxADR = max(AnnualExtDose),MeanADR = mean(AnnualExtDose), Sdv =sd(AnnualExtDose))
View(df)
df1 <- df %>% group_by(city) %>% summarise(MinADR = min(AnnualExtDose), MaxADR = max(AnnualExtDose),MeanADR = mean(AnnualExtDose), Sdv =sd(AnnualExtDose))
View(df1)
#or
d1 %>% group_by(country, gender) %>% summarise(amt = sum(loan_amount)) %>% transmute(gender = gender, perc = amt/sum(amt))


#44 Whole
survey <- read.csv("44whole.csv")
dim(survey)
View(survey)
