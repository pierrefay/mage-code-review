import os
import sys
import glob
import re
import cgi
import zlib
from utils.repertoire import Repertoire

class Audit:

	def __init__(self):
		"""commentaires"""

	# Fonction qui liste le nombre de namespaces et de modules	
	def nbrNamespaceAndModule(self, path, dossierLog):
		retour=""
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
			retour +=  "- codePool : "+codePool+" ("+str(nombreDeNamespaces)+" namespaces, "+str(nombreDeModules)+" modules) \n"
		retour+="\n## Total  : "+str(nombreDeNamespacesTotal)+" namespaces et "+str(nombreDeModulesTotal)+"\n"
		retour+="\n"
		
		return retour


	# Fonction qui analyse les templates
	def analyserLeCode(self, path, dossierLog, tab):	
		#DEBUT LOADS IN TEMPLATES			
		rep = Repertoire()	
		if(tab is None):
			results = {}
			#code
			results['code_search_for_new']=[]
			results['code_global_php']=[]
			results['code_mysql']=[]
			results['code_logs']=[]
			#templates
			results['template_search_for_load']=[]
			results['template_search_for_getblock']=[]
			results['template_search_for_createblock']=[]
			results['template_search_for_new']=[]
			results['template_global_php']=[]
			results['template_mysql']=[]
			results['template_logs']=[]
		else:
			results=tab

		dirs = os.listdir(path)	
		for ligne in dirs:		
			if os.path.isdir(path+ligne):
				self.analyserLeCode(path+ligne+"/", dossierLog, results)
			else:
				#ici on est dans chaque fichier du dossier
				if(re.search(r"app",path+ligne)):
					#si dans le code
					if(re.search(r"app\/code\/core",path+ligne)):
						continue

					#si dans le code
					if(re.search(r"app\/code",path+ligne)):

						#ici on est dans chaque fichier PHP
						if(ligne.endswith('.php')):
						
							#new dans le  code
							search_for_new =self.searchForNew(path+ligne, dossierLog,1)
							if(len(search_for_new) is not 0):
								results['code_search_for_new'].append(search_for_new)
							
