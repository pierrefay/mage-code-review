# -*-coding:Latin-1 -*
from utils.audit import Audit

audit = Audit()

dossierLog =  '/home/pierre/Documents/Projects/MagentoCodeAnalysis/logs/'
path = '/home/pierre/Documents/Projects/courir/courir/'

#analyse nombre de modules
audit.nbrNamespaceAndModule(path,dossierLog)

#RECHERCHE
resultTpl = audit.analyserTemplates(path+"app/design/frontend/", dossierLog, None)

###
###  Debut du fichier
###

loadsTemplatesLog = open(dossierLog+"load-in-template.html", "w")
loadsTemplatesLog.write("<head>")
loadsTemplatesLog.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">")
loadsTemplatesLog.write("</head>")
loadsTemplatesLog.write("<body>")

### Analyse des modules ###

### Loads dans templates  ###
loadsTemplatesLog.write("<h2>Loads dans les templates</h2>\n")
loadsTemplatesLog.write("<p>Ces appels prennent beaucoup de charges et ne permettent pas à magento d'utiliser le cache correctement. Il faut absolument sortir ces appels des fichiers des templates (.phtml) et les effectuer correctement dans les blocs.</p>\n")
loadsTemplatesLog.write("<table style=\"border:1px solid #000;text-align:left;\">\n")
loadsTemplatesLog.write("<tr><th>Fichier</th><th style=\"width:100px;\">Ligne</th><th>Code concerné</th></tr>\n")

tab=resultTpl['search_for_load']
for res in tab:
	loadsTemplatesLog.write("<tr><td>"+res[0]['path']+"</td><td>"+res[0]['ligne']+"</td><td>"+res[0]['contents']+"</td></tr>\n")

loadsTemplatesLog.write("</table>\n")

### getBlock dans templates  ###
loadsTemplatesLog.write("<h2>GetBlock dans les templates</h2>\n")
loadsTemplatesLog.write("<p>Ces appels empèchent magento d'utiliser le cache correctement. Il faut absolument sortir ces appels des fichiers des templates (.phtml) et utiliser correctement les layouts.</p>\n")
loadsTemplatesLog.write("<table style=\"border:1px solid #000;text-align:left;\">\n")
loadsTemplatesLog.write("<tr><th>Fichier</th><th style=\"width:100px;\">Ligne</th><th>Code concerné</th></tr>\n")

tab=resultTpl['search_for_getblock']
for res in tab:
	loadsTemplatesLog.write("<tr><td>"+res[0]['path']+"</td><td>"+res[0]['ligne']+"</td><td>"+res[0]['contents']+"</td></tr>\n")

loadsTemplatesLog.write("</table>\n")

### createBlock dans templates  ###
loadsTemplatesLog.write("<h2>CreateBlock dans les templates</h2>\n")
loadsTemplatesLog.write("<p>Ces blocs ne sont pas crées correctement, leur création devrait être dans le layout ou dans un contrôleur</p>\n")
loadsTemplatesLog.write("<table style=\"border:1px solid #000;text-align:left;\">\n")
loadsTemplatesLog.write("<tr><th>Fichier</th><th style=\"width:100px;\">Ligne</th><th>Code concerné</th></tr>\n")

tab=resultTpl['search_for_createblock']
for res in tab:
	loadsTemplatesLog.write("<tr><td>"+res[0]['path']+"</td><td>"+res[0]['ligne']+"</td><td>"+res[0]['contents']+"</td></tr>\n")

loadsTemplatesLog.write("</table>\n")

###
### Fin du fichier
###
loadsTemplatesLog.write("</body>")
loadsTemplatesLog.close()
