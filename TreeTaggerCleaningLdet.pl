use warnings;
use strict;
use utf8;

binmode(STDOUT,':utf8');

open(IN,"2_tagged_clean2.txt");
open(OUT,">3_tagged_clean3.txt");
binmode (IN,':utf8');
binmode (OUT,':utf8');

# Problème → {l,.NOM} ' {idée,idée.NOM}
# Problème → {l,.VER:pper} ' {assurance,assurance.NOM}
# But → {l',le.DET:ART}{assurance,assurance.NOM}
# Regex (inutilisable) → sed -r ”s/\{l\.[^\}]+\} ' \{[^\,]+, [^\.]+\.NOM\}/\{l,le\.DET:ART\}/g”

while (my $ligne = <IN>) {
  chop $ligne;
  if ($ligne =~ /\{(l,\..+?\} ' ) \{[^,]+,[^\.]+\.NOM\}/){
    print "$1\n";
    $ligne =~ s/$1/{l',le.DET:ART}/g;
  }
  print OUT "$ligne\n";
}


# Problème → {l,.NOM} ' {Ardèche,Ardèche.NAM}
# But → {l',le.DET:ART}{Ardèche,Ardèche.NAM}

while (my $ligne = <IN>) {
  chop $ligne;
  if ($ligne =~ /\{(l,\..+?\} ' ) \{[^,]+,[^\.]+\.NAM\}/){
    print "$1\n";
    $ligne =~ s/$1/{l',le.DET:ART}/g;
  }
  print OUT "$ligne\n";
}

# Problème → {l,.ADJ} ' {algorithmique,algorithmique.ADJ}
# But → {l',le.DET:ART}{algorithmique,algorithmique.ADJ}

while (my $ligne = <IN>) {
  chop $ligne;
  if ($ligne =~ /\{(l,\..+?\} ' ) \{[^,]+,[^\.]+\.ADJ\}/){
    print "$1\n";
    $ligne =~ s/$1/{l',le.DET:ART}/g;
  }
  print OUT "$ligne\n";
}


# Problème → {l,.VER:pper} ' {ensemble,ensemble.ADV}
# But → {l',le.DET:ART}{ensemble,ensemble.ADV}

while (my $ligne = <IN>) {
  chop $ligne;
  if ($ligne =~ /\{(l,\..+?\} ' ) \{[^,]+,[^\.]+\.ADV\}/){
    print "$1\n";
    $ligne =~ s/$1/{l',le.DET:ART}/g;
  }
  print OUT "$ligne\n";
}



# Problème → {s,.VEr:subi} ' {avère,avérer.VER:pres}
# Problème → {s,.NOM} ' {intéresse,intéresser.VER:pres}


close(IN);
close(OUT);