#load in loop dans le  code
							search_for_code_load_in_loop =self.searchForLoadInLoop(path+ligne, dossierLog)
							
							#globalPHP dans le  code
							search_for_globalphp =self.searchForPhpGlobals(path+ligne, dossierLog)
							if(len(search_for_globalphp) is not 0):
								results['code_global_php'].append(search_for_globalphp)

							#fonctions mysql_ dans le code
							search_for_mysql =self.searchForMysql(path+ligne, dossierLog)
							if(len(search_for_mysql) is not 0):
								results['code_mysql'].append(search_for_mysql)

							#fonctions logs dans le code
							search_for_logs =self.searchForLogs(path+ligne, dossierLog)
							if(len(search_for_logs) is not 0):
								results['code_logs'].append(search_for_logs)
							

					#si dans design
					if(re.search(r"app\/design",path+ligne)):	
			
						#ici on est dans chaque fichier du dossier 
						if(ligne.endswith('.phtml')):

							#load dans les templates
							search_for_load =self.searchForLoad(path+ligne, dossierLog)
							if(len(search_for_load) is not 0):
								results['template_search_for_load'].append(search_for_load)

							#search for load in loop dans les templates
							search_for_load_in_loop =self.searchForLoadInLoop(path+ligne, dossierLog)
							
							#getblock dans les templates
							search_for_getblock =self.searchForGetblock(path+ligne, dossierLog)
							if(len(search_for_getblock) is not 0):
								results['template_search_for_getblock'].append(search_for_getblock)

							#createblock dans les templates
							search_for_createblock =self.searchForCreateblock(path+ligne, dossierLog)
							if(len(search_for_createblock) is not 0):
								results['template_search_for_createblock'].append(search_for_createblock)
					
							#new dans les templates
							search_for_new =self.searchForNew(path+ligne, dossierLog, 0)
							if(len(search_for_new) is not 0):
								results['template_search_for_new'].append(search_for_new)

							#globalPHP dans les templates
							search_for_globalphp =self.searchForPhpGlobals(path+ligne, dossierLog)
							if(len(search_for_globalphp) is not 0):
								results['template_global_php'].append(search_for_globalphp)

							#fonctions mysql_ dans le code
							search_for_mysql =self.searchForMysql(path+ligne, dossierLog)
							if(len(search_for_mysql) is not 0):
								results['template_mysql'].append(search_for_mysql)

							#fonctions logs dans le code
							search_for_logs =self.searchForLogs(path+ligne, dossierLog)
							if(len(search_for_logs) is not 0):
								results['template_logs'].append(search_for_logs)
	
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
			result = re.search(r"->load\(",ligne)					
			if result is not None:
				retours = {}
				retours['path'] = path
				retours['ligne'] = str(nbrLigne)  
				retours['contents']=(ligne[0:50].strip(" \t\n\r"))	
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
			result = re.search(r"->getBlock\(",ligne)					
			if result is not None:
				retours = {}
				retours['path'] = path
				retours['ligne'] = str(nbrLigne)  
				retours['contents']=(ligne[0:50].strip(" \t\n\r"))
				retoursAll.append(retours)
				nbrLoads+=1
		return retoursAll

	#
	# Fonction qui repere les getBlock dans les templates
	#
	def searchForPhpGlobals(self, path, dossierLog):
		fichier = open(path, 'r')
		nbrLigne=0	
		nbrLoads=0		
		retoursAll=[]
		for ligne in fichier:
			nbrLigne+=1	
			post = re.search(r"\$_POST",ligne)
			get = re.search(r"\$_GET",ligne)
			glo = re.search(r"\$_GLOBALS",ligne)	
			sess = re.search(r"\$_SESSION",ligne)
			if ( (post is not None) or (get is not None) or (glo is not None) or (sess is not None) ):
				retours = {}
				retours['path'] = path
				retours['ligne'] = str(nbrLigne)  
				retours['contents']=(ligne[0:50].strip(" \t\n\r"))	
				retoursAll.append(retours)
				nbrLoads+=1
		return retoursAll

	#
	# Fonction qui repere les getBlock dans les templates
	#
	def searchForLoadInLoop(self, path, dossierLog):
		fichier = open(path, 'r')  
		nbrLigne=0	
		nbrLoads=0	
		enterInLoop=0
		detecloop=0  
		inloop=0	
		continuer=0
		retoursAll=[]
		for ligne in fichier:
			nbrLigne+=1	
			result = re.search(r"->load\(",ligne)					
			if result is not None:
				 filee = open(path, 'r')
				 for line in filee:
					 for i in range(0, len(line)):
						if(line[i]=='f' and line[i+1]=='o' and  line[i+2]=='r' and ( line[i+3]==' ' or line[i+3]=='{') ):
							detecloop=1

						if(line[i]=='f' and line[i+1]=='o' and  line[i+1]=='r' and  line[i+1]=='e' and  line[i+1]=='a' and  line[i+1]=='c' and  line[i+1]=='h' and ( line[i+1]==' ' or line[i+1]=='{') ):
							detecloop=1
						if(line[i]=='d' and line[i+1]=='o' and ( line[i+1]==' ' or line[i+1]=='{') ):
							detecloop=1
						if(line[i]=='w' and line[i+1]=='h' and line[i+2]=='i' and line[i+3]=='l' and line[i+4]=='e'  and ( line[i+1]==' ' or line[i+1]=='{') ):
							detecloop=1

						if(detecloop == 1):
							 if(line[i]=='{'):
								enterInLoop=1
								detecloop=0  
							

						if(enterInLoop == 1):
						
							if(line[i]=='{'):
								inloop=inloop+1
															
							if(line[i]=='}'):
								inloop=inloop-1
								if(inloop==0):
									enterInLoop=0

							if(line[i]=='-' and line[i+1]=='>' and line[i+2]=='l' and line[i+3]=='o' and line[i+4]=='a' and line[i+5]=='d' and line[i+6]=='(' ):		
								
								retours={}
								retours['path'] = path
								retours['ligne'] = str(nbrLigne)  
								retours['contents']=(ligne[0:50].strip(" \t\n\r"))
								print('test' +path+'| '+str(nbrLigne)+'| '+(ligne[0:50].strip(" \t\n\r")))
								continuer=1
								break
						if(continuer==1):
							break

			if(continuer==1):
				continuer=0
				continue
			
						
						
					
					 
					

	#
	# Fonction qui repere les fonctions de logs 
	#
	def searchForLogs(self, path, dossierLog):
		fichier = open(path, 'r')
		nbrLigne=0	
		nbrLoads=0		
		retoursAll=[]
		for ligne in fichier:
			nbrLigne+=1	
			exp1 = re.search(r"print_r\(",ligne)
			exp2 = re.search(r"var_dump\(",ligne)
			exp3 = re.search(r"mage_debug::dump\(",ligne)	
			exp4 = re.search(r"Mage_Debug::dump\(",ligne)
			exp5 = re.search(r"->debug\(\);",ligne)
			exp6 = re.search(r"debug_backtrace\(",ligne)
			exp7 = re.search(r"debug_print_backtrace\(",ligne)
			if ( (exp1 is not None) or (exp2 is not None) or (exp3 is not None) or (exp4 is not None) or (exp5 is not None) or (exp6 is not None) or (exp7 is not None)):
				retours = {} 
				retours['path'] = path
				retours['ligne'] = str(nbrLigne)  
				retours['contents']=(ligne[0:50].strip(" \t\n\r"))
				retoursAll.append(retours)
				nbrLoads+=1
		return retoursAll

	#
	# Fonction qui repere les fonctions mysql non magento dans le code
	#
	def searchForMysql(self, path, dossierLog):
		fichier = open(path, 'r')
		nbrLigne=0	
		nbrLoads=0		
		retoursAll=[]
		for ligne in fichier:
			nbrLigne+=1	
			mysql = re.search(r"mysql\_",ligne)	
			if ( (mysql is not None)):
				retours = {}
				retours['path'] = path
				retours['ligne'] = str(nbrLigne)  
				retours['contents']=(ligne[0:50].strip(" \t\n\r"))
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
			result = re.search(r"->createBlock\(",ligne)
			resultWidgetName = re.search("customer/widget_",ligne)					
			if ( result is not None ) and ( resultWidgetName is None ):
				retours = {}
				retours['path'] = path
				retours['ligne'] = str(nbrLigne)  
				retours['contents']=(ligne[0:50].strip(" \t\n\r"))
				retoursAll.append(retours)
				nbrLoads+=1
		return retoursAll


	#
	# Fonction qui repere les new dans les templates
	# si code=1 on est dans le code
	# si code=0 on est dans les templates
	#
	def searchForNew(self, path, dossierLog, code):
		fichier = open(path, 'r')
		nbrLigne=0	
		nbrLoads=0
		isInScript=0	
		isInComment=0
		retoursAll=[]
		for ligne in fichier:
			inscript_one = re.search("text/javascript",ligne)
			inscript_two = re.search("script",ligne)
			inscript_three = re.search("<script>",ligne)
			outcript = re.search("</script",ligne)		
			intraduct = re.search("__\(",ligne)

			if(code is 1):
				varien = re.search("new Varien",ligne)
				stdclass = re.search("new StdClass",ligne)
				zend = re.search("new Zend",ligne)	
				exception = re.search("Exception",ligne)
				soap = re.search("new SoapClient",ligne)	
				simplexml = re.search("new SimpleXMLElement",ligne)
				arrayiterator = re.search("new ArrayIterator",ligne)
				stdclassbis = re.search("new stdClass",ligne)	
				date = re.search("DateTime",ligne)			

			incomment = re.search("\/\*",ligne)
			outcomment = re.search("\*\/",ligne)

			if ( (( inscript_one  is not None ) and ( inscript_two is not None )) or ( inscript_three is not None )  ):
				isInScript=1
			if(outcript is not None):
				isInScript=0

			if(incomment is not None):
				isInComment=1
			if(outcomment is not None):
				isInComment=0

			nbrLigne+=1	
			result = re.search("new ",ligne)				
			if ( result is not None ) and ( isInScript is not  1) and (intraduct is None)  and (isInComment is not 1):
				if( (code is not 1) or ((varien is None) and (stdclass is None) and (zend is None) and (exception is None)  and (soap is None) and (exception is None)  and (simplexml is None) and (arrayiterator is None) and (stdclassbis is None) and (date is None))):
					retours = {}
					retours['path'] = path
					retours['ligne'] = str(nbrLigne)  
					retours['contents']=(ligne[0:50].strip(" \t\n\r"))	
					retoursAll.append(retours)
					nbrLoads+=1
		return retoursAll


