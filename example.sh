#!/bin/bash

source gaugecommand.sh

# Show gauge (default)
gaugecommand "example_program.pl" "Loading Program example_program.pl" "perl example_program.pl"

# Don't show gauge
DISPLAYGAUGE=0
gaugecommand "example_program.pl" "Loading Program example_program.pl" "perl example_program.pl"
