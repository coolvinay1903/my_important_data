SHELL=/bin/bash
#PATH=/sbin:/bin:/usr/sbin:/usr/bin
MAILTO=vinays@mentor.com
#HOME=/home/vinays
############################################################
# *     *     *     *     *  command to be executed
# -     -     -     -     -
# |     |     |     |     |
# |     |     |     |     +----- day of week (0 - 6) (Sunday=0)
# |     |     |     +------- month (1 - 12)
# |     |     +--------- day of month (1 - 31)
# |     +----------- hour (0 - 23)
# +------------- min (0 - 59)
# Some examples
# * * * * * *                         Each minute
# 59 23 31 12 5 *                     One minute  before the end of year if the last day of the year is Friday
# 59 23 31 DEC Fri *                  Same as above (different notation)
# 45 17 7 6 * *                       Every  year, on June 7th at 17:45
# 45 17 7 6 * 2001,2002               Once a   year, on June 7th at 17:45, if the year is 2001 or  2002
############################################################

03 19 * * * /home/vinays/public/util_scripts/mycron.job|tee -a /home/vinays/public/junk/`date|awk '{print $2"_"$3"_"$6"_"$4}'|sed -e 's/://g'`.cscope.log
03 19 * * * /home/vinays/public/util_scripts/backup.sh|tee -a /home/vinays/public/junk/`date|awk '{print $2"_"$3"_"$6"_"$4}'|sed -e 's/://g'`.backup.log

#05 17 * * * source /home/vinays/print_date
