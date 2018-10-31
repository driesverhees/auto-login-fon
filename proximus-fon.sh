#!/bin/sh

wget -qO- --output-document=blank_page.html --no-check-certificate --save-cookies=cookie --keep-session-cookies http://www.google.com/blank.html

if (cat blank_page.html | grep -q -i "proximus"); then
	POST_ACTION=$(cat blank_page.html | grep -i 'action="https://proximus' | cut -d \" -f 4)
	if [ -n "$POST_ACTION" ]; then
		wget -qO- --output-document=return.html --no-check-certificate --load-cookies=cookie --keep-session-cookies --post-data="UserName=YOUR_FON_ACCOUNT&Password=YOUR_FON_PASSWORD&rememberMe=true&_rememberMe=on&login=Login" $POST_ACTION
		if (cat return.html | grep -q -i "success"); then
			logger "FON-network: Login successfull"
		else
			logger "FON-network: Login failed"
		fi
		rm return.html
	else
		logger "FON-network: Unable to get post url"

	fi
fi
rm cookie blank_page.html