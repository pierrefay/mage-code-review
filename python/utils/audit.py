import os
import sys
import glob
import re
from repertoire import Repertoire

class Audit:

	def __init__(self):
		"""commentaires"""

	# Fonction qui liste le nombre de namespaces et de modules	
	def nbrNamespaceAndModule(self, path, dossierLog):
		retour="-----------------------\n"
		retour+="Analyses des modules  \n"
		retour+="-----------------------\n"
		rep = Repertoire()
		codePoolDirs = os.listdir(path+'app/code/')			
		nombreDeModulesTotal = 0
		nombreDeNamespacesTotal = 0	
		for codePool in codePoolDirs:
			namespaceDirs = os.listdir(path+'app/code/'+codePool+'/')
			nombreDeNamespaces = rep.countFolders(path+'app/code/'+codePool+'/')
			nombreDeModules = 0
			nombreDeNamespacesTotal+=nombreDeNamespaces
			for namespace in namespaceDirs:
				nombreDeModules += rep.countFolders(path+'app/code/'+codePool+'/'+namespace+'/')
			nombreDeModulesTotal = nombreDeModulesTotal + nombreDeModules
			retour +=  "> codePool : "+codePool+" ("+str(nombreDeNamespaces)+" namespaces,"+str(nombreDeModules)+" modules) \n"
		retour+="\n"
		retour+="Total  :  "+str(nombreDeNamespacesTotal)+" namespaces et "+str(nombreDeModulesTotal)+" modules. \n"
		retour+="-----------------------\n"
		
		fichierlog = open(dossierLog+"etatModules.txt",'w+')
		fichierlog.write(retour)	
		fichierlog.close()	
		return retour


	# Fonction qui analyse les templates
	def analyserTemplates(self, path, dossierLog):	

		#DEBUT LOADS IN TEMPLATES		
		rep = Repertoire()	
		dirs = os.listdir(path)	
		for ligne in dirs:			
			if os.path.isdir(path+ligne):
				self.analyserTemplates(path+ligne+"/", dossierLog)
			else:
				#ici on est dans chaque fichier du dossier
				if(ligne.endswith('.phtml')):
					self.searchForLoads(path+ligne, dossierLog)	
				#elif(ligne.endswith('.xml')):	

		return None

	# Fonction qui repere les loads dans les templates
	def searchForLoads(self, path, dossierLog):
		fichier = open(path, 'r')
		nbrLigne=0	
		nbrLoads=0		
		fichierLog = open(dossierLog+"load-in-template.html", "a+")	
		for ligne in fichier:
			nbrLigne+=1	
			result = re.search("->load\(",ligne)
					
			if result is not None:
				fichierLog.write("<tr><td>"+path+"</td><td>"+str(nbrLigne)+"</td><td>"+ligne.strip(" \t\n\r")+"</td></tr>\n")	
				nbrLoads+=1

		fichierLog.close()
		return nbrLoads


