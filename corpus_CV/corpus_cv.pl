#!/usr/bin/perl

use warnings;
use strict;
use utf8;

binmode(STDOUT,':utf8');

#nombre d'occurrences pour chaque entreprise à ordonner par ordre alphabétique puis compte croissant

open(IN,"corpus.txt");
binmode (IN,':utf8');

my %compte = (); #initialisation d'un tableau de comptage

while (my $ligne = <IN>) {
  chop $ligne;
  if ($ligne =~ /^{EXPERIENCE}(.*)$/){ #regex qui permet de ne pas sélectionner le {EXPERIENCE} en début de ligne
    #print "$ligne\n";
    my @experiences = split(/,/,$1); #le split ne reprend pas toute la ligne mais seulement l'intitulé du poste
    if ($experiences[2] ne '-'){ #élimine les lignes où l'entreprise n'est pas renseignée
    my $entreprise = $experiences[2];
    #print "$entreprise\n";

    $entreprise = "\L$entreprise"; #normalisation en minuscules

    if (exists($compte{$entreprise})) {
      $compte{$entreprise} = $compte{$entreprise} + 1;}
      else{
        $compte{$entreprise} = 1;
      }
    }
  }
}

use locale; #ordre alphabétique suivant les paramètres linguistiques de la machine
#for my $entreprise (sort keys %compte)

for my $entreprise (sort {$compte{$a} <=> $compte{$b}} (keys %compte)){
  print $compte{$entreprise};
  print "\t";
  print $entreprise;
  print "\n";
}

close(IN);
