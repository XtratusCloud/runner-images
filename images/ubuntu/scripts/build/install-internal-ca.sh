#!/bin/bash -e
################################################################################
##  File:  install-internal-ca.sh
##  Desc:  Install internal CA certificates (root + intermediate) in the OS
##         trust store and in every JDK cacerts truststore
################################################################################

certs_dir="${INSTALLER_SCRIPT_FOLDER}/certs"
trust_dir="/usr/local/share/ca-certificates"

shopt -s nullglob
root_certs=("${certs_dir}/root/"*.pem "${certs_dir}/root/"*.crt)
intermediate_certs=("${certs_dir}/intermediate/"*.pem "${certs_dir}/intermediate/"*.crt)

if [ ${#root_certs[@]} -eq 0 ] && [ ${#intermediate_certs[@]} -eq 0 ]; then
    echo "No internal CA certificates found in ${certs_dir}. Skipping."
    exit 0
fi

install_to_os_trust_store() {
    local prefix=$1
    shift
    local cert base
    for cert in "$@"; do
        base=$(basename "$cert")
        base="${base%.*}"
        echo "Installing ${cert} to OS trust store as ${trust_dir}/${prefix}-${base}.crt"
        cp "$cert" "${trust_dir}/${prefix}-${base}.crt"
    done
}

install_to_os_trust_store "xtratus-root" "${root_certs[@]}"
install_to_os_trust_store "xtratus-int" "${intermediate_certs[@]}"

echo "Updating OS certificate trust store"
update-ca-certificates

install_to_java_truststores() {
    local cacerts jdk_home keytool cert alias
    for cacerts in /usr/lib/jvm/*/lib/security/cacerts /usr/lib/jvm/*/jre/lib/security/cacerts; do
        [ -f "$cacerts" ] || continue
        jdk_home=$(dirname "$(dirname "$(dirname "$cacerts")")")
        keytool="${jdk_home}/bin/keytool"
        [ -x "$keytool" ] || continue
        echo "Importing internal CA certificates into ${cacerts}"
        for cert in "${root_certs[@]}" "${intermediate_certs[@]}"; do
            alias="xtratus-$(basename "${cert%.*}" | tr '[:upper:] ' '[:lower:]_')"
            if "$keytool" -list -alias "$alias" -keystore "$cacerts" -storepass changeit > /dev/null 2>&1; then
                echo "Alias ${alias} already present in ${cacerts}, skipping"
                continue
            fi
            "$keytool" -importcert -noprompt -trustcacerts -alias "$alias" \
                -file "$cert" -keystore "$cacerts" -storepass changeit
        done
    done
}

install_to_java_truststores
