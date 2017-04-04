## Import list with uncoded countries
uncoded  <- read.csv("uncodedCountries.csv")
## Import list with coded countries
coded <- read.csv("codedCountries.csv", col.names = c("code", "local_name"))
## Merge the two lists
listCountries  <- merge(coded, uncoded, by = "local_name")
## Table results from attud questionnaire
teste  <- as.data.frame(table(attud$group5.group8.q18))
## Pick good names for dataframe
colnames(teste) <- c("code", "Freq")
### Convert vars into character
teste$code  <- as.character(teste$code)
listCountries$code  <- as.character(listCountries$code)
listCountries$local_name  <- as.character(listCountries$local_name)
# Merge table and list of codes
table1  <- merge(teste, listCountries, by = "code")

# Subset the data for coutries that answered the survey at least once 
table2  <- subset(table1, table1$Freq > 0)
# Create data from two variables - frequency and English name
finalCountryTable  <- table2[, c("Freq", "en_name")]
# Sort the data
sorted  <- finalCountryTable[order(-finalCountryTable$Freq),  ]

# Write data to send to cartoDB
write.csv(sorted, "toCartodb.csv")
