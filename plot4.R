## Reading in datasets

library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI <- tbl_df(NEI)
SCC <- tbl_df(SCC)

## Return list of SCC with EI.Sector ending with "Coal"

sCoal <- SCC %>% mutate(Coal = (grepl("(Coal$)", EI.Sector))) %>% filter(Coal==TRUE)

## Subset Coal related source

cPM2.5 <- NEI %>% filter(SCC %in% sCoal$SCC) %>% group_by(year) %>% summarise(sum(Emissions))

names(cPM2.5) <- c("year", "total")

## Plot xy graph by type

library(ggplot2)

png(filename = "plot4.png")

ggplot(cPM2.5, aes(x = year, y = total)) +
  geom_line(size=2) +
  labs(x = "Year", y = "Total Emissions (Tons)") +
  ggtitle("Total PM2.5 Emissions per Year\nfrom Coal-combustion Related Sources")

dev.off()