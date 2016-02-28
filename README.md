# Project- Getting And Cleaning Data


## About the script
The code in the run_analysis.R performs the following tasks:
1. Downloads the required data and unzip them in the "fuci" directory
2. Cleans them and transforms them as required by the project tasks. 
3. Organizes the results by grouping the subject ids and the activities in ascending order
4. Write a summarizedTable.csv in the directory from which the code was executed.

Note1: The variables are described in CodeBook.md.
Note2: the variables, that have been kept, are the ones ending in std() and mean(). The task description didn't clearly specify, if std()-X etc needed to be kept. 


## Running the script (on Linux systems or Bash)

1. Clone this repo
2. Execute the script:
      $ Rscript run_analysis.R
3. Browse the results
	    $ head summarizedTable.csv
