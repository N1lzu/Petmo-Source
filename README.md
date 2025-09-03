# PETMO -RANSOMWARE

Järjestys ja sisällys

1. Ekana tehdään "infector" kansioon ohjelmalle admin oikeudet ja MBR/GPT/EFI ylikirjoitus bootille
2. Tehdään Assemblyllä letterKernel (ransomletter), jossa se letter data
3. Sitten "payload" kansioon se kernel ja purkufunktiot

Rakenne

INFECTOR:
	mainkoodi, joka skannaa levytyypin (MBR/GPT/EFI), ja ottaa admin oikudet, restarttaa koneen 	niin c kielellä (main.c ja main.h)

PAYLOAD:
	itse bootkit, joka koneen käynnistyessä lataa letterKernelin ja ei anna Windowsin käynnistyä

DEKRYPTAUS:
	assemblyllä, jos ostettu key oikein, niin poistaa MBR/GPT/EFI ylikirjoituksen ja kernelin
