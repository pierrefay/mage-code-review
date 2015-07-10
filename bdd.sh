#!/bin/bash


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
	echo $(mysql -u $BDD_USERNAME  -p$BDD_USERPASS $BDD_NAME -h $BDD_HOST -N)
}
sendbdd(){
	echo $(mysql -u $BDD_USERNAME  -p$BDD_USERPASS $BDD_NAME -h $BDD_HOST)
}
sendbddT(){
	echo $(mysql --table -u $BDD_USERNAME  -p$BDD_USERPASS $BDD_NAME -h $BDD_HOST)
}


show_statistics()
{
	echo ""
	echo -e "\033[31m############################"
	echo -e "\033[31m### MAGENTO STATISTICS  ###"
	echo -e "\033[31m############################"
	echo ""
	echo "SELECT count(*) FROM $BDD_NAME.$BDD_PREFIX""core_website;" | echo -e "\033[37m- \033[32mNumber of websites:\033[37m  $(sendbddN)"
	echo "SELECT count(*) FROM $BDD_NAME.$BDD_PREFIX""core_store_group;" | echo -e "\033[37m- \033[32mNumber of stores:\033[37m $(sendbddN)"
	echo "SELECT count(*) FROM $BDD_NAME.$BDD_PREFIX""core_store;" | echo -e "\033[37m- \033[32mNumber of storeviews:\033[37m $(sendbddN)"
	echo "SELECT count(*) FROM $BDD_NAME.$BDD_PREFIX""sales_flat_order;" | echo -e "\033[37m- \033[32mNumber of orders:\033[37m $(sendbddN)"
	echo "SELECT count(*) FROM $BDD_NAME.$BDD_PREFIX""customer_entity;" | echo -e "\033[37m- \033[32mNumber of customers:\033[37m $(sendbddN)"
	echo "SELECT count(*) FROM $BDD_NAME.$BDD_PREFIX""customer_group;" | echo -e "\033[37m- \033[32mNumber of Client Groups:\033[37m $(sendbddN)"
	echo "SELECT count(*) FROM $BDD_NAME.$BDD_PREFIX""catalog_eav_attribute;" | echo -e "\033[37m- \033[32mNumber of attributes:\033[37m $(sendbddN)"
	echo "SELECT count(*) FROM $BDD_NAME.$BDD_PREFIX""catalog_product_entity;" | echo -e "\033[37m- \033[32mNumber of products:\033[37m $(sendbddN)"
	echo "SELECT count(*) FROM $BDD_NAME.$BDD_PREFIX""catalog_category_entity;" | echo -e "\033[37m- \033[32mNumber of categories:\033[37m $(sendbddN)"
	echo "SELECT count(*) FROM $BDD_NAME.$BDD_PREFIX""api_user;" | echo -e "\033[37m- \033[32mNomber of newsletter suscribers:\033[37m $(sendbddN)"
	echo "SELECT count(*) FROM $BDD_NAME.$BDD_PREFIX""admin_user;" | echo -e "\033[37m- \033[32mNumbers of API users:\033[37m $(sendbddN)"
	echo "SELECT count(*) FROM $BDD_NAME.$BDD_PREFIX""customer_group;" | echo -e "\033[37m- \033[32mNumber of admin users:\033[37m $(sendbddN)"
	echo "SELECT count(*) FROM $BDD_NAME.$BDD_PREFIX""cms_page;" | echo -e "\033[37m- \033[32mNumber of cms pages:\033[37m $(sendbddN)"
	echo "SELECT count(*) FROM $BDD_NAME.$BDD_PREFIX""cms_block;" | echo -e "\033[37m- \033[32mNomber of  cms pages:\033[37m $(sendbddN)"
	echo ""
}
show_database_size()
{
	echo -e "\033[31m##############################"
	echo -e "\033[31m### DATABASE TABLES SIZES  ###"
	echo -e "\033[31m##############################"
	echo ""
	echo "SELECT count(*) FROM $BDD_NAME.$BDD_PREFIX""log_customer" | echo -e  "\033[37m- \033[32mSize of logs customer:\033[37m $(sendbddN)"
	echo "SELECT count(*) FROM $BDD_NAME.$BDD_PREFIX""log_quote" | echo -e  "\033[37m- \033[32mSize of logs quote:\033[37m $(sendbddN)"
	echo "SELECT count(*) FROM $BDD_NAME.$BDD_PREFIX""log_summary" | echo -e  "\033[37m- \033[32mSize of logs summary:\033[37m $(sendbddN)"
	echo "SELECT count(*) FROM $BDD_NAME.$BDD_PREFIX""log_summary_type" | echo -e "\033[37m- \033[32mSize of logs summary type:\033[37m $(sendbddN)"
	echo "SELECT count(*) FROM $BDD_NAME.$BDD_PREFIX""log_url" | echo -e "\033[37m- \033[32mSize of logs url:\033[37m $(sendbddN)"
	echo "SELECT count(*) FROM $BDD_NAME.$BDD_PREFIX""log_url_info" | echo -e "\033[37m- \033[32mSize of logs url info:\033[37m $(sendbddN)"
	echo "SELECT count(*) FROM $BDD_NAME.$BDD_PREFIX""log_visitor" | echo -e "\033[37m- \033[32mSize of logs customer:\033[37m $(sendbddN)"
	echo "SELECT count(*) FROM $BDD_NAME.$BDD_PREFIX""log_visitor_info" | echo -e "\033[37m- \033[32mSize of logs info visitor:\033[37m $(sendbddN)"
	echo "SELECT count(*) FROM $BDD_NAME.$BDD_PREFIX""log_visitor_online" | echo -e "\033[37m- \033[32mSize of online visitor logs:\033[37m $(sendbddN)"
	echo "SELECT count(*) FROM $BDD_NAME.$BDD_PREFIX""sales_flat_quote" | echo -e "\033[37m- \033[32mSize of sales_flat_quote:\033[37m $(sendbddN)"
	echo "SELECT count(*) FROM $BDD_NAME.$BDD_PREFIX""core_url_rewrite;" | echo -e "\033[37m- \033[32mSize of core_url_rewrite:\033[37m $(sendbddN)"

	echo "SELECT value FROM $BDD_NAME.$BDD_PREFIX""core_config_data WHERE path LIKE 'catalog/frontend/flat_catalog_product';" | echo -e  "\033[37m- \033[32mFlat table product activated ?\033[37m $(yesno $(sendbddN))"
	echo "SELECT value FROM $BDD_NAME.$BDD_PREFIX""core_config_data WHERE path LIKE 'catalog/frontend/flat_catalog_category';" | echo -e "\033[37m- \033[32mFlat table catégorie activated ?\033[37m $(yesno $(sendbddN))"
}

