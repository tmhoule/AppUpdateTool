#!/bin/sh
# Todd Houle
# Dec 2015
# writes updates needed to $datafile
# That file is read in with the GUI tool

#Server to get config file from. 
configURL=$(defaults read /Library/Preferences/edu.mit.ll.updateTool.plist configURL)

#Server to get SHA of above config file.
SHAurl=$(defaults read /Library/Preferences/edu.mit.ll.updateTool.plist configSHAURL)

#Version Comparison Routine
vercomp () {
#    echo "Starting: $1 $2"
    if [[ $1 == $2 ]]
    then
        return 0
    fi
    local IFS=.
    local i ver1=($1) ver2=($2)
    # fill empty fields in ver1 with zeros
    for ((i=${#ver1[@]}; i<${#ver2[@]}; i++))
    do
        ver1[i]=0
    done
    for ((i=0; i<${#ver1[@]}; i++))
    do
        if [[ -z ${ver2[i]} ]]
        then
            # fill empty fields in ver2 with zeros 
            ver2[i]=0
        fi
        if ((10#${ver1[i]} > 10#${ver2[i]})); then
            return 1
        fi
        if ((10#${ver1[i]} < 10#${ver2[i]}))
        then
            return 2
        fi
    done
    return 0
}

update(){
    # Rename function arguments for easier reference 
    appName="$1" # Application Friendly Name
    latestVersion="$2" #The latest version of the app on the server
    packageName="$3"   #The name of the JSS policy to run to install the cached package
    installBy="$4"  #The date the update will be autoinstalled if not done yet.
    minVers="$5" #Versions below this will be ignored 
    appPath="$6" #path to the app, as defined in the config file
    appBundleName=$(defaults read "$appPath/Contents/Info.plist" CFBundleName 2>/dev/null)
    appSource="$7" #where to get app - Apple or http://yada.com/packages
    if [ "$appSource" == "Apple" ] || [ "$appSource" == "apple" ]; then
	echo "LLUpdate: $appName is not an update for a local application."
	return
    fi
    appSha="$8" #sha of pkg
    doReboot="$9" #should it reboot?
    if [ -z "$doReboot" ]; then
        doReboot="false"
    elif [ "$doReboot" == "0" ]; then
        doReboot="false"
    elif [ "$doReboot" == "1" ]; then
	doReboot="true"
    else  #if unknown
	doReboot="false"
    fi

    if [ -z "$appBundleName" ]; then
	appBundleName="NotInstalled"
    fi
    
    #build list of versions of app which will not be patched (appPath doesn't match defined path)
    unpatchedApps=$(/usr/bin/mdfind "kind:application" $appName)
    while read -r line; do
	if [ ! -z "$line" ]; then   #if line is not blank (app not installed)
	    if [ ! "$appPath" == "$line" ]; then   
		thisAppVersion=$(defaults read "$line/Contents/Info.plist" CFBundleShortVersionString 2>/dev/null)
		echo "--$appName - $line - version: $thisAppVersion (latest:$latestVersion)|color=black" >> /usr/local/updateTool/unpatchedAppList.txt
   	    fi
	fi
    done <<< "$unpatchedApps"
    
    #skip if not installed
    if [ ! -d "$appPath" ]; then
	echo "LLUpdate: $appName is not installed. Couldn't find $appPath"
        /usr/libexec/PlistBuddy -c "Delete \":$appName\"" /usr/local/updateTool/ApplicationUpdateControl.plist
	return
    fi
    
    # Define version installed on local machine
    installedVersion=`defaults read "$appPath/Contents/Info.plist" CFBundleShortVersionString`
    
    # check if older than min version
    if [ ! -z "$minVers" ]; then
	vercomp $minVers $latestVersion
	minOK=$?
	if [ $minOK == 1 ]; then
	    echo "LLUpdate: $appName does not meet minimum version requirement. Skipping"
	    return
	else
	    echo "LLUpdate: $appName passes minimum version requirement."
	fi
    fi
    
    #find out which is newer, server (listed below) or what is on client machine.
    if [[ $installedVersion =~ [A-z] ]] || [[ $installedVersion = "" ]]; then
	echo "LLUpdate: ERROR - $appName version contains unsupported text: $versionString"
	return
    else
	vercomp $latestVersion $installedVersion
	newerApp=$?
    fi
    
    # If newer version is available, do this stuff.
    if [ $newerApp == 1 ]; then
        # An update is available. Record it for the GUI
	echo "LLUpdate: update for $appName is available"
    elif [ $newerApp == 2 ]; then
	echo "LLUpdate: User has a newer version of $appName than on the server. Do Nothing"
	 /usr/libexec/PlistBuddy -c "Delete \":$appName\"" /usr/local/updateTool/ApplicationUpdateControl.plist
	 echo "-- :white_check_mark: $appName $installedVersion | color=\$darklight"   >> /tmp/uptodateapps.txt
    elif [ $newerApp == 0 ]; then
	echo "LLUpdate: User has same version of $appName as is installed.  Do Nothing."
	/usr/libexec/PlistBuddy -c "Delete \":$appName\"" /usr/local/updateTool/ApplicationUpdateControl.plist
	echo "-- :white_check_mark: $appName $installedVersion | color=\$darklight"   >> /tmp/uptodateapps.txt
    else
	echo "LLUpdate: ERROR: Unknown Error occured comparing version on $appName.  You have $installedVersion and the latest is $latestVersion."
	/usr/libexec/PlistBuddy -c "Delete \":$appName\"" /usr/local/updateTool/ApplicationUpdateControl.plist
    fi
    
    unset appPath
    unset appName
    unset latestVersion
    unset installPolicy
    unset installBy
    unset minvers
    
}

checkAppleUpdates(){
    echo "Checking for Apple Updates"
    updateList=`softwareupdate -l 2>&1 |grep -v "Finding available software"` #2>&1 redirects stderr to stdout so it'll be available to grep.  No New software available is a STDERR message instead of STDOUT
    nextWeek=$(date -v+thu "+%a %b %d 23:50:00 EST %Y")
    updatesNeeded=`echo "$updateList" |grep "No new software available"`
    hasError=`echo $updateList |grep "load data from the Software Update server"`
    
    `echo "$updateList" > /tmp/appleSWupdates.txt`
    
    if [[ ! $updatesNeeded =~ "No new software available" ]]; then
	if [[ ! $hasError =~ "Can't load data from the Software Update server" ]]; then
	    updateMiniList=`echo "$updateList" |grep \*`   #gives list of updates with no other crap   

	    #delete from PLIST any apple update not needed
            policiesToCheck=$(defaults read /usr/local/updateTool/ApplicationUpdateControl.plist |awk -F= '/{/{print $1}'|grep -v "{"|sed 's/"//g')
            while read -r line; do
                #Look to see if update is Apple Update.  If it is and it is NOT on our to-do list, delete it 
                policyICheck=$(/usr/libexec/PlistBuddy -c "Print :\"$line:Source\"" /usr/local/updateTool/ApplicationUpdateControl.plist)
                if [ "$policyICheck" == "Apple" ]; then
                    doINeedThisUpdate=$(grep "$line" /tmp/appleSWupdates.txt)
                    #if null, then delete this line  
                    if [ -z "$doINeedThisUpdate" ]; then
			echo "UpdateRabbit: Removing $line because I don't need that on this computer"
			/usr/libexec/PlistBuddy -c "Delete :\"$line\"" /usr/local/updateTool/ApplicationUpdateControl.plist
		    else
			echo "UpdateRabbit: I need $line."
                    fi
                fi
            done <<< "$policiesToCheck"

	    #skip blank lines (no updates available)
	    echo "$updateMiniList"| while read line;do
                if [ "$line" == "" ]; then
                    continue
                fi
		
		jssPolicy=`echo "$line" |sed 's/\* //g'`    #Removes * from the line
		appNameWithWhiteSpace=`echo "$updateList" |grep -A1 "$jssPolicy"|tail -1|awk -F\( '{print $1}'`   #give human readable name "Java for OS X 2012-005"
		appName="$(echo "${appNameWithWhiteSpace}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"   #Removes before and after space
		rebootNeeded=`echo "$updateList" |grep -A1 "$jssPolicy"|tail -1|grep restart`
               if [[ -z $rebootNeeded ]]; then
                   rebootStatus=false
               else
                   rebootStatus=true
               fi
		latestVersion=`echo "$updateList" |grep -A1 "$jssPolicy"|tail -1|awk -F\( '{print $2}'|awk -F\) '{print $1}'`
                /usr/libexec/PlistBuddy -c "Add :\"$jssPolicy:Source\" string Apple" /usr/local/updateTool/ApplicationUpdateControl.plist
                /usr/libexec/PlistBuddy -c "Add :\"$jssPolicy:Reboot\" bool $rebootStatus" /usr/local/updateTool/ApplicationUpdateControl.plist
                /usr/libexec/PlistBuddy -c "Add :\"$jssPolicy:LatestVersion\" string $latestVersion" /usr/local/updateTool/ApplicationUpdateControl.plist
                allreadyThere=$(defaults read /usr/local/updateTool/ApplicationUpdateControl-holder.plist "$jssPolicy")
		if [ "$?" == "1" ]; then  #if not there already
		    /usr/libexec/PlistBuddy -c "Add :\"$jssPolicy:DueDate\" date $nextWeek" /usr/local/updateTool/ApplicationUpdateControl.plist
		else  #if is in holder from previously being seen
		    dueDateRecovered=$(/usr/libexec/PlistBuddy -c "Print :\"$jssPolicy:DueDate\"" /usr/local/updateTool/ApplicationUpdateControl-holder.plist)
		    /usr/libexec/PlistBuddy -c "Add :\"$jssPolicy:DueDate\" date $dueDateRecovered" /usr/local/updateTool/ApplicationUpdateControl.plist
		fi
		
		unset allreadyThere
		unset installBy
		unset rebootNeeded
	    done
	    
       	fi
    fi
}


######################################### Main App Starts Here
######################################### 
######################################### 
######################################### 

###############
#add permissions check here - don't run if perms are off
###############

#clear unpatchedAppList
rm  /usr/local/updateTool/unpatchedAppList.txt
touch  /usr/local/updateTool/unpatchedAppList.txt

#clear listOfPatchNotNeededApps
rm /tmp/uptodateapps.txt

mkdir -p /usr/local/updateTool

#get config file containing updates from server
echo "LLUpdate: Getting config $configURL"
if [ ! -z $configURL ]; then
    rm /usr/local/updateTool/ApplicationUpdateControl.plist
    echo "Getting config file $configURL."
    curl -so /usr/local/updateTool/ApplicationUpdateControl.plist $configURL

    if [ ! -z "$SHAurl" ]; then
	curl -so /usr/local/updateTool/ApplicationUpdateControl.plist.sha256 $SHAurl
	thisSha=$(shasum -a 256 /usr/local/updateTool/ApplicationUpdateControl.plist |awk '{print $1}')
	shouldBSha=$(cat /usr/local/updateTool/ApplicationUpdateControl.plist.sha256)
	if [ ! "$thisSha" == "$shouldBSha" ]; then
	    echo "LLUpdate: ConfigFile SHA error. Exiting."
	    exit 1
	else
	    echo "LLUpdate: SHA is valid as expected"
	fi
    else
	echo "LLUpdate: No SHA Check for $configURL available"
    fi
    if [ ! -f /usr/local/updateTool/ApplicationUpdateControl.plist ]; then
	echo "No config file available.  Exiting."
	exit 1
    fi
else
    echo "Error: No ConfigURL. Does /Library/Preferences/edu.mit.ll.updateTool.plist configURL  exist?"
    exit 1
fi


#clean updaterInfo txt file
if [ ! -d /usr/local/updateTool/updateToolTouchFiles ]; then
    mkdir -p /usr/local/updateTool/updateToolTouchFiles
    chmod ugo+rwx /usr/local/updateTool/updateToolTouchFiles
fi

policiesToCheck=$(defaults read /usr/local/updateTool/ApplicationUpdateControl.plist |awk -F= '/{/{print $1}'|grep -v "{"|sed 's/"//g')
while read -r line; do
    dueDateApple=$(defaults read /usr/local/updateTool/ApplicationUpdateControl.plist "$line"|awk -F= '/DueDate/{print $2}'|sed 's/;//'|sed 's/"//g'| sed -e 's/^[[:space:]]*//')
    dueDate=$(date -j -f "%Y-%m-%d %H:%M:%S %z" "$dueDateApple" +"%m-%d-%Y %H:%M")
    appPath=$(defaults read /usr/local/updateTool/ApplicationUpdateControl.plist "$line"|awk -F= '/Path/{print $2}' | sed 's/"//g'|sed 's/;//'|sed -e 's/^[[:space:]]*//')
    packageName=$(defaults read /usr/local/updateTool/ApplicationUpdateControl.plist "$line"|awk '/PackageName/{print $3}' | sed 's/;//')
    source=$(defaults read /usr/local/updateTool/ApplicationUpdateControl.plist "$line"|awk '/Source/{print $3}'|sed 's/;//')
    latestVer=$(defaults read /usr/local/updateTool/ApplicationUpdateControl.plist "$line"|awk '/LatestVersion/{print $3}'|sed 's/;//'|sed 's/"//g')
    minVers=$(defaults read /usr/local/updateTool/ApplicationUpdateControl.plist  "$line"|awk '/MinimumVersion/{print $3}'|sed 's/;//'|sed 's/"//g')
    sha256=$(defaults read /usr/local/updateTool/ApplicationUpdateControl.plist "$line"|awk '/sha256/{print $3}' | sed 's/"//g'|sed 's/;//'|sed -e 's/^[[:space:]]*//')
    doReboot=$(defaults read /usr/local/updateTool/ApplicationUpdateControl.plist "$line"|awk '/reboot/{print $3}'|sed 's/;//'|sed 's/"//g')
    update "$line" "$latestVer" "$packageName" "$dueDate" "$minVers" "$appPath" "$source" "$sha256" "$doReboot"
    
done <<< "$policiesToCheck"

# Check for Apple Software
checkAppleUpdates

#backup the File
cp /usr/local/updateTool/ApplicationUpdateControl.plist /usr/local/updateTool/ApplicationUpdateControl-holder.plist

#to show in GUI tool
defaults write /Library/Preferences/edu.mit.ll.updateTool.plist lastRefresh -string "$(date)"

#Cache needed updates
echo "Caching updates"
/usr/local/updateTool/cacher.sh
