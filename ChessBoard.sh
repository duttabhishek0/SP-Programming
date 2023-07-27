#!/bin/bash

print_chessboard() {
    local rows=$1
    local columns=$2
    local black_square="██" 
    local white_square="  " 

    for ((i = 1; i <= rows; i++)); do
        for ((j = 1; j <= columns; j++)); do
            if (( (i + j) % 2 == 0 )); then
                printf "$black_square"
            else
                printf "$white_square"
            fi
        done
        printf "\n"  
    done
}

validateInput() {
    if [[ "$1" =~ ^[1-9][0-9]*$ ]]; then
        return 0
    else
        return 1
    fi
}

echo "Please enter the size of the chessboard (number of rows and columns):"
read -p "Rows: " input_rows
read -p "Columns: " input_columns

if ! validateInput "$input_rows" || ! validateInput "$input_columns"; then
    echo "Error: Invalid input. Please enter positive integers for the number of rows and columns."
    exit 1
fi

print_chessboard "$input_rows" "$input_columns"