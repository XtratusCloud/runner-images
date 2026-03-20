#!/bin/bash -e
################################################################################
##  File:  install-sapjco3.sh
##  Desc:  Install SAP JCo3
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/os.sh
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/etc-environment.sh

# Load environment variables
reload_etc_environment

# Install SAP JCo3
# Following Azure Pipelines Tool Cache structure:
# $AGENT_TOOLSDIRECTORY/sapjco3/3.1.13/x64/

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

# Make all shell scripts executable
find "$install_dir" -type f -name "*.sh" -exec chmod +x {} \;

# Set proper permissions
chmod -R a+rwX "$install_dir"

# Configure environment variables
prepend_etc_environment_variable "LD_LIBRARY_PATH" "${install_dir}"
prepend_etc_environment_variable "CLASSPATH" "${install_dir}/sapjco3.jar"

# Reload environment variables to make them available in the current session
reload_etc_environment

# Create the .complete marker file
touch "${tools_dir}/${tool_name}/${tool_version}/${tool_platform}.complete"

# Run tests
invoke_tests "Tools" "SAP JCo3"
