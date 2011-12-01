#!/usr/bin/python

import os
import sys
import cgi
import cgitb
cgitb.enable()
import cairo
import rsvg
import urllib

get = cgi.FieldStorage()

if (get.has_key('svg')):

	url = str(get['svg'].value)

	urllib.urlretrieve(url, "/tmp/rsvg")
	svg = rsvg.Handle("/tmp/rsvg")

	width = svg.props.width
	height = svg.props.width

	surface = cairo.ImageSurface (cairo.FORMAT_ARGB32, width, height)
	cr = cairo.Context(surface)

	svg.render_cairo(cr)

	surface.write_to_png("/tmp/rsvg")
	print "Content-Type: image/png\n"
	print open("/tmp/rsvg","r").read()
