#!/bin/bash
# 
# usage: ./cut_csv.sh FILE
#
# Use bash to shrink a large CSV file into a smaller
# one to test scripts on. New CSV will have the same
# filename prefixed with "short".
# Change the settings below to adjust for your needs.
#
# Author: D. Michael Senter

NUM=50      # number of rows to keep, including header
START=1     # first column no. to keep
STOP=9      # last column no. to keep

INFILE=$1
OUTFILE="short_$1"

head -n $NUM $INFILE | cut -d ',' -f $START-$STOP > $OUTFILE
