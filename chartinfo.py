#!/usr/bin/python

import os
import sys
import cgi
import cgitb
cgitb.enable()
import ci

get = cgi.FieldStorage()

if (get.has_key('lat') 
and get.has_key('lon') 
and get.has_key('year') 
and get.has_key('month') 
and get.has_key('day') 
and get.has_key('time') 
and get.has_key('hsys')
and get.has_key('display')):

	lat     = float(get['lat'].value)
	lon     = float(get['lon'].value)
	year    = int  (get['year'].value)
	month   = int  (get['month'].value)
	day     = int  (get['day'].value)
	time    = float(get['time'].value)
	hsys    = str  (get['hsys'].value)
	display = get['display'].value.split(',')
	
	results = ci.getinfo(lat, lon, year, month, day, time, hsys, display)
	
	print "Content-Type: text/xml;encoding utf-8\n"
	print "<?xml version='1.0' encoding='UTF-8'?>"
	print "<chartinfo ",
	for key in get.keys():
		print key + "=\"" + get.getvalue(key) + "\" ",
	print ">"
	for partk,partv in results.iteritems():
		print "  <"+partk+">"
		for item in partv:
			print "    <"+item["name"],
			for argk,argv in item.iteritems():
				if argk != "name":
					print argk+"=\""+str(argv)+"\"",
			print "/>"
		print "  </"+partk+">"	
	print "</chartinfo>"
	

