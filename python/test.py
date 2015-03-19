# -*-coding:Latin-1 -*
from utils.audit import Audit

audit = Audit()

dossierLog =  '/home/pierre/Documents/Projects/MagentoCodeAnalysis/logs/'
path = '/home/pierre/Documents/Projects/courir/courir/'

#analyse nombre de modules
audit.nbrNamespaceAndModule(path,dossierLog)

#loads dans templates
loadsTemplatesLog = open(dossierLog+"load-in-template.html", "w")
loadsTemplatesLog.write("<head>")
loadsTemplatesLog.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">")
loadsTemplatesLog.write("</head>")
loadsTemplatesLog.write("<body>")
loadsTemplatesLog.write("<h2>Loads dans les templates</h2>\n")
loadsTemplatesLog.write("<p>Ces appels prennent beaucoup de charges et ne permettent pas à magento d'utiliser le cache correctement. Il faut absolument sortir ces appels des fichiers des templates (.phtml) et les effectuer correctement dans les blocs.</p>\n")
loadsTemplatesLog.write("<table style=\"border:1px solid #000;text-align:left;\">\n")
loadsTemplatesLog.write("<tr><th>Fichier</th><th style=\"width:100px;\">Ligne</th><th>Code concerné</th></tr>\n")
loadsTemplatesLog.write("</body>")
loadsTemplatesLog.close()

#RECHERCHE
audit.analyserTemplates(path+"app/design/frontend/", dossierLog)

#fin loads des templates
loadsTemplatesLog = open(dossierLog+"load-in-template.html", "a")
loadsTemplatesLog.write("</table>\n")
loadsTemplatesLog.close()
