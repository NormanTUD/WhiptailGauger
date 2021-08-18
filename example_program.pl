#!/usr/bin/perl

$| = 1;

for (0 .. 10) {
	warn "PERCENTGAUGE: ".($_ * 10)."\n";
	warn "GAUGESTATUS: Loading module nr. $_...\n";
	sleep 1;
}
