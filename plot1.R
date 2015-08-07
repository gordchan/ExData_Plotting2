## Reading in datasets

library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")

NEI <- tbl_df(NEI)
# SCC <- tbl_df(SCC)

## Summary table of total PM2.5 emission per year

tPM2.5 <- NEI %>% group_by(year) %>% summarise(sum(Emissions))

names(tPM2.5) <- c("year", "total")

## Plot xy graph

png(filename = "plot1.png")

  plot(total~year, data=tPM2.5, type = "l", lwd = 2, xlab = "Year", ylab = "Total Emissions (Tons)")
    title(main="Total PM2.5 Emissions per Year")
    
dev.off()