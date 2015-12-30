# Long-Term-Care-Houses in Toronto, in R

This is a plot of the Long-Term-Care Houses in Toronto, using ggmap, ggplot2, etc.

So far it uses the ESRI shapefile of the City-operated Long-Term-Care Houses, available
in the [Open-Data location](http://www1.toronto.ca/wps/portal/contentonly?vgnextoid=aca5467d24716310VgnVCM1000003dd60f89RCRD "City of Toronto's Open Data location").
You need to download and unzip from the choices the Open-Data site provided the one
that is in the `WGS84` coordinates-system (World Geodetic Coordinates System, 1984).

It is possible to do the same for the City-operated Long-Term-Care houses in Ottawa
[at this location](http://data.ottawa.ca/dataset/long-term-care-homes "City of Ottawa's Open Data location").
In the U.S., the Federal Government [Open Data site](http://catalog.data.gov/ "U.S. Federal Government Open Data site")
has shapefiles for Assisted Living Facilities, Senior Housing, for different states and counties, for
example, for
[Missouri](http://catalog.data.gov/dataset/assisted-living-facilities-mo-2012-long-term-care-facilities-shp "Missouri's Shapefile of Assisted Living Facilities, Senior Housing").

In these cases, the script needs modification. (E.g., Toronto lists the telephone number
of the Long-Term-Care houses in its shapefile, but other Open-Data sites don't need
to give the phone number, or not code in the field name `TELEPHONE`.)

Another issue is the visualization of the other attributes that each Long-Term-Care house
has, like whether there is a smoking room or not, whether there is adult-day care
available, the number of respite and of convalescence beds, without filling the map
with too much information of these features. If this condition is met, then more of
these attributes can be visualized on the map as well.

# WIP

This project is a *work in progress*. The implementation is *incomplete* and
subject to change. The documentation can be inaccurate.

# Origin of the Idea

This script was inspired from [this](http://www.r-bloggers.com/shapefiles-in-r/).

# Example

This is an example of the plot with the telephone numbers of the City-operated
Long-Term-Care houses using the libraries above in R:

![Visualization of locations of the City-operated Long-Term-Care Houses in Toronto](/visual_long_term_care_houses.png?raw=true "Visualization of locations of the City-operated Long-Term-Care Houses in Toronto").


