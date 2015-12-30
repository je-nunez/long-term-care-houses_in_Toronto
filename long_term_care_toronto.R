options(echo=FALSE)

cmd_line_usage <- function() {
  # Command-line usage
  cat("Plot a map with the Long-Term-Care Houses (Assisted Living Facilities, Senior Housing) managed by the City of Toronto.\n",
      "Execute this program passing it one argument in the command-line:\n\n",
      "    First argument: the path to the ESRI Shapefile from Open-Data Toronto with the LTC Houses.\n\n",
      "(This shapefile can be downloaded and unzipped from:\n\n",
      "   http://www1.toronto.ca/wps/portal/contentonly?vgnextoid=aca5467d24716310VgnVCM1000003dd60f89RCRD\n\n",
      ")\n\n",
      "Example:\n\n",
      "     R -f <this-script.R> --args  <path-to-shapefile>\n",
      sep = "")

  quit( save = "no", status = 1 )
}

cmdline_args <- commandArgs(TRUE)

if ( length(cmdline_args) != 1 || cmdline_args[1] == "" || file.access(cmdline_args, mode = 4) != 0) {
  cmd_line_usage()
}

long_term_care_shp_path <- cmdline_args[1]

# load the required libraries

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

# read the shapefile

long_term_care <- readShapeSpatial(long_term_care_shp_path)

long_term_care.points <- fortify(as.data.frame(long_term_care))

# take this field from the shapefile and convert it to string
long_term_care.points[, "TELEPHONE"] <- sapply(long_term_care.points[, "TELEPHONE"],
                                               as.character)

# plot(long_term_care)

zoom_level <- 11

toronto_borders <- c(-79.59, 43.59, -79.12, 43.795)

city_background <- get_map(location = toronto_borders,
                           color = "color",
                           source = "osm",
                           maptype = "hybrid",
                           zoom = zoom_level)

png("/tmp/phone_numbers_long_term_care_houses.png",
    width=1200, height=760)

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
                label = paste(trimws(ADDRESS_FU), " (", TELEPHONE, ")", sep = "")),
            data = long_term_care.points,
            family="Helvetica", fontface="bold", size = text_size,
            vjust = 0.1, hjust = -0.05, alpha = 0.9) +
  geom_text(aes(x = coords.x1,
                y = coords.x2,
                angle = 45,
                label = BEDS),
            data = long_term_care.points,
            family="sans", fontface="bold", colour = "Blue",
            size = text_size, vjust = 0.1, hjust = 1.1) +
  labs(x = "Longitude",
       y = "Latitude",
       title = "Number of Beds, Address, and Phone-Number of Long-Term-Care Houses operated by the City of Toronto")

dev.off()
