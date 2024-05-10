echo "1. Check In\n 2. Make Reservation\n 3. Room Service\n 4. Check Out" 
read -p "Enter the choic: " c
if [ "$c"==1 ] then;
read -p "Enter costumer name: " n
grep "$n" Record.txt
fi
