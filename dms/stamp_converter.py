#!/usr/bin/env python
#
# Python script to convert UNIX timestamps in a CSV file
# into ISO standard. Supports Timestamps being found in 
# a single column as well as timestamps used as column
# headers.
#
# This script is designed to deal with one of two cases:
# CASE 1: Timestamp in Header file. Use -h/--header flag.
#     In this case the CSV is expected to look like this:
# | Header 1 | Header 2 | ... | TIMESTAMP 1 | TIMESTAMP 2 | ... | TIMSTAMP N |
# |----------|----------|-----|-------------|-------------|-----|------------|
# |  Data    | Data     | ... |    Data     |    Data     | ... |  Data      |
#
#     In this case the script will read in and convert the header row, with all
#     other rows being passed through to the output script.
#
# CASE 2: Timestamp in a column. Use -c/--column flag.
#     In this case, the CSV is expected to look like this:
# | Header 1 | Header 2 | .... | Time  | ... | Header N |
# |----------|----------|------|-------|-----|----------|
# |   Data   |   Data   | .... | Stamp | ... |   Data   |
# |   Data   |   Data   | .... | Stamp | ... |   Data   |
# 
#     In this case the script will pass through the header row. After that,
#     each row will be processed with the timestamp being replaced by a string.
#
# Author: D. Michael Senter


import csv
import sys
import argparse
from datetime import datetime


def stamp2iso(string):
    """
    Takes in a UNIX timestamp as string, returns string in ISO format.
    """
    return str(datetime.fromtimestamp(int(string)).strftime("%Y-%m-%dT%H:%M:%S"))


def fix_header(infile, outfile, colnum):
    """
    Fixes unix timestamp to ISO if occuring in the header of the file.

    NOTE: Assumes all subsequent column headers are also timestamps.
    If necessary, use a separate tool like csvkit to reorder the CSV 
    prior to running this function.

    Args:
        - infile: string pointing to source CSV
        - outfle: string pointing to target CSV.
        - colnum: number of first column in timestamp format. All subsequent columns
                  assumed to also be timestamps.
    """

    with open(infile, mode='r') as fid:
        colnum -= 1  # adj. colnum to account for zero-based indexing
        cread = csv.reader(fid)
        ctr = 0

        with open(outfile, mode='w') as new_file:
            cwrite = csv.writer(new_file)

            for row in cread:
                if ctr==0:
                    # we're in the header
                    outrow = row[:colnum] + [stamp2iso(elem) for elem in row[colnum:]]
                    ctr += 1
                else:
                    outrow = row
                cwrite.writerow(outrow)

        
def fix_column(infile, outfile, colnum):
    """
    Fixes unix timestamp to ISO if occuring in a single column.

    Args:
        - infile: string pointing to source CSV
        - outfle: string pointing to target CSV.
        - colnum: number of column in timestamp format.
    """
    with open(infile, mode='r') as fid:
        colnum -= 1  # adj. colnum to account for zero-based indexing
        cread = csv.reader(fid)
        ctr = 0

        with open(outfile, mode='w') as new_file:
            cwrite = csv.writer(new_file)
            for row in cread:
                if ctr==0:
                    outrow = row
                    ctr+=1
                else:
                    outrow = row[:colnum] + [stamp2iso(row[colnum])] + row[colnum+1:] 
                cwrite.writerow(outrow)



def main():

    # setting up the argument parser
    parser = argparse.ArgumentParser(add_help=False,
            description="""
            Tool to convert UNIX timestamps in CSV files. Open Script for details.
            """)
    parser.add_argument('cnum', type=int, help="Column no. for conversion.")
    parser.add_argument('filename', type=str, help="CSV file to be processed.")
    parser.add_argument('outfile', type=str, nargs='?', default="OUT.csv",
            help="Output filename (default: 'OUT.csv').")

    action_group = parser.add_mutually_exclusive_group(required=True)
    action_group.add_argument('-c', '--column', action='store_true',  help="Convert the column.")
    action_group.add_argument('-h', '--header', action='store_true', help="Convert the header.")

    parser.add_argument('--help', action="help", help="Show this help message.")

    args = parser.parse_args()

    if args.column:
        fix_column(args.filename, args.outfile, args.cnum)
    elif args.header:
        fix_header(args.filename, args.outfile, args.cnum)
    else:
        # shouldn't ever reach this case.
        parser.print_help()


if __name__=="__main__":
    main()