show_theme_configuration()
{
	echo ""
	echo -e "\033[31m############################"
	echo -e "\033[31m### THEME CONFIGURATION  ###"
	echo -e "\033[31m############################"
	echo ""

	echo -e "\033[37m- \033[32mPackage used (scope, value) :"
	echo "SELECT scope, scope_id, value FROM $BDD_NAME.$BDD_PREFIX""core_config_data WHERE path LIKE 'design/package/name';" | echo -e "\033[37m  $(sendbddT)"
	echo ""

	echo -e "\033[37m- \033[32mTheme used (template) (scope, value):"
	echo "SELECT scope, scope_id, value FROM $BDD_NAME.$BDD_PREFIX""core_config_data WHERE path LIKE 'design/theme/template';" |  echo -e "\033[37m $(sendbddT)"
	echo ""

	echo -e "\033[37m- \033[32mThemes used (layout) (scope, value):"
	echo "SELECT scope, scope_id, value FROM $BDD_NAME.$BDD_PREFIX""core_config_data WHERE path LIKE 'design/theme/layout';" |  echo -e "\033[37m $(sendbddT)"
	echo ""

	echo -e "\033[37m- \033[32mTemes used (skin) (scope, value):"
	echo "SELECT scope, scope_id, value FROM $BDD_NAME.$BDD_PREFIX""core_config_data WHERE path LIKE 'design/theme/skin';" |  echo -e "\033[37m $(sendbddT)"
	echo ""

	echo -e "\033[37m- \033[32mTemes used (default) (scope, value): " 
	echo "SELECT value FROM $BDD_NAME.$BDD_PREFIX""core_config_data WHERE path LIKE 'dev/js/merge_files';" | echo -e "\033[37m- \033[32mJS merge activated ?\033[37m $(yesno $(sendbddN))"
	echo "SELECT value FROM $BDD_NAME.$BDD_PREFIX""core_config_data WHERE path LIKE 'dev/css/merge_css_files';" | echo -e "\033[37m- \033[32mCSS merge activated ?\033[37m $(yesno $(sendbddN))"
}

