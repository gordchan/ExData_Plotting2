## Reading in datasets

library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI <- tbl_df(NEI)
SCC <- tbl_df(SCC)

## Return list of SCC with EI.Sector ending with "Coal"

sVehicle <- SCC %>% mutate(Mobile.Vehicle = (grepl("(^Mobile.+Vehicles)", EI.Sector))) %>% filter(Mobile.Vehicle==TRUE)

## Subset Coal related source
cmPM2.5 <- NEI %>% filter(SCC %in% sVehicle$SCC & (fips == "24510"|fips == "06037")) %>% group_by(fips, year) %>% summarise(sum(Emissions))

names(cmPM2.5) <- c("county", "year", "total")

## Plot xy graph by type

library(ggplot2)

png(filename = "plot6.png")

ggplot(cmPM2.5, aes(x = year, y = total, color = county)) +
  geom_line(size=2) +
  labs(x = "Year", y = "Total Emissions (Tons)") +
  ggtitle("Total PM2.5 Emissions per Year from Motor Vehicle Sources") +
  scale_colour_discrete(labels=c("Los Angeles County", "Baltimore City"))

dev.off()