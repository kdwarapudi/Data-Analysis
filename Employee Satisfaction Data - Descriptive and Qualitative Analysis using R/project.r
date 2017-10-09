#---
#  title: "IDS570-StatisticsForManagement_Team1"
#author: Apurva Krishnan, Dhanashree Lele, Kousalya Dwarapudi, Nikita Bhatia, Sarada
#Kannan
#date: "December 10, 2016"
# output:
#pdf_document: default
#html_document: default
#---
  
  
  #DATA CLEANING
  
#Load the Data 

employee<-read.csv(file.choose(),header = T)

#Taking a subset of the dataset relevant to the project

employee_subset1<-employee[,-c((6:78),84)]

#employee contains the whole, original dataset
#employee_subset1 contains only those columns which contains survey questions that are relevant to the project


#Filter rows which have employees who have attended at least three training programs out of fives

temp1 <- employee_subset1[,c(6:10)]
temp1[temp1 == 2 | temp1 == 3 | is.na(temp1)] <- 0
employee_subset1 <- employee_subset1[rowSums(temp1)>=3,]

#Filter rows which have employees' response to satisfaction level for at least three of the training programs out of five

temp2 <- employee_subset1[,c(11:15)]
temp2[temp2 == "X" | temp2 == "" | is.na(temp2)] <- "0"
employee_final <- employee_subset1[rowSums(apply(temp2, MARGIN = c(1,2), FUN = function(x) length(x[is.na(x)])))<3,]
employee_final[employee_final == ""] <- "0"

#Cleaning the columns Q80, Q81, Q82, Q83, Q84

employee_final$Q80<-as.numeric(levels(employee_final$Q80)[employee_final$Q80])
employee_final$Q80[is.na(employee_final$Q80)]<-0


employee_final$Q81<-as.numeric(levels(employee_final$Q81)[employee_final$Q81])
employee_final$Q81[is.na(employee_final$Q81)]<-0


employee_final$Q82<-as.numeric(levels(employee_final$Q82)[employee_final$Q82])
employee_final$Q82[is.na(employee_final$Q82)]<-0


employee_final$Q83<-as.numeric(levels(employee_final$Q83)[employee_final$Q83])
employee_final$Q83[is.na(employee_final$Q83)]<-0


employee_final$Q84<-as.numeric(levels(employee_final$Q84)[employee_final$Q84])
employee_final$Q84[is.na(employee_final$Q84)]<-0



#Calculating the work/life trainings' satisfaction index
employee_final$Index<-employee_final$Q80+employee_final$Q81+employee_final$Q82+employee_final$Q83+employee_final$Q84

#Calculating the percentage. (Index*100/25)
employee_final$Index<-employee_final$Index*4



#Narrowing Down
#SI- Satisfaction Index
#For the purpose of our analysis, we are narrowing down the scope to five agencies. Each of the five agencies represent five categories, like: Agency with highest SI, agency with lowest SI, agency with SI equal to the average SI, 4th agency with SI between lowest and average & the last agency with SI between highest and the average. 
#So as per the above idea, the agencies in each of the categories are- TR, IG, FM, CM, IN.

final_sorted<-employee_final[order(employee_final$Index),]
agency_index<-aggregate(Index~agency, data=final_sorted, FUN="mean")
agency_index<-agency_index[order(agency_index$Index),]

Employee_Filtered<-employee_final[(employee_final$agency=='TR' | employee_final$agency=='IG' | employee_final$agency=='FM' | employee_final$agency=='CM' | employee_final$agency=='IN'),]

#We finally have a data set with 3973 rows
#Univariate Analysis - Dependent Variable
plot(density(Employee_Filtered$Index), xlab = "Satifactory Index", ylab = "Density", col="Blue", main="Distribution of Satisfaction Index")

#Univariate Analysis - Independent Variables - Level 1 (Participation level in the programs)

#Variable : Q74- Participation level with Alternative Work Schedules (AWS) program

part_aws <- table(Employee_Filtered$Q74)
barplot(part_aws, main="Participation level in Alternative Work Schedules(Q74)", xlab = "Participation Level", ylab =
          "Propotion",col=c("green","red","blue"))