show_security()
{
	echo ""
	echo -e "\033[31m####################"
	echo -e "\033[31m### SECURITY    ####"
	echo -e "\033[31m####################"
	echo ""

	echo "SELECT value FROM $BDD_NAME.$BDD_PREFIX""core_config_data WHERE path LIKE 'web/secure/use_in_frontend';" | echo -e "\033[37m- \033[32mUse frontend SSL:\033[37m $(yesno $(sendbddN))"
	echo "SELECT value FROM $BDD_NAME.$BDD_PREFIX""core_config_data WHERE path LIKE 'web/secure/use_in_frontend';" | echo -e "\033[37m- \033[32mUse admin SSL:\033[37m $(yesno $(sendbddN))"
	echo "SELECT value FROM $BDD_NAME.$BDD_PREFIX""core_config_data WHERE path LIKE 'dev/log/active';" | echo -e "\033[37m- \033[32mAre the logs activated ?\033[37m $(echo $(yesno  $(sendbddN)))"
	echo "SELECT value FROM $BDD_NAME.$BDD_PREFIX""core_config_data WHERE path LIKE 'dev/log/file';" | echo -e "\033[37m- \033[32mLog file:\033[37m  $(sendbddN)" 
	echo "SELECT value FROM $BDD_NAME.$BDD_PREFIX""core_config_data WHERE path LIKE 'dev/log/exception_file';" | echo -e "\033[37m- \033[32mException file:\033[37m $(sendbddN)"
	echo "SELECT value FROM $BDD_NAME.$BDD_PREFIX""core_config_data WHERE path LIKE 'web/cookie/cookie_lifetime';" | echo -e "\033[37m- \033[32mCookie lifetime:\033[37m $(sendbddN)"
	echo "SELECT value FROM $BDD_NAME.$BDD_PREFIX""core_config_data WHERE path LIKE 'dev/restrict/allow_ips';" | echo -e "\033[37m- \033[32mIP Restrictions on the profiler ?\033[37m  $(sendbddN)"
	echo "SELECT value FROM $BDD_NAME.$BDD_PREFIX""core_config_data WHERE path LIKE 'dev/debug/profiler';" | echo -e "\033[37m- \033[32mProfiler activated ?\033[37m  $(yesno $(sendbddN))"
}

