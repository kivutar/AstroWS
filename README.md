AstroWS
=======

AstroWS is a set of web services about astrology.

Services
--------

### chartinfo.py

#### Description

Returns houses, bodies positions, aspects and conjunctions for a given place and datetime.

#### Arguments

#### Exemple call

<http://astro.kivutar.me/chartinfo.py?name=Jean-Andr%C3%A9%20Santoni&city=Ollioules&lat=43&lon=5&year=1984&month=6&day=8&time=13.25&hsys=G&display=0,1,2,3,4,5,6,7,8,9,10,12,23>

### transform.py

#### Description

XSLT processor, used to generate SVG natal chart from chartinfo.py output.

#### Exemple call

<http://astro.kivutar.me/transform.py?xml=http%3A%2F%2Fastro.kivutar.me%2Fchartinfo.py%3Flat%3D17.9970194353704%26lon%3D-76.7935752868652%26year%3D1945%26month%3D6%26day%3D02%26time%3D6.75%26hsys%3DE%26display%3D0%2C1%2C2%2C3%2C4%2C5%2C6%2C7%2C8%2C9%2C10%2C12%2C23&xsl=wheel.xsl>

### rasterize.py

#### Description

SVG to PNG converter.

#### Exemple call

<http://astro.kivutar.me/rasterize.py?svg=http://www.croczilla.com/svg/samples/lion/lion.svg>

Frontend
--------

We provide an xHTML form at <http://astro.kivutar.me/gui/form.html> as frontend to AstroWS.
