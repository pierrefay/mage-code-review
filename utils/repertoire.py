class RepertoireTools:

	def __init__(self):
		"""test"""

	def listerFichiersEtRepertoires(self, path):
		dirs = os.listdir(path)
		retour=''
		for ligne in dirs:
			ligne=path+'/'+ligne
			if os.path.isdir(ligne):
				retour= retour + ligne + "\n"
				retour  = retour + self.listerFichiersEtRepertoires(ligne)
			else:
				retour= retour + ligne + "\n"
		return retour

	def listerRepertoires(self, path):
		dirs = os.listdir(path)
		retour=''
		for ligne in dirs:
			ligne=path+'/'+ligne
			if os.path.isdir(ligne):
				retour= retour + ligne + "\n"
				retour = retour  + self.listerRepertoires(ligne)
		return retour

	def listerFichiers(self, path):
		dirs = os.listdir(path)
		retour=''
		for ligne in dirs:
			ligne=path+'/'+ligne
			if os.path.isdir(ligne):
				retour  = retour + self.listerFichiers(ligne)
			else:
				retour= retour + ligne + "\n"
		return retour