show_bad_practices()
{
	echo ""
	echo -e "\033[31m#####################"
	echo -e "\033[31m### BAD PRACTICE  ###"
	echo -e "\033[31m#####################"
	echo ""
	echo "SELECT count(*) FROM $BDD_NAME.$BDD_PREFIX""core_translate;" | echo -e "\033[37m- \033[32mTranslation in core_translate table:\033[37m $(sendbddN)"
	echo "SELECT value FROM $BDD_NAME.$BDD_PREFIX""core_config_data WHERE path LIKE 'dev/translate_inline/active';" | echo -e "\033[37m- \033[32mInline translation activated on frontend ?\033[37m $(yesno $(sendbdd))"
	echo "SELECT value FROM $BDD_NAME.$BDD_PREFIX""core_config_data WHERE path LIKE 'tax/calculation/price_includes_tax';" | echo -e "\033[37m- \033[32mShow catalog price including tax ?\033[37m  $(yesno $(sendbddN))"
	echo "SELECT value FROM $BDD_NAME.$BDD_PREFIX""core_config_data WHERE path LIKE 'tax/calculation/shipping_includes_tax';" | echo -e "\033[37m- \033[32mShow shipping price including tax ?\033[37m $(yesno $(sendbddN))"

	echo -e "\033[37m- \033[32mIs there static url in pages ?"
	echo "SELECT identifier FROM $BDD_NAME.$BDD_PREFIX""cms_page where content like '%http://$BASEURL%';" | echo $(sendbddN) > $OUTPUT_FOLDER/cms_page_static.txt 
	echo -e "\033[32m" 
	cat $OUTPUT_FOLDER/cms_page_static.txt

	echo ""
	echo -e "\033[32m  >\033[37m see $OUTPUT_FOLDER/cms_page_static.txt"
	echo -e "\033[37m- \033[32mIs there static url in cms blocks ?"
	echo "SELECT identifier FROM $BDD_NAME.$BDD_PREFIX""cms_block where content like '%http://$BASEURL%';" | echo $(sendbddN) > $OUTPUT_FOLDER/cms_block_static.txt
	echo -e "\033[32m" 
	cat $OUTPUT_FOLDER/cms_block_static.txt

	echo ""
	echo -e "\033[32m  >\033[37m see $OUTPUT_FOLDER/cms_block_static.txt"
	echo -e "\033[37m- \033[32mNon UTF-8 encoded files:"
	cd $BASEFOLDER && find $BASEFOLDER/app/ -type f | xargs -I {} bash -c "iconv -f utf-8 -t utf-16 {} &>/dev/null || echo {}" > $OUTPUT_FOLDER/non-utf8.txt
	echo -e "\033[32m" 
	cat $OUTPUT_FOLDER/non-utf8.txt
	echo ""
	echo -e "\033[32m>\033[37m see $OUTPUT_FOLDER/no-utf8.txt"

	echo -e "\033[37m- \033[32mCompilation state:"
	echo -e "\033[37m $(php $BASEFOLDER/shell/compiler.php state)"
}

show_database_check()
{
	echo ""
	echo -e "\033[31m########################"
	echo -e "\033[31m### DATABASE CHECK   ###"
	echo -e "\033[31m########################"
	echo ""

	echo -e "\033[37m- \033[32mChecking Database table:"
	if [ -x myisamchk ]; then
		#check BDD:
		echo -e "\033[37m  - \033[32mMyISAMCheck"
		#myisamchk -c -e $MYSQL_FOLDER/*.MYI  > $OUTPUT_FOLDER/myisamCheck.txt
		echo "    >\033[37m see $OUTPUT_FOLDER/myisamCheck.txt"
		cat $OUTPUT_FOLDER/myisamCheck.txt
	else
	    echo -e "\033[32m    >\033[37m myisamchk not installed"
	fi

	echo -e "\033[37m- \033[32mLooking for table configuration:"
	cd $BASEFOLDER && magerun db:maintain:check-tables > $OUTPUT_FOLDER/list_table_config.txt
	echo -e "\033[32m    >\033[37m see $OUTPUT_FOLDER/list_table_config.txt"
	cat $OUTPUT_FOLDER/list_table_config.txt

	echo -e "\033[32m - MysqlCheck"
	mysqlcheck -u $BDD_NAME  -p$BDD_PASS -c $BDD_NAME -h $BASEURL > $OUTPUT_FOLDER/mysqlCheck.txt
	echo -e "\033[32m   >\033[37m see $OUTPUT_FOLDER/mysqlCheck.txt"
	cat $OUTPUT_FOLDER/mysqlCheck.txt
}

