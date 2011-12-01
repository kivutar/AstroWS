#!/usr/bin/python
# -*- coding: utf-8 -*-

import cgi
import cgitb
cgitb.enable()
from Ft.Xml.Xslt import Transform
import urllib2

get = cgi.FieldStorage()

if (get.has_key('xml') and get.has_key('xsl')):

	url= get['xml'].value
	req = urllib2.Request(url)
	handle = urllib2.urlopen(req)

	print "Content-Type: image/svg+xml\n"
	print Transform(handle.read(), get['xsl'].value)	
