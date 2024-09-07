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

CHECK_ROOT(){
    if [ $USER_ID -ne 0 ]
    then
        echo -e "$R please run script with root user $N" | tee -a $LOG_FILE
        exit 1 # exit running script form this point
    fi
}

CHECK_ROOT

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is...$R FAILED $N" | tee -a $LOG_FILE
        exit 1 # exit running script form this point
    else
        echo -e "$2 is...$G  SUCCESS $N" | tee -a $LOG_FILE
    fi
}

dnf install mysql-server -y
VALIDATE $1 "Installing mysql-server"