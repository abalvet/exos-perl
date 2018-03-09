#!/usr/bin/perl

use warnings; # activation des messages d'erreurs
use strict;   # déclaration des variables obligatoire
use utf8;     # des accents dans le programme

binmode(STDOUT,':utf8'); # sortie en utf8

open(HTML,'>catalogue_jouets_images.html');
binmode(HTML,':utf8');

open(IN,'kdos.txt');
binmode (IN,':utf8');


print HTML "<!doctype html>\n";
print HTML "<html lang=\"fr\">\n";
print HTML "<head>\n";
print HTML "<link rel=\"stylesheet\" href=\"kdos.css\">\n";
print HTML "<title>Joyeux Noël !</title>\n";
print HTML "<meta charset=\"utf8\">\n";
print HTML "</head>\n";
print HTML "<body>\n";
print HTML "<h1 class=\"title\"><span>Catalogue de jouets</span></h1>\n";
print HTML "<center><table>\n";

while (my $ligne = <IN>) { # tant qu'il y a des lignes dans le fichier

	chop $ligne; # enlève le retour chariot
	next if ($ligne =~ /^#/); #passe à la ligne suivante si la ligne courante commence par dièse (commentaire)

	my @infos = split(/;/,$ligne);

	my $num  = $infos[0];
	my $nom = $infos[1];
	my $description = $infos[2];

	if ($num<1000) {$num = "0$num";}
	
	if (!defined($description)) {
		$description = "-";
}

	$description =~ s/(\d+ ans)/<b>$1<\/b>/gi;
	$description =~ s/(\d+ mois)/<b>$1<\/b>/gi;
	$description =~ s/(naissance)/<b>$1<\/b>/gi;
	
	print HTML "<tr>";

	if (-f "photos/$num.jpg") {
		print HTML "<td><img src=\"photos/$num.jpg\"></td>";
} else {
		print HTML "<td></td>";
}
		
	print HTML "<th>$num</th><td><span class=\"nom\">$nom</span></td><td>$description</td></tr>\n";	

    }
	



print HTML "</table></center>\n";
print HTML "</body>\n";
print HTML "</html>\n";

close(IN);
close(HTML);


