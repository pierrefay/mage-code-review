# -*-coding:Latin-1 -*
from utils.audit import Audit

audit = Audit()

dossierLog =  '/home/pierre/Documents/Projects/MagentoCodeAnalysis/logs/'
path = '/home/pierre/Documents/Projects/courir/courir/'


#on lance toutes les recherches
result = audit.analyserLeCode(path, dossierLog, None)
etatPlateforme = audit.nbrNamespaceAndModule(path,dossierLog)


#on construit le rapport


############################
###   Debut du fichier   ###
############################

loadsTemplatesLog = open(dossierLog+"load-in-template.html", "w")
loadsTemplatesLog.write("<head>")
loadsTemplatesLog.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">")
loadsTemplatesLog.write("</head>")
loadsTemplatesLog.write("<body>")

############################
###     ETAT GENERAL     ###
############################
loadsTemplatesLog.write("<h2>Etat général de la plateforme</h2>\n")
### Analyse des modules ###
loadsTemplatesLog.write("<h3>Modules et namespaces</h3>\n")
loadsTemplatesLog.write(etatPlateforme)

############################
###      TEMPLATES       ###
############################
loadsTemplatesLog.write("<h2>Etat des templates</h2>\n")

#############################
### Loads dans templates  ###
loadsTemplatesLog.write("<h3>Loads dans les templates</h3>\n")
loadsTemplatesLog.write("<p>Ces appels prennent beaucoup de charges et ne permettent pas à magento d'utiliser le cache correctement. Il faut absolument sortir ces appels des fichiers des templates (.phtml) et les effectuer correctement dans les blocs.</p>\n")
loadsTemplatesLog.write("<table style=\"border:1px solid #000;text-align:left;\">\n")
loadsTemplatesLog.write("<tr><th>Fichier</th><th style=\"width:100px;\">Ligne</th><th>Code concerné</th></tr>\n")

tab=result['template_search_for_load']
for res in tab:
	loadsTemplatesLog.write("<tr><td>"+res[0]['path']+"</td><td>"+res[0]['ligne']+"</td><td>"+res[0]['contents']+"</td></tr>\n")
loadsTemplatesLog.write("</table>\n")

############################
### getBlock dans templates  ###
loadsTemplatesLog.write("<h3>GetBlock dans les templates</h3>\n")
loadsTemplatesLog.write("<p>Ces appels empèchent magento d'utiliser le cache correctement. Il faut absolument sortir ces appels des fichiers des templates (.phtml) et utiliser correctement les layouts.</p>\n")
loadsTemplatesLog.write("<table style=\"border:1px solid #000;text-align:left;\">\n")
loadsTemplatesLog.write("<tr><th>Fichier</th><th style=\"width:100px;\">Ligne</th><th>Code concerné</th></tr>\n")

tab=result['template_search_for_getblock']
for res in tab:
	loadsTemplatesLog.write("<tr><td>"+res[0]['path']+"</td><td>"+res[0]['ligne']+"</td><td>"+res[0]['contents']+"</td></tr>\n")
loadsTemplatesLog.write("</table>\n")

###################################
### createBlock dans templates  ###
loadsTemplatesLog.write("<h3>CreateBlock dans les templates</h3>\n")
loadsTemplatesLog.write("<p>Ces blocs ne sont pas crées correctement, leur création devrait être dans le layout ou dans un contrôleur</p>\n")
loadsTemplatesLog.write("<table style=\"border:1px solid #000;text-align:left;\">\n")
loadsTemplatesLog.write("<tr><th>Fichier</th><th style=\"width:100px;\">Ligne</th><th>Code concerné</th></tr>\n")

tab=result['template_search_for_createblock']
for res in tab:
	loadsTemplatesLog.write("<tr><td>"+res[0]['path']+"</td><td>"+res[0]['ligne']+"</td><td>"+res[0]['contents']+"</td></tr>\n")
loadsTemplatesLog.write("</table>\n")


###################################
### new dans templates  ###
loadsTemplatesLog.write("<h3>New dans les templates</h3>\n")
loadsTemplatesLog.write("<p>On utilise jamais une instanciation directement via un \"new\" sur magento.</p>\n")
loadsTemplatesLog.write("<table style=\"border:1px solid #000;text-align:left;\">\n")
loadsTemplatesLog.write("<tr><th>Fichier</th><th style=\"width:100px;\">Ligne</th><th>Code concerné</th></tr>\n")

tab=result['template_search_for_new']
for res in tab:
	loadsTemplatesLog.write("<tr><td>"+res[0]['path']+"</td><td>"+res[0]['ligne']+"</td><td>"+res[0]['contents']+"</td></tr>\n")
