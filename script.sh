#!/bin/bash
# ------------------------------------------------------------------
# [Author]	Giacomo Cavicchioli
#			Automatically check if a website changes
#
#			This script uses:
#				- md5
#				- curl
#
# ------------------------------------------------------------------
VERSION=0.1.0
USAGE="Usage: checkchanges [-v] [-e notification_email] [-t refresh_time] url"

# DEFAULT VALUES
USING_EMAIL="your-email@you.com"
USING_TIME=600
USING_VERBOSE=false

# --- Option processing --------------------------------------------
if [ $# == 0 ] ; then
    echo $USAGE
    exit 1;
fi

while getopts ":vt:e:" opt; do
	case $opt in
		t)
			# set the specific time to refresh
			if [[ "$OPTARG" =~ ^[0-9]+$ ]] ; then
				# echo "-t was triggered, Parameter: $OPTARG" >&2
				USING_TIME=$OPTARG
			else
				echo -e "\n\tIf you use -$opt you must specify the time to refresh.\n"
				exit 1
			fi
			;;
		e)
			# set the notification email
			if [[ "$OPTARG" =~ .*@.* ]] ; then
				# echo "-e was triggered, Parameter: $OPTARG" >&2
				USING_EMAIL=$OPTARG
			else
				echo -e "\n\tIf you use -$opt you must specify a valid notification email.\n"
				exit 1
			fi
			;;
		v)
			# using verbose mode
			USING_VERBOSE=true
			;;
		*)
			echo -e "\n\tInvalid option: -$OPTARG\n"
			echo $USAGE
			exit 1
			;;
  esac
done
shift $(expr $OPTIND - 1 )

SITE=$1

echo -e "\n\tUSING:\n\tSite: $SITE\n\tTime to refresh: $USING_TIME seconds\n\tNotification email: $USING_EMAIL\n\tVerbode mode: $USING_VERBOSE\n\n"


ORIGINAL_MD5=$(curl $SITE 2>/dev/null | md5)
CURRENT_MD5=$ORIGINAL_MD5

while [ "$ORIGINAL_MD5" == "$CURRENT_MD5" ]	; do

	if [ $USING_VERBOSE ] ; then
		echo -e "\tCurrent checksum: $CURRENT_MD5 for website $SITE"
	fi

	CURRENT_MD5=$(curl $SITE 2>/dev/null | md5)

	# sleep USING_TIME
	sleep $USING_TIME
done

echo -e "\tCurrent checksum: $CURRENT_MD5 for website $SITE - CHANGED"
echo "Hello, $SITE just changed. Current checksum is $CURRENT_MD5" | sendmail $USING_EMAIL