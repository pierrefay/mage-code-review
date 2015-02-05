import os
import sys
import glob
import re
from repertoire import Repertoire

class Audit:

	def __init__(self):
		"""commentaires"""

	def lunchSearch(self, path, dossierLog):
		return self.nbrNamespaceAndModule(path, dossierLog);

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
			nombreDeNamespaces = rep.countFolders(path+'app/code/'+codePool+'/');
			nombreDeModules = 0
			nombreDeNamespacesTotal+=nombreDeNamespaces
			for namespace in namespaceDirs:
				nombreDeModules += rep.countFolders(path+'app/code/'+codePool+'/'+namespace+'/');
			nombreDeModulesTotal = nombreDeModulesTotal + nombreDeModules
			retour +=  "> codePool : "+codePool+" ("+str(nombreDeNamespaces)+" namespaces,"+str(nombreDeModules)+" modules) \n"
		retour+="\n"
		retour+="Total  :  "+str(nombreDeNamespacesTotal)+" namespaces et "+str(nombreDeModulesTotal)+" modules. \n"
		retour+="-----------------------\n"
		
		fichierlog = open(dossierLog+"etatModules.txt",'w')
		fwrite(fichierlog, retour)	
		fclsoe(fichierlog)	
		return retour


	# Fonction qui repere les loads dans les templates
	def analyserTemplates(self, path, dossierLog):	
		#variables utililsees pour les sorties des fonctions
		fichierLog = open(dossierLog+"load-in-template.txt", "w")
		nbrLoadInTemplate=0;
		
		#parcours
		rep = Repertoire()	
		dirs = os.listdir(path)		
		for ligne in dirs:			
			if os.path.isdir(path+ligne):
				nbrLoadInTemplate+= self.analyserTemplates(path+ligne+"/", fichierLog)
			else:
				#ici on est dans chaque fichier du dossier
				if(ligne.endswith('.phtml')):
					nbrLoadInTemplate += self.searchForLoads(path+ligne, fichierLog)					
				#elif(ligne.endswith('.xml')):		
		fichierLog.close()
		return nbrLoadInTemplate

	# Fonction qui repere les loads dans les templates
	def searchForLoads(self, path, fichierLog):		
		
		fichier = open(path, "r")
		nbrLigne=0	
		nbrLoads=0	
		for ligne in fichier:
			nbrLigne+=1
			if re.search("->load\(",ligne):
				log= path+"  | ligne "+str(nbrLigne)+"  | "+ligne.strip(" \t\n\r")+"\n"
				fichierLog.write(log);
				nbrLoads+=1
		return nbrLoads


