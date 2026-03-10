#!/bin/bash -e
################################################################################
##  File:  install-sapjco3.sh
##  Desc:  Install SAP JCo3
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh
source $HELPER_SCRIPTS/install.sh

# Install SAP JCo3
# Following Azure Pipelines Tool Cache structure:
# $AGENT_TOOLSDIRECTORY/sapjco3/3.1.13/x64/sapjco3/

tool_name="sapjco3"
tool_version="3.1.13"
tool_platform="x64"

archive_path="${INSTALLER_SCRIPT_FOLDER}/libraries/${tool_name}-linuxx86_64-${tool_version}.zip"

if [[ ! -f "$archive_path" ]]; then
    echo "File not found: $archive_path" >&2
    exit 1
fi

# Determine tools directory
tools_dir="${AGENT_TOOLSDIRECTORY}"
if [[ -z "$tools_dir" ]]; then
    tools_dir="/opt/hostedtoolcache"
fi

install_dir="${tools_dir}/${tool_name}/${tool_version}/${tool_platform}"
rm -rf "$install_dir"
mkdir -p "$install_dir"

unzip -qq "$archive_path" -d "$install_dir"

if [[ ! -f "$install_dir/sapjco3.jar" ]]; then
    echo "sapjco3.jar not found after extracting $archive_path" >&2
    exit 1
fi

# Make all shell scripts executable
find "$install_dir" -type f -name "*.sh" -exec chmod +x {} \;

# Set proper permissions
chmod -R a+rwX "$install_dir"

# Configure environment variables
export LD_LIBRARY_PATH="${install_dir}:$LD_LIBRARY_PATH"
export CLASSPATH="${install_dir}/sapjco3.jar:$CLASSPATH"

# Create the .complete marker file
touch "${tools_dir}/${tool_name}/${tool_version}/${tool_platform}.complete"
