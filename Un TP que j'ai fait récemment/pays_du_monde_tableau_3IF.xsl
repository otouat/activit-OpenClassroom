<?xml version="1.0" encoding="UTF-8"?>

<!-- New document created with EditiX at Tue Mar 19 16:36:46 CET 2019 -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html"/>
	
	
	
<xsl:template match="/">
<html>
<head>
<title>
Pays du monde
</title>
</head>
<body style="background-color:white;" >
<h1>Les pays du monde</h1>
         Mise en forme par : Thomas Jorda, Ousmane Touat (B3443)
<xsl:apply-templates select="metadonnees"/>
	<p>
	Le pays avec 6 voisins sont :
	<xsl:for-each select="//country">
		<xsl:if test="count(borders/neighbour)=6">
			<xsl:value-of select="name/common"/> ,
		</xsl:if>
	</xsl:for-each>
	</p>
	
	<p>
	Le pays avec le nom commun le plus petit est :
	<xsl:for-each select="//country">
		<xsl:sort select="string-length(name/common)" data-type="number" order="ascending"/>
		<xsl:if test="position()=1">
         			<xsl:value-of select="name/common"/>
         		</xsl:if>
	</xsl:for-each>
	</p>
	
	<xsl:for-each select="(//continent[not(text()=preceding::continent/text())])[position() &lt; count(//continent[not(self::*=../preceding::*)])+2]">
		<xsl:variable name="tmpContinent" select="current()"/>
		<br/>
		<h3>Pays du continent : <xsl:value-of select="current()"/> par sous-régions : </h3>
		<xsl:if test="$tmpContinent!=''">
			<xsl:for-each select="//subregion[not(text()=preceding::subregion/text())]">
				<xsl:if test="current()/../continent = $tmpContinent">
					<xsl:apply-templates select="current()"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="not(node())">
			<xsl:apply-templates select="(//subregion[not(node())])[position()=2]"/>
		</xsl:if>
	</xsl:for-each>
	</body>
</html>
</xsl:template>
	
	
<xsl:template match="metadonnees"> 
	
   <p style="text-align:center; color:blue;">
	
   	Objectif : <xsl:value-of select="objectif"/>
	
    </p><hr/>
	
</xsl:template>


<xsl:template match="//subregion">
	<h4>
		<xsl:value-of select="current()"/>
	</h4>
	<table border="3" width="1800" align="center">
		<tr>
			<th>N°</th>
			<th>Nom</th>
			<th>Capitale</th>
			<th>Voisins</th>
			<th>Coordonnees</th>
			<th>Drapeau</th>
		</tr>
		<xsl:apply-templates select="//country[infosContinent/subregion=current()]"/>
	</table>
</xsl:template>
	
	
<xsl:template match="//country">
	<tr>
	
        <td><xsl:value-of select="position()"/></td>
	
            
		<td style="color:green" ><xsl:value-of select="name/common"/>   
			<span style="color:black"> (<xsl:value-of select="name/official"/>)</span>
			<br/>
			<xsl:if test="name/native_name/@lang='fra' ">
				<span style="color:brown">
					<xsl:value-of select="name/native_name[@lang='fra']/official"/>
				</span>
			</xsl:if></td>
	
            
            
		<td><xsl:value-of select="capital"/></td>
	
            
		<td>
			<xsl:choose>
			<xsl:when test="count(borders) &gt; 0">
				<xsl:for-each select="borders/neighbour">
					<xsl:value-of select="//country[codes/cca3=current()]/name/common"/>
					<xsl:if test="position() != last() ">
						<xsl:text>, </xsl:text>
					</xsl:if>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="landlocked='false'">
				<xsl:text>Ile</xsl:text>
				</xsl:if>
			</xsl:otherwise>
			</xsl:choose>
		</td>
	
            
		<td>
       
			Latitude : <xsl:value-of select="coordinates/@lat"/>
 
			<br/>
			Longitude : <xsl:value-of select="coordinates/@long"/>
         
		</td>
	
            
		<td>
			<xsl:element name="img">
			<xsl:attribute name="src">
				<xsl:text>http://www.geonames.org/flags/x/</xsl:text>
				<xsl:value-of select="translate(codes/cca2, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
				<xsl:text>.gif</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="alt"/>
			<xsl:attribute name="height">40</xsl:attribute>
			<xsl:attribute name="width">60</xsl:attribute>
			</xsl:element>
		</td>
	
	</tr>
	
</xsl:template>

</xsl:stylesheet>

