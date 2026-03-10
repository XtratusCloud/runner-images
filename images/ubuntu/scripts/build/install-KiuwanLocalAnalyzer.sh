#!/bin/bash -e
################################################################################
##  File:  install-KiuwanLocalAnalyzer.sh
##  Desc:  Install Kiuwan Local Analyzer
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/etc-environment.sh

# Load environment variables
reload_etc_environment

# Install KiuwanLocalAnalyzer
# Following Azure Pipelines Tool Cache structure:
# $AGENT_TOOLSDIRECTORY/KiuwanLocalAnalyzer/1.0.0/x64/

archive_path="${INSTALLER_SCRIPT_FOLDER}/libraries/KiuwanLocalAnalyzer.zip"

if [[ ! -f "$archive_path" ]]; then
    echo "File not found: $archive_path" >&2
    exit 1
fi

tool_name="KiuwanLocalAnalyzer"
tool_version="1.0.0"
tool_platform="x64"

# Determine tools directory
tools_dir="${AGENT_TOOLSDIRECTORY}"
if [[ -z "$tools_dir" ]]; then
    tools_dir="/opt/hostedtoolcache"
fi

install_dir="${tools_dir}/${tool_name}/${tool_version}/${tool_platform}"
rm -rf "$install_dir"
mkdir -p "$install_dir"

unzip -qq "$archive_path" -d "$install_dir"

if [[ ! -f "$install_dir/kiuwan.sh" ]]; then
    echo "kiuwan.sh not found after extracting $archive_path" >&2
    exit 1
fi

# Make all shell scripts executable
find "$install_dir" -type f -name "*.sh" -exec chmod +x {} \;

# Set proper permissions
chmod -R a+rwX "$install_dir"

# Create the .complete marker file
touch "${tools_dir}/${tool_name}/${tool_version}/${tool_platform}.complete"
