### Here I will describe what file "run_analysis.R" does step by step and explain main variables.
---

####Steps of the script:

- Step 1: Check if the data set is in the WD. If not, download it.
- Step 2: Let's get list of all files in the zip archiev and choose only necessary files for our dataset.
- Step 3: Get col. names for X_train and X_test data sets and descriptive activity names (to replace numbers).
- Step 4: Read (and unzip) necessary txt files to certain variables-datasets.
- Step 5: Choose only columns that contain "mean" and "std" measurements.
- Step 6: Merge all data sets in one main data set.
- Step 7: Add descriptive activity names to our main data set and reshape it slightly.
- Step 8: Make summary of our data set (with dplyr) and write it in a new file.

---

####Variables in the code:

| Varieble| Description|
| :----------------------| :------------------------- |
| filelist.of.archiev | list of all files in the archiev|
| zipfiles.for.dataset | list of files necessary for the dataset|
| labes.for.dataset | list with names of columns for data set |
| activity.names | table with activity numbers and their names |
| subject_test | table with ID of persons for each row in test data set |
| subject_train | table with ID of persons for each row in train data set |
| y_test | table with ID of activities for each row in test data set  |
| y_train | table with ID of activities for each row in train data set |
| x_test | table with all measurement for each row in test data set |
| x_train | table with all measurement for each row in train data set |
| main_database | bounded tables subject/y/x test/train data sets |
| mean_and_std_col | list of T/F if measurement is mean or std function |
| main_database_mean_by_group | summary of measurement per persons and subjects |
