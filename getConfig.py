from bs4 import BeautifulSoup
from bs4 import CData
import os, sys
if len(sys.argv) > 0:
	for arg in sys.argv:
		doc = open("../app/etc/local.xml")
		soup = BeautifulSoup(doc,'html.parser')

		if arg=="prefix":
		    print(soup.find_all('table_prefix')[0].text)
		elif arg=="host":
			print(soup.find_all('host')[0].text)
		elif arg=="name":
			print(soup.find_all('dbname')[0].text)
		elif arg=="username":
			print(soup.find_all('username')[0].text)
		elif arg=="userpass":
			print(soup.find_all('password')[0].text)
else:
	print("pas d'arguments")

