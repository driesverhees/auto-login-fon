#!/bin/sh
# Username and password of the FON account (url encoded!)
FON_USERNAME='xxxxxxxx'
FON_PASSWORD='xxxxxxxx'
wget -qO- --no-check-certificate --output-document=blank_page.html http://www.google.com/blank.html
if (cat blank_page.html | grep -q -i "proximus"); then
	POST_ACTION=$(cat blank_page.html | grep -i 'action="https://proximus' | cut -d \" -f 4)
	if [ -n "$POST_ACTION" ]; then
		# Replace encoded &amp; in the URL by &
		CLEANED_POST_ACTION=$(echo $POST_ACTION | sed 's/\b\&amp;\b/\&/g')
		# Send POST request		
		wget -qO- --no-check-certificate --output-document=return.html --post-data="UserName=$FON_USERNAME&Password=$FON_PASSWORD&chooseUser=passuser&rememberMe=true&_rememberMe=on&login=Login&language=en_GB" "$CLEANED_POST_ACTION"
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
rm blank_page.html
