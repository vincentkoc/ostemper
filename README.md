# OS Temper

![](docs/logo.png)

[![Build Status](https://travis-ci.org/koconder/ostemper.svg?branch=master)](https://travis-ci.org/koconder/ostemper) [![Donate BTC](https://img.shields.io/badge/donate-BTC-orange.svg)](https://github.com/koconder/ostemper#contributing-and-donations) [![Donate ETH](https://img.shields.io/badge/donate-ETH-orange.svg)](https://etherdonation.com/d?to=0xe6fbd8de8157934767867022b7a8e8691d8df3dc)

This script is an "all-in-one" solution for a large number of security fixes, recommended tweaks and first time setup for Mac OS X operating system. This has only been tested for OSX version 10.13.x

## Requirements and Running
### Platform
- `mac_os_x`

### OS Versions Supported
- `10.13.x`

### Running OS Temper
- `ostemper.sh` - You would need to download the ostemper.sh file into your target machine. From there in terminal you need to enable the file for execution using: `chmod +x ostemper.sh`
-  Then launch ostemper using `./ostemper.sh`

## Install and Run
### Easy Install Method
For quick setup and running based on the default configuration as per the current release in Github. If you would like to modify please feel free to fork and make any changes as needed. Open Terminal app and run:

    bash -c "$(curl -fsSL https://raw.githubusercontent.com/koconder/ostemper/master/ostemper.sh)"


### Git Pull
If you have pulled the script down using Git, you have two features avalible for use, first is the out of the box automated hardening and installation, the other is automatic system-wide updates and cleaning.

**Auto-Harden**

    ./ostemper.sh

**Auto-Update**

    ./ostemper-update.sh

## Features and Functionality
### Security
- Disabling a number of potentially insecure services
- Enabling firewalls and other essential security fixes
- Disabling crash reports and analytics collection where possible
- Enabling automatic updates
- Other privacy tweaks

### Development
- Installing Xcode and Git
- Installing Homebrew
- Installing a number of commonly used fonts
- Common Bash and Terminal tweaks

### Updates and Installs
- Running all required system updates
- Updating SSH configuration
- Common apps installed

### Tweaks
- Finder tweaks

## References and Sources
OS Temper is built upon the works and ideas from other scripts and community discussions, you can find a list of the sources below.

*Automated Installs:*
- [github.com/Edditoria/dotfiles](https://github.com/Edditoria/dotfiles)
- [github.com/caskroom/homebrew-cask](https://github.com/caskroom/homebrew-cask)
- [github.com/pablopunk/mac-fresh-install
](https://github.com/pablopunk/mac-fresh-install)

*System and Security Tweaks:*
- [github.com/nicolinuxfr/macOS-post-installation](https://github.com/nicolinuxfr/macOS-post-installation)
- [github.com/andrewparadi/.files](https://github.com/andrewparadi/.files)
- [github.com/karek314/macOS-home-call-drop](https://github.com/karek314/macOS-home-call-drop)
- [cipherli.st](https://cipherli.st/)
- [gov.uk](https://www.gov.uk/government/uploads/system/uploads/attachment_data/file/470580/osx-provisioning-script.sh.txt)

*Developer Friendly Tweaks:*
- [github.com/kiriaze/mac-dev-env](https://github.com/kiriaze/mac-dev-env)
- [github.com/filipmaelbrancke/mac-install](https://github.com/filipmaelbrancke/mac-install)
- [github.com/jeremybradbury/mac-php-dev-env](https://github.com/jeremybradbury/mac-php-dev-env)

*OS Temper terminal logic and functionality*:
- [github.com/Winetricks/winetricks](https://github.com/Winetricks/winetricks)

## Contributing and Donations

If you find something interesting or would like to contribute, please open issue and start disccussion. Feel free to fork and pull request.
If OS Tamper has helped you out feel free to donate via BTC/ETH or to the EFF
- BTC: 14v9knBDAmJAMxWovuLfy7YkLDyfq8phNb
- ETH: 0xe6fbd8de8157934767867022b7a8e8691d8df3dc
- EFF: (https://supporters.eff.org/donate/button)

## License and Authors
Author: Vincent Koc (vincent@loophole.eu)
Copyright: 2018, Vincent K.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at: http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

OSTemper logo based upon Fingerprint by LAFS from the Noun Project under Creative Commons licence 3.0: https://creativecommons.org/licenses/by/3.0/