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

echo ""
echo "**********"
echo "*"
echo "* Auto Hardening for Apple OS X"
echo "*"
echo "**********"
echo ""
echo ":: Starting Hardening... Please give me your password to get to work"
  sudo -v

echo ""
echo ""
echo "> Setting Password for Root Account"
  sudo passwd -u root

echo ""
echo ""
echo "> Setting up system fixes and running Apple Updates"
  # Disable the boot up "ding" sound
  sudo nvram SystemAudioVolume=" "

  # Set the timezone; see `sudo systemsetup -listtimezones` for other values
  sudo systemsetup -settimezone "Australia/Sydney" > /dev/null

  # Expand save panel by default
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

  # Use current folder for search default
  defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

  # Show Status bar in Finder and Indicators in dock
  defaults write com.apple.finder ShowStatusBar -bool true
  defaults write com.apple.dock show-process-indicators -bool true

  # Disable smart quotes as they're annoying when typing code
  defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
  # Disable smart dashes as they're annoying when typing code
  defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

  # Disable automatic period substitution as it’s annoying when typing code
  defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

  # Disable auto-correct
  defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

  # Disable automatic capitalization as it’s annoying when typing code
  defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

  # Automatically hide and show the Dock
  defaults write com.apple.dock autohide -bool true

  # Screeshot
  defaults write com.apple.screencapture disable-shadow -bool true
  defaults write com.apple.screencapture name "Screenshot"

  # Show Filenames
  sudo defaults write NSGlobalDomain AppleShowAllExtensions -bool true

  # Stop DS_Stores
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
  defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

  # Safari Clean-up / Enabling the Develop menu and the Web Inspector in Safari
  defaults write com.apple.safari IncludeDevelopMenu -int 1
  defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
  defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
  defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
  defaults write com.apple.safari ShowOverlayStatusBar -int 1
  defaults write com.apple.safari ShowFullURLInSmartSearchField -int 1
  defaults write com.apple.safari SendDoNotTrackHTTPHeader -int 1

  # Fix Textedit
  defaults write com.apple.TextEdit RichText -int 0

  # Fix Terminal
  defaults write com.apple.terminal FocusFollowsMouse -string YES
  defaults write org.x.X11 wm_ffm -bool true 

  softwareupdate --schedule on
  defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticCheckEnabled -bool true
  defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticDownload -bool true
  defaults write /Library/Preferences/com.apple.commerce.plist AutoUpdateRestartRequired -bool true
  defaults write /Library/Preferences/com.apple.commerce.plist AutoUpdate -bool true


  # Check for App Updates daily, not just once a week
  defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

  # Increase Bluetooth Audio Quality
  #defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40
  defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Max (editable)" 80
  defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" 40
  defaults write com.apple.BluetoothAudioAgent "Apple Initial Bitpool (editable)" 80
  defaults write com.apple.BluetoothAudioAgent "Apple Initial Bitpool Min (editable)" 80
  defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool" 80
  defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool Max" 80
  defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool Min" 80

  # stop Photos from opening automatically
  defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

  # Show language menu in the top right corner of the boot screen
  sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true

  # Enabling Text Selection in Quick Look
  defaults write com.apple.finder QLEnableTextSelection -bool true

  # Disable “natural” scrolling
  defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

  # Enabling snap-to-grid for icons on the desktop and in other icon views
  /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
  /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
  /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

  # update apps from Mac AppStore
  #sudo softwareupdate --list --verbose
  sudo softwareupdate --install --all --verbose


echo ""
echo ""
echo "> Disabling Apple Agents"
  ./homecall.sh fixmacos

echo ""
echo ""
echo "> Improve Speed"
  # Reduce Transparency
  defaults write com.apple.universalaccess reduceTransparency -bool true


echo ""
echo ""
echo "> Disabling Guest Access and Other Network Security and Timemachine Hardening"
  # Disable Guest
  sudo defaults write /Library/Preferences/com.apple.AppleFileServer guestAccess -bool NO
  sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server AllowGuestAccess -bool NO

  # Kill IPV6 and DNS Leaks
  sudo defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool YES
  networksetup -setv6off Wi-Fi >/dev/null
  networksetup -setv6off Ethernet >/dev/null
  
  # Stop Timemachine Popups
  defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

  # Time Machine Dose Not Require Power
  sudo defaults write /Library/Preferences/com.apple.TimeMachine RequiresACPower -bool false

  # Disable remote login
  sudo launchctl unload -w /System/Library/LaunchDaemons/ssh.plist

  # Quit Printer App after Jobs Finished
  defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

  # Enable App Firewall
  sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate

  # Ensure Gatekeeper is Enabled
  sudo spctl --master-enable

  # Ensure Filevault is Enabled
  sudo fdesetup enable

  # Disable Remote Apple Events
  sudo systemsetup -setremoteappleevents off

  # Enable Play iOS charging sound when MagSafe is connected.
  defaults write com.apple.PowerChime ChimeOnAllHardware -bool true && \
  open /System/Library/CoreServices/PowerChime.app


  # Disable Infared
  defaults write /Library/Preferences/com.apple.driver.AppleIRController DeviceEnabled -int 0

  # Disable Crash reporting
  defaults write com.apple.CrashReporter DialogType none

  # Disable default to iCloud for files
  defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

  # Privacy: don’t send search queries to Apple
  defaults write com.apple.Safari UniversalSearchEnabled -bool false
  defaults write com.apple.Safari SuppressSearchSuggestions -bool true

