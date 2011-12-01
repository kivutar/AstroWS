#!/usr/bin/python

import os
import sys
import math
import swisseph as swe

cibodies  = []
cihouses  = []
ciascmcs  = []
ciaspects = []
ciresults = {}

bnames = ["Sun", "Moon", "Mercury", "Venus", "Mars", "Jupiter", "Saturn", 
"Uranus", "Neptune", "Pluto", "MeanNode", "TrueNode", "MeanApogee", 
"OscuApogee", "Earth", "Chiron", "Pholus", "Ceres", "Pallas", "Juno", "Vesta", 
"InterpretedApogee", "InterpretedPerigee", "MeanSouthNode", "TrueSouthNode"]
hnames = ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI", 
"XII", "XIII", "XIV", "XV", "XVI", "XVII", "XVIII", "XIX", "XX", "XXI", "XXII", 
"XXIII", "XXIV", "XXV", "XXVI", "XXVII", "XXVIII", "XXIX", "XXX", "XXXI", 
"XXXII", "XXXIII", "XXXIV", "XXXV", "XXXVI"]
anames = ["Ascendant", "MC", "ARMC", "Vertex", "EquatorialAscendant", 
"Co-Ascendant1", "Co-Ascendant2", "PolarAscendant", "NASCMC"]
snames = ["Aries", "Taurus", "Gemini", "Cancer", "Leo", "Virgo", "Libra", 
"Scorpio", "Sagittarius", "Capricorn", "Aquarius", "Pisces"]

def sanitize(deg):
	if deg > 360:
		return deg - 360
	elif deg < 0:
		return deg + 360
	else:
		return deg

def cmp_bodies(b1, b2):
	if   b1["degree_ut"] >  b2["degree_ut"]:
		return 1
	elif b1["degree_ut"] == b2["degree_ut"]:
		return 0
	else:
		return -1

def test_aspect(body1, body2, deg1, deg2, delta, orb, type):
	if ((deg1 > (deg2       + delta - orb) and deg1 < (deg2       + delta + orb)) or 
	    (deg1 > (deg2       - delta - orb) and deg1 < (deg2       - delta + orb)) or
	    (deg1 > (deg2 + 360 + delta - orb) and deg1 < (deg2 + 360 + delta + orb)) or 
	    (deg1 > (deg2 - 360 + delta - orb) and deg1 < (deg2 - 360 + delta + orb)) or 
	    (deg1 > (deg2 + 360 - delta - orb) and deg1 < (deg2 + 360 - delta + orb)) or  
	    (deg1 > (deg2 - 360 - delta - orb) and deg1 < (deg2 - 360 - delta + orb))):
		if (deg1 > deg2):
			aspect(body1, body2, deg1, deg2, type)

def aspect(body1, body2, deg1, deg2, type):
	aspect = { "name"    : type,
	           "body1"   : body1['name'],
	           "body2"   : body2['name'],
	           "degree1" : deg1,
	           "degree2" : deg2 }
	ciaspects.append(aspect)

def getinfo(lat=0.0, lon=0.0, year=1970, month=1, day=1, time=0.0, hsys='E', display=range(23)):

	swe.set_ephe_path('ephe')

	julday = swe.julday(year, month, day, time)
	geo = swe.set_topo(lon, lat, 0)
	houses, ascmc = swe.houses(julday, lat, lon, hsys)
	
	for body in range(25):
		if str(body) in display:
			if body == 23:
				result = swe.calc_ut(julday, 10)
				degree_ut = sanitize(result[0] + 180);
				retrograde = bool(result[3] > 0)
			elif body == 24:
				result = swe.calc_ut(julday, 11)
				degree_ut = sanitize(result[0] + 180);
				retrograde = bool(result[3] > 0)		
			else:
				result = swe.calc_ut(julday, body)
				degree_ut = result[0];
				retrograde = bool(result[3] < 0)			
			for sign in range(12):
				deg_low =  float(sign * 30)
				deg_high = float((sign + 1) * 30)
				if (degree_ut >= deg_low and degree_ut <= deg_high):
					cibody = { "id"         : body,
						       "name"       : bnames[body],
						       "sign"       : sign,
						       "sign_name"  : snames[sign],
						       "degree"     : degree_ut - deg_low,
						       "degree_ut"  : degree_ut,
						       "retrograde" : retrograde }
					cibodies.append(cibody)

	for index, degree_ut in enumerate(houses):
		for sign in range(12):
			deg_low =  float(sign * 30)
			deg_high = float((sign + 1) * 30)
			if (degree_ut >= deg_low and degree_ut <= deg_high):
				cihouse = { "id"         : index + 1,
				            "number"     : hnames[index],
				            "name"       : "House",
				            "sign"       : sign,
				            "sign_name"  : snames[sign],
				            "degree"     : degree_ut - deg_low,
				            "degree_ut"  : degree_ut }
				cihouses.append(cihouse)
	
	for index, degree_ut in enumerate(ascmc):
		for sign in range(12):
			deg_low =  float(sign * 30)
			deg_high = float((sign + 1) * 30)
			if (degree_ut >= deg_low and degree_ut <= deg_high):
				ciascmc = { "id"         : index + 1,
				            "name"       : anames[index],
				            "sign"       : sign,
				            "sign_name"  : snames[sign],
				            "degree"     : degree_ut - deg_low,
				            "degree_ut"  : degree_ut }
				ciascmcs.append(ciascmc)
	
	for body1 in cibodies:
		deg1 = body1["degree_ut"] - ciascmcs[0]["degree_ut"] + 180
		for body2 in cibodies:
			deg2 = body2["degree_ut"] - ciascmcs[0]["degree_ut"] + 180
			test_aspect(body1, body2, deg1, deg2, 180, 10, "Opposition")
			test_aspect(body1, body2, deg1, deg2, 150,  2, "Quincunx")
			test_aspect(body1, body2, deg1, deg2, 120,  8, "Trine")
			test_aspect(body1, body2, deg1, deg2,  90,  6, "Square")
			test_aspect(body1, body2, deg1, deg2,  60,  4, "Sextile")
			test_aspect(body1, body2, deg1, deg2,  30,  1, "Semi-sextile")
			test_aspect(body1, body2, deg1, deg2,   0, 10, "Conjunction")

	swe.close()
	
	cibodies.sort(cmp_bodies)

	old_deg = -1000.
	dist = 0
	for body in cibodies:
		deg = body["degree_ut"] - ciascmcs[0]["degree_ut"] + 180
		dist = dist + 1 if math.fabs(old_deg - deg) < 5 else 0
		body["dist"] = dist
		old_deg = deg
	
	ciresults = {
		"bodies"  : cibodies,
		"houses"  : cihouses,
		"ascmcs"  : ciascmcs,
		"aspects" : ciaspects,
		}

	return ciresults

