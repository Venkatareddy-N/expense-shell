#!/bin/bash

LOGS_FOLDER="/var/log/expense"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIME_STAMP=$(date +%Y-%M-%d-%H-%M-%S)
LOG_FILE=$LOGS_FOLDER/$SCRIPT_NAME-$TIME_STAMP.log

mkdir -p $LOGS_FOLDER # -p if dir not there it will create 

USER_ID=$(id -u) # 0-for root user

#COLOR Codes
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

echo -e "Logs file is : $G $LOG_FILE $N and user id is : $R $USER_ID $N"

CHECK_ROOT(){
    if [ $USER_ID -ne 0]
    then
        echo -e "$R please run script with root user $N" | tee -a $LOG_FILE
        exit 1 # exit running script
    fi
}

CHECK_ROOT