#!/bash/bin
#Creating cronjob
#
CRON_FILE="/var/spool/cron/root"

	if [ ! -f $CRON_FILE ]; then
	   echo "cron file for root doesnot exist, creating.."
	   touch $CRON_FILE
	fi
	/usr/bin/crontab $CRON_FILE
	echo "Updating cron job"
    #gcloud init
    systemctl enable cron
    /bin/echo "* * * * * gcloud pubsub subscriptions pull demo1-subscription --project gcpdemo-task1" >> $CRON_FILE


