## Reads the data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

## Filter data from baltimore and aggregate the data by year
baltimore_data <- NEI[NEI$fips=="24510", ]
pm_by_year_in_baltimore <- aggregate(x = baltimore_data$Emissions, by = list(year = baltimore_data$year), FUN = sum)

## Plot the chart
plot(pm_by_year_in_baltimore$year, pm_by_year_in_baltimore$x/1000, type = "l", xlab = "Years", ylab = "Emission", main = "Emission by year in Baltimore", yaxt = "n")

## Correct the Y axis label
y_label <-paste0(axTicks(2),"K")
axis(2,at=axTicks(2), labels=y_label)

## Save the plot
dev.copy(png, file="plot2.png")
dev.off()