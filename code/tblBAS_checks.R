#############################################################
#
#   Program: tblBAS_checks.R
#   Project: IeDEA
# 
#   PI: Firas Wehbe, PhD
#   Biostatistician/Programmer: Meridith Blevins, MS
#   Purpose: Read in IeDEAS standard and write  
#            data queries
#
#   INPUT: "tblBAS.csv"
#   OUTPUT: 
#
#   Notes: As long as the working directory in "setwd" is
#          correctly pointing to the location of tblBAS.csv,
#          then this code should run smoothly, generating
#          a listing of data queries.
#
#   Created: 22 October 2012
#   Revisions: 
#     
#############################################################

## NAME OF TABLE FOR WRITING QUERIES
tablename <- "tblBAS"
## NAMES EXPECTED FROM HICDEP+/IeDEAS DES
expectednames <- c("patient","birth_d","enrol_d","gender",
		   "mode","naive_y","haart_d")
acceptablenames <- c(expectednames,"program","birth_d_a","enrol_d_a","haart_d_a")

################### QUERY CHECKING BEGINS HERE ###################

## CHECK FOR EXTRA OR MISSING VARIABLES
extravar(acceptablenames,basic)
missvar(expectednames,basic)

## PRIOR TO CONVERTING DATES, CHECK THAT THE TYPE IS APPROPRIATE 
notdate(birth_d,basic)
notdate(enrol_d,basic)
notdate(haart_d,basic)

## CHECK FOR MISSING DATA
missingvalue(birth_d,basic)
missingvalue(enrol_d,basic)
missingvalue(patient,basic)
missingvalue(country,basic)
missingvalue(gender,basic)
missingvalue(mode,basic)
missingvalue(naive_y,basic)
# check missing haart_d only among those confirmed not naive 
notnaive <- basic[basic$naive_y==0,]
missingvalue(haart_d,notnaive)

## CONVERT DATES USING EXPECTED FORMAT (will force NA if format is incorrect)
if(exists("birth_d",basic)){basic$birth_d <- convertdate(birth_d,basic)}
if(exists("enrol_d",basic)){basic$enrol_d <- convertdate(enrol_d,basic)}
if(exists("haart_d",basic)){basic$haart_d <- convertdate(haart_d,basic)}

## CHECK FOR DATES OCCURRING IN THE WRONG ORDER
outoforder(birth_d,enrol_d,basic)
outoforder(birth_d,haart_d,basic)

## CHECK FOR DATES OCCURRING TOO FAR IN THE FUTURE
futuredate(birth_d,basic)
futuredate(enrol_d,basic)
futuredate(haart_d,basic)

## CHECK FOR DUPLICATE PATIENT IDs
queryduplicates(patient,basic)

## CHECK FOR UNEXPECTED CODING
badcodes(gender,c(1,2,9),basic)
badcodes(mode,c(1:8,90,99),basic)
badcodes(naive_y,c(0,1,9),basic)
badcodes(birth_d_a,c("<",">","D","M","Y","U"),basic)
badcodes(enrol_d_a,c("<",">","D","M","Y","U"),basic)
badcodes(haart_d_a,c("<",">","D","M","Y","U"),basic)

## QUERY PATIENTS WITH NO RECORD IN tblPROGRAM
if(exists("program") & exists("program",basic)){badrecord(program,basic,program)}

################### QUERY CHECKING ENDS HERE ###################