loadsTemplatesLog.write("</table>\n")

###################################
### PHP globals dans templates  ###
loadsTemplatesLog.write("<h3>Appels PHP globals les templates</h3>\n")
loadsTemplatesLog.write("<p>On utilise jamais ces fonctions dans magento pour des raisons de sécurité. à la place de $_POST préférer $this->getRequest()->getPost() par exemple.</p>\n")
loadsTemplatesLog.write("<table style=\"border:1px solid #000;text-align:left;\">\n")
loadsTemplatesLog.write("<tr><th>Fichier</th><th style=\"width:100px;\">Ligne</th><th>Code concerné</th></tr>\n")

tab=result['template_global_php']
for res in tab:
	loadsTemplatesLog.write("<tr><td>"+res[0]['path']+"</td><td>"+res[0]['ligne']+"</td><td>"+res[0]['contents']+"</td></tr>\n")
loadsTemplatesLog.write("</table>\n")

###################################
### Fonctions mysql dans templates  ###
loadsTemplatesLog.write("<h3>Appels aux fonctions mysql dans les templates</h3>\n")
loadsTemplatesLog.write("<p>Magento utilise des objets pour dialoguer directement avec la base de donnée, il ne faut jamais utiliser les fonctions \"mysql_\" de php.</p>\n")
loadsTemplatesLog.write("<table style=\"border:1px solid #000;text-align:left;\">\n")
loadsTemplatesLog.write("<tr><th>Fichier</th><th style=\"width:100px;\">Ligne</th><th>Code concerné</th></tr>\n")

tab=result['template_mysql']
for res in tab:
	loadsTemplatesLog.write("<tr><td>"+res[0]['path']+"</td><td>"+res[0]['ligne']+"</td><td>"+res[0]['contents']+"</td></tr>\n")
loadsTemplatesLog.write("</table>\n")

############################
###         CODE         ###
############################

loadsTemplatesLog.write("<h2>Etat du code</h2>\n")

#########################
### new dans le code  ###
loadsTemplatesLog.write("<h3>New dans le code</h3>\n")
loadsTemplatesLog.write("<p>On utilise jamais une instanciation directement via un \"new\" sur magento.</p>\n")
loadsTemplatesLog.write("<table style=\"border:1px solid #000;text-align:left;\">\n")
loadsTemplatesLog.write("<tr><th>Fichier</th><th style=\"width:100px;\">Ligne</th><th>Code concerné</th></tr>\n")

tab=result['code_search_for_new']
for res in tab:
	loadsTemplatesLog.write("<tr><td>"+res[0]['path']+"</td><td>"+res[0]['ligne']+"</td><td>"+res[0]['contents']+"</td></tr>\n")
loadsTemplatesLog.write("</table>\n")

#################################
### PHP globals dans le code  ###
loadsTemplatesLog.write("<h3>Appels PHP globals le code</h3>\n")
loadsTemplatesLog.write("<p>On utilise jamais ces fonctions dans magento pour des raisons de sécurité. à la place de $_POST préférer $this->getRequest()->getPost() par exemple.</p>\n")
loadsTemplatesLog.write("<table style=\"border:1px solid #000;text-align:left;\">\n")
loadsTemplatesLog.write("<tr><th>Fichier</th><th style=\"width:100px;\">Ligne</th><th>Code concerné</th></tr>\n")

tab=result['code_global_php']
for res in tab:
	loadsTemplatesLog.write("<tr><td>"+res[0]['path']+"</td><td>"+res[0]['ligne']+"</td><td>"+res[0]['contents']+"</td></tr>\n")
loadsTemplatesLog.write("</table>\n")

#################################
###    Mysql dans le code  ###
loadsTemplatesLog.write("<h3>Appels aux fonctions mysql dans le code</h3>\n")
loadsTemplatesLog.write("<p>Magento utilise des objets pour dialoguer directement avec la base de donnée, il ne faut jamais utiliser les fonctions \"mysql_\" de php.</p>\n")
loadsTemplatesLog.write("<table style=\"border:1px solid #000;text-align:left;\">\n")
loadsTemplatesLog.write("<tr><th>Fichier</th><th style=\"width:100px;\">Ligne</th><th>Code concerné</th></tr>\n")

tab=result['code_mysql']
for res in tab:
	loadsTemplatesLog.write("<tr><td>"+res[0]['path']+"</td><td>"+res[0]['ligne']+"</td><td>"+res[0]['contents']+"</td></tr>\n")
loadsTemplatesLog.write("</table>\n")


############################
###     ANALYSE BDD      ###
############################


###
### Fin du fichier
###
loadsTemplatesLog.write("</body>")
loadsTemplatesLog.close()
