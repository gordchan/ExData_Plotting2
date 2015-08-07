## Reading in datasets

library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")

NEI <- tbl_df(NEI)
# SCC <- tbl_df(SCC)

## Subset of total PM2.5 emission per year for Baltimore City, Maryland

ctPM2.5 <- NEI %>% filter(fips=="24510") %>% group_by(year) %>% summarise(sum(Emissions))

names(ctPM2.5) <- c("year", "total")

## Plot xy graph

png(filename = "plot2.png")

  plot(total~year, data=ctPM2.5, type = "l", lwd = 2, xlab = "Year", ylab = "Total Emissions (Tons)")
    title(main="Total PM2.5 Emissions per Year\n(Baltimore City, Maryland)")

dev.off()