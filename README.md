# IeDEA-DES QA Checks

Please see the [downloads](https://github.com/IeDEA/qa-checks-r/downloads) section for documentation of the exceptions that are currently implemented. You can clone this repository if you are familiar with Git and GitHub. Alternatively, click on the cloud button with the word `zip` to download a zip archive of the most current version of the scripts.

The major directions for running these scripts:

1. Install RStudio
2. Place the programs and the data (`tblBAS.csv` `tblLAB_CD4.csv`, and `tblLAB_RNA`) in the `input` folder.  
3. Open `tbl_checks.R` with RStudio
4. Change working directory to source of files/data ( _Session -> Set Working Directory -> To Source File Location_ ).
5. Click on `Source` or `CTRL+SHIFT+S`.
6. If successful, a query file and checks file will also be located in the `output` folder.
