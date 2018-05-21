#!/bin/sh
#Todd Houle
#Mar 2016
#update 26May2016
# to check for pending updates  in /usr/local/updateTool/updaterInfo.txt
# and either force install or open the GUI app.

bitBarPath=$(defaults read /Library/Preferences/com.matryer.BitBar.plist pluginsDirectory)
bitBarApp=$(/usr/bin/mdfind "kind:applications" bitbar|head -1)

writeToLog(){
#    logger "UpdateRabbit: $1"
    echo "UpdateRabbit: $1"
}

CheckForNetwork(){
# Determine if the network is up by looking for any non-loopback network interfaces.                                                                                            
    local test
    if [[ -z "${NETWORKUP:=}" ]]; then
        test=$(ifconfig -a inet 2>/dev/null | sed -n -e '/127.0.0.1/d' -e '/0.0.0.0/d' -e '/inet/p' | wc -l)
        if [[ "${test}" -gt 0 ]]; then
            NETWORKUP="-YES-"
        else
            NETWORKUP="-NO-"
        writeToLog "No Network Avail. Exiting"
        exit
        fi
    fi
}

checkFileForUpdates(){
    updatesNeeded=`cat /usr/local/updateTool/updaterInfo.txt`
    if [ ! -z "$updatesNeeded" ]; then
        return 0
    else
        return 1
    fi
}

lookForOverDueUpdates(){
    rebootRequiredOverDueUpdate=False
    while read line; do
	dueDate=`echo "$line" |awk -FdueDate:\" '{print $2}' | awk -F\" '{print $1}'`
        dueDateJules=`date -j -f "%m-%d-%Y %H:%M" "$dueDate" "+%s"`
        dateAge=`expr $nowJules - $dueDateJules`
	if [ $dateAge -gt 0 ]; then
            forceInstallDone="true"
	    appName=`echo "$line" |awk -FappName:\" '{print $2}' |awk -F\" '{print $1}'`
	    policyName=`echo "$line" | awk -FjssPolicy:\" '{print $2}' |awk -F\" '{print $1}'`
	    rebootRequiredthisUpdate=`echo "$line" |awk -Freboot: {'print $2'} |tr -d }`
	    if [ $rebootRequiredthisUpdate = "true" ]; then
		rebootRequiredOverDueUpdate=true
	    fi
	    addName="$appName,"  #yeah, I know its spelt wrong
	    OVERDUEUPDATES+=($addName)
	    OVERDUEUPDATESPOLICY+=("$policyName")
            writeToLog "DueDateHasPassed! Policy $policyName"
	fi
    done </usr/local/updateTool/updaterInfo.txt
}

checkFileForUpdates(){
    updatesNeeded=`cat /usr/local/updateTool/updaterInfo.txt`
    if [ ! -z "$updatesNeeded" ]; then
        return 0
    else
        return 1
    fi
}


installUpdates(){
    defaults delete /Library/Preferences/edu.mit.updateTool.plist updateSnoozeCount
    for ((i = 0; i < ${#OVERDUEUPDATESPOLICY[@]}; i++)); do
        helperLine=`grep "${OVERDUEUPDATESPOLICY[$i]}" /usr/local/updateTool/updaterInfo.txt`
        policyName=`echo "$helperLine" | awk -FjssPolicy:\" '{print $2}' |awk -F\" '{print $1}'`
        source=`echo "$helperLine" | awk -Fsource:\" '{print $2}' |awk -F\" '{print $1}'`
        reboot=`echo "$helperLine" | awk -Freboot: '{print $2}' |tr -d }`
#     only kills process when update is overdue.  Need solution for non-overdue updates
#	appName=`echo "$helperLine" | awk -FappName:\" '{print $2}' |awk -F\" '{print $1}'`
#	appProcess=$(ps axww -o pid,command|grep -v grep |grep -v bash|grep "$appName"|awk '{print $1}')
#	/bin/kill $appProcess
	if [ "$reboot" == "false" ]; then
	    rebootAction="rebootNo"
	else
	    rebootAction="rebootYes"
	fi
	touch "/usr/local/updateTool/updateToolTouchFiles/$source+$policyName+$rebootAction" 
	writeToLog "creating touch file: $source+$policyName+$rebootAction"
    done
    
}
##############################################
##Look for network
CheckForNetwork
#CheckSiteNetwork

#quit if another instance of script is running
if [ -d /tmp/myscript.lock ]; then
    writeToLog "Another instance of the Installer is already running."
    exit 1
fi

#keep BitBar in sync
if [ -f "$bitBarApp/Contents/MacOS/BitBar" ] && [ -d $bitBarPath ]; then
    open -g bitbar://refreshPlugin?name=*
    if [ $? -ne 0 ]; then
        killall BitBar
        open -g bitbar://refreshPlugin?name=*
    fi
fi


#cancel if installRunning
SERVICE='updateInstaller.sh'                                                                                          
if ps ax | grep -v grep | grep $SERVICE > /dev/null;then
    echo "Can't kick.  Installer already running"
    writeToLog "Can't kick.  Installer already running"
    exit
fi


checkFileForUpdates
needed=$?
if [ $needed == 0 ]; then
    writeToLog "Updates Are Needed: Continue"
else
    writeToLog "No Updates needed.  Closing"
    exit 0
fi

#date needed to compare against in 'lookforoverdueupdates'
nowJules=`date +%s`

#zero overDueUpdate array. Used to present friendly policy name in dialog box
OVERDUEUPDATES=()

#zero array to record jss policy name to invoke later if overdue
OVERDUEUPDATESPOLICY=()

#pause if root is logged in, give the user time to get started if just booted
currentUser=`stat -f '%Su' /dev/console`
if [ "$currentUser" == "root" ]; then
    sleep 180
fi
currentUser=`stat -f '%Su' /dev/console`

lookForOverDueUpdates

if [ -z "$OVERDUEUPDATES" ]; then
    writeToLog "Updates, but nothing overdue."
else
    writeToLog "OverDueUpdates: ${OVERDUEUPDATES[*]}"
    
    threeHoursFromNow=$(date -v +3H "+%r")
    
    if [ "$currentUser" != "root" ]; then
	if [ "$rebootRequiredOverDueUpdate" == "False" ]; then
	    osascript -e "display dialog \"Updates are overdue and will be applied beginning at $threeHoursFromNow.\" with title \"Updates Due\" with icon caution buttons {\"Install\"} giving up after 10800"
	else
	    osascript -e "display dialog \"Updates are overdue and will be applied beginning at $threeHoursFromNow.\" with title \"Updates Due\" with icon caution buttons {\"Reboot\"} giving up after 10800"
	fi
    fi
    installUpdates
fi