legend("topright", legend = c("Yes", "No","Not Available to me"), fill =
         c("green","red","blue"), cex=0.75)
box()


#Variable : Q75 - Participation level with Health and Wellness Programs (for example, exercise, medical screening, quit smoking programs)

part_health_well <- table(Employee_Filtered$Q75)
barplot(part_health_well, main="Participation level in Health & Wellness Prog(Q75)", xlab = "Participation Level", ylab =
          "Propotion",col=c("green","red","blue"))
legend("topright", legend = c("Yes", "No","Not Available to me"), fill =
         c("green","red","blue"), cex=0.75)
box()


#Variable : Q76 -Participation level with Employee Assistance Program (EAP)

part_emp_assi <- table(Employee_Filtered$Q76)
barplot(part_emp_assi, main="Participation level in Employee Assistance Prog(Q76)", xlab = "Participation Level", ylab =
          "Propotion",col=c("green","red","blue"))
legend("topright", legend = c("Yes", "No","Not Available to me"), fill =
         c("green","red","blue"), cex=0.75)
box()


#Variable : Q77 -Participation level with Child Care Programs (for example, daycare, parenting classes, parenting support groups)

part_child_care <- table(Employee_Filtered$Q77)
barplot(part_child_care, main="Participation level in Child Care Prog(Q77)", xlab = "Participation Level", ylab =
          "Propotion",col=c("green","red","blue"))
legend("topright", legend = c("Yes", "No","Not Available to me"), fill =
         c("green","red","blue"), cex=0.75)
box()


#Variable : Q78 - Participation level with Elder Care Programs (for example, support groups, speakers)

part_elder_care <- table(Employee_Filtered$Q78)
barplot(part_elder_care, main="Participation level in Elder Care Prog(Q78)", xlab = "Participation Level", ylab =
          "Propotion",col=c("green","red","blue"))
legend("topright", legend = c("Yes", "No","Not Available to me"), fill =
         c("green","red","blue"), cex=0.75)
box()

#Univariate Analysis - Independent Variables - Level 2 (Satisfaction level of the programs attended)

#Variable : Q80 -Satisfaction level with Alternative Work Schedules (AWS)

aws <- table(Employee_Filtered$Q80)
barplot(aws, main="Satisfaction level with Alternative Work Schedules (Q80)", xlab = "Satisfaction Ratings", ylab =
          "Propotion",col=c("steelblue","red", "black", "yellow", "blue","green"))
legend("topleft", legend = c("No response", "Very Dissatisfied","Dissatisfied","Neither Satisfied nor Dissatisfied","Satisfied","Very Satisfied"), fill =
         c("steelblue","red", "black", "yellow", "blue","green"), cex=0.5)
box()


#Variable : Q81 - Satisfaction level with Health and Wellness Programs (for example, exercise, medical screening, quit smoking programs)

health_well <- table(Employee_Filtered$Q81)
barplot(health_well, main="Satisfaction level with Health and Wellness Programs (Q81)", xlab = "Satisfaction Ratings", ylab =
          "Propotion",col=c("steelblue","red", "black", "yellow", "blue","green"))
legend("topleft", legend = c("No response", "Very Dissatisfied","Dissatisfied","Neither Satisfied nor Dissatisfied","Satisfied","Very Satisfied"), fill =
         c("steelblue","red", "black", "yellow", "blue","green"), cex=0.5)
box()


#Variable : Q82 - Satisfaction level with Employee Assistance Program (EAP)

emp_assi <- table(Employee_Filtered$Q82)
barplot(emp_assi, main="Satisfaction level with Employee Assistance Program (EAP) (Q82)", xlab = "Satisfaction Ratings", ylab =
          "Propotion",col=c("steelblue","red", "black", "yellow", "blue","green"))
legend("topleft", legend = c("No response", "Very Dissatisfied","Dissatisfied","Neither Satisfied nor Dissatisfied","Satisfied","Very Satisfied"), fill =
         c("steelblue","red", "black", "yellow", "blue","green"), cex=0.5)
