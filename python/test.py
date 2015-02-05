from utils.audit import Audit

audit = Audit()

dossierLog =  'home/pierre/Documents/Projets/python/test/'
path = '/home/pierre/Documents/Projets/Courir/Docker/apache-redis/courir/'

namespaceAndmodules = audit.lunchSearch(path,dossierLog)
print namespaceAndmodules

res="-----------------------\n"
res+="  Load in templates    \n"
res+="-----------------------\n"
calcul = audit.analyserTemplates(path+"app/design/frontend/", fichier)
print res+str(calcul)+"  loads dans les templates"
