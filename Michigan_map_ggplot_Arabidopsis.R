## after https://eriqande.github.io/rep-res-web/lectures/making-maps-with-R.html

library(ggplot2)
library(ggmap)
library(mapdata)
library(tidyverse)

## obtaining the Michigan Indiana specific accessions from dataset in Tibble form

ecotypes_all_tibble<-read_csv('LHY_SNP_WRLD_dataset.csv')

## filter on country and latitude and longitude coordinates

michigan_indiana<-ecotypes_all_tibble %>%
  filter(country.x == "USA") %>%
  filter(between(long, -93, -84)) %>%
  filter(between(lat, 39, 48))

## prepare map

states<-map_data('state')
michigan<-subset(states,region %in% c('michigan','indiana','illinois','wisconsin'))
m<-ggplot()+geom_polygon(data=michigan,aes(x=long,y=lat,group=group))+coord_fixed(1.3)

## add data points

m + theme_void() +
  geom_point(data=michigan_indiana,aes(x=long,y=lat,color=factor(genotype_comp)),shape=21,stroke=1.5,size=5,alpha=0.9) +
  labs(x="longitude", y="latitude",col="haplotype") +
  scale_color_manual(values=c("dodgerblue1","firebrick1","lightgoldenrod")) +
  theme(legend.background = element_rect(fill="gray 60"),legend.title=element_blank())+theme(legend.justification = c(0,1),legend.position = c(0,1)) +
  theme(legend.background = element_rect(colour="black",size=0.25))

ggsave('Michigan_map_LHY_haplotype.png')  
