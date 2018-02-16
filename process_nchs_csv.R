# Clear the console, and the environment.
cat("\014")
rm(list=ls())

# Read the CSV heart disease data.
setwd('/home/gary/UW Data Science/INFO 474/info474-a3')
data_frame <- read.csv('NCHS_-_Leading_Causes_of_Death__United_States.csv')

# Isolate to diseases of heart, and only the columns we want.
just_heart_disease <- data_frame[data_frame$Cause.Name == 'Diseases of Heart',
                                 c('Year', 'State', 'Deaths',
                                   'Age.adjusted.Death.Rate')]

# Rename the columns.
colnames(just_heart_disease) <- c('year', 'state', 'count', 'rate')

# Remove 'United State'
just_heart_disease <- just_heart_disease[just_heart_disease$state != 'United States',]

# Read the state ID file, and merge it with the heart disease data.
ids <- read.csv('state_ids.csv', colClasses = c(rep("character",2)))
just_heart_disease <- merge(just_heart_disease, ids, by = 'state')

# Reorder the columns, then sort by state and year.
just_heart_disease <- just_heart_disease[, c('id', 'state',
                                             'year', 'count', 'rate')]

# Sort by id, state and year.
just_heart_disease <- just_heart_disease[order(just_heart_disease$id,
                                               just_heart_disease$state,
                                               just_heart_disease$year), ]

# Write out the file new file.
write.csv(just_heart_disease, file = 'heart_disease.csv', row.names = F)
