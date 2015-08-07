## Reading in datasets

library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")

NEI <- tbl_df(NEI)
# SCC <- tbl_df(SCC)

## Subset of total PM2.5 emission per year by type for Baltimore City, Maryland

cttPM2.5 <- NEI %>% filter(fips=="24510") %>% group_by(year, type) %>% summarise(sum(Emissions))

names(cttPM2.5) <- c("year", "type", "total")

## Plot xy graph by type

library(ggplot2)

png(filename = "plot3.png")

ggplot(cttPM2.5, aes(x = year, y = total, color = type)) +
    geom_line(size=2) +
    labs(x = "Year", y = "Total Emissions (Tons)") +
    ggtitle("Total PM2.5 Emissions per Year by Type\n(Baltimore City, Maryland)")

dev.off()