#!/usr/bin/perl

use warnings;
use strict;
use utf8;

binmode(STDOUT,':utf8');

#compter les mots du corpus

open(IN,"corpus.txt");
binmode (IN,':utf8');

my %compte = ();

my %stop = ();
open(STOP,"stop-list.txt");
binmode(STOP,'utf8');
while (my $mot = <STOP>) {
    chop $mot;
    $stop{$mot} = 1;
}
close(STOP);

while (my $ligne = <IN>) {
  chop $ligne;
  if ($ligne !~ /^{/) {
    my @mots = split(/\W+/,$ligne);
    foreach my $mot (@mots){
      $mot = "\L$mot";
if (($mot !~ /^\d*$/) && (!exists($stop{$mot}))){
  if (exists($compte{$mot})) {
    $compte{$mot} = $compte{$mot}+1;
  } else {
    $compte{$mot} = 1;
  }

}
    }
  }
}


for my $mot (sort {$compte{$a} <=> $compte{$b}} (keys %compte)){
  print $compte{$mot};
  print "\t";
  print $mot;
  print "\n";
}


close(IN);
