# Project- Getting And Cleaning Data


## About the script
The code in the run_analysis.R performs the following tasks:		
1. Downloads the required data and unzip them in the "fuci" directory		
2. Cleans them and transforms them as required by the project tasks. It places them in a single data.frame and extracts the names from features.txt		
3. Organizes the results by grouping the subject ids and the activities in ascending order		
4. Write a summarizedTable.csv in the directory from which the code was executed.		

Note1: The variables are described in CodeBook.md.		
Note2: the variables included from the original measurements are the ones ending in std() and mean(). The assignment description didn't clearly specify, if std()-X etc needed to be kept.		
Note3: data.table, plyr and dplyr packages are required		


## Running the script (on Linux systems or Bash)

1. Clone this repo
2. Execute the script:		
	$ Rscript run_analysis.R
3. Browse the results		
	$ head summarizedTable.csv
