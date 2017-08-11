## Reads the data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

## Filter data from coal combustion-related source
## The choice was made based on the Major Source Sector Fuel Combustion and all
## the Detailed Category Names that contains Coal
## Information source: http://www.epa.gov/air/emissions/basic.htm
filtered_scc <- SCC[grep("Fuel Comb.*Coal", SCC$EI.Sector), ]

## Merges the data
classified_NEI <- merge(NEI, filtered_scc, by="SCC")

## aggregate the data by year
pm_by_year_coal <- with(classified_NEI,{ aggregate(x = Emissions, by = list(year = year), FUN = sum)})

## Plot the chart
plot(pm_by_year_coal$year, pm_by_year_coal$x/1000, type = "l", xlab = "Years", ylab = "Emission", main = "Emission by year for coal combustion", yaxt = "n")

## Correct the Y axis label
y_label <-paste0(axTicks(2),"K")
axis(2,at=axTicks(2), labels=y_label)

## Save the plot
dev.copy(png, file="plot4.png")
dev.off()