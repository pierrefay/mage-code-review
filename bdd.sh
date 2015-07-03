#!/bin/bash
if [ "$#" -ne 2 ]; then
     echo "Illegal number of parameters use run-server.sh <bdd_name> <prefix>"
     prefixbdd="$1_"
     bddName="$2"
fi

BASEFOLDER="/var/www/html/"
BASEURL="www.latabledarc.com"
prefixbdd="lta_"
bddName="tabledarc"

# ETAT DU SYSTEME

echo "Nombre de website:"
echo "SELECT count(*) FROM $bddName.$prefixbdd""core_website;" | mysql -u root $bddName

echo "Nombre de store:"
echo "SELECT count(*) FROM $bddName.$prefixbdd""core_store_group;" | mysql -u root $bddName

echo "Nombre de storeview:"
echo "SELECT count(*) FROM $bddName.$prefixbdd""core_store;" | mysql -u root $bddName 

echo "Nombre de commandes:"
echo "SELECT count(*) FROM $bddName.$prefixbdd""sales_flat_order;" |  mysql -u root $bddName

echo "Nombre de clients:"
echo "SELECT count(*) FROM $bddName.$prefixbdd""customer_entity;" |  mysql -u root $bddName

echo "Nombre de groupe clients:"
echo "SELECT count(*) FROM $bddName.$prefixbdd""customer_group;" |  mysql -u root $bddName

echo "Nombre de dattributs:"
echo "SELECT count(*) FROM $bddName.$prefixbdd""catalog_eav_attribute;" | mysql -u root $bddName

echo "Nombre de produits:"
echo "SELECT count(*) FROM $bddName.$prefixbdd""catalog_product_entity;" | mysql -u root $bddName

echo "Nombre de catégories:"
echo "SELECT count(*) FROM $bddName.$prefixbdd""catalog_category_entity;" | mysql -u root $bddName

echo "Nombre dinscrits à la newsletter:"
echo "SELECT count(*) FROM $bddName.$prefixbdd""api_user;" |  mysql -u root $bddName

echo "Nombre dutilisateurs de lAPI:"
echo "SELECT count(*) FROM $bddName.$prefixbdd""admin_user;" |  mysql -u root $bddName

echo "Nombre de comptes admin:"
echo "SELECT count(*) FROM $bddName.$prefixbdd""customer_group;" |  mysql -u root $bddName

echo "Nombre de pages cms:"
echo "SELECT count(*) FROM $bddName.$prefixbdd""cms_page;" |  mysql -u root $bddName

echo "Nombre de blocs cms:"
echo "SELECT count(*) FROM $bddName.$prefixbdd""cms_block;" |  mysql -u root $bddName

# TABLES VOLUMINEUSES (PERFS)

echo "Taille de la table logs customer:"
echo "SELECT count(*) FROM $bddName.$prefixbdd""log_customer" |  mysql -u root $bddName

echo "Taille de la table logs quote:"
echo "SELECT count(*) FROM $bddName.$prefixbdd""log_quote" |  mysql -u root $bddName

echo "Taille de la table logs summary:"
echo "SELECT count(*) FROM $bddName.$prefixbdd""log_summary" |  mysql -u root $bddName

echo "Taille de la table logs summary type:" 
echo "SELECT count(*) FROM $bddName.$prefixbdd""log_summary_type" |  mysql -u root $bddName

echo "Taille de la table logs url:" 
echo "SELECT count(*) FROM $bddName.$prefixbdd""log_url" |  mysql -u root $bddName

echo "Taille de la table logs url info:" 
echo "SELECT count(*) FROM $bddName.$prefixbdd""log_url_info" |  mysql -u root $bddName

echo "Taille de la table logs customer:" 
echo "SELECT count(*) FROM $bddName.$prefixbdd""log_visitor" |  mysql -u root $bddName

echo "Taille de la table logs info visitor:" 
echo "SELECT count(*) FROM $bddName.$prefixbdd""log_visitor_info" |  mysql -u root $bddName

echo "Taille de la table logs of online visitor:"
echo "SELECT count(*) FROM $bddName.$prefixbdd""log_visitor_online" |  mysql -u root $bddName

echo "Taille de la table sales_flat_quote:"
echo "SELECT count(*) FROM $bddName.$prefixbdd""sales_flat_quote" |  mysql -u root $bddName

echo "Nombre dentrée dans la table core url rewrite:"
echo "SELECT count(*) FROM $bddName.$prefixbdd""core_url_rewrite;" |  mysql -u root $bddName

# VERIF PERFS

echo "Logs activés ?"
echo "SELECT * FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'dev/log/active';" |  mysql -u root $bddName

echo "Logs file:"
echo "SELECT * FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'dev/log/file';" |  mysql -u root $bddName

echo "Exception file:"
echo "SELECT * FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'dev/log/exception_file';" |  mysql -u root $bddName

