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

echo "Installing $(tput setaf 6)Pulsar shell$(tput setaf 7) please wait...      "

DEFAULT_ZIP="https://github.com/datastax/pulsar/releases/download/ls31_4.6/lunastreaming-shell-3.1.4.6-bin.zip"
ZIP_DOWNLOAD_URL="${1:-$DEFAULT_ZIP}"
candidate_base_name=$(basename $ZIP_DOWNLOAD_URL)


pulsar_shell_root_dir="$HOME/.pulsar-shell"
mkdir -p $pulsar_shell_root_dir
pulsar_shell_downloads_dir="$pulsar_shell_root_dir/downloads"
mkdir -p $pulsar_shell_downloads_dir
pulsar_shell_candidates_dir="$pulsar_shell_root_dir/candidates"
mkdir -p $pulsar_shell_candidates_dir

pulsar_shell_current_symlink="$pulsar_shell_candidates_dir/current"
mkdir -p $pulsar_shell_candidates_dir

downloaded_zip_path=$pulsar_shell_downloads_dir/$candidate_base_name
downloaded_extracted_dir=${ZIP_DOWNLOAD_URL//-bin\.zip}
downloaded_extracted_path="$pulsar_shell_candidates_dir/$(basename $downloaded_extracted_dir)"

darwin=false
case "$(uname)" in
    Darwin*)
        darwin=true
        ;;
esac

echo "$(tput setaf 2)[OK]$(tput setaf 7) - Ready to install $(basename $downloaded_extracted_dir)."

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

function inject_if_not_found() {
    local file=$1
    touch "$file"
    if [[ -z $(grep 'pulsar-shell/candidates' "$file") ]]; then
        echo -e "\n$init_snipped" >> "$file"
        echo "$(tput setaf 2)[OK]$(tput setaf 7) - pulsar-shell bin added to ${file}"
    fi
}



bash_profile="${HOME}/.bash_profile"
bashrc="${HOME}/.bashrc"
zshrc="${ZDOTDIR:-${HOME}}/.zshrc"
init_snipped=$( cat << EOF
export PATH=\$PATH:$pulsar_shell_current_symlink/bin
EOF
)

if [[ $darwin == true ]]; then
  inject_if_not_found $bash_profile
else
  inject_if_not_found $bashrc
fi

if [[ -s "$zshrc" ]]; then
  inject_if_not_found $zshrc
fi

echo "$(tput setaf 2)[OK]$(tput setaf 7) - Installation Successful"
echo "Open $(tput setaf 2)a new terminal$(tput setaf 7) and run: $(tput setaf 3)pulsar-shell$(tput setaf 7)"
echo ""
echo "You can close this window."
