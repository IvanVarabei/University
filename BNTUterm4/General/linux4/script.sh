#!/bib/bash
echo "The name of script is $0" 
echo -n "Hello $1"
echo "Hello $2"
n1=3
n2=4
sum=$((n1+n2))
echo "$n1+$n2=$sum"
myHost=`hostname`
ping -c 4 $myHost
