#Whole area on a 4x4 km2
library(leaflet)
library(dplyr)
library(jpmesh)
library(ggplot2)
nukeicon <- makeIcon(iconUrl = "nukeicon.png",iconWidth = 18, iconHeight=18)

air_11 <- read.csv("44/Aug2011.csv") #2776    7, 105 NAME_2 level

names(air_11) <- c("mdate","pref","city","NorthlatDec","EastlngDec",
                      "daichi_distance","AvgAirDoseRate")
air_11$mdate <- as.Date(air_11$mdate)
air_11$pref <- as.character(air_11$pref)
air_11$city <- as.character(air_11$city)
air_11$gride <- latlong_to_meshcode(lat = air_11$NorthlatDec, long = air_11$EastlngDec,order = 3)
#remove background radiations, jp govt sets at 0.04µSv/h
air_11<- subset(air_11, AvgAirDoseRate > 0.04) # 2776    8
#Calculate annual external dose rate
air_11$AnnualExtDose <- (air_11$AvgAirDoseRate - 0.04)*(8 + 16*0.4)*365/1000

#make cuts of Annual External Air Dose
air_11$AnnualExDoseRange <- cut(air_11$AnnualExtDose, c(0,1,3,5,10,15,20,25,30))

#remove duplicate grides
air_11 <- air_11[!duplicated(air_11$gride),] # 2392   10

#calculate area
air_11AnnualExDoseRange_summary <- data.frame(table(air_11$AnnualExDoseRange))
air_11AnnualExDoseRange_summary$Areakm2 <- air_11AnnualExDoseRange_summary$Freq
sum(air_11AnnualExDoseRange_summary$Areakm2)  # 

iro2 <- colorFactor(
        palette = "PuRd",
        domain = air_11$AnnualExDoseRange
)
air_11_plot <- leaflet() %>%
        addTiles()%>%
        addCircles(data = air_11,lng = ~EastlngDec, lat = ~NorthlatDec,
                   color = ~iro2(air_11$AnnualExDoseRange)) %>%
        addLegend("bottomright", pal = iro2, values = air_11$AnnualExDoseRange,
                  title = "AnnualExDoseRange",
                  labFormat = labelFormat(prefix = "mSv/y "),
                  opacity = 1)%>%
        addMarkers(lat = 37.4211, lng = 141.0328,icon = nukeicon)
air_11_plot

unique_gride <- unique()

air_11_15_summary <- air_11_15 %>% summarise(group_by(unique(gride)) %>% transmute(MinADR = min(AnnualExtDose), MaxADR = max(AnnualExtDose),MeanADR = mean(AnnualExtDose), SdADR =sd(AnnualExtDose)))

### 2012
air_12 <- read.csv("44/March2012.csv") #2674    7, 58 NAME_2 level

names(air_12) <- c("mdate","pref","city","NorthlatDec","EastlngDec",
                   "daichi_distance","AvgAirDoseRate")
air_12$mdate <- as.Date(air_12$mdate)
air_12$pref <- as.character(air_12$pref)
air_12$city <- as.character(air_12$city)
air_12$gride <- latlong_to_meshcode(lat = air_12$NorthlatDec, long = air_12$EastlngDec,order = 3)
#remove background radiations, jp govt sets at 0.04µSv/h
air_12<- subset(air_12, AvgAirDoseRate > 0.04) # 2776    8
#Calculate annual external dose rate
air_12$AnnualExtDose <- (air_12$AvgAirDoseRate - 0.04)*(8 + 16*0.4)*365/1000

#make cuts of Annual External Air Dose
air_12$AnnualExDoseRange <- cut(air_12$AnnualExtDose, c(0,1,3,5,10,15,20,25,30))

#remove duplicate grides
air_12 <- air_12[!duplicated(air_12$gride),] # 2295   10

## 2013
air_13 <- read.csv("44/May2013.csv") #2747    7, 58 NAME_2 level

names(air_13) <- c("mdate","pref","city","NorthlatDec","EastlngDec",
                   "daichi_distance","AvgAirDoseRate")
air_13$mdate <- as.Date(air_13$mdate)
air_13$pref <- as.character(air_13$pref)
air_13$city <- as.character(air_13$city)
air_13$gride <- latlong_to_meshcode(lat = air_13$NorthlatDec, long = air_13$EastlngDec,order = 3)
#remove background radiations, jp govt sets at 0.04µSv/h
air_13<- subset(air_13, AvgAirDoseRate > 0.04) # 2747    8
#Calculate annual external dose rate
air_13$AnnualExtDose <- (air_13$AvgAirDoseRate - 0.04)*(8 + 16*0.4)*365/1000

#make cuts of Annual External Air Dose
air_13$AnnualExDoseRange <- cut(air_13$AnnualExtDose, c(0,1,3,5,10,15,20,25,30))

#remove duplicate grides
air_13 <- air_13[!duplicated(air_13$gride),] # 2395   10


# 2014
air_14 <- read.csv("44/May2014.csv") #2904    7, 58 NAME_2 level

