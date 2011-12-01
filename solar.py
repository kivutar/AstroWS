#!/usr/bin/python

import os
import sys
import datetime
import swisseph as swe
import cgi
import cgitb
cgitb.enable()
import ci
import urllib2

def decHour( input ):
	hours=int(input)
	mands=(input-hours)*60.0
	mands=round(mands,5)
	minutes=int(mands)
	seconds=int(round((mands-minutes)*60))
	return [hours,minutes,seconds]
	
def decHourJoin( inH , inM , inS ):
	dh = float(inH)
	dm = float(inM)/60
	ds = float(inS)/3600
	output = dh + dm + ds
	return output

get = cgi.FieldStorage()

if (get.has_key('name') 
and get.has_key('city') 
and get.has_key('newcity') 
and get.has_key('lat') 
and get.has_key('lon') 
and get.has_key('newlat') 
and get.has_key('newlon') 
and get.has_key('year') 
and get.has_key('newyear') 
and get.has_key('month') 
and get.has_key('day') 
and get.has_key('time') 
and get.has_key('hsys')
and get.has_key('display')):

	name    = str  (get['name'].value)
	city    = str  (get['city'].value)
	newcity = str  (get['newcity'].value)
	lat     = float(get['lat'].value)
	lon     = float(get['lon'].value)
	newlat  = float(get['newlat'].value)
	newlon  = float(get['newlon'].value)
	year    = int  (get['year'].value)
	newyear = int  (get['newyear'].value)
	month   = int  (get['month'].value)
	day     = int  (get['day'].value)
	time    = float(get['time'].value)
	hsys    = str  (get['hsys'].value)
	display = str  (get['display'].value)

	swe.set_ephe_path('ephe')
	
	# Thanks to openastro.org for this algorythm

	solaryearsecs = 31556925.51 # 365 days, 5 hours, 48 minutes, 45.51 seconds
	#print("localToSolar: from %s to %s" %(year,newyear))
	h,m,s = decHour(time)
	dt_original = datetime.datetime(year,month,day,h,m,s)
	dt_new = datetime.datetime(newyear,month,day,h,m,s)
	result1 = swe.calc_ut(swe.julday(year,month,day,time), 0)
	#print("localToSolar: first sun %s" % (result1[0]) )
	result2 = swe.calc_ut(swe.julday(newyear,month,day,time), 0)
	#print("localToSolar: second sun %s" % (result2[0]) )
	sundiff = result1[0] - result2[0]
	#print("localToSolar: sundiff %s" %(sundiff))
	sundelta = ( sundiff / 360.0 ) * solaryearsecs
	#print("localToSolar: sundelta %s" % (sundelta))
	dt_delta = datetime.timedelta(seconds=int(sundelta))
	dt_new = dt_new + dt_delta
	result2 = swe.calc_ut(swe.julday(dt_new.year,dt_new.month,dt_new.day,decHourJoin(dt_new.hour,dt_new.minute,dt_new.second)), 0)
	#print("localToSolar: new sun %s" % (result2[0]))

	#get precise
	step = 0.000011408 # 1 seconds in degrees
	sundiff = result1[0] - result2[0]
	sundelta = sundiff / step
	dt_delta = datetime.timedelta(seconds=int(sundelta))
	dt_new = dt_new + dt_delta
	result2 = swe.calc_ut(swe.julday(dt_new.year,dt_new.month,dt_new.day,decHourJoin(dt_new.hour,dt_new.minute,dt_new.second)), 0)
	#print("localToSolar: new sun #2 %s" % (result2[0]))

	step = 0.000000011408 # 1 milli seconds in degrees
	sundiff = result1[0] - result2[0]
	sundelta = sundiff / step
	dt_delta = datetime.timedelta(milliseconds=int(sundelta))
	dt_new = dt_new + dt_delta
	result2 = swe.calc_ut(swe.julday(dt_new.year,dt_new.month,dt_new.day,decHourJoin(dt_new.hour,dt_new.minute,dt_new.second)), 0)
	#print("localToSolar: new sun #3 %s" % (result2[0]))	

	s_year = dt_new.year
	s_month = dt_new.month
	s_day = dt_new.day
	s_time = decHourJoin(dt_new.hour,dt_new.minute,dt_new.second)
	
	url  = "http://astro.kivutar.me/chartinfo.py?"
	url += "name="+str(name)
	url += "&city="+str(newcity)
	url += "&lat="+str(newlat)
	url += "&lon="+str(newlon)
	url += "&year="+str(s_year)
	url += "&month="+str(s_month)
	url += "&day="+str(s_day)
	url += "&time="+str(s_time)
	url += "&hsys="+str(hsys)
	url += "&display="+str(display)
	url += "&solar=1"
	
	req =  urllib2.Request(url)
	handle = urllib2.urlopen(req)
	print "Content-Type: text/xml;encoding utf-8\n"
	print handle.read()
	
	
