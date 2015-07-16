# -*- coding: iso-8859-1 -*-
import os,sys
from utils.audit import Audit
from prettytable import PrettyTable

audit = Audit()

dossierLog =  '/var/www/html/codetest/'
path = '/var/www/html/'

result = audit.analyserLeCode(path, dossierLog, None)
etatPlateforme = audit.nbrNamespaceAndModule(path,dossierLog)


############################
###     ETAT GENERAL     ###
############################
fileToWrite = open(dossierLog+"number_of_modules.txt", "w")
fileToWrite.write("################################\n")
fileToWrite.write("###   Modules and namespaces ###\n")
fileToWrite.write("################################\n")
fileToWrite.write(etatPlateforme)
fileToWrite.write("\n\n")


#############################
### Loads dans templates  ###
#############################
fileToWrite = open(dossierLog+"loads_in_templates.txt", "w")
fileToWrite.write("###############################\n")
fileToWrite.write("###    Loads in templates   ###\n")
fileToWrite.write("###############################\n")
fileToWrite.write("\n")
x = PrettyTable(["File", "Line", "Beginning of the line"])
x.padding_width = 1
tab=result['template_search_for_load']
for res in tab:
	x.add_row([res[0]['path'] , res[0]['ligne'] , res[0]['contents']])
fileToWrite.write(x.get_string())
fileToWrite.write("\n\n")


###################################
### createBlock in templates    ###
###################################
fileToWrite = open(dossierLog+"createblock_in_templates.txt", "w")
fileToWrite.write("#####################################\n")
fileToWrite.write("###    createBlock in templates   ###\n")
fileToWrite.write("#####################################\n")
fileToWrite.write("\n")
x = PrettyTable(["File", "Line", "Beginning of the line"])
x.padding_width = 1
tab=result['template_search_for_createblock']
for res in tab:
	x.add_row([res[0]['path'] , res[0]['ligne'] , res[0]['contents']])
fileToWrite.write(x.get_string())
fileToWrite.write("\n\n")

###################################
###      new in templates       ###
###################################
fileToWrite = open(dossierLog+"new_in_templates.txt", "w")
fileToWrite.write("#####################################\n")
fileToWrite.write("###        new in templates       ###\n")
fileToWrite.write("#####################################\n")
fileToWrite.write("\n")
x = PrettyTable(["File", "Line", "Beginning of the line"])
x.padding_width = 1
tab=result['template_search_for_new']
for res in tab:
	x.add_row([res[0]['path'] , res[0]['ligne'] , res[0]['contents']])

fileToWrite.write(x.get_string())
fileToWrite.write("\n\n")

###################################
### PHP globals dans templates  ###
###################################
fileToWrite = open(dossierLog+"php_in_templates.txt", "w")
fileToWrite.write("#####################################\n")
fileToWrite.write("###  PHP functions in templates   ###\n")
fileToWrite.write("#####################################\n")
fileToWrite.write("\n")
x = PrettyTable(["File", "Line", "Beginning of the line"])
x.padding_width = 1
tab=result['template_global_php']
for res in tab:
	x.add_row([res[0]['path'] , res[0]['ligne'] , res[0]['contents']])

fileToWrite.write(x.get_string())
fileToWrite.write("\n\n")

#######################################
### Fonctions mysql dans templates  ###
#######################################
fileToWrite = open(dossierLog+"mysql_in_templates.txt", "w")
fileToWrite.write("#####################################\n")
fileToWrite.write("###  Mysql functions in templates   ###\n")
fileToWrite.write("#####################################\n")
fileToWrite.write("\n")
x = PrettyTable(["File", "Line", "Beginning of the line"])
x.padding_width = 1
tab=result['template_mysql']
for res in tab:
	x.add_row([res[0]['path'] , res[0]['ligne'] , res[0]['contents']])

fileToWrite.write(x.get_string())
fileToWrite.write("\n\n")

#######################################
###     Logs dans les templates     ###
#######################################
fileToWrite = open(dossierLog+"logs_in_templates.txt", "w")
fileToWrite.write("#####################################\n")
fileToWrite.write("###    Logs dans les templates    ###\n")
fileToWrite.write("#####################################\n")
fileToWrite.write("\n")
x = PrettyTable(["File", "Line", "Beginning of the line"])
x.padding_width = 1
tab=result['template_logs']
for res in tab:
	x.add_row([res[0]['path'] , res[0]['ligne'] , res[0]['contents']])
fileToWrite.write(x.get_string())
fileToWrite.write("\n\n")

#########################
### new in the code   ###
#########################
fileToWrite = open(dossierLog+"new_in_code.txt", "w")
fileToWrite.write("########################\n")
fileToWrite.write("### new in the code  ###\n")
fileToWrite.write("########################\n")
fileToWrite.write("\n")
x = PrettyTable(["File", "Line", "Beginning of the line"])
x.padding_width = 1
tab=result['code_search_for_new']
for res in tab:
	x.add_row([res[0]['path'] , res[0]['ligne'] , res[0]['contents']])
fileToWrite.write(x.get_string())
fileToWrite.write("\n\n")

#################################
### php function in the code  ###
#################################
fileToWrite = open(dossierLog+"php_in_code.txt", "w")
fileToWrite.write("#################################\n")
fileToWrite.write("### php function in the code  ###\n")
fileToWrite.write("#################################\n")
fileToWrite.write("\n")
x = PrettyTable(["File", "Line", "Beginning of the line"])
x.padding_width = 1
tab=result['code_global_php']
for res in tab:
	x.add_row([res[0]['path'] , res[0]['ligne'] , res[0]['contents']])
fileToWrite.write(x.get_string())
fileToWrite.write("\n\n")

##################################
### logs function in the code  ###
##################################
fileToWrite = open(dossierLog+"logs_in_code.txt", "w")
fileToWrite.write("###################################\n")
fileToWrite.write("### logs functions in the code  ###\n")
fileToWrite.write("###################################\n")
fileToWrite.write("\n")
x = PrettyTable(["File", "Line", "Beginning of the line"])
x.padding_width = 1
tab=result['code_logs']
for res in tab:
	x.add_row([res[0]['path'] , res[0]['ligne'] , res[0]['contents']])
fileToWrite.write(x.get_string())
fileToWrite.write("\n\n")

#################################
###    Mysql dans le code     ###
#################################
fileToWrite = open(dossierLog+"mysql_in_code.txt", "w")
fileToWrite.write("#################################\n")
fileToWrite.write("###   Mysql dans le code      ###\n")
fileToWrite.write("#################################\n")
fileToWrite.write("\n")
x = PrettyTable(["File", "Line", "Beginning of the line"])
x.padding_width = 1
tab=result['code_mysql']
for res in tab:
	x.add_row([res[0]['path'] , res[0]['ligne'] , res[0]['contents']])
fileToWrite.write(x.get_string())
fileToWrite.write("\n\n")








