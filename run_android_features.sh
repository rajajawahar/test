#!/usr/bin/env bash
PARAMS="-p android"

while getopts ":rd:" OPTION; do
        case $OPTION in

                r)
                    PARAMS=$PARAMS" --format json -o report.html"
                    ;;
                d)
                    PARAMS=$PARAMS" ADB_DEVICE_ARG=$OPTARG"

                    ;;
                [?])    echo "Usage: $0 [-r] [-d DEVICE_ID].\n     -r: should create reports.\n     DEVICE_ID: where to run tests."
                        exit 1;;
        esac
done

# clear old files
rm -rf screenshot*
rm -rf test_servers
# resign apk
bundle exec calabash-android build "../app/build/outputs/apk/app-debug.apk"
# run tests
bundle exec calabash-android run "../app/build/outputs/apk/app-debug.apk" $PARAMS