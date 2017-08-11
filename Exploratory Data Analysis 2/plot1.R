## Reads the data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

## Aggregate the data by year
pm_by_year <- aggregate(x = NEI$Emissions, by = list(year = NEI$year), FUN = sum)

## Plot the chart
plot(pm_by_year$year, pm_by_year$x/1000000, type = "l", xlab = "Years", ylab = "Emission", main = "Emission by year in U.S.", yaxt = "n")

## Correct the Y axis label
y_label <-paste0(axTicks(2),"MM")
axis(2,at=axTicks(2), labels=y_label)

## Save the plot
dev.copy(png, file="plot1.png")
dev.off()