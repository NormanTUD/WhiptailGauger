#!/bin/bash

DISPLAYGAUGE=1

function gaugecommand () {
    set +x
    PCT=0
    TITLE=$1
    TEXT=$2
    COMMAND=$3

    COMMANDFILE="$RANDOM.command"
    while [[ -e $COMMANDFILE ]]; do
            COMMANDFILE="$RANDOM.command"
    done

    echo $COMMAND > $COMMANDFILE 2>/dev/null

    if [[ "$DISPLAYGAUGE" -eq "1" ]]; then
            GAUGEFILE=$RANDOM.gauge
            while [[ -e $GAUGE ]]; do
                    GAUGEFILE=$RANDOM.gauge
            done

            (stdbuf -oL -eL bash $COMMANDFILE 2> $GAUGEFILE >/dev/null) &
            OLDTERM=$TERM
            export TERM=linux

            JOBPID=$(jobs -p | sed -e 's/ running.*//' | sed -e 's/.*\+ //')
            (
                    while ps -auxf | grep -v grep | grep $JOBPID >/dev/null; do
                            if [[ -e $GAUGEFILE ]]; then
                                echo "XXX"
                                CURRENT_PERCENTAGE=$(cat $GAUGEFILE | grep PERCENTGAUGE | sed -e 's/PERCENTGAUGE: //' | tail -n1)
                                echo $CURRENT_PERCENTAGE
                                HASMSG=$(cat $GAUGEFILE | grep GAUGESTATUS | tail -n1 | sed -e 's/GAUGESTATUS: //')
                                if [[ -z $HASMSG ]]; then
                                    echo "$TEXT"
                                else
                                    echo "$TEXT ($HASMSG)"
                                fi
                                echo "XXX"
                                if [[ "$CURRENT_PERCENTAGE" -eq "100" ]]; then
                                    exit
                                fi
                            fi
                            sleep 1
                    done
            ) | whiptail --title "$TITLE" --gauge "$TEXT" 8 120 0
            cat $GAUGEFILE
            rm $GAUGEFILE
            export TERM=$OLDTERM
    else
            bash $COMMANDFILE
    fi

    if [[ "$DEBUG" -eq "1" ]]; then
        set -x
    fi
    rm $COMMANDFILE
}
