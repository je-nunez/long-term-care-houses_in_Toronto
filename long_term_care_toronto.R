required_packages <- c("plyr", "ggplot2", "sp", "rgeos", "maptools", "ggmap", "rgdal")

missing_packages <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]
if( 0 < length(missing_packages) ) {
  options(repos=c(CRAN="http://cran.cnr.Berkeley.edu/"))
  install.packages(missing_packages, dep=TRUE)
}

library(plyr)
library(sp)
library(rgeos)
library(ggplot2)
library(maptools)
library(ggmap)
library(rgdal)

shp_dirname <- "/set/here/full/directory/path/to/shapefile/"
shp_fullpath <- paste(shp_dirname,
                      "city_op_long_term_care_wgs84.shp",
                      sep = "")

long_term_care <- readShapeSpatial(shp_fullpath)

long_term_care.points <- fortify(as.data.frame(long_term_care))

# take this field from the shapefile and convert it to string
long_term_care.points[, "TELEPHONE"] <- sapply(long_term_care.points[, "TELEPHONE"],
                                               as.character)

# plot(long_term_care)

zoom_level <- 11

toronto_borders <- c(-79.58, 43.59, -79.15, 43.795)

city_background <- get_map(location = toronto_borders,
                           color = "color",
                           source = "osm",
                           maptype = "hybrid",
                           zoom = zoom_level)

png("/tmp/phone_numbers_long_term_care_houses.png",
    width=1200, height=1200)

# the point-size may be related with the # of beds in the long-term-care house
point_size <- 6
text_size <- 5

ggmap(city_background) +
  geom_point(aes(x = coords.x1,
                 y = coords.x2,
                 shape = 8),
             data = long_term_care.points,
             size = point_size,
             color = "Blue",
             fill = "Blue",
             alpha = 1.0) +
  scale_shape_identity() +
  geom_text(aes(x = coords.x1,
                y = coords.x2,
                label = TELEPHONE),
            data = long_term_care.points,
            family="Helvetica", fontface="bold", size = text_size,
            vjust = 0.1, hjust = -0.2, alpha = 0.9) +
  labs(x = "Longitude",
       y = "Latitude",
       title = "Phone numbers of Long-Term-Care Houses Toronto")

dev.off()
