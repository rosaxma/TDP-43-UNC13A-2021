#!/bin/bash
while IFS= read -r line
do 
	git mv ${line} Majiq/ 
done < file_names