names(air_14) <- c("mdate","pref","city","NorthlatDec","EastlngDec",
                   "daichi_distance","AvgAirDoseRate")
air_14$mdate <- as.Date(air_14$mdate)
air_14$pref <- as.character(air_14$pref)
air_14$city <- as.character(air_14$city)
air_14$gride <- latlong_to_meshcode(lat = air_14$NorthlatDec, long = air_14$EastlngDec,order = 3)
#remove background radiations, jp govt sets at 0.04µSv/h
air_14 <- subset(air_14, AvgAirDoseRate > 0.04) # 2904    8
#Calculate annual external dose rate
air_14$AnnualExtDose <- (air_14$AvgAirDoseRate - 0.04)*(8 + 16*0.4)*365/1000

#make cuts of Annual External Air Dose
air_14$AnnualExDoseRange <- cut(air_14$AnnualExtDose, c(0,1,3,5,10,15,20,25,30))

#remove duplicate grides
air_14 <- air_14[!duplicated(air_14$gride),] # 2548   10


## 2015
air_15 <- read.csv("44/May2015.csv") #2871    7, 58 NAME_2 level

names(air_15) <- c("mdate","pref","city","NorthlatDec","EastlngDec",
                   "daichi_distance","AvgAirDoseRate")
air_15$mdate <- as.Date(air_15$mdate)
air_15$pref <- as.character(air_15$pref)
air_15$city <- as.character(air_15$city)
air_15$gride <- latlong_to_meshcode(lat = air_15$NorthlatDec, long = air_15$EastlngDec,order = 3)
#remove background radiations, jp govt sets at 0.04µSv/h
air_15 <- subset(air_15, AvgAirDoseRate > 0.04) # 2870    8
#Calculate annual external dose rate
air_15$AnnualExtDose <- (air_15$AvgAirDoseRate - 0.04)*(8 + 16*0.4)*365/1000

#make cuts of Annual External Air Dose
air_15$AnnualExDoseRange <- cut(air_15$AnnualExtDose, c(0,1,3,5,10,15,20,25,30))

#remove duplicate grides
air_15 <- air_15[!duplicated(air_15$gride),] # 2544   10

#FUKUSHIMA POPULATION
fuk_pop <- read.csv("44/fuk.csv")
length(unique(fuk_pop$gridcode))
View(fuk_pop)




#############
air_11_plot <- leaflet() %>%
        addProviderTiles("Stamen.Toner")%>%
        addCircles(data = air_11,lng = ~EastlngDec, lat = ~NorthlatDec,
                   color = ~iro2(air_11$AnnualExDoseRange),radius=2000,fillOpacity = 1) %>%
        addLegend("bottomright", pal = iro2, values = air_11$AnnualExDoseRange,
                  title = "AnnualExDoseRange",
                  labFormat = labelFormat(prefix = "mSv/y "),
                  opacity = 1)%>%
        addMarkers(lat = 37.4211, lng = 141.0328,icon = nukeicon)%>%
        addPolygons(data=fu_adm,color="black", fillOpacity=0, weight = 1, fill = FALSE)
air_11_plot

# ORDERED AnnualExDoseRange
unique(air_11$AnnualExDoseRange)
air_11_ordered <- air_11[order(air_11$AnnualExDoseRange),]
View(air_11_ordered)
nukeicon <- makeIcon(iconUrl = "nk.png",iconWidth = 18, iconHeight=18)
iro2 <- colorFactor(
        palette = "Reds",
        domain = air_11$AnnualExDoseRange
)
air_11_ordered_plot <- leaflet() %>%
        addProviderTiles("Stamen.Toner")%>%
        addCircles(data = air_11_ordered,lng = ~EastlngDec, lat = ~NorthlatDec,
                   color = ~iro2(air_11_ordered$AnnualExDoseRange),radius=2000,fillOpacity = 1,stroke=FALSE) %>%
        addLegend("bottomright", pal = iro2, values = air_11_ordered$AnnualExDoseRange,
                  title = "AnnualExDoseRange",
                  labFormat = labelFormat(prefix = "mSv/y "),
                  opacity = 1)%>%
        addMarkers(lat = 37.4211, lng = 141.0328,icon = nukeicon)%>%
        addPolygons(data=fu_adm,color="black", fillOpacity=0, weight = 1, fill = FALSE)
air_11_ordered_plot


## BEGIN FORTIFYING TO USE GGPLOT
library(maptools)
library(rgeos)
library(ggplot2)
fu_f <- fortify(fu_adm)
head(fu_f,n = 2)
head(fu_adm@data, n=2)
p <- ggplot(fu_f) +
        geom_point(data = air_11_ordered, aes(x = EastlngDec, y = NorthlatDec, color = AnnualExDoseRange,shape=15),size=3)+
        scale_shape_identity()+
        scale_color_brewer(palette="Reds")+
        geom_polygon(data=fu_f,aes(x = long, y = lat, group = group),color="#999999",fill=NA)+
        coord_map()+
        annotate("text", x = 141.0328, y = 37.4211, label = "x",color="red", size=4)+
        ggtitle("Year 2011") +
        theme(axis.line=element_blank(),
              axis.text.x=element_blank(),
              axis.text.y=element_blank(),
              axis.ticks=element_blank(),
              axis.title.x=element_blank(),
              axis.title.y=element_blank(),
              panel.background=element_blank(),
              panel.border=element_blank(),
              panel.grid.major=element_blank(),
              panel.grid.minor=element_blank(),
              plot.background=element_blank())
