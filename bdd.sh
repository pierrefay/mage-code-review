#!/bin/bash




if [ "$#" -ne 8 ]; then
     echo "Illegal number of parameters use : 
     <magento_folder> <base_url> <prefix_bdd> <bdd_host> <bdd_name> <bdd_username> <bdd_password>"
    BASEFOLDER="/data/tabledarc/html/"
    MYSQL_FOLDER="/data/tabledarc/mysql"
	BASEURL="www.latabledarc.com"
	prefixbdd="lta_"
	bddName="tabledarc"
	BDD_NAME="pfay"
	BDD_PASS="pfay123"
	OUTPUT_FOLDER="/home/pierre/Desktop/codetest"
	
else
    BASEFOLDER="$1"
	BASEURL="$2"
	prefixbdd="$3_"
	bddName="$4"
	BDD_NAME="$5"
	BDD_PASS="$6"
	OUTPUT_FOLDER="$7"	
	MYSQL_FOLDER="$8"
fi

yesno () {  
    if [ "$1" = "0" ]; then
    	echo "NO"
   	else
   		echo "YES"
	fi
}

ttcht () {   
    if [ "$1" = "0" ]; then
    	echo "HT"
   	else
   		echo "TTC"
	fi
}
sendbddN(){
	echo $(mysql -u $BDD_NAME  -p$BDD_PASS $bddName -h $BASEURL -N)
}
sendbdd(){
	echo $(mysql -u $BDD_NAME  -p$BDD_PASS $bddName -h $BASEURL)
}


# ETAT DU SYSTEME
echo "SELECT count(*) FROM $bddName.$prefixbdd""core_website;" | echo "Number of websites: $(sendbddN)"
echo "SELECT count(*) FROM $bddName.$prefixbdd""core_store_group;" | echo "Number of stores: $(sendbddN)"
echo "SELECT count(*) FROM $bddName.$prefixbdd""core_store;" | echo "Number of storeviews: $(sendbddN)"
echo "SELECT count(*) FROM $bddName.$prefixbdd""sales_flat_order;" | echo "Number of orders: $(sendbddN)"
echo "SELECT count(*) FROM $bddName.$prefixbdd""customer_entity;" | echo "Number of customers: $(sendbddN)"
echo "SELECT count(*) FROM $bddName.$prefixbdd""customer_group;" | echo "Number of Client Groups: $(sendbddN)"
echo "SELECT count(*) FROM $bddName.$prefixbdd""catalog_eav_attribute;" | echo "Number of attributes: $(sendbddN)"
echo "SELECT count(*) FROM $bddName.$prefixbdd""catalog_product_entity;" | echo "Number of products: $(sendbddN)"
echo "SELECT count(*) FROM $bddName.$prefixbdd""catalog_category_entity;" | echo "Number of categories: $(sendbddN)"
echo "SELECT count(*) FROM $bddName.$prefixbdd""api_user;" | echo "Nomber of newsletter suscribers: $(sendbddN)"
echo "SELECT count(*) FROM $bddName.$prefixbdd""admin_user;" | echo "Numbers of API users: $(sendbddN)"
echo "SELECT count(*) FROM $bddName.$prefixbdd""customer_group;" | echo "Number of admin users: $(sendbddN)"
echo "SELECT count(*) FROM $bddName.$prefixbdd""cms_page;" | echo "Number of cms pages: $(sendbddN)"
echo "SELECT count(*) FROM $bddName.$prefixbdd""cms_block;" | echo "Nomber of  cms pages: $(sendbddN)"

# TABLES VOLUMINEUSES (PERFS)
echo "SELECT count(*) FROM $bddName.$prefixbdd""log_customer" | echo "Size of logs customer: $(sendbddN)"
echo "SELECT count(*) FROM $bddName.$prefixbdd""log_quote" | echo "Size of logs quote: $(sendbddN)"
echo "SELECT count(*) FROM $bddName.$prefixbdd""log_summary" | echo "Size of logs summary: $(sendbddN)"
echo "SELECT count(*) FROM $bddName.$prefixbdd""log_summary_type" | echo "Size of logs summary type: $(sendbddN)"
echo "SELECT count(*) FROM $bddName.$prefixbdd""log_url" | echo "Size of logs url: $(mysql -u $BDD_NAME -p$BDD_PASS $bddName -h $BASEURL -N  )"
echo "SELECT count(*) FROM $bddName.$prefixbdd""log_url_info" | echo "Size of logs url info: $(sendbddN)"
echo "SELECT count(*) FROM $bddName.$prefixbdd""log_visitor" | echo "Size of logs customer: $(sendbddN)"
echo "SELECT count(*) FROM $bddName.$prefixbdd""log_visitor_info" | echo "Size of logs info visitor: $(sendbddN)"
echo "SELECT count(*) FROM $bddName.$prefixbdd""log_visitor_online" | echo "Size of online visitor logs: $(sendbddN)"
echo "SELECT count(*) FROM $bddName.$prefixbdd""sales_flat_quote" | echo "Size of sales_flat_quote: $(sendbddN)"
echo "SELECT count(*) FROM $bddName.$prefixbdd""core_url_rewrite;" | echo "Size of core_url_rewrite: $(sendbddN)"

echo "SELECT value FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'catalog/frontend/flat_catalog_product';" | echo "Flat table product activated ? $(yesno $(sendbddN))"
echo "SELECT value FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'catalog/frontend/flat_catalog_category';" | echo "Flat table catégorie activated ? $(yesno $(sendbddN))"

