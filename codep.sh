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
            if ! grep -iq "$n" Record.txt; then
            echo "Customer Does Not Have a Reservation!"
        else
            grep -i "$n" Record.txt
        fi
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
        echo "Reservation Done!";
    elif [ "$c" = "3" ]; then
        echo "Room Services:"
        echo "1. Laundry - SAR 50"
        echo "2. Room Cleaning - SAR 30"
        echo "3. Breakfast - SAR 20"
        read -p "Enter the service you want please: " service_choice
        if [ "$service_choice" = "1" ]; then
            service_name="Laundry"
            service_price=50
        elif [ "$service_choice" = "2" ]; then
            service_name="Room Cleaning"
            service_price=30
        elif [ "$service_choice" = "3" ]; then
            service_name="Breakfast"
            service_price=20
        else
            echo "Invalid choice!"
            continue
        fi
        read -p "Enter your name: " resident_name
        price_record=$(grep -i "$resident_name" Record.txt | awk -F ', ' '{print $6}' | grep -o '[0-9]*')
        if [ -n "$price_record" ]; then
            price=$((price_record + service_price))
            echo "$service_name added to $resident_name's bill. New total price: SAR $price"
            sed -i "/$resident_name/s/SAR [0-9]*/& + $service_name SAR $service_price, Total: SAR $price/" Record.txt
        else
            echo "Resident not found!"
        
        fi
       elif [ "$c" = "4" ]; then
       read -p "Enter customer name for Check Out: " name_checkout
       customer_info=$(grep -i "$name_checkout" Record.txt)
        if [ -n "$customer_info" ]; then
            echo "Customer Information:"
            echo "$customer_info"
            read -p "Payment method (cash or card): " payment_method
            if [ "$payment_method" = "card" ]; then
                read -p "Enter card number: " card_number
                read -p "Enter card PIN: " card_pin
                read -p "Enter amount to be charged: " amount
                echo "Payment processed successfully. Thank you!"
            elif [ "$payment_method" = "cash" ]; then
                echo "Thank you!"
            else
                echo "Invalid payment method!"
                continue
            fi
            sed -i "/$name_checkout/d" Record.txt
            echo "Check Out completed for $name_checkout."
        else
            echo "Customer not found!"
        fi
    elif [ "$c" = "5" ]; then
        echo "Exiting..."
        break
    fi
done
