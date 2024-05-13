#!/bin/bash

while true; do
    echo "1. Check In"
    echo "2. Make Reservation"
    echo "3. Room Service"
    echo "4. Check Out"
    echo "5. Exit"
    
    read -p "Enter your choice: " c
    
    if [ "$c" = "1" ]; then
        read -p "Enter customer name: " n
        grep -i "$n" Record.txt
    elif [ "$c" = "2" ]; then
        echo "1. Classic Twin Room\nFits up to: 4 individuals\n2 Single beds and 1 sofa bed\nPrice: SAR 103\n\n2. Classic Triple Room\nFits up to: 3 individuals\n2 Single beds and 1 sofa bed\nPrice: SAR 116\n\n3. Classic Quadruple Room\nFits up to: 4 individuals\n3 Single beds\nPrice: SAR 127" 
        read -p "Enter your choice: " r
        if [ "$r" = "1" ]; then
            room_tybe="Classic Twin Room"
            read -p "Customer name: " n1
            read -p "Customer phone number: " ph
            read -p "Number of Days: " d
            price=$((103 * $d))
        elif [ "$r" = "2" ]; then
            room_tybe="Classic Triple Room"
            read -p "Customer name: " n1
            read -p "Customer phone number: " ph
            read -p "Number of Days: " d
            price=$((116 * $d))
        elif [ "$r" = "3" ]; then
            room_tybe="Classic Quadruple Room"
            read -p "Customer name: " n1
            read -p "Customer phone number: " ph
            read -p "Number of Days: " d
            price=$((127 * $d))
        fi
        echo "$n1, $ph, $room_tybe, $d days, SAR $price" >> Record.txt
    elif [ "$c" = "5" ]; then
        echo "Exiting..."
        break 
    fi
done
