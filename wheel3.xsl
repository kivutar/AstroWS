<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:math="http://exslt.org/math">
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
					<xsl:for-each select="chartinfo/aspects/*">
						<xsl:variable name = "rad1" select="@degree1 * $PI div 180" />
						<xsl:variable name = "rad2" select="@degree2 * $PI div 180" />
						<xsl:variable name = "class" select="concat(local-name(),' ',@body1,' ',@body2,' ',@body1,@body2)" />
						<xsl:variable name = "title" select="concat(local-name(),' between ',@body1,' and ',@body2)" />
						<xsl:choose>
							<xsl:when test="local-name()='Conjunction'">
								<xsl:variable name = "x1" select="( math:cos($rad1) * 211) + 300" />
								<xsl:variable name = "y1" select="(-math:sin($rad1) * 211) + 300" />
								<xsl:variable name = "x2" select="( math:cos($rad2) * 211) + 300" />
								<xsl:variable name = "y2" select="(-math:sin($rad2) * 211) + 300" />
								<path>
									<xsl:attribute name="d"><xsl:value-of select="concat('M',$x1,',',$y1,' A 211,211 0 0 1 ',$x2,',',$y2)"/></xsl:attribute>
									<xsl:attribute name="class"><xsl:value-of select="$class"/></xsl:attribute>
									<xsl:attribute name="title"><xsl:value-of select="$title"/></xsl:attribute>
								</path>	
							</xsl:when>
							<xsl:otherwise>
								<xsl:variable name = "x1" select="( math:cos($rad1) * 75) + 300" />
								<xsl:variable name = "y1" select="(-math:sin($rad1) * 75) + 300" />
								<xsl:variable name = "x2" select="( math:cos($rad2) * 75) + 300" />
								<xsl:variable name = "y2" select="(-math:sin($rad2) * 75) + 300" />
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
					</xsl:for-each>
				</g>
				<g id="houses">			
					<path d="M 300,295 L 300,305" class="origin" />
					<path d="M 295,300 L 305,300" class="origin" />
					<path id="cercle" d="M 300 200 C 244.8 200 200 244.80001 200 300 C 200 355.2 244.8 400.00001 300 400 C 355.2 400 400 355.20001 400 300 C 400 244.8 355.2 200 300 200 z M 300 225 C 341.4 225 375 258.6 375 300 C 375 341.39999 341.4 375 300 375 C 258.6 374.99999 225 341.4 225 300 C 225 258.59999 258.6 225 300 225 z" />
				</g>
				<g id="cuspids">
					<xsl:for-each select="chartinfo/houses/*">
						<xsl:variable name = "rad1" select="(@degree_ut - $asc + 180) * $PI div 180" />
						<xsl:variable name = "rad2" select="(@degree_ut - $asc + 185) * $PI div 180" />
						<xsl:variable name = "x1" select="( math:cos($rad1) * 75) + 300" />
						<xsl:variable name = "y1" select="(-math:sin($rad1) * 75) + 300" />
						<xsl:variable name = "x2" select="( math:cos($rad1) * 240) + 300" />
						<xsl:variable name = "y2" select="(-math:sin($rad1) * 240) + 300" />
						<xsl:variable name = "x3" select="( math:cos($rad2) * 85) + 295" />
						<xsl:variable name = "y3" select="(-math:sin($rad2) * 85) + 305" />
						<line>
							<xsl:attribute name="x1"><xsl:value-of select="$x1"/></xsl:attribute>
							<xsl:attribute name="y1"><xsl:value-of select="$y1"/></xsl:attribute>
							<xsl:attribute name="x2"><xsl:value-of select="$x2"/></xsl:attribute>
							<xsl:attribute name="y2"><xsl:value-of select="$y2"/></xsl:attribute>
							<xsl:attribute name="class"><xsl:value-of select="concat('House ',@number)"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="concat('House ',@number)"/></xsl:attribute>
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
						<xsl:variable name = "x1" select="( math:cos($rad) * 215) + 300" />
						<xsl:variable name = "y1" select="(-math:sin($rad) * 215) + 300" />
						<xsl:variable name = "x2" select="( math:cos($rad) * 195) + 300" />
						<xsl:variable name = "y2" select="(-math:sin($rad) * 195) + 300" />
						<xsl:variable name = "x3" select="( math:cos($rad) * (175 - @dist*20)) + 300" />
						<xsl:variable name = "y3" select="(-math:sin($rad) * (175 - @dist*20)) + 300" />
						<xsl:variable name = "x4" select="( math:cos($rad) * (140 - @dist*20)) + 285" />
						<xsl:variable name = "y4" select="(-math:sin($rad) * (140 - @dist*20)) + 300" />							
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
						<path d="M 296.69889,50.028445 C 173.89868,49.220374 60.153109,152.39966 51.239089,275.11851 C 40.449985,379.67823 100.99418,488.22229 198.67681,528.81739 C 286.8823,568.29401 399.3537,552.1213 469.48868,484.24812 C 536.67912,422.92471 567.65781,322.84811 541.65194,234.84154 C 517.81623,144.99327 440.48033,70.912301 348.65829,54.752024 C 331.59894,51.208456 314.17355,49.774669 296.69889,50.028445 z
						M 301.13089,83.326785 C 413.48133,81.521159 516.59117,180.78114 516.89946,293.7303 C 520.67446,394.00334 446.40083,492.43728 347.37534,511.53992 C 256.17827,532.25122 153.55248,488.26158 110.46025,404.53456 C 67.610407,327.43446 76.487577,222.91192 137.14679,157.73778 C 177.91303,111.31756 238.64284,82.491973 301.13089,83.326785 z"
							class="disc" />
						<path d="M 425.09801,83.323915 L 408.21166,112.57193" />
						<path d="M 83.412664,175 L 111.6489,191.28406" />
						<path d="M 174.72456,516.98345 L 191.69963,487.58176" />
						<path d="M 516.58738,425 L 487.69455,408.33728" />
						<path d="M 516.34497,175.0932 L 487.85904,191.53955" />
						<path d="M 175.49937,84.358538 L 191.62095,112.28195" />
						<path d="M 84.358554,424.50065 L 111.81452,408.64894" />
						<path d="M 425.18674,516.82978 L 408.74773,488.35657" />
						<path d="M 550.23081,300 L 517.2304,300" />
						<path d="M 300.00001,50.998683 L 300,82.97455" />
						<path d="M 50.9987,300.00001 L 83.589304,300" />
						<path d="M 300.00003,549.0013 L 300,517.02547" />
					</g>
					<g id="signs">
						<g id="aries" title="Aries">
							<path d="M 526.21594,221.08406 C 547.48695,226.78365 523.85681,259.53924 513.93532,242.35471 C 513.93533,222.63765 550.79351,239.04773 535.20595,254.6353" />
						</g>
						<g id="taurus" title="Taurus">
							<path d="m 468.2963,144.52868 c -2.97406,3.10813 -8.26844,3.44359 -11.61482,0.74332 -3.40517,-2.5189 -4.4427,-7.60335 -2.3124,-11.25995 1.95811,-3.6798 6.70672,-5.47863 10.61238,-4.02793 3.96365,1.30421 6.55039,5.68939 5.77157,9.78937 -0.29739,1.7901 -1.16975,3.47616 -2.45673,4.75519 z" />
							<path d="m 481.97393,134.02985 c -5.21491,2.09522 -11.66444,0.0325 -14.71389,-4.68279 -2.27745,-3.35153 -2.74347,-7.82427 -1.19581,-11.57048" />
						</g>
						<g id="gemini" title="Gemini">
							<path d="M 355.79958,61.628128 C 351.81481,66.800981 374.43046,73.002411 372.83937,66.193915 C 368.92608,62.175414 360.44763,88.225108 367.03976,87.838241 C 370.71791,83.25558 349.40106,76.640574 350,83.272459 C 355.21543,86.823148 361.92959,60.300701 355.79958,61.628128 z" />
						</g>
						<g id="cancer" title="Cancer">
							<path d="m 226.56175,73.722287 c 2.03109,-4.260265 5.86491,-7.794107 10.55624,-8.790136 4.4075,-1.003931 9.0535,0.08338 12.98674,2.162675" />
							<path d="m 233.58934,74.073262 c 0.66879,2.176946 -1.18113,4.611014 -3.45794,4.550869 -2.26289,0.09991 -4.15496,-2.272882 -3.54949,-4.456952 0.44924,-2.214976 3.19928,-3.47831 5.17106,-2.371851 0.89697,0.456569 1.58193,1.303635 1.83637,2.277934 z" />
							<path d="m 252.60064,76.409684 c -2.0311,4.260267 -5.86493,7.794109 -10.55626,8.790138 -4.4075,1.003927 -9.05349,-0.08338 -12.98672,-2.162664" />
							<path d="m 245.57302,76.058705 c -0.66879,-2.176946 1.18113,-4.611014 3.45794,-4.550869 2.2629,-0.09991 4.15496,2.272882 3.54949,4.456952 -0.44923,2.214976 -3.19928,3.47831 -5.17105,2.371851 -0.89698,-0.456569 -1.58194,-1.303635 -1.83638,-2.277934 z" />
						</g>
						<g id="leo" title="Leo">
							<path d="m 133.83512,146.59194 c -1.49061,-1.35001 -0.64636,-4.25017 1.40835,-4.83778 1.98979,-0.75778 4.0746,1.119 3.50612,3.15736 -0.45251,2.22982 -3.439,3.25334 -4.91447,1.68042 z" />
							<path d="m 138.35379,142.79286 c -0.59865,-1.25068 -2.15739,-1.68795 -3.25116,-2.43864 -2.59189,-1.52195 -5.47289,-2.87446 -7.30429,-5.35089 -1.11965,-1.60939 -0.52339,-3.71757 0.11788,-5.39332 1.51342,-3.69663 5.52379,-6.40037 9.57037,-5.78668 1.99319,0.60194 3.02727,2.61784 4.0542,4.26756 1.76048,2.95531 2.9609,6.29915 5.2971,8.8763 0.88583,1.07511 2.56936,1.48787 3.67061,0.49409 0.94452,-0.73119 1.61255,-1.75591 2.21206,-2.77245" />
						</g>
						<g id="virgo" title="Virgo">
							<path d="m 62.4718,248.19409 c -0.448697,-1.41564 -0.513115,-3.43525 1.06724,-4.15802 2.28032,-0.90514 4.790353,-0.20958 7.094815,0.2661 2.830715,0.67362 5.589883,1.60682 8.395889,2.37085 -4.089485,-1.00311 -8.175885,-2.30173 -11.829694,-4.43538 -1.406887,-0.9077 -3.229035,-2.14768 -3.046837,-4.04636 0.505152,-1.69452 2.767495,-1.38355 4.159235,-1.45378 4.332179,0.20333 8.59899,1.13325 12.788845,2.20431 -4.282977,-1.27395 -8.63538,-2.66422 -12.391249,-5.14943 -1.208326,-0.8586 -2.813929,-2.2294 -2.230294,-3.89677 0.761597,-1.36218 2.582957,-1.27338 3.947196,-1.32997 4.747609,0.0203 9.483323,1.259 14.228422,0.59883 1.385478,-0.22799 2.975878,-0.87539 3.344629,-2.3823" />
							<path d="m 72.702808,228.71903 c -1.828818,-0.87184 -3.977279,-1.85922 -4.753519,-3.86868 -0.347138,-1.73253 1.466965,-3.52717 3.215744,-3.07255 2.788694,0.64695 4.94205,2.72814 7.070886,4.5147 3.400658,2.94742 6.36937,6.40954 10.067083,9.00255 0.795622,0.47502 2.004381,1.24473 2.817733,0.41267" />
						</g>
						<g id="libra" title="Libra">
							<path d="M 89.728472,373.36551 C 87.067611,363.43508 84.406751,353.50466 81.74589,343.57423" />
							<path d="m 83.7702,374.96203 c -0.965346,-3.60273 -1.930692,-7.20545 -2.896038,-10.80818" />
							<path d="m 78.730717,356.15444 c -0.981017,-3.66123 -1.962033,-7.32247 -2.94305,-10.9837" />
							<path d="m 80.94385,364.26467 c -1.049976,3.9914 -5.407558,6.70283 -9.461915,5.89355 -4.022346,-0.62014 -7.138145,-4.53489 -6.844552,-8.57995 0.126134,-3.99176 3.521828,-7.529 7.513573,-7.84184 2.386267,-0.24315 4.849036,0.60853 6.568391,2.2727" />
						</g>
						<g id="capricorn" title="Capricorn">
							<path d="m 370,520.52492 c -2.49777,2.93696 -2.84436,7.01043 -2.80989,10.70836 -0.0864,0.61428 0.25397,2.36452 -0.0119,2.31594 -2.40928,-3.51736 -4.81857,-7.03471 -7.22785,-10.55207 -2.25118,3.34672 -4.50809,6.91967 -5.14077,10.97621 -0.27804,1.79182 0.0897,4.07934 1.91566,4.91471 2.02337,0.97147 4.78172,-0.53666 4.85776,-2.83402 0.0694,-2.46574 -1.78065,-4.42876 -3.51363,-5.94712 -2.36178,-2.05052 -5.18382,-3.43854 -7.90844,-4.92311 -1.7204,-1.02245 -3.03341,-3.06961 -2.43284,-5.11187 0.93433,-3.29665 4.77066,-5.24303 8.03671,-4.61762" />
						</g>
						<g id="aquarius" title="Aquarius">
							<path d="m 476.69171,457.68313 c 0.48448,2.00618 1.04221,4.30091 0.0442,6.23476 -0.82692,1.36646 -2.59515,0.80893 -3.80797,0.40683 -1.17645,-0.47245 -3.02846,-0.61425 -3.49684,0.89181 -0.50125,1.87904 1.34969,3.71561 0.456,5.55017 -0.82729,1.35037 -2.58529,0.78248 -3.7892,0.38805 -1.17643,-0.47245 -3.02846,-0.61429 -3.49682,0.89179 -0.50126,1.87903 1.34967,3.71561 0.456,5.55017 -1.06917,1.4506 -3.14885,1.20903 -4.72655,1.03046 -0.71821,-0.10589 -1.43071,-0.25485 -2.12896,-0.45397" />
							<path d="m 469.77111,450.76252 c 0.48449,2.00619 1.04221,4.30092 0.0442,6.23478 -0.82691,1.36646 -2.59514,0.80891 -3.80796,0.40682 -1.17644,-0.47246 -3.02846,-0.61426 -3.49684,0.8918 -0.50125,1.87904 1.3497,3.71561 0.456,5.55017 -0.82729,1.35037 -2.58529,0.78248 -3.78919,0.38805 -1.17644,-0.47246 -3.02844,-0.61427 -3.49681,0.8918 -0.50128,1.87903 1.34967,3.71562 0.45597,5.55018 -1.06916,1.4506 -3.14883,1.20902 -4.72653,1.03045 -0.7182,-0.10589 -1.4307,-0.25485 -2.12895,-0.45397" />
						</g>
						<g id="pisces" title="Pisces">
							<path d="m 527.83005,353.82681 c -1.08002,4.03066 -2.16003,8.06132 -3.24005,12.09198" />
							<path d="m 539.27873,351.70291 c -1.0452,3.96282 -5.84799,6.58272 -10.73753,5.87157 -4.73718,-0.54091 -8.98451,-4.10512 -9.69193,-8.11718 -0.21257,-1.0788 -0.18812,-2.17106 0.0663,-3.20524" />
							<path d="m 513.17866,367.89748 c 1.0452,-3.96282 5.84799,-6.58272 10.73753,-5.87157 4.73718,0.54091 8.98451,4.10512 9.69193,8.11718 0.21257,1.0788 0.18812,2.17106 -0.0663,3.20524" />
						</g>
						<g id="sagittarius" title="Sagittarius">
							<path d="m 250.29885,516.36873 c -8.83738,5.10226 -17.67476,10.20452 -26.51214,15.30678" />
							<path d="m 239.59392,528.44081 c -1.70076,-2.9458 -3.40151,-5.89159 -5.10227,-8.83739" />
							<path d="m 229.57114,533.04915 c -1.85862,-0.49802 -3.71725,-0.99603 -5.57587,-1.49405 0.49802,-1.85861 0.99605,-3.71723 1.49407,-5.57584" />
						</g>
						<g id="scorpio" title="Scorpio">
							<path d="m 139.43237,481.93325 c -1.54707,-0.29301 -3.47836,-1.34164 -3.25591,-3.18554 0.4798,-2.788 2.65851,-4.85119 4.48354,-6.86724 2.11512,-2.1997 4.39916,-4.22716 6.56492,-6.37545 -3.2782,3.40291 -6.81585,6.66668 -10.9394,9.02353 -1.52378,0.77127 -3.62534,1.81253 -5.18751,0.58673 -1.47245,-1.42912 -0.37448,-3.65547 0.47927,-5.11151 2.55651,-4.0395 6.06693,-7.3753 9.64228,-10.50413 -3.64007,3.44084 -7.41708,6.91259 -11.9572,9.12947 -1.45883,0.68769 -3.70218,1.30238 -4.77617,-0.33806 -1.21806,-1.81613 0.29059,-3.9222 1.40091,-5.37328 2.24343,-2.96905 5.36315,-5.37206 6.75776,-8.90882 0.79628,-1.94931 -0.67567,-3.96146 -2.49197,-4.62037 -4.65602,-1.80106 -10.13929,1.12994 -12.09703,5.53437 -0.58891,1.25006 -0.94089,2.60431 -1.08982,3.97599" />
							<path d="m 121.36169,457.58659 c -1.31354,1.20991 -2.62707,2.41983 -3.94061,3.62974 -1.20992,-1.31354 -2.41985,-2.62709 -3.62977,-3.94063" />
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
</xsl:stylesheet>
