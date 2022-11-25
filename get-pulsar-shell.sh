#!/bin/bash

set -e

track_last_command() {
    last_command=$current_command
    current_command=$BASH_COMMAND
}
trap track_last_command DEBUG

echo_failed_command() {
    local exit_code="$?"
	if [[ "$exit_code" != "0" ]]; then
		echo "'$last_command': command failed with exit code $exit_code."
	fi
}

trap echo_failed_command EXIT

clear

echo "
______         _                          _            _  _ 
| ___ \       | |                        | |          | || |
| |_/ / _   _ | | ___   __ _  _ __   ___ | |__    ___ | || |
|  __/ | | | || |/ __| / _\` || '__| / __|| '_ \  / _ \| || |
| |    | |_| || |\__ \| (_| || |    \__ \| | | ||  __/| || |
\_|     \__,_||_||___/ \__,_||_|    |___/|_| |_| \___||_||_|
                                                           
"

echo "Installing $(tput setaf 6)Luna Streaming shell $(tput setaf 7) please wait...      "

ZIP_DOWNLOAD_URL="https://github.com/datastax/pulsar/releases/download/ls210_2.5/lunastreaming-shell-2.10.2.5-bin.zip"


pulsar_shell_root_dir="$HOME/.pulsar-shell"
mkdir -p $pulsar_shell_root_dir
pulsar_shell_downloads_dir="$pulsar_shell_root_dir/downloads"
mkdir -p $pulsar_shell_downloads_dir
pulsar_shell_candidates_dir="$pulsar_shell_root_dir/candidates"
mkdir -p $pulsar_shell_candidates_dir

pulsar_shell_current_symlink="$pulsar_shell_candidates_dir/current"
mkdir -p $pulsar_shell_candidates_dir

downloaded_zip_path=$pulsar_shell_downloads_dir/$(basename $ZIP_DOWNLOAD_URL)
downloaded_extracted_dir=${ZIP_DOWNLOAD_URL//-bin\.zip}
downloaded_extracted_path="$pulsar_shell_candidates_dir/$(basename $downloaded_extracted_dir)"



# Config Files
bash_profile="${HOME}/.bash_profile"
bashrc="${HOME}/.bashrc"
zshrc="${ZDOTDIR:-${HOME}}/.zshrc"
init_snipped=$( cat << EOF
#THIS MUST BE AT THE END OF THE FILE FOR PULSAR_SHELL TO WORK
export PATH=\$PATH:$pulsar_shell_current_symlink/bin
EOF
)

# OS specific support (must be 'true' or 'false').
cygwin=false;
darwin=false;
solaris=false;
freebsd=false;
linux=false;
case "$(uname)" in
    CYGWIN*)
        cygwin=true
        ;;
    Darwin*)
        darwin=true
        ;;
    SunOS*)
        solaris=true
        ;;
    FreeBSD*)
        freebsd=true
        ;;
    Linux*)
        linux=true
        ;;
esac

echo "$(tput setaf 2)[OK]$(tput setaf 7) - Ready to install."

if ! command -v unzip > /dev/null; then
	echo "Not found."
	echo "======================================================================================================"
	echo " Please install unzip on your system using your favourite package manager."
	echo ""
	echo " Restart after installing unzip."
	echo "======================================================================================================"
	echo ""
	exit 1
fi
echo "$(tput setaf 2)[OK]$(tput setaf 7) - unzip command is available"

if ! command -v curl > /dev/null; then
	echo "Not found."
	echo ""
	echo "======================================================================================================"
	echo " Please install curl on your system using your favourite package manager."
	echo ""
	echo " Restart after installing curl."
	echo "======================================================================================================"
	echo ""
	exit 1
fi
echo "$(tput setaf 2)[OK]$(tput setaf 7) - curl command is available"

echo ""
echo "$(tput setaf 6)Downloading archive:$(tput setaf 7)"
if [ -f "$downloaded_zip_path" ]; then
	echo "$(tput setaf 2)[OK]$(tput setaf 7) - Archive is already there"
else
	curl --fail --location --progress-bar "$ZIP_DOWNLOAD_URL" > "$downloaded_zip_path"  
	echo "$(tput setaf 2)[OK]$(tput setaf 7) - File downloaded"  
fi

# check integrity
ARCHIVE_OK=$(unzip -qt "$downloaded_zip_path" | grep 'No errors detected in compressed data')
if [[ -z "$ARCHIVE_OK" ]]; then
	echo "Downloaded zip archive corrupt. Are you connected to the internet?"
	exit
fi
echo "$(tput setaf 2)[OK]$(tput setaf 7) - Integrity of the archive checked"

echo ""
echo "$(tput setaf 6)Extracting and installation:$(tput setaf 7)"
unzip -qo "$downloaded_zip_path" -d "$pulsar_shell_candidates_dir"
echo "$(tput setaf 2)[OK]$(tput setaf 7) - Extraction is successful"

rm -rf $pulsar_shell_current_symlink
ln -s $downloaded_extracted_path $pulsar_shell_current_symlink 

echo "$(tput setaf 2)[OK]$(tput setaf 7) - Pulsar shell installed at $pulsar_shell_candidates_dir"


if [[ $darwin == true ]]; then
  # Adding on MAC OS
  touch "$bash_profile"
  if [[ -z $(grep './pulsar-shell' "$bash_profile") ]]; then
    echo -e "\n$init_snipped" >> "$bash_profile"
    echo "$(tput setaf 2)[OK]$(tput setaf 7) - astra added to ${bash_profile}"
  fi
else
  touch "${bashrc}"
  if [[ -z $(grep './pulsar-shell' "$bashrc") ]]; then
      echo -e "\n$init_snipped" >> "$bashrc"
      echo "$(tput setaf 2)[OK]$(tput setaf 7) - astra added to ${bashrc}"
  fi
fi

touch "$zshrc"
if [[ -z $(grep './pulsar-shell' "$zshrc") ]]; then
    echo -e "\n$init_snipped" >> "$zshrc"
    echo "$(tput setaf 2)[OK]$(tput setaf 7) - astra added to ${zshrc}"
fi

echo "$(tput setaf 2)[OK]$(tput setaf 7) - Installation Successful"
echo "Open $(tput setaf 2)A NEW TERMINAL$(tput setaf 7) and run: $(tput setaf 3)pulsar-shell$(tput setaf 7)"
echo ""
echo "You can close this window."