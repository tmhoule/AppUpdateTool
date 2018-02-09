#!/bin/sh
#Todd
#22Sept2017
#To cache download installers

CheckForNetwork(){
# Determine if the network is up by looking for any non-loopback network interfaces. 
    local test

    if [[ -z "${NETWORKUP:=}" ]]; then
        test=$(ifconfig -a inet 2>/dev/null | sed -n -e '/127.0.0.1/d' -e '/0.0.0.0/d' -e '/inet/p' | wc -l)
        if [[ "${test}" -gt 0 ]]; then
            NETWORKUP="-YES-"
        else
            NETWORKUP="-NO-"
        fi
    fi
}

writeToLog(){
    logger "LLUpdate: $1"
}


###########

#check perms on files

rm /usr/local/updateTool/updaterinfo.txt
touch /usr/local/updateTool/updaterinfo.txt

policiesToCheck=$(defaults read /usr/local/updateTool/ApplicationUpdateControl.plist |awk -F= '/{/{print $1}'|grep -v "{"|sed 's/"//g')
shopt -s nocasematch #ignore case in IF statements
while read -r line; do
    source=$(/usr/libexec/PlistBuddy -c "Print :\"$line:Source\"" /usr/local/updateTool/ApplicationUpdateControl.plist)
    
    if [ "$source" == "Apple" ]; then
	/usr/sbin/softwareupdate -d "$line" >/dev/null 2>&1
	if [ $? -eq 0 ]; then  #if last line completed successfully
	    dueDateLong=$(/usr/libexec/PlistBuddy -c "print :\"$line:DueDate\"" /usr/local/updateTool/ApplicationUpdateControl.plist)
	    dueDate=$(date -j -f "%a %b %d %H:%M:%S %Z %Y" "$dueDateLong" +"%m-%d-%Y %H:%M")
	    rebootStatus=$(/usr/libexec/PlistBuddy -c "print :\"$line:Reboot\"" /usr/local/updateTool/ApplicationUpdateControl.plist)
	    vers=$(/usr/libexec/PlistBuddy -c "print :\"$line:LatestVersion\"" /usr/local/updateTool/ApplicationUpdateControl.plist)
	    echo "{source:\"Apple\",appName:\"$line\",appVersion:\"$vers\",jssPolicy:\"$line\",dueDate:\"$dueDate\",appInstallChk:true,reboot:$rebootStatus}" >> /usr/local/updateTool/updaterinfo.txt
	fi
    elif [[ "$source" == "http"* ]]; then
        pkgName=$(/usr/libexec/PlistBuddy -c "Print :\"$line:PackageName\"" /usr/local/updateTool/ApplicationUpdateControl.plist)
        thisSha=$(shasum -a 256 /usr/local/updateTool/cache/$pkgName | awk '{print $1}')
        shaPkg=$(/usr/libexec/PlistBuddy -c "Print :\"$line:sha256\"" /usr/local/updateTool/ApplicationUpdateControl.plist)
        if [ "$thisSha" != "$shaPkg" ]; then
            echo "INVALID SHA. Downloading..."
            rm /usr/local/updateTool/cache/$pkgName >/dev/null 2>&1
	    curl -o /usr/local/updateTool/cache/downloading/$pkgName $source/$pkgName
            thisSha=$(shasum -a 256 /usr/local/updateTool/cache/downloading/$pkgName | awk '{print $1}')
	    if [ "$thisSha" != "$shaPkg" ]; then
		echo "LLUpdate: Error downloading $pkgName from $source. Will try again later."
		continue
	    else
		mv /usr/local/updateTool/cache/downloading/$pkgName /usr/local/updateTool/cache/$pkgName
	    fi	
	fi
        dueDateLong=$(/usr/libexec/PlistBuddy -c "print :\"$line:DueDate\"" /usr/local/updateTool/ApplicationUpdateControl.plist)
        dueDate=$(date -j -f "%a %b %d %H:%M:%S %Z %Y" "$dueDateLong" +"%m-%d-%Y %H:%M")
        rebootStatus=$(/usr/libexec/PlistBuddy -c "print :\"$line:Reboot\"" /usr/local/updateTool/ApplicationUpdateControl.plist)
        vers=$(/usr/libexec/PlistBuddy -c "print :\"$line:LatestVersion\"" /usr/local/updateTool/ApplicationUpdateControl.plist)
        echo "{source:\"JSS\",appName:\"$line\",appVersion:$vers,jssPolicy:\"$line\",dueDate:\"$dueDate\",appInstallChk:true,reboot:$rebootStatus}"  >> /usr/local/updateTool/updaterinfo.txt
    fi
    
    unset pkgName
    unset shaPkg
    unset isDownloaded
done <<< "$policiesToCheck"


bitBarPath=$(defaults read /Library/Preferences/com.matryer.BitBar.plist pluginsDirectory)
bitBarApp=$(/usr/bin/mdfind "kind:applications" bitbar|head -1)
if [ -f $bitBarApp/Contents/MacOS/BitBar ] && [ -d $bitBarPath ]; then
    open -g bitbar://refreshPlugin?name=*
    if [ $? -ne 0 ]; then
	killall BitBar
	open -g bitbar://refreshPlugin?name=*
    fi    
fi


