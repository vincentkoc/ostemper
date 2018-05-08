#!/bin/bash
#
# Copyright (c) 2018 Vincent Koc
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Boilerplate header
# Colors from https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
echo -e
echo -e "\033[0;33m############################################################"
echo -e "  OS Temper :: Automatic OS Hardening and Tweaks"
echo -e "############################################################\033[0m"
echo -e


# Disable if not running as sudo
if [[ $UID -ne 0 ]]; then
	echo -e "[\033[31m!\033[m] This script needs to be run as root (with sudo).."
	exit 1
fi


# Validate login
sudo -v
echo -e "[\033[32m+\033[m] Login validated as sudo/root"

# Validate preference files
echo -e "[\033[33m?\033[m] Resetting file permissions for users pref files before starting"
chmod 755 ~/Library/Preferences/ >/dev/null

# System and user information for logging
echo -e
echo -e
echo -e ":::"
echo -e "::: Current machine and user information"
echo -e ":::"
	echo -e "\t|- [\033[33m?\033[m] Current User: $(id -u -n)"
	echo -e "\t|- [\033[33m?\033[m] Current Hostname: $(hostname)"
	echo -e "\t\- [\033[33m?\033[m] Kernel and Timestamp: $(uname -v)"

# Starting system tweaks
echo -e
echo -e
echo -e ":::"
echo -e "::: Starting System and Developer Tweaks"
echo -e ":::"

	echo -e "\t|- [\033[32m+\033[m] System tweaks / Disabled boot up 'ding' sound"
	sudo nvram SystemAudioVolume=" " >/dev/null

	# Set the timezone; see `sudo systemsetup -listtimezones` for other values
	#sudo systemsetup -settimezone "Australia/Sydney" > /dev/null

	echo -e "\t|- [\033[32m+\033[m] System tweaks / Finder expanding save panel by default"
	defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
	defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

	echo -e "\t|- [\033[32m+\033[m] System tweaks / Use current folder for search default"
	defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

	echo -e "\t|- [\033[32m+\033[m] System tweaks / Show status bar in Finder and Indicators in dock"
	defaults write com.apple.finder ShowStatusBar -bool true
	defaults write com.apple.dock show-process-indicators -bool true

	echo -e "\t|- [\033[32m+\033[m] System tweaks / Disable smart quotes when typing"
	defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

	echo -e "\t|- [\033[32m+\033[m] System tweaks / Disable smart dashes when typing"
	defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

	echo -e "\t|- [\033[32m+\033[m] System tweaks / Disable automatic period substitution when typing"
	defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

	echo -e "\t|- [\033[32m+\033[m] System tweaks / Disable automatic capitalisation when typing"
	defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

	echo -e "\t|- [\033[32m+\033[m] System tweaks / Disable auto-correct"
	defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

	echo -e "\t|- [\033[32m+\033[m] System tweaks / Automatically hide and show the dock"
	defaults write com.apple.dock autohide -bool true

	echo -e "\t|- [\033[32m+\033[m] System tweaks / Disable screenshot shadows"
	defaults write com.apple.screencapture disable-shadow -bool true
	defaults write com.apple.screencapture name "Screenshot"

	echo -e "\t|- [\033[32m+\033[m] System tweaks / Disable DS_Store files on non physical volumes "
	defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
	defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

	echo -e "\t|- [\033[32m+\033[m] System tweaks / Improving Bluetooth audio quality"
	#defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40
	defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Max (editable)" 80
	defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" 40
	defaults write com.apple.BluetoothAudioAgent "Apple Initial Bitpool (editable)" 80
	defaults write com.apple.BluetoothAudioAgent "Apple Initial Bitpool Min (editable)" 80
	defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool" 80
	defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool Max" 80
	defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool Min" 80

	echo -e "\t|- [\033[32m+\033[m] System tweaks / Stop 'Photos' app from opening automatically"
	defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
	
	echo -e "\t|- [\033[32m+\033[m] System tweaks / Enable text selection in 'Quick Look'"
	defaults write com.apple.finder QLEnableTextSelection -bool true

	echo -e "\t|- [\033[32m+\033[m] System tweaks / Disable natural scrolling for trackpad and mouse"
	defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

	echo -e "\t|- [\033[32m+\033[m] System tweaks / Enabling snap-to-grid for icons in Finder"
	/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist >/dev/null 2>/dev/null
	/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist >/dev/null 2>/dev/null
	/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist >/dev/null 2>/dev/null

	echo -e "\t|- [\033[32m+\033[m] System tweaks / Close 'Printer' app when printing jobs finish"
	defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

	echo -e "\t|- [\033[32m+\033[m] System tweaks / Show language menu in the top right corner of the boot screen"
	sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true

	echo -e "\t|- [\033[32m+\033[m] System tweaks / Hide time machine popups"
	defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

	echo -e "\t\- [\033[32m+\033[m] System tweaks / Enable iOS charing chime when plugged into magsafe"
	defaults write com.apple.PowerChime ChimeOnAllHardware -bool true && \
	open /System/Library/CoreServices/PowerChime.app

	#echo -e "[\033[32m+\033[m] System tweaks / Reduce transparency in Finder"
	#defaults write com.apple.universalaccess reduceTransparency -bool true

