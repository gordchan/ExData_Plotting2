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

## Convert to percentage change

c1mPM2.5 <- cmPM2.5 %>% filter(fips == "06037")
  pc1 <- c1mPM2.5$`sum(Emissions)`/c1mPM2.5$`sum(Emissions)`[1]

c2mPM2.5 <- cmPM2.5 %>% filter(fips == "24510")
  pc2 <- c2mPM2.5$`sum(Emissions)`/c2mPM2.5$`sum(Emissions)`[1]

cmPM2.5 <- cbind(cmPM2.5, c((pc1*100)-100, (pc2*100)-100))

  names(cmPM2.5) <- c("county", "year", "total", "percentage")

## Plot xy graph by type

library(ggplot2)

png(filename = "plot6.png")

ggplot(cmPM2.5, aes(x = year, y = percentage, color = county)) +
  geom_line(size=2) +
  labs(x = "Year", y = "% change in Total Emissions (Tons)") +
  ggtitle("Changes in PM2.5 Emissions per Year\nfrom Motor Vehicle Sources") +
  scale_colour_discrete(labels=c("Los Angeles County", "Baltimore City")) +
  geom_hline(yintercept= 0, linetype = 2)

dev.off()