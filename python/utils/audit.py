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
	def analyserTemplates(self, path, dossierLog, tab):	
		#DEBUT LOADS IN TEMPLATES			
		rep = Repertoire()	
		if(tab is None):
			results = {}
			results['search_for_load']=[]
			results['search_for_getblock']=[]
			results['search_for_createblock']=[]
		else:
			results=tab

		dirs = os.listdir(path)	
		for ligne in dirs:			
			if os.path.isdir(path+ligne):
				self.analyserTemplates(path+ligne+"/", dossierLog, results)
			else:
				#ici on est dans chaque fichier du dossier
				if(ligne.endswith('.phtml')):

					#load dans les templates
					search_for_load =self.searchForLoad(path+ligne, dossierLog)
					if(len(search_for_load) is not 0):
						results['search_for_load'].append(search_for_load)

					#getblock dans les templates
					search_for_getblock =self.searchForGetblock(path+ligne, dossierLog)
					if(len(search_for_getblock) is not 0):
						results['search_for_getblock'].append(search_for_getblock)

					#createblock dans les templates
					search_for_createblock =self.searchForCreateblock(path+ligne, dossierLog)
					if(len(search_for_createblock) is not 0):
						results['search_for_createblock'].append(search_for_createblock)
	
				#elif(ligne.endswith('.xml')):	

		return results

	#
	# Fonction qui repere les loads dans les templates
	#
	def searchForLoad(self, path, dossierLog):
		fichier = open(path, 'r')
		nbrLigne=0	
		nbrLoads=0		
		retoursAll=[]
		for ligne in fichier:
			nbrLigne+=1	
			result = re.search("->load\(",ligne)					
			if result is not None:
				retours = {}
				retours['path'] = path
				retours['ligne'] = str(nbrLigne)  
				retours['contents']=ligne.strip(" \t\n\r")	
				retoursAll.append(retours)
				nbrLoads+=1
		return retoursAll


	#
	# Fonction qui repere les getBlock dans les templates
	#
	def searchForGetblock(self, path, dossierLog):
		fichier = open(path, 'r')
		nbrLigne=0	
		nbrLoads=0		
		retoursAll=[]
		for ligne in fichier:
			nbrLigne+=1	
			result = re.search("->getBlock\(",ligne)					
			if result is not None:
				retours = {}
				retours['path'] = path
				retours['ligne'] = str(nbrLigne)  
				retours['contents']=ligne.strip(" \t\n\r")	
				retoursAll.append(retours)
				nbrLoads+=1
		return retoursAll

	#
	# Fonction qui repere les createBlock dans les templates
	#
	def searchForCreateblock(self, path, dossierLog):
		fichier = open(path, 'r')
		nbrLigne=0	
		nbrLoads=0		
		retoursAll=[]
		for ligne in fichier:
			nbrLigne+=1	
			result = re.search("->createBlock\(",ligne)
			resultWidgetName = re.search("customer/widget_",ligne)					
			if ( result is not None ) and ( resultWidgetName is None ):
				retours = {}
				retours['path'] = path
				retours['ligne'] = str(nbrLigne)  
				retours['contents']=ligne.strip(" \t\n\r")	
				retoursAll.append(retours)
				nbrLoads+=1
		return retoursAll


