library(reshape);
#make sure:
#setwd('/Users/Honglei/Desktop/shiny_app');
Sys.setlocale(locale = "C");
positions <- c('AUG', 'SEP', 'OCT', 'NOV', 'DEC');

data <- read.csv(
  "targets_all.csv",
  na.strings = ".."
  );

data <- data[, c('Employee__HR_Full_Name', 'month', 
                 'Client_all', 'Prospect_COI_all', 'joint')];

colnames(data)[3] <- 'Client';
colnames(data)[4] <- 'Prospect/COI';
colnames(data)[5] <- 'Joint';

data <- melt(data, id = c('Employee__HR_Full_Name','month'));

colnames(data)[1] <- 'CRM';
colnames(data)[3] <- 'type';
colnames(data)[4] <- 'count';

target_joint <- 4;
target_all <- 9;

ymax1 <- sort(data[which(data$type %in% c('Client', 'Prospect/COI')),]$count,decreasing = T)[1];
ymax2 <- sort(data[which(data$type == 'Joint'),]$count,decreasing = T)[1];


