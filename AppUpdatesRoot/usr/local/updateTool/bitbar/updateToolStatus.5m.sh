#!/bin/sh
#1490637179
#27 Mar 2017


#Is Darkmode on?  Bitbar only reads dark mode setting when first starting. Quit and relaunch if you change dark mode.
BitBarDarkMode=${BitBarDarkMode}
icon="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"

alertImgSM="iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAACXBIWXMAAAsTAAALEwEAmpwYAAABWWlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNS40LjAiPgogICA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxuczp0aWZmPSJodHRwOi8vbnMuYWRvYmUuY29tL3RpZmYvMS4wLyI+CiAgICAgICAgIDx0aWZmOk9yaWVudGF0aW9uPjE8L3RpZmY6T3JpZW50YXRpb24+CiAgICAgIDwvcmRmOkRlc2NyaXB0aW9uPgogICA8L3JkZjpSREY+CjwveDp4bXBtZXRhPgpMwidZAAACrUlEQVQ4Ea2UvU9UQRTFz7x94IqJ0cSogdjZwJoYo+FfgFgpxK/GxFYNpYUVClbaGS3xo0AwIv4HWpuI0ajUxmjEymhEhd29/u68NwssGyrvZt6bd+65Z+7cubPSFmbjytxtD9TnI85LbIuwzi57rEoUmNWQzep7OYYiVvo6RYZOoJlCCDK7p13q0TvyjNmpqc9a1qFwgQVKTnt83FI7qBdFdohd0TbEVvQ7Dp875pY4bcGbMvS6hXE1bUb9CnqlurYjUtgyrxxx09FwVouJu15zc4YDyLgFXVc3Ypn+kt2tOAJzx9znlrjxo8OjdRDTGuYQzOYYM5pKVJvWVMTcB8fxFJM4GzIMp9WwU9Qv10QkeK6mn4nM+0eZv8h8wrkes85f9JkD9hwZt1FdZFvHtMomje8u1SLujy7q6lidrVfhjOiSw61Y5rFeqQXsofZyqm8I2s+6DZao0CofyWtAu5ExvSfmILMGngrRX5E+HM7rW9IotpxaoFtXEXSxOuSMp2+5F7F9YHsYfQy3LHKcWyXGrdQIKGc0cdMe6Qi0l4jkiPnGRHZiAT/bQWZ/KMVbCuFyhZ/mhl2HNxjO6bVr5boGwS3oBjXKqZ3nEK8db5cM2qE7PJv43Ixf0VoG12NWiJWOu1ZRw1mdwDHPtWqAJDGLVZK+4LsMHgi8TWAvLM9wTbQH5qpOhjN6lnFfq7gnY70SCTbWoIU9n/thVPNhRE99HjH3rVkoaz3pWjk1GkOypl/AXpFk1IPa+RLD/HXdjTDziLmvyM/9GdnVKUuN+ViwJ/rAZz9jJTqToL+9WhU2LC2VsJ/2KrwkV8BGfXOOLNNiTsiCdiLot3TDvSkl/Fhy2sbN2yiLC8TP1qPoBrHLhWA3SfYA90MEeUadLOHtmSVugS/pk+YS9N/e/wDdZfMoqKXoGgAAAABJRU5ErkJggg=="

## if updates are running, then only show status for that update and exit
if [ -f /tmp/installStatus.txt ]; then
    cat /tmp/installStatus.txt
    exit
fi


################# MENU BAR #####   LOOK FOR ERRORS FOR MENU BAR Action ####
if [ -f /usr/local/updateTool/updateInfo.txt ]; then
    hazUpdatesPending=`cat /usr/local/updateTool/updateInfo.txt 2>/dev/null`
fi

##### HEADER, MENU BAR  ### If errors, show alert, otherwise show icon
if [ ! -z "$hazUpdatesPending" ]; then
    echo "|image=$icon dropdown=false"
    echo "|image=$alertImgSM dropdown=false"
else
    echo "|image=$icon dropdown=false"
fi

#################### END MENU BAR


##### SECURITY LEVEL
echo "---"
echo ":lock: Lock Screen |bash=/usr/local/updateTool/Scripts/StartSS.sh terminal=false"

######  LL APP UPDATES
echo "---"
if [ -f /tmp/holdLLAppUpdates ]; then
    echo "Updates are Disabled | image=$icon terminal=false color=red"
elif [ -s /usr/local/updateTool/updaterInfo.txt ]; then
    nowJules=`date +%s`
    echo "Updates Are Available|image=$icon bash=/usr/local/updateTool/openPopUP.sh terminal=false"
    while read oneLine; do
        dueDate=`echo $oneLine |awk -FdueDate:\" '{print $2}' | awk -F\" '{print $1}'`
        dueDateJules=`date -j -f "%m-%d-%Y %H:%M" "$dueDate" "+%s"`
        dateAge=`expr $nowJules - $dueDateJules`
        appName=`echo $oneLine |awk -FappName:\" '{print $2}' |awk -F\" '{print $1}'`
        if [ $dateAge -gt 0 ]; then
	    echo "$appName - Update is Overdue| bash=/usr/local/updateTool/openPopUP.sh terminal=false color=red"
	else
	    echo "$appName - Due: $dueDate| bash=/usr/local/updateTool/openPopUP.sh terminal=false"
        fi
    done </usr/local/updateTool/updaterInfo.txt
else
    echo "No Application Updates Available| image=$icon bash=/usr/local/updateTool/openPopUP.sh terminal=false"
fi

if [ -f /tmp/uptodateapps.txt ]; then
    echo ":white_check_mark: Up to date applications..."
    cat /tmp/uptodateapps.txt
fi

#########  Disk Space Warning
percentUsed=$(df -h|grep "/$"|awk '{print $5}'|sed s/%//g)
if [ $percentUsed -gt 92 ]; then
    echo "---"
    echo ":exclamation: Warning: Boot drive $percentUsed% full!|color=red"
elif [ $percentUsed -gt 80 ]; then
    echo "---"
    echo ":exclamation: Boot drive $percentUsed% full|color=$darklight"
fi
