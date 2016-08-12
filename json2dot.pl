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

sub should_we_descend($) {
    my $D = shift;
    return 0 unless ref $D;
    return 0 if ref $D eq "JSON::XS::Boolean";
    return 1;
}

sub escape_chars($) {
     my $t = shift;
     $t = "<null>" unless defined $t;
     $t =~ s!\&!&amp;!g;
     $t =~ s!\"!&quot;!g;
     $t =~ s!\<!&lt;!g;
     $t =~ s!\>!&gt;!g;
     $t
}

sub struct2dot {
    my ($parent, $D) = @_;
    my ($i, $k, $c, $nbsp);
    if (ref $D eq 'ARRAY') {
	my $name = next_name();
	print $name;
	print qq([label=<\n<table border="0" cellborder="1" cellspacing="0">\n);
	print "<tr><td>empty array</td></tr>" if $#$D == -1;
	for ($i=0; $i<=$#$D; ++$i) {
        if (should_we_descend($D->[$i])) {
		$c = $nbsp ? "" : "&nbsp;" x 4;
		$nbsp = 1;
	    } else {
		$c = escape_chars($D->[$i]);
	    }
	    print qq(<tr><td border="0">$i</td><td PORT="p_$i">$c</td></tr>);
	}
	print qq(</table>>];\n\n);
	for ($i=0; $i<=$#$D; ++$i) {
	    struct2dot("$name:p_$i", $D->[$i]) if (should_we_descend($D->[$i]));
	}
	print "$parent -> $name\n";
    } elsif (ref $D eq 'HASH') {
	my $name = next_name();
	print $name;
	print qq([label=<\n<table border="0" cellborder="1" cellspacing="0">\n);
	$i = 0;
	my @keys = keys %$D;
	print "<tr><td>empty object</td></tr>" if $#keys == -1;
	foreach $k (@keys) {
	    if (should_we_descend($D->{$k})) {
		$c = $nbsp ? "" : "&nbsp;" x 4;
		$nbsp = 1;
	    } else {
		$c = escape_chars($D->{$k});
	    }
	    print qq(<tr><td>$k</td><td PORT="p_$i">$c</td></tr>);
	    ++$i;
	}
	print qq(</table>>];\n\n);
	print "$parent -> $name\n";
	$i = 0;
	foreach $k (@keys) {
	    struct2dot("$name:p_$i", $D->{$k}) if (should_we_descend($D->{$k}));
	    ++$i;
	}
    } else {
	print STDERR "warning: '$D' ignored, type is ".(ref $D)."\n";
    }
}

sub next_name {
    $LatestName = defined $LatestName ?
	"N" . sprintf("%04d", substr($LatestName,1)+1) : 'N0000';
    return $LatestName;
}