# CONFIGURATION DU THEME
echo ""
echo "Les packages utilisés(scope, value) :"
echo "SELECT scope, scope_id, value FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'design/package/name';" | mysql --tab -u $BDD_NAME  -p$BDD_PASS $bddName -h $BASEURL
echo ""
echo "Les thémes (template) utilisés (scope, value):"
echo "SELECT scope, scope_id, value FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'design/theme/template';" | mysql --tab -u $BDD_NAME  -p$BDD_PASS $bddName -h $BASEURL
echo ""
echo "Les themes (layout) utilisés (scope, value):"
echo "SELECT scope, scope_id, value FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'design/theme/layout';" | mysql --tab -u $BDD_NAME  -p$BDD_PASS $bddName -h $BASEURL
echo ""
echo "Les themes (skin) utilisés  (scope, value):"
echo "SELECT scope, scope_id, value FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'design/theme/skin';" | mysql --tab -u $BDD_NAME  -p$BDD_PASS $bddName -h $BASEURL
echo ""
echo "Les themes (default) utilisés (scope, value): " 
echo "SELECT value FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'dev/js/merge_files';" | echo "JS merge activated ? $(yesno $(sendbddN))"
echo "SELECT value FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'dev/css/merge_css_files';" | echo "CSS merge activated ? $(yesno $(sendbddN))"

# SECURITE
echo "SELECT value FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'web/secure/use_in_frontend';" | echo "Use frontend SSL: $(yesno $(sendbddN))"
echo "SELECT value FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'web/secure/use_in_frontend';" | echo "Use admin SSL: $(yesno $(sendbddN))"

echo "SELECT value FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'dev/log/active';" | echo "Are the logs activated ? $(echo $(yesno  $(sendbddN)))"
echo "SELECT value FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'dev/log/file';" | echo "- Log file:  $(sendbddN)" 
echo "SELECT value FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'dev/log/exception_file';" | echo "- Exception file: $(sendbddN)"

echo "SELECT value FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'web/cookie/cookie_lifetime';" | echo "Cookie lifetime: $(sendbddN)"

echo "SELECT value FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'dev/restrict/allow_ips';" | echo "IP Restrictions on the profiler ?  $(sendbddN)"
echo "SELECT value FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'dev/debug/profiler';" | echo "Profiler activated ?  $(yesno $(sendbddN))"


echo "SELECT count(*) FROM $bddName.$prefixbdd""core_translate;" | echo "Translation in core_translate table: $(sendbddN)"

echo "SELECT value FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'dev/translate_inline/active';" | echo "Inline translation activated on frontend ? $(yesno $(sendbdd))"

echo "SELECT value FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'tax/calculation/price_includes_tax';" | echo "Show catalog price including tax ?  $(yesno $(sendbddN))"

echo "SELECT value FROM $bddName.$prefixbdd""core_config_data WHERE path LIKE 'tax/calculation/shipping_includes_tax';" | echo "Show shipping price including tax ? $(yesno $(sendbddN))"

echo "Is there static url in pages ?"
echo "SELECT identifier FROM $bddName.$prefixbdd""cms_page where content like '%http://$BASEURL%';" | echo $(sendbddN) > $OUTPUT_FOLDER/cms_page_static.txt 
echo "> see OUTPUT_FOLDER/cms_page_static.txt"

echo "Is there static url in cms blocks ?"
echo "SELECT identifier FROM $bddName.$prefixbdd""cms_block where content like '%http://$BASEURL%';" | echo $(sendbddN) > $OUTPUT_FOLDER/cms_block_static.txt
echo "> see OUTPUT_FOLDER/cms_block_static.txt"

echo "Checking Database table:"
if [ -x myisamchk ]; then
	#check BDD:
	echo " - MyISAMCheck"
	#myisamchk -c -e $MYSQL_FOLDER/*.MYI  > $OUTPUT_FOLDER/myisamCheck.txt
	echo "   > see $OUTPUT_FOLDER/myisamCheck.txt"
else
    echo "> myisamchk not installed"
fi

echo "Looking for table configuration:"
cd $BASEFOLDER && magerun db:maintain:check-tables > $OUTPUT_FOLDER/list_table_config.txt
echo "> see $OUTPUT_FOLDER/list_table_config.txt"

#Check non Myisam table
echo " - MysqlCheck"
mysqlcheck -u $BDD_NAME  -p$BDD_PASS -c $bddName -h $BASEURL  > $OUTPUT_FOLDER/mysqlCheck.txt
echo "   > see $OUTPUT_FOLDER/mysqlCheck.txt"

echo "Compilation activated ?"
php $BASEFOLDER/shell/compiler.php state

#nombre de rewrites
echo "Analysing module rewrites:"
cd $BASEFOLDER && magerun dev:module:rewrite:list > $OUTPUT_FOLDER/list_rewrite.txt
echo "> see $OUTPUT_FOLDER/list_rewrite.txt"

#rewrites qui posent des soucis 
echo "Rewrites Conflics:"
cd $BASEFOLDER && magerun dev:module:rewrite:conflicts > $OUTPUT_FOLDER/conflicts_rewrite.txt
echo "> see $OUTPUT_FOLDER/conflicts_rewrite.txt"

#liste de tous les fichiers non utf8
echo "Non UTF-8 encoded files:"
cd $BASEFOLDER && find . -type f | xargs -I {} bash -c "iconv -f utf-8 -t utf-16 {} &>/dev/null || echo {}" > $OUTPUT_FOLDER./non-utf8.txt
echo "> see $OUTPUT_FOLDER/non-utf8.txt"

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