echo ""
echo ""
echo "> Disabling Apple Remote Desktop and Removing"
  # Deactivate and Stop the Remote Management Service
  sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -deactivate -stop 

  # Disable ARD Agent and Remove Access Privileges for All Users
  sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -deactivate -configure -access -off

  # Remove ARD
  sudo rm -rf /var/db/RemoteManagement ; \
  sudo defaults delete /Library/Preferences/com.apple.RemoteDesktop.plist ; \
  defaults delete ~/Library/Preferences/com.apple.RemoteDesktop.plist ; \
  sudo rm -r /Library/Application\ Support/Apple/Remote\ Desktop/ ; \
  rm -r ~/Library/Application\ Support/Remote\ Desktop/ ; \
  rm -r ~/Library/Containers/com.apple.RemoteDesktop


echo ""
echo ""
echo "> Utility: Installing Homebrew, Updating then Key System Apps"
  is brew || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile
  echo 'export PATH="/usr/local/sbin:$PATH"' >> ~/.bash_profile
  echo 'export HOMEBREW_NO_ANALYTICS=1"' >> ~/.bash_profile
  echo 'export HOMEBREW_NO_GITHUB_API=1"' >> ~/.bash_profile
  echo 'export HOMEBREW_NO_INSECURE_REDIRECT=1"' >> ~/.bash_profile

  brew doctor
  brew -v update
  brew upgrade
  brew cleanup
  brew analytics off

  brew install wget
  brew install findutils
  brew tap homebrew/dupes
  brew tap homebrew/services
  brew install homebrew/dupes/grep

  printf 'export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"' >> ~/.zshrc
  export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"


echo ""
echo ""
echo "> Updating: Installing and Configuring Git and OpenSSL"
  brew install git
  git --version

  # These scripts will initial setup global config of git
  # And then set osxkeychain for Github login (but will not login yet)
  # And then set SSH key for Gitlab account (will open your default browser)
  git config --global color.ui true
  git config --global credential.helper osxkeychain
  git config --global core.excludesfile '~/.gitignore'
  echo '.DS_Store' >> ~/.gitignore

  # OpenSSL linking
  brew install openssl
  brew link openssl --force

echo ""
echo ""
echo "> Updating: Setting up Homebrew Casks"
  brew tap caskroom/cask
  brew tap caskroom/versions
  brew tap homebrew/dupes

echo ""
echo ""
echo "> Installing: Fonts"
  brew tap caskroom/fonts

  fonts=(
    font-m-plus
    font-clear-sans
    font-roboto
    font-open-sans
    font-source-sans-pro
    font-lato
    font-alegreya
    font-montserrat
    font-inconsolata
    font-pt-sans
    font-quattrocento-sans
    font-quicksand
    font-raleway
    font-sorts-mill-goudy
    font-ubuntu
  )

  # install fonts
  brew cask install ${fonts[@]}

echo ""
echo ""
echo "> Installing: Key Applications"
  #brew cask install google-chrome
  #brew cask install sublime-text
  #brew cask install adobe-air
  brew cask install ccleaner
  brew cask install caffeine
  brew cask install vlc
  #brew cask install the-unarchiver

echo ""
echo ""
echo "> Cleaning: Update and Clean all Installs"
  brew tap buo/cask-upgrade
  brew cu --all --yes
  read -p "update apps from Mac AppStore now? [Y|n] " input_macapp
  if [[ $input_macapp =~ ^(Y|y|Yes|yes) ]]; then
    sudo softwareupdate -i -a -v
  else
    echo "Skipped update from Mac App Store"
  fi


echo ""
echo ""
echo "> Reloading System After Changes"
  brew doctor
  brew cleanup
  brew cask cleanup

  rm -f -r /Library/Caches/Homebrew/*
  
  killall SystemUIServer
  killall Dock
  killall Finder

echo ""
echo ""
echo "> Utility: Installing Xcode Commandline Tools"
  if [ "$(checkFor pkgutil --pkg-info=com.apple.pkg.CLTools_Executables)" ]; then
    xcode-select --install
    sleep 1
    osascript -e 'tell application "System Events"' -e 'tell process "Install Command Line Developer Tools"' -e 'keystroke return' -e 'click button "Agree" of window "License Agreement"' -e 'end tell' -e 'end tell'
  fi
  sudo xcodebuild -license accept


echo ""
echo ""
echo "> Utility: Installing Quartz"
  curl http://xquartz-dl.macosforge.org/SL/XQuartz-2.7.7.dmg -o /tmp/XQuartz.dmg
  open /tmp/XQuartz.dmg
  sudo installer -package /Volumes/XQuartz-2.7.7/XQuartz.pkg -target /
  hdiutil detach /Volumes/XQuartz-2.7.7