show_rewrites()
{
	echo ""
	echo -e "\033[31m#######################"
	echo -e "\033[31m### PLUGIN REWRITE  ###"
	echo -e "\033[31m#######################"
	echo ""

	echo -e "\033[32mAnalysing module rewrites:"
	cd $BASEFOLDER && magerun dev:module:rewrite:list > $OUTPUT_FOLDER/list_rewrite.txt
	echo -e "\033[32m>\033[37m see $OUTPUT_FOLDER/list_rewrite.txt"
	echo -e "\033[32m" 
	cat $OUTPUT_FOLDER/list_rewrite.txt
	 
	echo -e "\033[32mRewrites Conflics:"
	cd $BASEFOLDER && magerun dev:module:rewrite:conflicts > $OUTPUT_FOLDER/conflicts_rewrite.txt
	echo -e "\033[32m>\033[37m see $OUTPUT_FOLDER/conflicts_rewrite.txt"
	echo -e "\033[32m" 
	cat $OUTPUT_FOLDER/conflicts_rewrite.txt
}



echo -e "\033[37m"

if [ "$#" -ne 2 ]; then
	echo "Illegal number of parameters use :  <magento_folder> <mysql_folder>"   
	BASEFOLDER="/var/www/html"
	MYSQL_FOLDER="/data/tabledarc/mysql"
	#exit
else
	BASEFOLDER="$1"
	BASEURL="$2"
fi
   
BDD_HOST=$(python "$BASEFOLDER/mage-code-review/getConfig.py" "host")
BDD_PREFIX=$(python "$BASEFOLDER/mage-code-review/getConfig.py" "prefix")
BDD_NAME=$(python "$BASEFOLDER/mage-code-review/getConfig.py" "name")
BDD_USERNAME=$(python "$BASEFOLDER/mage-code-review/getConfig.py" "username")
BDD_USERPASS=$(python "$BASEFOLDER/mage-code-review/getConfig.py" "userpass")
OUTPUT_FOLDER="$BASEFOLDER/codetest"

if [ -d "$BASEFOLDER/codetest" ]
then
	echo ""
else
	mkdir $BASEFOLDER/codetest 
	chmod 777 $BASEFOLDER/codetest
fi


while [ $# -gt 0 ]
do
    case $1 in
        -stat) echo "$(show_statistics)" ;;

	-db:size) echo "$(show_database_size)" ;;

	-db:check) echo "$(show_database_check)" ;;

	-practice:bad) echo "$(show_bad_practices)" ;;

	-practice:security) echo "$(show_security)" ;;

	-config:rewrite) echo "$(show_rewrites)" ;;

	-theme:config) echo "$(show_theme_configuration)" ;;

	--all)  echo "$(show_statistics)" echo "$(show_database_size)"	echo "$(show_bad_practices)" echo "$(show_security)" 	echo "$(show_rewrites)"  echo "$(show_theme_configuration)" ;;
	--help) 
		echo -e "\033[32m -stat			\033[37mGet all statistics about your magento platform" 
		echo -e "\033[32m -db:size		\033[37mGet the size of all your database table"
		echo -e "\033[32m -practice:bad		\033[37mGet all your bad practices" 
		echo -e "\033[32m -practice:security	\033[37mGet all security bad practices" 
		echo -e "\033[32m -config:rewrite	\033[37mGet all informations about your rewrite"  
		echo -e "\033[32m -theme:config		\033[37mGet all informations about the use of your theme"
		echo -e "\033[32m --all			\033[37mLaunch a full analysis of your plateform" 
		echo -e "\033[32m --help			\033[37mGet Help about this command  (that's why you've got this message)" 

    esac
    shift
done
echo -e "\033[37m"
exit



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