box()


#Variable : Q83 - Satisfaction level with Child Care Programs (for example, daycare, parenting classes, parenting support groups)

child_care <- table(Employee_Filtered$Q83)
barplot(child_care, main="Satisfaction level with Child Care Programs (Q83)", xlab = "Satisfaction Ratings", ylab =
          "Propotion",col=c("steelblue","red", "black", "yellow", "blue","green"))
legend("topright", legend = c("No response", "Very Dissatisfied","Dissatisfied","Neither Satisfied nor Dissatisfied","Satisfied","Very Satisfied"), fill =
         c("steelblue","red", "black", "yellow", "blue","green"), cex=0.5)
box()



#Variable : Q84 - Satisfaction level with Elder Care Programs (for example, support groups, speakers)

elder_care <- table(Employee_Filtered$Q84)
barplot(elder_care, main="Satisfaction level with Elder Care Programs (Q84)", xlab = "Satisfaction Ratings", ylab =
          "Propotion",col=c("steelblue","red", "black", "yellow", "blue","green"))
legend("topright", legend = c("No response", "Very Dissatisfied","Dissatisfied","Neither Satisfied nor Dissatisfied","Satisfied","Very Satisfied"), fill =
         c("steelblue","red", "black", "yellow", "blue","green"), cex=0.5)
box()

#Univariate Analysis - Control Variables

#DSEX:
control_DSEX<-table(Employee_Filtered$DSEX)
barplot(control_DSEX, main="Gender Proportion",xlab = "Gender type",ylab = "Proportion", col =
          c("blue", "pink"))
legend("topleft", legend = c("Male", "Female"), fill = c("blue","pink"), cex=0.75)
box()


#DSUPER
control_DSUPER<-table(Employee_Filtered$DSUPER)
barplot(control_DSUPER, main="Supervisory Status",xlab = "Supervisory Type",ylab = "Proportion/Frequency", col =
          c("red", "blue"))
legend("topright", legend = c("Non-Supervisor/Team Leader", "Supervisor/Manager/Senior Leader"), fill = c("red","blue"), cex=0.40)
box()


#DFEDTEN
#How long have you been with the Federal Government (excluding military service)?
control_DFEDTEN<-table(Employee_Filtered$DFEDTEN)
barplot(control_DFEDTEN, main="Experience with federal Govt.",xlab = "Experience range in years",ylab = "Proportion/Frequency", col =
          c("blue", "green","red"))
legend("topleft", legend = c("5 or fewer years", "6-14 years", "15 or more years"), fill = c("blue", "green","red"), cex=0.55)
box()


#DLEAVING
#Are you considering leaving your organization within the next year, and if so, why?
control_DLEAVING<-table(Employee_Filtered$DLEAVING)
barplot(control_DLEAVING, main="Employee considering leaving organization in next 1 year",xlab = "",ylab = "Proportion/Frequency", col =
          c("green","blue","yellow","red"))
legend("topright", legend = c("No", "Yes,to take another job within Govt.", "Yes,to take another job outside govt.","Yes, other"), fill = c("green","blue","yellow","red"), cex=0.50)
box()

#BIVARIATE ANALYSIS

#Box plot - Supervisory status Vs Satisfaction Index
library(ggplot2)
plot1 <- ggplot(Employee_Filtered, aes(Employee_Filtered$DSUPER, Employee_Filtered$Index)) + 
  geom_boxplot(aes(fill = Employee_Filtered$DSUPER)) +
  theme(legend.position="right")
plot1 + scale_fill_discrete(name = "Employee's Supervisory status vs Satisfaction index", breaks=c("A","B"),labels=c("Non-Supervisor/Team Leader","Supervisor/ Manager/ Senior Leader"))

#Box plot between Employee's sex and Satisfaction Index
plot(employee_final$Index~employee_final$DSEX, col=c("steelblue","green"), main="Employee's Sex and corresponding satisfaction index")
legend("topleft",legend = c("Female","Male"),fill =c("steelblue","green") )