# Starting system tweaks
echo -e
echo -e
echo -e ":::"
echo -e "::: Starting Developer Tweaks"
echo -e ":::"

	echo -e "\t|- [\033[32m+\033[m] Developer tweaks / Show all file extensions"
	defaults write NSGlobalDomain AppleShowAllExtensions -bool true

	echo -e "\t|- [\033[32m+\033[m] Developer tweaks / Fix terminal follow focus mouse"
	defaults write com.apple.terminal FocusFollowsMouse -string YES
	defaults write org.x.X11 wm_ffm -bool true

	echo -e "\t|- [\033[32m+\033[m] Developer tweaks / Default plain-text for 'Richtext' app"
	defaults write com.apple.TextEdit RichText -int 0

	echo -e "\t\- [\033[32m+\033[m] Developer tweaks / Enable safari developer and web inspector"
	defaults write com.apple.safari IncludeDevelopMenu -int 1
	defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
	defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
	defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
	defaults write com.apple.safari ShowOverlayStatusBar -int 1
	defaults write com.apple.safari ShowFullURLInSmartSearchField -int 1


# Starting intial security tweaks
echo -e
echo -e
echo -e ":::"
echo -e "::: Starting Security Tweaks - Inital"
echo -e ":::"

	echo -e "\t|- [\033[32m+\033[m] Security tweaks / Time machine dose not require AC power (magsafe)"
	defaults write /Library/Preferences/com.apple.TimeMachine RequiresACPower -bool false


	echo -e "\t|- [\033[32m+\033[m] Security tweaks / Enabling scheduled updates"
	softwareupdate --schedule on >/dev/null
	defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticCheckEnabled -bool true
	defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticDownload -bool true
	defaults write /Library/Preferences/com.apple.commerce.plist AutoUpdateRestartRequired -bool true
	defaults write /Library/Preferences/com.apple.commerce.plist AutoUpdate -bool true

	echo -e "\t|- [\033[32m+\033[m] Security tweaks / Check for App Updates daily, not just once a week"
	defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

	echo -e "\t|- [\033[32m+\033[m] Security tweaks / Disable IPV6 on Wi-fi and Ethernet adapters"
	#TODO: Scan all adapters and replicate
	networksetup -setv6off Wi-Fi >/dev/null
	networksetup -setv6off Ethernet >/dev/null

	echo -e "\t|- [\033[32m+\033[m] Security tweaks / Disable infared"
	defaults write /Library/Preferences/com.apple.driver.AppleIRController DeviceEnabled -int 0

	echo -e "\t|- [\033[32m+\033[m] Security tweaks / Disable guest login access"
	defaults write /Library/Preferences/com.apple.AppleFileServer guestAccess -bool NO
	defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server AllowGuestAccess -bool NO

	echo -e "\t|- [\033[32m+\033[m] Security tweaks / Disable SSH access"
	launchctl unload -w /System/Library/LaunchDaemons/ssh.plist >/dev/null 2>/dev/null

	echo -e "\t|- [\033[32m+\033[m] Security tweaks / Enable gatekeeper"
	spctl --master-enable >/dev/null

	echo -e "\t\- [\033[32m+\033[m] Security tweaks / Enable filevault"
	#TODO: Check fdesetup
	echo -e "\t\- [\033[33m?\033[m] ...You may be asked for login again, please keep recovery key safe"
	echo -e
	fdesetup enable
	echo -e

