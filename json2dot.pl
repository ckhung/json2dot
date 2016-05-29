#!/usr/bin/perl -w

use strict;
use JSON;
use File::Slurp;
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');

my $D;

if ($ARGV[0]) {
    $D = read_file($ARGV[0], binmode =>':utf8');
} else {
    $D = do { local $/; <STDIN> };
}

$D = from_json($D);

# this is ok: print $D->{features}[0]{properties}{name};
# this does not work no matter what: Dumper($D);

my $LatestName;

print <<"eof";
digraph structs {

    node [shape=plaintext]
    rankdir=LR;

    root [label=" "; shape=circle;];
eof

struct2dot("root", $D);

print "}\n";

sub struct2dot {
    my ($parent, $D) = @_;
    my ($i, $k, $c, $nbsp);
    if (ref $D eq 'ARRAY') {
	my $name = next_name();
	print $name;
	print qq([label=<\n<table border="0" cellborder="1" cellspacing="0">\n);
	for ($i=0; $i<=$#$D; ++$i) {
	    if (ref $D->[$i]) {
		$c = $nbsp ? "" : "&nbsp;" x 4;
		$nbsp = 1;
	    } else {
		$c = $D->[$i];
	    }
	    print qq(<tr><td border="0">$i</td><td PORT="p_$i">$c</td></tr>);
	}
	print qq(</table>>];\n\n);
	for ($i=0; $i<=$#$D; ++$i) {
	    struct2dot("$name:p_$i", $D->[$i]) if (ref $D->[$i]);
	}
	print "$parent -> $name\n";
    } elsif (ref $D eq 'HASH') {
	my $name = next_name();
	print $name;
	print qq([label=<\n<table border="0" cellborder="1" cellspacing="0">\n);
	$i = 0;
	my @keys = keys %$D;
	foreach $k (@keys) {
	    if (ref $D->{$k}) {
		$c = $nbsp ? "" : "&nbsp;" x 4;
		$nbsp = 1;
	    } else {
		$c = $D->{$k};
	    }
	    print qq(<tr><td>$k</td><td PORT="p_$i">$c</td></tr>);
	    ++$i;
	}
	print qq(</table>>];\n\n);
	print "$parent -> $name\n";
	$i = 0;
	foreach $k (@keys) {
	    struct2dot("$name:p_$i", $D->{$k}) if (ref $D->{$k});
	    ++$i;
	}
    } else {
	print STDERR "warning: '$D' ignored\n";
    }
}

sub next_name {
    $LatestName = defined $LatestName ?
	"N" . sprintf("%04d", substr($LatestName,1)+1) : 'N0000';
    return $LatestName;
}

