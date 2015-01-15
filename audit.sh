#!/bin/bash

etatModuleNamespace()
{	
	depth=${2:-1}
	DOSSIERS=$(ls -l $1 | grep "^d" | awk '{print $9}')
	for codePool in $DOSSIERS; do  
		nbr=$(ls -l "$1/$codePool" | grep -v 'total' | wc -l)
		nbrCodepool=0
		dossierNamespace=$(ls -l "$1/$codePool" | grep "^d" | awk '{print $9}')	
		for namespace in $dossierNamespace; do  
			nbrCodepool=$(( $nbrCodepool + $(ls -l "$1/$codePool/$namespace" | grep -v 'total' | wc -l) ))
		done
		echo "$codePool ($nbr namespaces , $nbrCodepool modules)"
	done
}

TRAVAIL=$1
DOSSIER_CODE="$TRAVAIL/app/code"
SEP='--------------------------------------';


echo '--------- ETAT DES MODULES  ----------'
etatModuleNamespace $DOSSIER_CODE
echo $SEP

echo '--------- ANALYSE DES TEMPLATES  ----------'
echo ''
echo '--------- getBlock dans les templates  ----------' > 'analyse_templates_getblock.log'
echo '--------- getBlock dans les templates  ----------'
echo $(find "$TRAVAIL/app/design/frontend" -name "*" -exec grep -Hn ">getBlock(" {} \; | awk '{print $1}' | wc -l) " getBlock dans les templates"
echo ''
find "$TRAVAIL/app/design/frontend" -name "*" -exec grep -Hn ">getBlock(" {} \; >> 'analyse_templates_getblock.log'
echo "> analyse_templates_getblock.log"

echo ''
echo '--------- createBlock dans les templates  ----------' >> 'analyse_templates_createblock.log'
echo '--------- createBlock dans les templates  ----------'
echo $(find "$TRAVAIL/app/design/frontend" -name "*" -exec grep -Hn '>createBlock(' {} \; | awk '{print $1}' | wc -l) " createBlock dans les templates"
find "$TRAVAIL/app/design/frontend" -name "*" -exec grep -Hn '>createBlock(' {} \; >> 'analyse_templates_createblock.log'
echo "> analyse_templates_createblock.log"

echo ''
echo '--------- "new" dans les templates  ----------' >> 'analyse_templates_createblock.log'
echo '--------- "new" dans les templates  ----------'
echo $(find "$TRAVAIL/app/design/frontend" -name "*" -exec grep -Hn "= new " {} \; | awk '{print $1}' | wc -l) " new dans les templates"
find "$TRAVAIL/app/design/frontend" -name "*" -exec grep -Hn "= new" {} \; >> 'analyse_templates_new.log'
sed '/Varien/d' analyse_templates_new.log
echo "> analyse_templates_new.log"

echo ''
echo '--------- "load" dans les templates  ----------' >> 'analyse_templates_load.log'
echo '--------- "load" dans les templates  ----------'
echo $(find "$TRAVAIL/app/design/frontend" -name "*" -exec grep -Hn '>load(' {} \; | awk '{print $1}' | wc -l) " load dans les templates"
find "$TRAVAIL/app/design/frontend" -name "*" -exec grep -Hn '>load(' {} \; >> 'analyse_templates_load.log'
echo "> analyse_templates_load.log"

echo ''
echo '--------- ANALYSE DU CODE DES MODULES  ----------'

echo ''
echo '--------- "new" dans le code ----------'
echo '--------- "new" dans le code ----------' >> 'analyse_code_new.log'
echo $(find "$TRAVAIL/app/code" -name "*" -exec grep -Hn "= new " {} \; | awk '{print $1}' | wc -l) " new dans le code"
find "$TRAVAIL/app/code" -name "*" -exec grep -Hn "= new" {} \; >> 'analyse_code_new.log'
echo "> analyse_code_new.log"

echo ''
echo '--------- "load" dans le code ----------'
echo '--------- "load" dans le code ----------' >> 'analyse_code_load.log'
echo $(find "$TRAVAIL/app/code" -name "*" -exec grep -Hn '>load(' {} \; | awk '{print $1}' | wc -l) " load dans le code"
find "$TRAVAIL/app/code" -name "*" -exec grep -Hn '>load(' {} \; >> 'analyse_code_load.log'
echo "> analyse_code_load.log"

echo ''
echo '---------  $_POST,$_GET,$_GLOBAL, mysql_ ----------'
echo '--------- $_POST dans le code ----------' >> 'analyse_code_load.log'
echo $(find "$TRAVAIL/app" -name "*" -exec grep -Hn '$_POST' {} \; | awk '{print $1}' | wc -l) ' $_POST dans le code et les templates'
find "$TRAVAIL/app" -name "*" -exec grep -Hn '$_POST' {} \; >> 'analyse_code_php_basic.log'

echo '--------- $_GET dans le code ----------' >> 'analyse_code_load.log'
echo $(find "$TRAVAIL/app" -name "*" -exec grep -Hn '$_GET' {} \; | awk '{print $1}' | wc -l) ' $_GET dans le code et les templates'
find "$TRAVAIL/app" -name "*" -exec grep -Hn '$_GET' {} \; >> 'analyse_code_php_basic.log'
 
echo '--------- $_GLOBAL dans le code ----------' >> 'analyse_code_load.log'
echo $(find "$TRAVAIL/app" -name "*" -exec grep -Hn '$_GLOBAL' {} \; | awk '{print $1}' | wc -l) ' $_GLOBAL dans le code et les templates'
find "$TRAVAIL/app" -name "*" -exec grep -Hn '$_GLOBAL' {} \; >> 'analyse_code_php_basic.log'

echo '--------- mysql_ dans le code ----------' >> 'analyse_code_load.log'
echo $(find "$TRAVAIL/app" -name "*" -exec grep -Hn 'mysql_' {} \; | awk '{print $1}' | wc -l) ' mysql_ dans le code et les templates'
find "$TRAVAIL/app" -name "*" -exec grep -Hn 'mysql_' {} \; >> 'analyse_code_php_basic.log'


