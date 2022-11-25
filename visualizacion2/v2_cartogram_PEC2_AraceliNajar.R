setwd("G:/Mi unidad/Master_Data_Science/Semestre_1/Visualización_datos/PECs/PEC2")

library(sf)           # transform 
library(dplyr)        # data wrangling
library(cartogram)    # for the cartogram
library(ggplot2)      # to realize the plots
library(broom)        # from geospatial format to data frame
library(tweenr)       # to create transition dataframe between 2 states
library(gganimate)    # To realize the animation
library(maptools)     # world boundaries coordinates
library(viridis)      # for a nice color palette


data(wrld_simpl) # DATASET

countries = c('Austria', 'Belgium', 'Bulgaria', 'Cyprus', 'Czech Republic', 'Denmark', 'Estonia', 'Finland', 'France', 'Germany', 'Greece', 'Hungary', 'Iceland', 'Ireland', 'Italy', 'Latvia', 'Lithuania', 'Luxembourg', 'Malta', 'Netherlands', 'Norway', 'Poland', 'Portugal', 'Slovenia', 'Spain', 'Sweden', 'United Kingdom')
mapsimple = wrld_simpl[wrld_simpl$NAME %in% countries,]


sfno <- st_as_sf(mapsimple)

sfproj <- st_transform(sfno, crs = 23038)

cartogram <- cartogram_cont(sfproj, "POP2005", itermax = 7)

europe_cartogram <- ggplot() +
  geom_sf(data = cartogram, 
          aes(fill = POP2005/1000000) , size=0, alpha=0.9) +
  theme_void() +
  labs( title = "Europe Cartogram", subtitle="Population per country in 2005" ) +
  theme(
    text = element_text(color = "#22211d"), 
    plot.background = element_rect(fill = "#f5f5f4", color = NA), 
    panel.background = element_rect(fill = "#f5f5f4", color = NA), 
    legend.background = element_rect(fill = "#f5f5f4", color = NA),
    plot.title = element_text(size= 22, hjust=0.5, color = "#4e4d47", margin = margin(b = -0.1, t = 0.4, l = 2, unit = "cm")),
    plot.subtitle = element_text(size= 13, hjust=0.5, color = "#4e4d47", margin = margin(b = -0.1, t = 0.4, l = 2, unit = "cm")),
    legend.position = c(0.2, 0.7)
  )

ggsave('cartogram_PEC2_AraceliNajar.png')
