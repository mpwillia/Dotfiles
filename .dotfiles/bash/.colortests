
function ColorTest()
{
   echo "Color Test Functions"
   echo "  Show16ColorChart()"
}


function Show16ColorChart()
{
   #Printing color blocks
   echo "  Black      Red      Green     Yellow     Blue    Magenta     Cyan      Gray"

   # Print Normal Colors
   for height in 0 1 2 3; do
      __printColorsInRange 40 47 "" "          " ""
      echo #Newline
   done

   # Print Bold Colors
   for height in 0 1 2 3; do
      __printColorsInRange 100 107 "" "          " ""
      echo #Newline
   done
   echo #Newline

   #Printing example text
   
   #Normal Colors
   __printColorsInRange 30 37 "" " Example  " ""
   echo #Newline

   __printColorsInRange 90 97 "" " Example  " ""
   echo #Newline
   echo #Newline

   #Background Example w/ Black Text

   #Normal Colors
   __printColorsInRange 40 47 ";30" " Example " " "
   echo #Newline

   #Bold Colors
   __printColorsInRange 100 107 ";30" " Example " " "
   echo #Newline
   echo #Newline

   #Background Example w/ White Test

   #Normal Colors
   __printColorsInRange 40 47 ";97" " Example " " "
   echo #Newline

   #Bold Colors
   __printColorsInRange 100 107 ";97" " Example " " "
   echo #NewLine

}

function testColorsInRange()
{
   source ~/.bash_profile
   __printColorsInRange 40 47 "" "         " ""
} 

# $1 - lower bound
# $2 - upper bound
# $3 - extra color params
# $4 - text to color
# $5 - postfix text
function __printColorsInRange()
{
   local lowerBound=$1
   local upperBound=$2
   local extraColorParams=$3
   local coloredText=$4
   local postfix=$5

   while [ $lowerBound -le $upperBound ]; do
      echo -en "\e[${lowerBound}${extraColorParams}m${coloredText}\e[0m${postfix}"
      ((lowerBound++))
   done
} 



function Ignoremefornow()
{
   #Background
   for clbg in {40..47} {100..107} 49 ; do
      #Foreground
      for clfg in {30..37} {90..97} 39 ; do
         #Formatting
         for attr in 0 1 2 4 5 7 ; do
            #Print the result
            echo -en "\e[${attr};${clbg};${clfg}m ^[${attr};${clbg};${clfg}m \e[0m"
         done
         echo #Newline
      done
   done
}

