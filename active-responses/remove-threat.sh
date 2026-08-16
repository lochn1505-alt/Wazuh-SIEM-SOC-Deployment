#!/bin/bash
# Wazuh - Active Response to remove malicious files detected by VirusTotal

LOCAL=`dirname $0`;
cd $LOCAL
cd ../

PWD=`pwd`

read INPUT_JSON
FILENAME=$(echo $INPUT_JSON | jq -r .parameters.alert.data.virustotal.source.file)
COMMAND=$(echo $INPUT_JSON | jq -r .command)
LOG_FILE="${PWD}/../logs/active-responses.log"

#--------- Analyze command ---------#
if [ ${COMMAND} = "add" ]
then
    # Xóa file độc hại
    rm -f "$FILENAME"
    
    if [ $? -eq 0 ]; then
        echo "`date '+%Y/%m/%d %H:%M:%S'` $0: $INPUT_JSON Successfully removed threat" >> ${LOG_FILE}
    else
        echo "`date '+%Y/%m/%d %H:%M:%S'` $0: $INPUT_JSON Error removing threat" >> ${LOG_FILE}
    fi
    exit 0;
fi