# Starting intial security tweaks
echo -e
echo -e
echo -e ":::"
echo -e "::: Starting Security Tweaks - Privacy"
echo -e ":::"

	echo -e "\t|- [\033[32m+\033[m] Security tweaks / Send 'Do Not Track' header in Safari"
	defaults write com.apple.safari SendDoNotTrackHTTPHeader -int 1

	echo -e "\t|- [\033[32m+\033[m] Security tweaks / Disable potential DNS leaks"
	defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool YES

	echo -e "\t|- [\033[32m+\033[m] Security tweaks / Disable Apple remote events"
	systemsetup -setremoteappleevents off >/dev/null 2>/dev/null

	echo -e "\t|- [\033[32m+\033[m] Security tweaks / Disable Apple remote agent and remove access"
	/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -deactivate -configure -access -off >/dev/null 2>/dev/null
	
	echo -e "\t|- [\033[32m+\033[m] Security tweaks / Disable crash reporting"
	defaults write com.apple.CrashReporter DialogType none

	echo -e "\t|- [\033[32m+\033[m] Security tweaks / New documents disable auto-save to iCloud"
	defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

	echo -e "\t\- [\033[32m+\033[m] Security tweaks / Disable search data leaking in safari"
	defaults write com.apple.Safari UniversalSearchEnabled -bool false
	defaults write com.apple.Safari SuppressSearchSuggestions -bool true
	defaults write com.apple.Safari.plist WebsiteSpecificSearchEnabled -bool NO

