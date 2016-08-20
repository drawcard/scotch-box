#!/bin/bash
# This script lets you jump to the theme folder of a Wordpress website faster, and start Gulp.

# Choose from a list of websites
# Thanks http://stackoverflow.com/a/3200362

cd /var/www/public/clients
printf "Please select a website folder:\n"
select d in */; do test -n "$d" && break; echo ">>> Invalid Selection"; done
cd "$d"/www/wp-content/themes && pwd

printf "Please select a theme folder:\n"
select d in */; do test -n "$d" && break; echo ">>> Invalid Selection"; done
cd "$d" && pwd

# Thanks http://askubuntu.com/a/56685
echo "Pick a task:"
echo "1) Gulp Watch (fast)";
echo "2) Gulp Watch"; 
echo "3) Gulp Clean, Build, Watch"; 
echo "4) Do nothing (go to dir)";

read n
case $n in
    1) gulp watch --fast;;
    2) gulp watch;; 
    3) gulp && gulp watch;;
    4) pwd;;
    *) pwd;;
esac
