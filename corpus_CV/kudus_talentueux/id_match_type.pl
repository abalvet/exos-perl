#!/usr/bin/perl

use warnings;
use strict;
use utf8;

binmode(STDOUT,':utf8');

open(IN,"fichier.txt"); #nom de fichier à modifier en fonction
binmode (IN,':utf8');

my $num_ligne = 0;
while (my $ligne = <IN>) {

  chop $ligne;
  #pour test
  #print "$ligne\n";

  my ($id, $type, $match) = (split /,/, $ligne)[0, 1, 2];

  #pour test
  #print "Identifiant : $id\n";
  #print "Type : $type\n";
  #print "Match : $match\n";

  my @identifiants = ();
  my @types = ();
  my @matches = ();
  
  push (@identifiants, $id);
  push (@types, $type);
  push (@matches, $match);
  
  use Data::Dumper;
  my %id_types;
  @id_types{@identifiants} = @types;
  #pour test
  print Dumper(\%id_types);
}


close(IN);