# Starting intial security tweaks
echo -e
echo -e
echo -e ":::"
echo -e "::: Starting Security Tweaks - Calling Home"
echo -e ":::"

	# NEED TO ADD "System Integrity Protection" checks

	DAEMONS=()
	DAEMONS+=('com.apple.netbiosd') #Netbiosd is microsoft's networking service. used to share files between mac and windows
	#DAEMONS+=('com.apple.preferences.timezone.admintool') #Time setting daemon
	#DAEMONS+=('com.apple.preferences.timezone.auto') #Time setting daemon
	#DAEMONS+=('com.apple.remotepairtool') #Pairing devices remotely
	#DAEMONS+=('com.apple.rpmuxd') #daemon for remote debugging of mobile devices.
	#DAEMONS+=('com.apple.security.FDERecoveryAgent') #Full Disk Ecnryption - Related to File Vault https://developer.apple.com/legacy/library/documentation/Darwin/Reference/ManPages/man8/FDERecoveryAgent.8.html
	#DAEMONS+=('com.apple.icloud.findmydeviced') #Related to find my mac
	#DAEMONS+=('com.apple.findmymacmessenger') #Related to find my mac daemon, propably act on commands sent through FindMyDevice in iCloud
	DAEMONS+=('com.apple.familycontrols') #Parent control
	#DAEMONS+=('com.apple.findmymac') #Find my mac daemon
	#DAEMONS+=('com.apple.AirPlayXPCHelper') #Airplay daemon
	DAEMONS+=('com.apple.SubmitDiagInfo') #Feedback - most likely it submits your computer data when click 'About this mac'
	DAEMONS+=('com.apple.screensharing') #Screensharing daemon
	DAEMONS+=('com.apple.appleseed.fbahelperd') #Related to feedback
	#DAEMONS+=('com.apple.apsd') #Apple Push Notification Service (apsd) - it's calling home quite often + used by Facetime and Messages
	DAEMONS+=('com.apple.AOSNotificationOSX') #Notifications
	#DAEMONS+=('com.apple.FileSyncAgent.sshd') #Mostlikely sshd on this machine
	#DAEMONS+=('com.apple.ManagedClient.cloudconfigurationd') #Related to manage current macOS user iCloud
	#DAEMONS+=('com.apple.ManagedClient.enroll') #Related to manage current macOS user
	#DAEMONS+=('com.apple.ManagedClient') #Related to manage current macOS user
	#DAEMONS+=('com.apple.ManagedClient.startup') #Related to manage current macOS user
	#DAEMONS+=('com.apple.iCloudStats') #Related to iCloud
	#DAEMONS+=('com.apple.locationd') #Propably reading current location
	#DAEMONS+=('com.apple.mbicloudsetupd') #iCloud Settings
	#DAEMONS+=('com.apple.laterscheduler') #Schedule something?
	DAEMONS+=('com.apple.awacsd') #Apple Wide Area Connectivity Service daemon - Back to My Mac Feature
	#DAEMONS+=('com.apple.eapolcfg_auth') #perform privileged operations required by certain EAPOLClientConfiguration.h APIs
	DAEMONS+=('com.apple.awdd') #Sending out diagnostics & usage
	DAEMONS+=('com.apple.CrashReporterSupportHelper') #Crash reporter
	#DAEMONS+=('com.apple.trustd') #Propably related to certificates

	AGENTS=()
	#AGENTS+=('com.apple.photoanalysisd') #Apple AI to analyse photos stored in Photos.app, most likely to match faces and scenery but it happens to make requests to Apple during process, i have not checked what are those requestes i have just blocked it with Little Snitch
	#AGENTS+=('com.apple.telephonyutilities.callservicesd') #Handling phone and facetime calls
	#AGENTS+=('com.apple.AirPlayUIAgent') #Related Airport
	#AGENTS+=('com.apple.AirPortBaseStationAgent') #Related Airport
	#AGENTS+=('com.apple.CalendarAgent') #Calendar events related to iCloud
	#AGENTS+=('com.apple.iCloudUserNotifications') #iCloud notifications, like reminders
	AGENTS+=('com.apple.familycircled') #Family notifications, like reminders
	AGENTS+=('com.apple.familycontrols.useragent') #Family notifications, like reminders
	AGENTS+=('com.apple.familynotificationd') #Family notifications, like reminders
	AGENTS+=('com.apple.gamed') #GameCenter
	#AGENTS+=('com.apple.icloud.findmydeviced.findmydevice-user-agent') #Find my device ?
	#AGENTS+=('com.apple.icloud.fmfd') #Find my device ?
	#AGENTS+=('com.apple.imagent') #Facetime & Messages
	AGENTS+=('com.apple.cloudfamilyrestrictionsd-mac') #iCloud Family restrictions
	###AGENTS+=('com.apple.cloudpaird') #Related to iCloud
	AGENTS+=('com.apple.cloudphotosd') #Propably syncing your photos to icloud
	AGENTS+=('com.apple.DictationIM') #Dictation
	AGENTS+=('com.apple.assistant_service') #Siri
	#AGENTS+=('com.apple.CallHistorySyncHelper') #Related to call history syncing (iCloud)
	#AGENTS+=('com.apple.CallHistoryPluginHelper') #Related to call history (iCloud)
	#AGENTS+=('com.apple.AOSPushRelay') # Related to iCloud https://github.com/fix-macosx/yosemite-phone-home/blob/master/icloud-user-r0/System/Library/PrivateFrameworks/AOSKit.framework/Versions/A/Helpers/AOSPushRelay.app/Contents/MacOS/AOSPushRelay/20141019T072634Z-auser-%5B172.16.174.146%5D:49560-%5B17.110.240.83%5D:443.log
	#AGENTS+=('com.apple.IMLoggingAgent') #IMFoundation.framework - Not sure about this one, maybe used to log in to computer on start
	#AGENTS+=('com.apple.geodMachServiceBridge') #Located in GeoServices.framework, related to locations maybe used for maps, maybe as well for things like find my mac, or just syping
	#AGENTS+=('com.apple.syncdefaultsd') ##Propably related to syncing keychain
	#AGENTS+=('com.apple.security.cloudkeychainproxy3') #Propably related to syncing keychain to icloud 
	#AGENTS+=('com.apple.security.idskeychainsyncingproxy') #Most likely also related to keychain - IDSKeychainSyncingProxy.bundle
	#AGENTS+=('com.apple.security.keychain-circle-notification') #Related to keychain
	#AGENTS+=('com.apple.sharingd') #Airdrop, Remote Disks, Shared Directories, Handoff
	AGENTS+=('com.apple.appleseed.seedusaged') #Feedback assistant
	#AGENTS+=('com.apple.cloudd') #Related to sync data to iCloud, most likely used by iMessage,Mail,iCloud drive, etc...
	#AGENTS+=('com.apple.assistant') #Keychain
	AGENTS+=('com.apple.parentalcontrols.check') #Related to parental control
	AGENTS+=('com.apple.parsecd') #Used by spotlight and/or siri, propably some suggestions - CoreParsec.framework
	#AGENTS+=('com.apple.identityservicesd') #Used to auth some apps, as well used by iCloud
	#AGENTS+=('com.apple.bird') #Part of iCloud
	AGENTS+=('com.apple.rtcreportingd') #Related to Home Sharing, most likely it checks if device is auth for home sharing + Facetime
	AGENTS+=('com.apple.SafariCloudHistoryPushAgent') #Good one, sending out your browsing history... :)
	AGENTS+=('com.apple.safaridavclient') #Sending bookmarks to iCloud, even if you disable it may send your bookmarks to Apple
	AGENTS+=('com.apple.SafariNotificationAgent') #Notifications in Safari

	for agent in "${AGENTS[@]}"
	do
		sudo launchctl unload -w /System/Library/LaunchAgents/${agent}.plist >/dev/null 2>/dev/null
		#launchctl unload -w /System/Library/LaunchAgents/${agent}.plist >/dev/null 2>/dev/null
		echo -e "\t\- [\033[32m+\033[m] Disabled Agent: (${agent})"
	done

	for daemon in "${DAEMONS[@]}"
	do
		sudo launchctl unload -w /System/Library/LaunchDaemons/${daemon}.plist >/dev/null 2>/dev/null
		#launchctl unload -w /System/Library/LaunchDaemons/${daemon}.plist >/dev/null 2>/dev/null
		echo -e "\t\- [\033[32m+\033[m] Disabled Daemon: (${daemon})"
	done


