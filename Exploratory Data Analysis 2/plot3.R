require("ggplot2")

## Reads the data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

## Filter data from baltimore and aggregate the data by year
baltimore_data <- NEI[NEI$fips=="24510", ]
pm_by_year_in_baltimore <- aggregate(x = baltimore_data$Emissions, by = list(year = baltimore_data$year, type = baltimore_data$type), FUN = sum)

## Plot the chart
qplot(year, x, data = pm_by_year_in_baltimore, facets = . ~ type, geom = "line", main = "Emission by type", xlab = "Years", ylab = "Emission")

## Save the plot
ggsave(filename = "plot3.png", width = 7, height = 4)