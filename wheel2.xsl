<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:math="http://exslt.org/math"
	xmlns="http://www.w3.org/2000/svg">
	<xsl:output 
		method="xml" 
		media-type="image/svg+xml" 
		doctype-public="-//W3C//DTD SVG 1.0//EN" 
		doctype-system="http://www.w3.org/TR/2001/PR-SVG-20010719/DTD/svg10.dtd" 
		version="1.0" 
		encoding="UTF-8" 
		indent="yes"/>
	<xsl:variable name = "asc" select="chartinfo/ascmcs/Ascendant/@degree_ut" />
	<xsl:variable name = "PI" select="math:constant('PI',10)" />
	<xsl:template name="deg-min">
    	<xsl:param name="deg"/>
    	<xsl:variable name="units" select="floor($deg)" />
    	<xsl:variable name="decimals" select="$deg - $units" />
    	<xsl:variable name="minutes" select="format-number($decimals * 60,'00')" />
    	<xsl:value-of select="concat($units,'°',$minutes)"/>
	</xsl:template>
	<xsl:variable name="time">
		<xsl:variable name="hour" select="chartinfo/@time" />
    	<xsl:variable name="units" select="floor($hour)" />
    	<xsl:variable name="decimals" select="$hour - $units" />
    	<xsl:variable name="minutes" select="format-number($decimals * 60,'00')" />
    	<xsl:value-of select="concat($units,':',$minutes,'GMT')"/>		
	</xsl:variable>
	<xsl:variable name="latitude">
		<xsl:variable name="deg" select="chartinfo/@lat" />
    	<xsl:variable name="units" select="floor($deg)" />
    	<xsl:variable name="decimals" select="$deg - $units" />
    	<xsl:variable name="minutes" select="format-number($decimals * 60,'00')" />
    	<xsl:choose>
    		<xsl:when test='$deg &lt; 0'>
    			<xsl:value-of select="concat(math:abs($units),'S',$minutes)"/>
    		</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($units,'N',$minutes)"/>
			</xsl:otherwise>
    	</xsl:choose>	
	</xsl:variable>
	<xsl:variable name="longitude">
		<xsl:variable name="deg" select="chartinfo/@lon" />
    	<xsl:variable name="units" select="floor($deg)" />
    	<xsl:variable name="decimals" select="$deg - $units" />
    	<xsl:variable name="minutes" select="format-number($decimals * 60,'00')" />
    	<xsl:choose>
    		<xsl:when test='$deg &lt; 0'>
    			<xsl:value-of select="concat(math:abs($units),'W',$minutes)"/>
    		</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($units,'E',$minutes)"/>
			</xsl:otherwise>
    	</xsl:choose>	
	</xsl:variable>
	<xsl:template match="/">
		<xsl:processing-instruction name="xml-stylesheet">href="style.css" type="text/css"</xsl:processing-instruction>
		<svg 
			xmlns="http://www.w3.org/2000/svg" 
			xmlns:xlink="http://www.w3.org/1999/xlink" 
			width="100%" height="100%" 
			version="1.0" 
			viewBox="0 0 600 600">
			<title>
				<xsl:choose>
					<xsl:when test="chartinfo/@solar">
					    <xsl:value-of select="concat(
					    	'Solar Return of ',
					    	chartinfo/@name,' in ',
					    	chartinfo/@city,' (',$latitude,',',$longitude,') on ',
					    	chartinfo/@month,'/',chartinfo/@day,'/',chartinfo/@year,' at ',
					    	$time
					    	)"/>
	            	</xsl:when>
	            	<xsl:otherwise>
					    <xsl:value-of select="concat(
					    	'Natal Chart of ',
					    	chartinfo/@name,' born in ',
					    	chartinfo/@city,' (',$latitude,',',$longitude,') on ',
					    	chartinfo/@month,'/',chartinfo/@day,'/',chartinfo/@year,' at ',
					    	$time
					    	)"/>	            	
	            	</xsl:otherwise>
	            </xsl:choose>
			</title>
			<defs>
				<marker id="Arrow" 
					viewBox="-2 -2 14 14" refX="5" refY="5" 
					markerUnits="strokeWidth" markerWidth="14" markerHeight="14" orient="auto">
					<path d="M 0 0 L 5 5 L 0 10" />
				</marker>
				<g id="Sun">
					<circle cx="0" cy="0" r="9" />
					<circle cx="0" cy="0" r="1" />
				</g>
				<g id="Moon">
					<path d="M -6.3,-6.7 
					C -2.7,-10.35 3.2,-10.3 6.757,-6.6 
					C 10.3,-3 10.3,3 6.6,6.7 
					C 3,10.3 -2.8,10.3 -6.4,6.6 
					C -6.4,6.6 1.4,6.3 1.4,0 
					C 1.4,-6.2 -6.3,-6.7 -6.3,-6.7 z" />
				</g>
				<g id="Mercury">
					<path d="M -4,-9 A 4,4 0 1 0 4,-9" />
					<circle cx="0" cy="-1" r="4" />
					<line x1="0" y1="3" x2="0" y2="9.5" />
					<line x1="-3.5" y1="6" x2="3.5" y2="6" />
				</g>
				<g id="Venus">
					<circle cx="0" cy="-2.5" r="5" />
					<line x1="0" y1="2.5" x2="0" y2="9" />
					<line x1="-3.5" y1="5.5" x2="3.5" y2="5.5" />
				</g>
				<g id="Mars">
					<circle cx="-1.5" cy="1.5" r="5.5" />
					<path d="M 3,-7 L 7,-7 L 7,-3" />
					<line x1="7" y1="-7" x2="2.5" y2="-2.5" />
				</g>
				<g id="Jupiter">
					<path d="M 6.5,4 L -5,4 C 6.2,-1.4 -1,-10.4 -5,-4.5" />
					<line x1="3" y1="0.5" x2="3" y2="7.5" />
				</g>
				<g id="Saturn">
					<path d="M 0,7.7 C 10.2,3 3.75,-5 0,0" />
					<path d="M 0,-7.5 L 0,0.5" />
				    <path d="M -3.5,-4.5 L 3.5,-4.5" />	
				</g>
				<g id="Uranus">
					<circle cx="0" cy="5" r="4" />
					<path d="M 0,-5.5 L 0,0.5" />
					<path d="M 2.5,-3.5 L -2.5,-3.5" />
					<path d="M -5.6,-7.4 A 3.75,3.75 0 0 1 -5.6,0" />
					<path d="M 5.6,-7.4 A 3.75,3.75 0 0 0 5.6,0" />		
				</g>
				<g id="Neptune">
					<path d="M -5.5,-7 
						L -5.5,-4.5 
						C -5.5,-4.5 -5.5,-4.5 -5.5,-4.5 
						C -5.5,-1.5 -3,1 0,1 
						C 3,1 5.5,-1.5 5.5,-4.5 
						L 5.5,-7" />
					<line x1="0" y1="7.5" x2="0" y2="-7" />
					<line x1="-3" y1="4" x2="3" y2="4" />
				</g>
				<g id="Pluto">
					<circle cx="0" cy="4" r="4" />
					<path d="M 0,-7 L 0,0" />
					<path d="M 2.5,-2.5 L -2.5,-2.5" />
					<path d="M -4,-9 A 4,4 0 1 0 4,-9" />
				</g>
				<g id="MeanNode">
					<path d="M -3,6 A 6,6 1 1 1 3,6" />
					<circle cx="-4" cy="8" r="2" />
					<circle cx="4" cy="8" r="2" />
				</g>
				<g id="TrueNode">
					<path d="M -3,6 A 6,6 1 1 1 3,6" />
					<circle cx="-4" cy="8" r="2" />
					<circle cx="4" cy="8" r="2" />
				</g>
				<g id="MeanSouthNode">
					<path d="M -3,-6 A 6,6 1 1 0 3,-6" />
					<circle cx="-4" cy="-8" r="2" />
					<circle cx="4" cy="-8" r="2" />
				</g>
				<g id="TrueSouthNode">
					<path d="M -3,-6 A 6,6 1 1 0 3,-6" />
					<circle cx="-4" cy="-8" r="2" />
					<circle cx="4" cy="-8" r="2" />
				</g>
				<g id="MeanApogee">
					<path d="M -4.25,-7 
						C -2.25,-9 1,-9 3,-7 
						C 5,-5 5,-1.66 3,0.33 
						C 1,2.3 -2.3,2.3 -4.3,0.3 
						C -4.3,0.3 0,0.1 0,-3.35 
						C 0,-6.75 -4.3,-7 -4.25,-7 z " />
					<path d="M 0,8 L 0,2" />
					<path d="M -3,5 L 3,5" />		
				</g>
				<g id="OscuApogee">
					<path d="M -4.25,-7 
						C -2.25,-9 1,-9 3,-7 
						C 5,-5 5,-1.66 3,0.33 
						C 1,2.3 -2.3,2.3 -4.3,0.3 
						C -4.3,0.3 0,0.1 0,-3.35 
						C 0,-6.75 -4.3,-7 -4.25,-7 z " />
					<path d="M 0,8 L 0,2" />
					<path d="M -3,5 L 3,5" />
				</g>
				<g id="Earth">
					<circle cx="0" cy="0" r="7" />
					<line x1="0" y1="-7" x2="0" y2="7" />
					<line x1="-7" y1="0" x2="7" y2="0" />
				</g>
				<g id="Chiron">
					<circle cx="0" cy="5" r="4" />
					<path d="M -2,-9 L -2,1" />
					<path d="M 3,-7 L -0.5,-4 L 3,-1" />	
				</g>
				<g id="Pholus">
					<path d="M 0,2.5 L 5,-2.5 L 0,-7.5 L -5,-2.5 z" />
					<line x1="0" y1="2.5" x2="0" y2="9" />
					<path d="M -6,9 L -3,5 L 0,9 L 3,5 L 6,9" />
				</g>
				<g id="Ceres">
					<path d="M 0,2.5 A 5,5 1 1 0 -5,-2.5" />
					<line x1="0" y1="2.5" x2="0" y2="9" />
					<line x1="-3.5" y1="5.5" x2="3.5" y2="5.5" />		
				</g>
				<g id="Pallas">
					<path d="M 0,2.5 L 5,-2.5 L 0,-7.5 L -5,-2.5 z" />
					<line x1="0" y1="2.5" x2="0" y2="9" />
					<line x1="-3.5" y1="5.5" x2="3.5" y2="5.5" />
				</g>
				<g id="Juno">
					<line x1="0" y1="-7.5" x2="0" y2="9" />
					<line x1="-3.5" y1="5.5" x2="3.5" y2="5.5" />
					<line x1="-5" y1="-2.5" x2="5" y2="-2.5" />
					<line x1="-4" y1="-6.5" x2="4" y2="1.5" />
					<line x1="-4" y1="1.5" x2="4" y2="-6.5" />
				</g>
				<g id="Vesta">
					<path d="M -8,0 L -5,0 L 0,8 L 5,0 L 8,0" />
					<path d="M -3,-2 L 0,3 L 3,-2" />
					<path d="M 0,-5 L 0,-2" />
				</g>
				<g id="InterpretedApogee">
					<circle cx="0" cy="0" r="7" />
					<circle cx="0" cy="0" r="3" />	
				</g>
				<g id="InterpretedPerigee">
					<circle cx="0" cy="0" r="7" />
					<circle cx="0" cy="0" r="3" />		
				</g>
			</defs>
			<g id="main">
				<g id="aspects">
					<xsl:for-each select="chartinfo/bodies/*">
						<xsl:sort select="@degree_ut"/>
						<xsl:variable name="deg1" select="@degree_ut - $asc + 180" />
						<xsl:variable name="body1" select="local-name()" />
						<xsl:for-each select="//chartinfo/bodies/*">
							<xsl:sort select="@degree_ut"/>
							<xsl:variable name="deg2" select="@degree_ut - $asc + 180" />
							<xsl:variable name="body2" select="local-name()" />
							<xsl:call-template name="testAspect"><xsl:with-param name="body1" select="$body1" /><xsl:with-param name="body2" select="$body2" /><xsl:with-param name="deg1" select="$deg1" /><xsl:with-param name="deg2" select="$deg2" /><xsl:with-param name="delta" select="180" /><xsl:with-param name="orb" select="10" /><xsl:with-param name="type" select=  "'Opposition'" /></xsl:call-template>
							<xsl:call-template name="testAspect"><xsl:with-param name="body1" select="$body1" /><xsl:with-param name="body2" select="$body2" /><xsl:with-param name="deg1" select="$deg1" /><xsl:with-param name="deg2" select="$deg2" /><xsl:with-param name="delta" select="150" /><xsl:with-param name="orb" select= "2" /><xsl:with-param name="type" select=    "'Quincunx'" /></xsl:call-template>
							<xsl:call-template name="testAspect"><xsl:with-param name="body1" select="$body1" /><xsl:with-param name="body2" select="$body2" /><xsl:with-param name="deg1" select="$deg1" /><xsl:with-param name="deg2" select="$deg2" /><xsl:with-param name="delta" select="120" /><xsl:with-param name="orb" select= "8" /><xsl:with-param name="type" select=       "'Trine'" /></xsl:call-template>
							<xsl:call-template name="testAspect"><xsl:with-param name="body1" select="$body1" /><xsl:with-param name="body2" select="$body2" /><xsl:with-param name="deg1" select="$deg1" /><xsl:with-param name="deg2" select="$deg2" /><xsl:with-param name="delta" select= "90" /><xsl:with-param name="orb" select= "6" /><xsl:with-param name="type" select=      "'Square'" /></xsl:call-template>
							<xsl:call-template name="testAspect"><xsl:with-param name="body1" select="$body1" /><xsl:with-param name="body2" select="$body2" /><xsl:with-param name="deg1" select="$deg1" /><xsl:with-param name="deg2" select="$deg2" /><xsl:with-param name="delta" select= "60" /><xsl:with-param name="orb" select= "4" /><xsl:with-param name="type" select=     "'Sextile'" /></xsl:call-template>
							<xsl:call-template name="testAspect"><xsl:with-param name="body1" select="$body1" /><xsl:with-param name="body2" select="$body2" /><xsl:with-param name="deg1" select="$deg1" /><xsl:with-param name="deg2" select="$deg2" /><xsl:with-param name="delta" select= "30" /><xsl:with-param name="orb" select= "1" /><xsl:with-param name="type" select="'Semi-sextile'" /></xsl:call-template>
							<xsl:call-template name="testAspect"><xsl:with-param name="body1" select="$body1" /><xsl:with-param name="body2" select="$body2" /><xsl:with-param name="deg1" select="$deg1" /><xsl:with-param name="deg2" select="$deg2" /><xsl:with-param name="delta" select=  "0" /><xsl:with-param name="orb" select="10" /><xsl:with-param name="type" select= "'Conjunction'" /></xsl:call-template>							
						</xsl:for-each>
					</xsl:for-each>
				</g>
				<g id="houses">			
					<path d="M 300,295 L 300,305" class="origin" />
					<path d="M 295,300 L 305,300" class="origin" />
				</g>
				<g id="cuspids">
					<xsl:for-each select="chartinfo/houses/*">
						<xsl:variable name="rad1" select="(@degree_ut - $asc + 180) * $PI div 180" />
						<xsl:variable name="rad2" select="(@degree_ut - $asc + 185) * $PI div 180" />
						<xsl:variable name="x1" select="( math:cos($rad1) * 150) + 300" />
						<xsl:variable name="y1" select="(-math:sin($rad1) * 150) + 300" />
						<xsl:variable name="x2" select="( math:cos($rad1) * 240) + 300" />
						<xsl:variable name="y2" select="(-math:sin($rad1) * 240) + 300" />
						<xsl:variable name="x3" select="( math:cos($rad2) * 240) + 295" />
						<xsl:variable name="y3" select="(-math:sin($rad2) * 240) + 305" />
						<line>
							<xsl:attribute name="x1"><xsl:value-of select="$x1"/></xsl:attribute>
							<xsl:attribute name="y1"><xsl:value-of select="$y1"/></xsl:attribute>
							<xsl:attribute name="x2"><xsl:value-of select="$x2"/></xsl:attribute>
							<xsl:attribute name="y2"><xsl:value-of select="$y2"/></xsl:attribute>
							<xsl:attribute name="class"><xsl:value-of select="concat('House ',@number)"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="concat('House ',@number)"/></xsl:attribute>
							<xsl:if test="@id=1 or @id=4 or @id=7 or @id=10 or @id=13 or @id=16 or @id=19 or @id=22 or @id=25 or @id=28 or @id=31 or @id=34">
								<xsl:attribute name="marker-end">url("#Arrow")</xsl:attribute>
							</xsl:if>
						</line>
						<text>
							<xsl:attribute name="x"><xsl:value-of select="$x3"/></xsl:attribute>
							<xsl:attribute name="y"><xsl:value-of select="$y3"/></xsl:attribute>
							<xsl:attribute name="class"><xsl:value-of select="concat('House ',@number)"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="concat('House ',@number)"/></xsl:attribute>
							<xsl:value-of select="@number"/>
						</text>
					</xsl:for-each>	
				</g>
				<g id="bodies">
					<xsl:for-each select="chartinfo/bodies/*">
						<xsl:sort select="@degree_ut"/>
						<xsl:variable name = "rad" select="(@degree_ut - $asc + 180) * $PI div 180" />
						<xsl:variable name = "x1" select="( math:cos($rad) * 150) + 300" />
						<xsl:variable name = "y1" select="(-math:sin($rad) * 150) + 300" />
						<xsl:variable name = "x2" select="( math:cos($rad) * 170) + 300" />
						<xsl:variable name = "y2" select="(-math:sin($rad) * 170) + 300" />
						<xsl:variable name = "x3" select="( math:cos($rad) * (185 + @dist*20)) + 300" />
						<xsl:variable name = "y3" select="(-math:sin($rad) * (185 + @dist*20)) + 300" />
						<xsl:variable name = "x4" select="( math:cos($rad) * (260 + @dist*20)) + 285" />
						<xsl:variable name = "y4" select="(-math:sin($rad) * (260 + @dist*20)) + 300" />							
						<line>
							<xsl:attribute name="x1"><xsl:value-of select="$x1"/></xsl:attribute>
							<xsl:attribute name="y1"><xsl:value-of select="$y1"/></xsl:attribute>
							<xsl:attribute name="x2"><xsl:value-of select="$x2"/></xsl:attribute>
							<xsl:attribute name="y2"><xsl:value-of select="$y2"/></xsl:attribute>
							<xsl:attribute name="class"><xsl:value-of select="local-name()"/></xsl:attribute>
						</line>
						<use>
							<xsl:attribute name="x"><xsl:value-of select="$x3"/></xsl:attribute>
							<xsl:attribute name="y"><xsl:value-of select="$y3"/></xsl:attribute>
							<xsl:attribute namespace="http://www.w3.org/1999/xlink" name="href">#<xsl:value-of select="local-name()"/></xsl:attribute>
							<xsl:attribute name="class"><xsl:value-of select="local-name()"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="local-name()"/></xsl:attribute>
						</use>
						<text>
							<xsl:attribute name="x"><xsl:value-of select="$x4"/></xsl:attribute>
							<xsl:attribute name="y"><xsl:value-of select="$y4"/></xsl:attribute>
							<xsl:attribute name="class"><xsl:value-of select="local-name()"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="@degree"/></xsl:attribute>
							<xsl:call-template name="deg-min">
								<xsl:with-param name="deg"><xsl:value-of select="@degree"/></xsl:with-param>
							</xsl:call-template>
						</text>
					</xsl:for-each>
				</g>
				<g id="zodiac">
					<xsl:attribute name="transform">
						rotate(<xsl:value-of select="$asc + 180"/>, 300, 300)
					</xsl:attribute>
					<g id="cercle">
						<path d="M 429.9,375 
							C 471.3,303.3 446.7,211.5 375,170.1 
							C 303.3,128.7 211.5,153.3 170.1,225 
							C 128.7,296.7 153.3,388.5 225,429.9 
							C 296.7,471.3 388.5,446.7 429.9,375 z 
							M 386.6,350 
							C 359,397.79972 297.8,414.2 250,386.6 
							C 202.2,359 185.8,297.8 213.4,250 
							C 241,202.2 302.2,185.8 350,213.4 
							C 397.8,241 414.2,302.2 386.6,350 z"
							class="disc" />
						<path d="M 375,170 L 350,213.4" />
						<path d="M 170,225 L 213.4,250" />
						<path d="M 225,430 L 250,386.6" />
						<path d="M 430,375 L 386.6,350" />
						<path d="M 430,225 L 386.6,250" />
						<path d="M 225,170 L 250,213.4" />
						<path d="M 170,375 L 213.4,350" />
						<path d="M 375,430 L 350,386.6" />
						<path d="M 450,300 L 400,300" />
						<path d="M 300,150 L 300,200" />
						<path d="M 150,300 L 200,300" />
						<path d="M 300,450 L 300,400" />
					</g>
					<g id="signs">
						<g id="aries" title="Aries">
							<path id="aries" d="M 418.5,254.8 C 434.3,259 416.7,283.4 409.3,270.6 C 409.3,256 436.8,268.2 425.2,279.8" />
						</g>
						<g id="taurus" title="Taurus">
							<path d="M 393.41654,214.16277 A 7.1815534,7.1815534 0 1 1 379.05343,214.16277 A 7.1815534,7.1815534 0 1 1 393.41654,214.16277 z" />
							<path d="M 402.05659,210.54049 A 9.7227182,9.7227182 0 0 1 389.46264,197.63936" />
						</g>
						<g id="gemini" title="Gemini">
							<path d="M 327.9,170.6 C 324.8,174.7 342.8,179.6 341.5,174.2 C 338.4,171 331.6,191.8 336.9,191.4 C 339.8,187.8 322.8,182.5 323.3,187.8 C 327.5,190.6 332.82,169.5 327.9,170.6 z " />
						</g>
						<g id="cancer" title="Cancer">
							<path d="M 257.73779,179.06185 C 261.35516,171.7638 268.85597,169.97028 276.24884,173.8509" />
							<path d="M 263.2647,180.14136 A 2.8586366,2.8586366 0 1 1 257.54743,180.14136 A 2.8586366,2.8586366 0 1 1 263.2647,180.14136 z" />
							<path d="M 278.21129,181.17486 C 274.5939,188.47292 267.09308,190.26642 259.70024,186.38582" />
							<path d="M 278.35113,180.14136 A 2.8586366,2.8586366 0 1 1 272.63386,180.14136 A 2.8586366,2.8586366 0 1 1 278.35113,180.14136 z" />
						</g>
						<g id="leo" title="Leo">
							<path d="M 212.353,218.36121 A 2.4969709,2.4969709 0 1 1 207.35906,218.36121 A 2.4969709,2.4969709 0 1 1 212.353,218.36121 z" />
							<path d="M 211.83845,217.04038 C 211.89165,215.72876 202.64619,212.74157 202.60267,209.11347 C 202.55466,205.11206 206.16383,200.88167 210.90391,201.33055 C 215.58416,201.77376 218.19323,219.89577 223.71104,210.34327" />
						</g>
						<g id="virgo" title="Virgo">
							<path d="M 178.73092,259.25192 C 178.73092,259.25192 172.61807,256.76082 173.88184,253.92555 C 177.91125,244.88554 194.59455,270.29165 197.9204,266.53338" />
							<path d="M 168.07132,279.54282 C 165.71513,271.03479 178.36178,276.0928 185.3229,277.95803 C 185.2513,278.02292 168.52026,273.93525 169.87349,268.88496 C 170.77616,265.51613 187.35999,269.82107 187.48123,269.90295 C 187.48123,269.90295 170.9001,265.44682 172.17609,260.68472 C 173.40903,256.08328 192.96934,263.57692 194.66893,257.23393" />
						</g>
						<g id="libra" title="Libra">
							<path d="M 190.1,341.8 L 183.6,317.8" />
							<path d="M 185.3,343.1 L 182.9,334.4" />
							<path d="M 181.2,327.9 L 178.8,319.1" />
							<path d="M 183,334.5 A 6.7,6.7 0 1 1 181.2,327.8" />
						</g>
						<g id="capricorn" title="Capricorn">
							<path d="M 342,412.1 C 339.2,415.3 338.7,420.4 339.1,426.25 L 331.2,414.7 C 312,442.4 350.8,432.1 321.8,417.7 C 313.6,413.6 320.1,405.4 326.7,406.7" />
						</g>
						<g id="aquarius" title="Aquarius">
							<path d="M 397.2,381.5 C 397.2,381.5 398.4,385.5 397,386.9 C 395.6,388.3 393,385.7 391.7,387.1 C 390.3,388.5 392.9,391.1 391.5,392.5 C 390.1,393.9 387.5,391.3 386.1,392.7 C 384.7,394.1 387.3,396.6 385.9,398 C 384.5,399.4 380.5,398.2 380.5,398.2" />
							<path d="M 391.6,375.9 C 391.6,375.9 392.8,379.9 391.4,381.3 C 390,382.7 387.4,380.1 386,381.5 C 384.6,382.9 387.2,385.5 385.8,386.8 C 384.4,388.2 381.9,385.6 380.5,387 C 379.1,388.4 381.7,391 380.3,392.4 C 378.9,393.8 374.97,392.6 374.9,392.6" />
						</g>
						<g id="pisces" title="Pisces">
							<path d="M 431.3,325.4 A 8.9,8.9 0 0 1 414.5,320.9" />
							<path d="M 410,338.2 A 8.7,8.7 0 0 1 426.6,342.7" />
							<path d="M 421.9,327 L 419.3,336.7" />
						</g>
						<g id="sagittarius" title="Sagittarius">
							<path d="M 259.9,426.5 L 254.9,425.1 L 256.3,420.2" />
							<path d="M 278.5,411.5 L 254.8,425.3" />
							<path d="M 268.9,422.4 L 264.3,414.4" />
						</g>
						<g id="scorpio" title="Scorpio">
							<path d="M 217.8,404.7 C 209.3,402.6 220.2,394 225.4,388.8 C 225.4,388.9 213.1,401.7 209.6,398 C 206.3,394.2 219.4,383.1 219.6,383 C 219.6,383 207.25,395.3 203.8,391.9 C 199.2,387.5 215.5,379.3 210.5,374.3 C 206.8,370.7 197.2,373.2 196.2,382.4" />
							<path d="M 200.4,381.2 L 196.6,384.7 L 193.1,380.9" />
						</g>
					</g>
				</g>
				<text id="ascendant" y="305" x= "0">
					<xsl:attribute name="title">
						<xsl:value-of select="chartinfo/ascmcs/Ascendant/@degree"/>
					</xsl:attribute>
					<xsl:call-template name="deg-min">
						<xsl:with-param name="deg"><xsl:value-of select="chartinfo/ascmcs/Ascendant/@degree"/></xsl:with-param>
					</xsl:call-template>
				</text>
			</g>
		</svg>
	</xsl:template>
	
	<xsl:template name="testAspect">
		<xsl:param name="body1"/>
    	<xsl:param name="body2"/>
    	<xsl:param name="deg1"/>
    	<xsl:param name="deg2"/>
    	<xsl:param name="delta"/>
    	<xsl:param name="orb"/>
    	<xsl:param name="type"/>
    	
    	<xsl:variable name="rad1" select="$deg1 * $PI div 180" />
		<xsl:variable name="rad2" select="$deg2 * $PI div 180" />
		<xsl:variable name="class" select="concat($type,' ',$body1,' ',$body2,' ',$body1,$body2)" />
		<xsl:variable name="title" select="concat($type,' between ',$body1,' and ',$body2)" />
    	
    	<xsl:if test="
    		($deg1 &gt; ($deg2       + $delta - $orb) and $deg1 &lt; ($deg2       + $delta + $orb)) or 
			($deg1 &gt; ($deg2       - $delta - $orb) and $deg1 &lt; ($deg2       - $delta + $orb)) or
			($deg1 &gt; ($deg2 + 360 + $delta - $orb) and $deg1 &lt; ($deg2 + 360 + $delta + $orb)) or 
			($deg1 &gt; ($deg2 - 360 + $delta - $orb) and $deg1 &lt; ($deg2 - 360 + $delta + $orb)) or 
			($deg1 &gt; ($deg2 + 360 - $delta - $orb) and $deg1 &lt; ($deg2 + 360 - $delta + $orb)) or  
			($deg1 &gt; ($deg2 - 360 - $delta - $orb) and $deg1 &lt; ($deg2 - 360 - $delta + $orb))">
			<xsl:if test="$deg1 &gt; $deg2">
								
				<xsl:choose>
					<xsl:when test="$type='Conjunction'">
						<xsl:variable name = "x1" select="( math:cos($rad1) * 155) + 300" />
						<xsl:variable name = "y1" select="(-math:sin($rad1) * 155) + 300" />
						<xsl:variable name = "x2" select="( math:cos($rad2) * 155) + 300" />
						<xsl:variable name = "y2" select="(-math:sin($rad2) * 155) + 300" />
						<path>
							<xsl:attribute name="d"><xsl:value-of select="concat('M',$x1,',',$y1,' A 155,155 0 0 1 ',$x2,',',$y2)"/></xsl:attribute>
							<xsl:attribute name="class"><xsl:value-of select="$class"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="$title"/></xsl:attribute>
						</path>	
					</xsl:when>
					<xsl:otherwise>
						<xsl:variable name = "x1" select="( math:cos($rad1) * 99) + 300" />
						<xsl:variable name = "y1" select="(-math:sin($rad1) * 99) + 300" />
						<xsl:variable name = "x2" select="( math:cos($rad2) * 99) + 300" />
						<xsl:variable name = "y2" select="(-math:sin($rad2) * 99) + 300" />
						<line>
							<xsl:attribute name="x1"><xsl:value-of select="$x1"/></xsl:attribute>
							<xsl:attribute name="y1"><xsl:value-of select="$y1"/></xsl:attribute>
							<xsl:attribute name="x2"><xsl:value-of select="$x2"/></xsl:attribute>
							<xsl:attribute name="y2"><xsl:value-of select="$y2"/></xsl:attribute>
							<xsl:attribute name="class"><xsl:value-of select="$class"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="$title"/></xsl:attribute>
						</line>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
