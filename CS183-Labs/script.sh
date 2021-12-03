#! /bin/bash

mode=$1

search() {

	files_and_folders=$(ls $1)

	arr=($files_and_folders)
	
	flag=1;


	for ((i=0; i<${#arr[@]}-1; i++))
	do
		flag=0;
		for ((j=0; j<${#arr[@]}-1-$i; j++))
		do
			
			# THE COMPARISON FLAGS
			compare=false
			if [[ $mode == 1 ]]
			then
				if [[ "${arr[$j]//./}" > "${arr[$j+1]//./}" ]]; then compare=true; fi
			fi
			if [[ $mode == 2 ]]
			then
				if [[ "${arr[$j]//./}" < "${arr[$j+1]//./}" ]]; then compare=true; fi
			fi

			if [ "$compare" = true ]
			then
				temp=${arr[$j]};
				arr[$j]=${arr[$j+1]};
				arr[$j+1]=$temp;
				flag=1;
			fi
		done
	
		if [[ $flag -eq 0 ]]; then
			break;
		fi
	done

	for file in "${arr[@]}"
	do

		if [ -d "$1$file" ]; then
			echo -n "|-"
			for ((i=0; i<$2; i++)); do echo -n "-"; done
			echo "$file"
			search "$1$file/" $2+1		
		fi

		if [ -f "$1$file" ]; then 
			echo -n "|-"
			for ((i=0; i<$2; i++)); do echo -n "-"; done
			echo "$file"
		fi

	done


}

search "./" 0
