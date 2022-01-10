#!/bin/bash
#Creating cronjob
mkdir /pubsubbucket
cat << EOF > /pubsubbucket/GC_CJ.sh
#!/bin/bash
PATH="$PATH":/snap/bin
# The ".boto" file contains the settings that helps you connect to Google Cloud Storage.
export BOTO_CONFIG="/home/m_elizsagm/.boto"
gcloud pubsub subscriptions pull demo1-subscription --format="json(ackId, message.attributes, message.data.decode(\"base64\").decode(\"utf-8\"), message.messageId, message.publishTime)" >> /tmp/bucket
gsutil cp /tmp/bucket gs://demo-task1-22
EOF
#Execution
chmod +x /pubsubbucket/GC_CJ.sh

#Installing crontab
apt-get update -y
apt-get install cron -y

#Add to crontab
CRON_FILE="/var/spool/cron/root"
if [ ! -f $CRON_FILE ]; then
   echo "cron file for root doesnot exist, creating.."
   touch $CRON_FILE
fi

systemctl enable cron.service
echo "Updating cron job"
#Runs every 5 min
#/bin/echo "* * * * * gcloud pubsub subscriptions pull demo1-subscription --project gcpdemo-task1" >> $CRON_FILE
/bin/echo '*/5 * * * * /bin/bash -c "/pubsubbucket/GC_CJ.sh"' >> $CRON_FILE | crontab -
/usr/bin/crontab $CRON_FILE

