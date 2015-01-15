import os
import sys
sys.path.append('./utils')
import repertoire

rep = RepertoireTools();

fichier = open('/home/pierre/Bureau/python/test.txt','w')
path = '/var/www/courir/app/code/local/Courir/Cms'

retour = rep.listerFichiersEtRepertoires(path)

fichier.write(retour)
print(retour)
fichier.close()


