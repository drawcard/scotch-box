                                                                                                                                                                      #!/bin/bash

# Choose from a list of websites
# Thanks http://stackoverflow.com/a/3200362

cd /var/www/public/clients
printf "Please select a website folder:\n"
select d in */; do test -n "$d" && break; echo ">>> Invalid Selection"; done
cd "$d"/www/wp-content/themes && pwd

printf "Please select a theme folder:\n"
select d in */; do test -n "$d" && break; echo ">>> Invalid Selection"; done
cd "$d" && pwd

echo "Pick a task:"
echo "1) Gulp Watch (fast)";
echo "2) Gulp Watch"; 
echo "3) Gulp Clean, Build, Watch"; 

# Disable this option for now until we convert this script to work in ZSH.
# echo "4) Do nothing (go to dir)";

read n
case $n in
    1) echo "Running 'gulp watch' --fast in `pwd`..." && gulp watch --fast;;
    2) echo "Running 'gulp watch' in `pwd`..." && gulp watch;; 
    3) echo "Running 'gulp && gulp watch' in `pwd`..." && gulp && gulp watch;;
#    4) git status;;
#    *) git status;;
esac

pwd && git status
