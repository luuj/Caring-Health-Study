library(dplyr)
library(tidyr)

# Read in data
dat <- read.csv("/Users/jonathanluu/Dropbox/Caring Health/Data/CHC_SDOH_dataset_1.5.22_SFTPupload.csv")

# Get unique entries
dat.distinct <- dat %>% distinct(PAT_ID, .keep_all = T)
dat.distinct %>% nrow()

## Exploratory analysis
# Age
dat.distinct$Age %>% summary()
dat.distinct$Age %>% hist(main="Histogram of age", xlab="Age (years)")

# Language
dat.distinct$Language %>% unique() %>% length()
dat.distinct$Language %>% table() %>% sort(decreasing = T) %>% head()

# Race
dat.distinct$Race %>% table() %>% sort(decreasing = T) 

# Interpreter
dat.distinct$Interpreter %>% table()

# Number of visits
dat.distinct$Num_Visits %>% summary()
dat.distinct %>% filter(Num_Visits <= 20) %>% pull(Num_Visits) %>% 
  hist(breaks=0:20, main="Histogram of number of visits", xlab="Number of visits")

# Questions
dat$FLO_MEAS_ID %>% unique() %>% length() # 47 different response types
dat$FLO_MEAS_NAME %>% unique()
dat$DOMAIN_GRP %>% unique() # 13 categories of responses

# Some individuals have a lot of responses
dat$PAT_ID %>% table() %>% sort(decreasing = T) %>% head()
dat %>% filter(PAT_ID == "Z3347793") %>% View() 

# Filter by response category
dat.resp <- dat %>% select(PAT_ID, FLO_MEAS_ID, DOMAIN_GRP) %>% 
  count(PAT_ID, DOMAIN_GRP) %>% filter(DOMAIN_GRP != "") %>% 
  pivot_wider(names_from = DOMAIN_GRP, values_from = n)
View(dat.resp)
dat.resp %>% summary()
