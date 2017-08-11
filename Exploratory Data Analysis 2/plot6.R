require("ggplot2")

## Defines the norm function for posterior use
norm_vec <- function(x) sqrt(sum(x^2))

## Reads the data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

compared_cities <- data.frame(fips = c("24510",'06037'), city_name = c('Baltimore', 'LA'))

## Filter data from baltimore and LA
cities_data <- merge(NEI, compared_cities, by="fips")

## Filter data from coal combustion-related source
## The choice for the filter was based on the forum discussions and
## as can be seen on the filtered_scc data below, it filters mainly the
## mobile sources with gasoline and diesel combustible
filtered_scc <- SCC[grep(".*Vehicles.*", SCC$EI.Sector), ]

## Merges the data
classified_NEI <- merge(cities_data, filtered_scc, by="SCC")

## aggregate the data by year
pm_by_year <- with(classified_NEI,{ 
                    aggregate(x = Emissions, 
                              by = list(year = year, city_name = city_name), 
                              FUN = sum)})
## Normalizes the data by the first year emisison, so we can see the variation
pm_by_year$norm_by_first_year <- apply(pm_by_year, 
      1, 
      function(x){
        as.numeric(x["x"])/
          pm_by_year[pm_by_year$city_name==x["city_name"]&pm_by_year$year=="1999","x"]
      })

## Plot the chart
qplot(year, norm_by_first_year, data = pm_by_year, facets = . ~ city_name, geom = "line", main = "Variation in Emission by Year between cities", xlab = "Years", ylab = "Emission / First Year Emisison")

## Save the plot
ggsave(filename = "plot6.png", width = 7, height = 4)