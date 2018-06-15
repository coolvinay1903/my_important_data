#!/bin/bash
sd=`date +%Y%m%d_%H%M%S`
backup_dir="/home/vinays/public/backup/$sd";
/bin/mkdir -p $backup_dir
crontab -l > ~/.cronjob.`hostname`
/bin/cp -prfL ~/.cronjob.`hostname` ~/.profile ~/.bashrc ~/bash_settings ~/.alias ~/.cshrc* ~/.mycshrc ~/.vimrc ~/.emacs.d ~/.emacs ~/.vnc/ $backup_dir && echo "Copied data successfully"
cd /home/vinays/public/backup/
/bin/tar cfz $sd.tar.gz $sd && echo "Tar-ing the backup image"
/bin/rm -rf $backup_dir && echo "Cleaning up"
echo "backup @ $backup_dir.tar.gz"
echo "Done"
exit 0;
