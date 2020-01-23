#!/bin/bash
#
# Simple shell script to download the various Excel sheets with the 
# NTD 2018 data made available by the FTA. The dowloaded Excel files 
# will be converted to csv using the Python package "csvkit". For clean-up
# the CSV files will be moved into a folder called "csv" while the Excel files
# will be moved into a folder called "excel". 
#
# Author: D. Michael Senter


# LIST of all Excel files
LINKS="https://www.transit.dot.gov/sites/fta.dot.gov/files/2018%20Agency%20Info.xlsx
https://www.transit.dot.gov/sites/fta.dot.gov/files/2018%20Agency%20Mode%20TOS.xlsx
https://www.transit.dot.gov/sites/fta.dot.gov/files/2018%20Agency%20UZA.xlsx
https://www.transit.dot.gov/sites/fta.dot.gov/files/2018%20Capital%20Use.xlsx
https://www.transit.dot.gov/sites/fta.dot.gov/files/2018%20Contractual%20Relationship.xlsx
https://www.transit.dot.gov/sites/fta.dot.gov/files/2018%20Energy%20Consumption.xlsx
https://www.transit.dot.gov/sites/fta.dot.gov/files/2018%20Facility%20Inventory.xlsx
https://www.transit.dot.gov/sites/fta.dot.gov/files/2018%20Fare%20Revenue.xlsx
https://www.transit.dot.gov/sites/fta.dot.gov/files/2018%20Federal%20Funding%20Allocation.xlsx
https://www.transit.dot.gov/sites/fta.dot.gov/files/2018%20Group%20Plan%20Sponsors.xlsx
https://www.transit.dot.gov/sites/fta.dot.gov/files/2018%20Operating%20Expenses.xlsx
https://www.transit.dot.gov/sites/fta.dot.gov/files/2018%20Operating%20Expenses%20Reconciling_0.xlsx
https://www.transit.dot.gov/sites/fta.dot.gov/files/2018%20Performance%20Measure%20Targets.xlsx
https://www.transit.dot.gov/sites/fta.dot.gov/files/2018%20Reportable%20Segments.xlsx
https://www.transit.dot.gov/sites/fta.dot.gov/files/2018%20Reporting%20Waivers.xlsx
https://www.transit.dot.gov/sites/fta.dot.gov/files/2018%20Revenue%20Vehicle%20Inventory.xlsx
https://www.transit.dot.gov/sites/fta.dot.gov/files/2018%20Safety%20Information.xlsx
https://www.transit.dot.gov/sites/fta.dot.gov/files/2018%20Service.xlsx
https://www.transit.dot.gov/sites/fta.dot.gov/files/2018%20Service%20Vehicle%20Inventory.xlsx
https://www.transit.dot.gov/sites/fta.dot.gov/files/2018%20Statement%20of%20Finances.xlsx
https://www.transit.dot.gov/sites/fta.dot.gov/files/2018%20Transit%20Agency%20Employees.xlsx
https://www.transit.dot.gov/sites/fta.dot.gov/files/2018%20Transit%20Facilities.xlsx
https://www.transit.dot.gov/sites/fta.dot.gov/files/2018%20Transit%20Stations.xlsx
https://www.transit.dot.gov/sites/fta.dot.gov/files/2018%20Transit%20Way%20Mileage.xlsx
https://www.transit.dot.gov/sites/fta.dot.gov/files/2018%20UZA%20Sums.xlsx
https://www.transit.dot.gov/sites/fta.dot.gov/files/2018%20Vehicle%20Maintenance.xlsx
https://www.transit.dot.gov/sites/fta.dot.gov/files/2018%20Questionable%20Data%20Items.xlsx
https://www.transit.dot.gov/sites/fta.dot.gov/files/2018%20Data%20Dictionary.xlsx
https://www.transit.dot.gov/sites/fta.dot.gov/files/2018%20Recipient%20Counties%20Served%20and%20State%20Admin.xlsx"


echo "BEGIN download of of $(echo "$LINKS" | wc -l) files."
echo ""
echo ""

# download new files
echo "$LINKS" | wget -i -

echo ""
echo "<==========================================================================================>"
echo ""

# convert downloaded files to CSV
for i in *.xlsx; do
	 #[ -f "$if" ] || break
	 echo "Converting '$i'"
	 in2csv "$i" > "${i%.xlsx}.csv"
done

echo ""
echo "<==========================================================================================>"
echo ""

# get rid of spaces in CSV file names
for f in *.csv; do mv "$f" "${f// /_}"; done

# sort everything into nice folders

echo "BEGIN moving Excel files."

if [ ! -d ./excel ]; then
	echo "Excel directory doesn't exist. Creating directory..."
	mkdir excel
fi 

mv -v *.xlsx excel

echo ""
echo "BEGIN moving CSV Files."

if [ ! -d ./csv ]; then
	echo "CSV directory doesn't exist. Creating directory..."
	mkdir csv
fi

mv -v *.csv csv 