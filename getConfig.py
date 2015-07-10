from bs4 import BeautifulSoup 
from bs4 import CData
import os, sys

if len(sys.argv) > 0:
	for arg in sys.argv: 
		doc = open("../app/etc/local.xml")
		soup = BeautifulSoup(doc,'xml')

		if arg=="prefix":
			print soup.find_all('global')[0].resources.db.table_prefix.string
		elif arg=="host":
			print soup.find_all('global')[0].resources.default_setup.connection.host.string
		elif arg=="name":
			print soup.find_all('global')[0].resources.default_setup.connection.dbname.string
		elif arg=="username":
			print soup.find_all('global')[0].resources.default_setup.connection.username.string
		elif arg=="userpass":
			print soup.find_all('global')[0].resources.default_setup.connection.password.string
		
else:
	print "pas d'arguments"