echo "Flat table produits activé ?"
echo "SELECT * FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'catalog/frontend/flat_catalog_product';" |  mysql -u root $bddName

echo "Flat table catégorie activé ?"
echo "SELECT * FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'catalog/frontend/flat_catalog_category';" |  mysql -u root $bddName

# CONFIGURATION DU THEME

echo "Le package utilisé nest pas default ?"
echo "SELECT * FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'design/package/name';" |  mysql -u root $bddName

echo "Le théme (template) utilisé nest pas default ?"
echo "SELECT * FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'design/theme/template';" |  mysql -u root $bddName

echo "Le theme (layout) utilisé nest pas default ?"
echo "SELECT * FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'design/theme/layout';" |  mysql -u root $bddName

echo "Le theme (skin) utilisé nest pas default ?"
echo "SELECT * FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'design/theme/skin';" |  mysql -u root $bddName

echo "Le theme (default) utilisé nest pas default ?" 
echo "SELECT * FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'design/theme/default';" |  mysql -u root $bddName

echo "Fusion des js activés ?"
echo "SELECT * FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'dev/js/merge_files';" |  mysql -u root $bddName

echo "Fusion des css activés ?"
echo "SELECT * FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'dev/css/merge_css_files';" |  mysql -u root $bddName

# SECURITE

echo "Utilisation du SSL en frontend:"
echo "SELECT * FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'web/secure/use_in_frontend';" |  mysql -u root $bddName

echo "Utilisation du SSL en admin:"
echo "SELECT * FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'web/secure/use_in_frontend';" |  mysql -u root $bddName

echo "Temps de vie du cookie:"
echo "SELECT * FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'web/cookie/cookie_lifetime';" |  mysql -u root $bddName

echo "Restrictions IP sur le profiler ?"
echo "SELECT * FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'dev/restrict/allow_ips';" |  mysql -u root $bddName

echo "Profiler activés ?"
echo "SELECT * FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'dev/debug/profiler';" |  mysql -u root $bddName

echo "Logs activés ?"
echo "SELECT * FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'dev/log/active';" |  mysql -u root $bddName

echo "Logs file:"
echo "SELECT * FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'dev/log/file';" |  mysql -u root $bddName

echo "Exception file:"
echo "SELECT * FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'dev/log/exception_file';" |  mysql -u root $bddName


# AUTRES VERIFICATIONS

echo "Traduction en ligne activées sur le frontend ?"
echo "SELECT count(*) FROM $bddName.$prefixbdd""core_translate;" |  mysql -u root $bddName

echo "Présence de traduction dans core_translate ?"
echo "SELECT * FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'dev/translate_inline/active';" |  mysql -u root $bddName

echo "afficher les prix catalogue (1=TTC  0=HT) ?"
echo "SELECT * FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'tax/calculation/price_includes_tax';" |  mysql -u root $bddName

echo "afficher les frais de port  (1=TTC  0=HT) ?"
echo "SELECT * FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'tax/calculation/shipping_includes_tax';" |  mysql -u root $bddName

echo "Url en dur dans le contenu statique (pages cms) ?"
echo "SELECT identifier FROM $bddName.$prefixbdd""cms_page where content like '%http://$BASEURL%';" |  mysql -u root $bddName

echo "Url en dur dans le contenu statique (blocs cms) ?"
echo "SELECT identifier FROM $bddName.$prefixbdd""cms_block where content like '%http://$BASEURL%';" |  mysql -u root $bddName

echo "Vérification des tables corrompues?"
#check BDD:
#MyISAM
myisamchk -c -e /var/lib/mysql/tabledarc/*.MYI

#Check non Myisam table
mysqlcheck -c tabledarc -u root

#AUTRES:
echo "Compilation activée ?"
php $BASEFOLDER.shell/compiler.php state

# configuration de la bdd
magerun  db:maintain:check-tables > list_table_config.txt

#nombre de rewrites
magerun dev:module:rewrite:list > list_rewrite.txt

#rewrites qui posent des soucis 
magerun dev:module:rewrite:conflicts > conflicts_rewrite.txt

#liste de tous les fichiers non utf8
find . -type f | xargs -I {} bash -c "iconv -f utf-8 -t utf-16 {} &>/dev/null || echo {}" > utf8_fail.txt

#################################################
###     TESTS FICHIERS                        ###
#################################################
# custom url dans ladmin
# est ce que le core a été modifié ?
# comparaison index.php avec le standard
# presence du downloader
# nombre de surcharges / conflits ?
# module local Mage ?
# encodage non utf8
# .htaccess limitant les acces dans app, lib, var et tout autre dossier non media ou js/theme
# liste des modules commaunautaires => quest ce quils font ? => faire un tableau avec un descriptif, nom = Attribuer une note de "




