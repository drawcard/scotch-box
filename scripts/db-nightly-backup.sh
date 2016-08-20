#-------
# MYSQL NIGHTLY BACKUP SCRIPT
# Adapted from: http://www.linuxbrigade.com/back-up-all-of-your-mysql-databases-nightly/
# Add this to line to cron as root for nightly backups (sudo crontab -e)
# 30 3 * * * /usr/local/bin/mysql_backup.sh
#-------
DB_BACKUP="/var/www/public/mysql-backup/`date +%Y-%m-%d`"
DB_USER="root"
DB_PASSWD="root"
HN=`hostname | awk -F. '{print $1}'`
 
# Create the backup directory
mkdir -p $DB_BACKUP
 
# Remove backups older than 10 da     ys
find /var/www/public/mysql-backup/ -maxdepth 1 -type d -mtime +10 -exec rm -rf {} \;
 
# Backup each database on the system
echo 'Dumping databases...'
for db in $(mysql --user=$DB_USER --password=$DB_PASSWD -e 'show databases' -s --skip-column-names|grep -viE '(staging|performance_schema|information_schema)');
do mysqldump --user=$DB_USER --password=$DB_PASSWD --events --opt --single-transaction $db | gzip > "$DB_BACKUP/mysqldump-$HN-$db-$(date +%Y-%m-%d).gz";
echo $db
done
