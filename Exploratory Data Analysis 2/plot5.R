## Reads the data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

## Filter data from baltimore
baltimore_data <- NEI[NEI$fips=="24510", ]

## Filter data from coal combustion-related source
## The chocice for the filter was based on the forum discussions and
## as can be seen on the filtered_scc data below, it filters mainly the
## mobile sources with gasoline and diesel combustible
filtered_scc <- SCC[grep(".*Vehicles.*", SCC$EI.Sector), ]

## Merges the data
classified_NEI <- merge(baltimore_data, filtered_scc, by="SCC")

## aggregate the data by year
pm_by_year <- with(classified_NEI,{ aggregate(x = Emissions, by = list(year = year), FUN = sum)})

## Plot the chart
plot(pm_by_year$year, pm_by_year$x/1000, type = "l", xlab = "Years", ylab = "Emission", main = "Emission by year for Motor Vehicles in Baltimore", yaxt = "n")

## Correct the Y axis label
y_label <-paste0(axTicks(2),"K")
axis(2,at=axTicks(2), labels=y_label)

## Save the plot
dev.copy(png, file="plot5.png")
dev.off()