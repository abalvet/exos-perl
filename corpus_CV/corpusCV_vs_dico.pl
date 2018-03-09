#!/usr/bin/perl

use warnings;
use strict;
use utf8;

binmode(STDOUT,':utf8');

#liste des mots du corpus qui ne sont pas dans le dictionnaire

open(IN,"corpus.txt");
binmode (IN,':utf8');

my %dictionnaire = ();
open(DICO,'dictionnaire.txt');
binmode(DICO,':utf8');
while (my $mot = <DICO>) {
    chop $mot;
    $dictionnaire{$mot} = 1;
}
close(DICO);

my $num_ligne = 0;
while (my $ligne = <IN>) {
  chop $ligne;
  $num_ligne = $num_ligne+1;
  if ($ligne =~ /^{PERSONNE}([^,]+),/) {
    print ">>> $1\n";
  }

  if ($ligne =~ /^[^{]/) { #ou if ($ligne !~ /^{/)
  #print "$ligne\n";
    my @mots = split(/\W+/,$ligne);
    foreach my $mot (@mots){
      $mot = "\L$mot";
      if ((length($mot)>1) && (!exists($dictionnaire{$mot}))) {
        #print "$. "; #numéro de ligne bourrin
        print "$num_ligne : $mot\n";
      }
    }
  }
}





close(IN);
