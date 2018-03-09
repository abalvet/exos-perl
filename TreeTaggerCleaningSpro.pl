use warnings;
use strict;
use utf8;

binmode(STDOUT,':utf8');

open(IN,"3_tagged_clean3.txt");
open(OUT,">4_tagged_clean4.txt");
binmode (IN,':utf8');
binmode (OUT,':utf8');

#SCRIPT A RETRAVAILLER = PLANTAGE SI 2 APOSTROPHES DANS UNE MEME LIGNE


# Problème → {s,.VEr:subi} ' {avère,avérer.VER:pres}
# Problème → {s,.NOM} ' {intéresse,intéresser.VER:pres}


while (my $ligne = <IN>) {
  chop $ligne;
  if ($ligne =~ /\{(s,\..+?\} ' ) \{[^,]+,[^\.]+\.VER[^\}]+?\}/){
    print "$1\n";
    $ligne =~ s/$1/{s',se.PRO}/g;
  }
  print OUT "$ligne\n";
}

close(IN);
close(OUT);