p + facet_grid(~ month)
# 
# + theme_bw()
# update_labels(p, list(x = "Longitude", y = "Latitude"))


#Pie Charts
pie <- ggplot(air_11_ordered, aes(x = "sq.km", fill = AnnualExDoseRange)) +
                      geom_bar(width = 1) 
pie <- pie + coord_polar(theta = "y") 

pie + scale_fill_brewer(palette="Reds")+
        theme_minimal()

## 5 Years of data
air_11_15 <- read.csv("44/44whole.csv") #21,350     8, 105 NAME_2 level
air_11_15$Air.dose.rate.at.a.height.of.1.cm..μSv.h. <- NULL
names(air_11_15) <- c("mdate","pref","city","NorthlatDec","EastlngDec",
                   "daichi_distance","AvgAirDoseRate")
air_11_15$mdate <- as.Date(air_11_15$mdate)
air_11_15$pref <- as.character(air_11_15$pref)
air_11_15$city <- as.character(air_11_15$city)
air_11_15$gride <- latlong_to_meshcode(lat = air_11_15$NorthlatDec, long = air_11_15$EastlngDec,order = 3)
#remove background radiations, jp govt sets at 0.04µSv/h
air_11_15<- subset(air_11_15, AvgAirDoseRate > 0.04) # 2776    8
#Calculate annual external dose rate
air_11_15$AnnualExtDose <- (air_11_15$AvgAirDoseRate - 0.04)*(8 + 16*0.4)*365/1000

#make cuts of Annual External Air Dose
air_11_15$AnnualExDoseRange <- cut(air_11_15$AnnualExtDose, c(0,1,3,5,10,15,20,25,30)) # 21327    10

#remove duplicate grides
# air_11_15 <- air_11_15[!duplicated(air_11_15$gride),] # 2392   10

air1115 <- air_11_15 
#cut out year out of date variable
air1115$n_year <- strftime(air_11_15$mdate, "%Y") #21,327    11
#get out repeats per year
air_11_15new <- air1115 %>% distinct(n_year, gride, .keep_all = TRUE) #12,469    11

air_11_15new$n_year <- as.numeric(air_11_15new$n_year)

#calculate area
air_11_15AnnualExDoseRange_summary <- data.frame(table(air_11_15$AnnualExDoseRange))
air_11_15AnnualExDoseRange_summary$Areakm2 <- air_11_15AnnualExDoseRange_summary$Freq
sum(air_11_15AnnualExDoseRange_summary$Areakm2)  # 
##########


#add special evacuation zone
sez <- read.csv("44/sez.csv")
dim(sez)
names(sez) <- c("gridcode","sdate","edate","pref","city","no_samples","AvgAirDoseRate",
                     "NE_nLat","NE_eLong","NW_nLat","NW_eLong",
                     "SW_nLat","SW_eLong","SE_nLat","SE_eLong")
#plots
p <- ggplot() +
        #geom_rect(data = sez, aes(xmin = SW_eLong, xmax = NE_eLong, ymin = SW_nLat, ymax = NE_nLat, fill="red"))+
        geom_point(data = air_11_15new, aes(x = EastlngDec, y = NorthlatDec, color = AnnualExDoseRange,shape=15))+
        scale_shape_identity()+
        scale_color_brewer(palette="Reds")+
        geom_polygon(data=fu_f,aes(x = long, y = lat, group = group),color="#999999",fill=NA)+
        coord_map()+
        annotate("text", x = 141.0328, y = 37.4211, label = "x",color="red", size=4)+
        theme(axis.line=element_blank(),
              axis.text.x=element_blank(),
              axis.text.y=element_blank(),
              axis.ticks=element_blank(),
              axis.title.x=element_blank(),
              axis.title.y=element_blank(),
              panel.background=element_blank(),
              panel.border=element_blank(),
              panel.grid.major=element_blank(),
              panel.grid.minor=element_blank(),
              plot.background=element_blank())
p + facet_wrap(~ n_year)

#Pie Charts
pie <- ggplot(air_11_15new, aes(x = "sq.km", fill = AnnualExDoseRange)) +
        geom_bar(width = 1) 
pie <- pie + coord_polar(theta = "y") 

pie <- scale_fill_brewer(palette="Reds")
pie + facet_grid(~ new_m)


# Consistence check in combined dataset
with(air_11_15new,aggregate(gride ~ n_year,FUN=function(x){length(unique(x))}))
year_grp <- dplyr::group_by(air_11_15new,n_year)

year_11v12 <- dplyr::setdiff(air_11_15new$gride)

air_11_15new$n_year[air_11_15new$n_year==2014]