#Box plot between Employee's experince in fedeeral agencies and their satisfaction index
plot2 <- ggplot(Employee_Filtered, aes(Employee_Filtered$DFEDTEN, Employee_Filtered$Index)) + 
  geom_boxplot(aes(fill = Employee_Filtered$DFEDTEN)) +
  theme(legend.position="right")
plot2 + scale_fill_discrete(name = "Employee's experience vs Satisfaction index", breaks=c("A","B","C"),labels=c("6-14 years","5 or fewer years","15 or more years"))

#Box plot between Employee's willingness to retain in company and their satisfaction index
plot3 <- ggplot(Employee_Filtered, aes(Employee_Filtered$DLEAVING, Employee_Filtered$Index)) + 
  geom_boxplot(aes(fill = Employee_Filtered$DLEAVING)) +
  theme(legend.position="right")
plot3 + scale_fill_discrete(name = "Employee attrition rate vs Satisfaction index", breaks=c("A","B","C","D"),labels=c("No","Yes,take another job within Fed.gov","Yes,take another job outside Fed.gov","Yes,other"))

# AVg satisfaction index for all 5 agencies
Overall<-Employee_Filtered %>% group_by(agency) %>% summarize(avg = mean(Index), std = sd(Index), trimmed_avg = mean(Index, trim=0.1))
Overall

# Correlation Plot

#Column 13 - Q80 (Alternative Work Schedules (AWS))
#Column 14 - Q81 (Health and Wellness Programs (for example, exercise, medical    screening, quit smoking programs))
#Column 15 - Q82 (Employee Assistance Program (EAP))
#Column 16 - Q83 (Child Care Programs (for example, daycare, parenting classes, parenting support groups))
#Column 17 - Q84 (Elder Care Programs (for example, support groups, speakers))
#Column 27- Index (SATISFACTION INDEX)

empSum <- Employee_Filtered[,c(11:15,27)]
cor(empSum)
install.packages("corrplot")
library(corrplot)
corrplot(cor(empSum), method="square")


#ANOVA and TukeyHSD TESTING
index.aov<-aov(Index~agency, data=Employee_Filtered)
index.aov
index.tk<-TukeyHSD(index.aov, ordered=TRUE)
index.tk

index.aov<-aov(Index~DSEX, data=Employee_Filtered)
index.aov
index.tk<-TukeyHSD(index.aov, ordered=TRUE)
index.tk

index.aov<-aov(Index~DLEAVING, data=Employee_Filtered)
index.aov
index.tk<-TukeyHSD(index.aov, ordered=TRUE)
index.tk

index.aov<-aov(Index~DFEDTEN, data=Employee_Filtered)
index.aov
index.tk<-TukeyHSD(index.aov, ordered=TRUE)
index.tk

#Multiple Regression Modelling
mod1 <- lm(Index~agency+DLEAVING, data = Employee_Filtered)
summary(mod1)$r.squared

plot(hatvalues(mod1))
identify(hatvalues(mod1))
outliers <- c(24,27,205,  270,  349,  464,  571,  636,  805,  852,  894, 1001,1077, 1194, 1386,1557, 1585, 1863, 1984, 2079, 2201, 2249, 2281, 2349,2485,2570,2686,2736,3069,3197,3516,3565,3619)
Employee_Filtered1 <- Employee_Filtered
Employee_Filtered1 <- Employee_Filtered1[-outliers,]
mod2 <- lm(Index~agency+DLEAVING, data = Employee_Filtered1)
summary(mod2)$r.squared

set.seed(1230)
n <- 200
emp_samp <- Employee_Filtered[sample(1:nrow(Employee_Filtered),200,replace=FALSE),]
mod2 <- lm(Index~agency+DLEAVING, data = emp_samp)
summary(mod2)
plot(hatvalues(mod2))
identify(hatvalues(mod2), col="red")
outliers <- c(89,94)
emp_samp <- emp_samp[-outliers,]
summary(mod2)

emp_mod <- lm(Index~agency+Q78+Q81+Q82+Q83+Q84, data = Employee_Filtered)
summary(emp_mod)$r.squared
