<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                version="2.0">

  <!-- Output come HTML -->
  <xsl:output method="html" doctype-public="XSLT-Compat" encoding="UTF-8" indent="yes"/>

  <!-- Template radice -->
  <xsl:template match="/">
    <!-- Inizio HTML -->
    <html>
      <head>
        <title>La Rassegna Settimanale</title>
        <link rel="stylesheet" href="stile.css"/>
        <script src="script.js" defer="defer"></script>
      </head>
      <body>
        <!-- Header -->
        <div class="header">
          <h1 id="titolo">
            <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
          </h1>
        </div>

        <!-- Navbar -->
        <div class="navbar">
          <ul>
            <li><a href="#articoli">Articoli</a></li>
            <li><a href="#bibliografie">Bibliografie</a></li>
            <li><a href="#notizie">Notizie</a></li>
            <li><a href="#informazioni">Informazioni</a></li>
          </ul>
        </div>

        <!-- Contenuto principale -->
        <div class="main-container">
          <!-- Sidebar -->
          <div class="sidebar">
            <h3>Filtri</h3>
            <ul id="tagList">
              <li><a href="#" id="placeName">Luoghi (<xsl:value-of select="count(//tei:placeName)" />) </a></li>
              <li><a href="#" id="geogName">Luoghi naturali (<xsl:value-of select="count(//tei:geogName)" />)</a></li>
              <li><a href="#" id="orgName"> Organizzazioni (<xsl:value-of select="count(//tei:orgName)" />)</a></li>
              <li><a href="#" id="temi">Temi (<xsl:value-of select="count(//tei:rs[@type='temi'])" />)</a></li>
              <li><a href="#" id="persName">Persone (<xsl:value-of select="count(//tei:persName)" />)</a></li>
              <li><a href="#" id="date">Date (<xsl:value-of select="count(//tei:date)" />)</a></li>
              <li><a href="#" id="titoli"> Titoli (<xsl:value-of select="count(//tei:title)" />)</a></li>
              <li><a href="#" id="foreign">Lingua Straniera (<xsl:value-of select="count(//tei:foreign)" />)</a></li>
              <li><a href="#" id="epithet">Epiteti (<xsl:value-of select="count(//tei:addName)" />)</a></li>
            </ul>
          </div>

          <!-- Cicla attraverso i surface -->
          <xsl:for-each select="//tei:surface">
            <!-- Crea una variabile per l'indice che incrementa ogni volta (position di surface) -->
            <xsl:variable name="currentIndex" select="position()"/>

            <!-- Crea un div container per ogni surface -->
            <div class="container">

              <xsl:choose>
                <xsl:when test="position() = 1">
                  <h2 id="articoli">ARTICOLI</h2>
                </xsl:when>
                <xsl:when test="position() = 3">
                  <h2 id="bibliografie">BIBLIOGRAFIE</h2>
                </xsl:when>
                <xsl:when test="position() = 5">
                  <h2 id="notizie">NOTIZIE</h2>
                </xsl:when>
              </xsl:choose>

              <!-- Image Container -->
              <div class="image-container">
                <!-- Estrae e visualizza l'immagine corrispondente a ciascun surface -->
                <img>
                  <xsl:attribute name="src">
                    <xsl:value-of select="tei:graphic/@url"/>
                  </xsl:attribute>
                  <xsl:attribute name="width">500px</xsl:attribute>
                  <xsl:attribute name="height">
                    <xsl:value-of select="tei:graphic/@height"/>
                  </xsl:attribute>
                  <xsl:attribute name="usemap">
                    <xsl:value-of select="concat('#', @xml:id)"/>
                  </xsl:attribute>
                </img>

                <!-- Aggiunge la mappa cliccabile associata all'immagine -->
                <xsl:call-template name="createMap"/>
              </div>

              <!-- Text Container sotto l'immagine -->
              <div class="text-container">
                <!-- Seleziona il testo corrispondente al currentIndex di surface -->
                <xsl:apply-templates select="//tei:text[$currentIndex]"/>
              </div>

            </div>
          </xsl:for-each>


          <!-- Informazioni Section -->
          <div id="informazioni">
            <h2>INFORMAZIONI</h2>
            <div>
              <h3>Edizione digitale</h3>
              <p><strong>Progetto sotto la guida di: </strong> <xsl:value-of select="//tei:respStmt[1]/tei:name"/></p>
              <p><strong>Codifica realizzata da: </strong>
                <xsl:for-each select="//tei:editionStmt/tei:respStmt[2]/tei:name">
                  <xsl:value-of select="tei:forename"/> <xsl:value-of select="tei:surname"/>
                  <xsl:if test="position() != last()">, </xsl:if>
                </xsl:for-each>
              </p>
              <p><strong>Pubblicato da: </strong> <xsl:value-of select="//tei:publicationStmt/tei:publisher"/></p>
              <p><strong>Data: </strong> <xsl:value-of select="//tei:publicationStmt/tei:date"/></p>
              <p><strong>Disponibilità: </strong> <xsl:value-of select="//tei:availability/tei:p"/></p>
            </div>

            <div>
              <h3>Fonte Bibliografica</h3>
              <p><strong>Titolo: </strong> <xsl:value-of select="//tei:sourceDesc/tei:bibl/tei:title[1]"/></p>
              <p><strong>Fondatori: </strong>
                <xsl:for-each select="//tei:bibl/tei:author">
                  <xsl:value-of select="."/>
                  <xsl:if test="position() != last()">, </xsl:if>
                </xsl:for-each>
              </p>
              <p><strong>Luogo di pubblicazione: </strong> <xsl:value-of select="//tei:pubPlace"/></p>
              <p><strong>Data di pubblicazione: </strong> 
                <xsl:value-of select="//tei:bibl/tei:date[1]"/> - <xsl:value-of select="//tei:bibl/tei:date[2]"/>
              </p>
              <p><strong>Lingua: </strong> <xsl:value-of select="//tei:langUsage/tei:language"/></p>
              <p><strong>Tipo di pubblicazione: </strong> settimanale</p>
              <p><strong>Numero di riviste pubblicate:</strong> 213</p>
            </div>

            <div>
              <h3>Autori che hanno preso parte alla rivista:</h3>
              <ul>
                <xsl:for-each select="//tei:listPerson/tei:person/tei:persName">
                  <li><xsl:value-of select="."/></li>
                </xsl:for-each>
              </ul>
            </div>
          </div>

        </div>
      </body>
    </html>
  </xsl:template>

  <!-- Template per <tei:ab> -->
  <xsl:template match="tei:ab">
    <span id="{@facs}">
      <!-- La funzione node() seleziona tutti i nodi figli dell'elemento <tei:ab>, inclusi i <tei:lb> -->
      <xsl:apply-templates select="node()"/>
    </span>
  </xsl:template>

  <!-- Template per <tei:lb> (line break) -->
  <xsl:template match="tei:lb">
    <br/>
  </xsl:template>

  <!-- Template per <tei:quote> -->
  <xsl:template match="tei:quote">
    <blockquote class="quote">
      <xsl:apply-templates select="node()"/>
    </blockquote>
  </xsl:template>

  <!-- Template per creare la mappa cliccabile per ogni surface -->
  <xsl:template name="createMap">
    <xsl:element name="map">
      <xsl:attribute name="name">
        <xsl:value-of select="@xml:id"/>
      </xsl:attribute>
      <!-- Calcola la larghezza dell'immagine e il rapporto di ridimensionamento -->
      <xsl:variable name="Width" select="number(substring-before(tei:graphic/@width, 'px'))"/>
      <xsl:variable name="ratio" select="500 div $Width"/>
      <!-- Cicla attraverso le zone della superficie per creare le aree cliccabili -->
      <xsl:for-each select="tei:zone">
        <xsl:element name="area">
          <xsl:attribute name="shape">rect</xsl:attribute>
          <!-- Calcola le coordinate per l'area cliccabile in base al rapporto -->
          <xsl:attribute name="coords">
            <xsl:value-of select="concat(@ulx * $ratio, ',', @uly * $ratio, ',', @lrx * $ratio, ',', @lry * $ratio)" />
          </xsl:attribute>
          <!-- L'attributo id corrisponde all'xml:id della zona -->
          <xsl:attribute name="id">
            <xsl:value-of select="@xml:id" />
          </xsl:attribute>
          <!-- L'attributo href punta alla zona corrispondente nel testo -->
          <xsl:attribute name="href">
            <xsl:value-of select="concat('##', @xml:id)" />
          </xsl:attribute>
        </xsl:element>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>

  <!-- Template per i filtri -->
  <xsl:template match="tei:persName | tei:placeName | tei:geogName | tei:publisher | tei:date | tei:foreign | tei:orgName | tei:addName | tei:rs[@type='opere'] | tei:rs[@type='temi'] | tei:rs[@type='correnti-letteriarie']">
    <span class="{name()}">
      <xsl:attribute name="data-filter">
        <xsl:choose>
          <xsl:when test="@type">
            <xsl:value-of select="@type" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="name()" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:apply-templates />
    </span>
  </xsl:template>

  <!-- Template per gli spazi dei titoli -->
  <xsl:template match="tei:lb[@xml:id='next_text1']">
    <br/>
    <br/>
    <br/>
  </xsl:template>

  
  <xsl:template match="tei:lb[@xml:id='next_text2']">
    <br/>
    <br/>
    <br/>
  </xsl:template>

 
  <xsl:template match="tei:lb[@xml:id='next_text3']">
    <br/>
    <br/>
    <br/>
  </xsl:template>


    <xsl:template match="tei:lb[@xml:id='t_pio']">
        <br/>
        <br/>
        <lb>
            <xsl:value-of select="."/> 
        </lb>
    </xsl:template>

    

    <xsl:template match="tei:lb[@xml:id='t_gp']">
        <br/>
        <br/>
        <lb>
            <xsl:value-of select="."/>
        </lb>
    </xsl:template>

    

    <xsl:template match="tei:lb[@xml:id='t_let']">
        <br/>
        <br/>
        <lb>
            <xsl:value-of select="."/> 
        </lb>
    </xsl:template>

    <!-- Template per <choice> -->
  <xsl:template match="tei:choice">
    <span class="choice">
      <span class="sic" style="display: none;">
        <xsl:apply-templates select="tei:sic"/>
      </span>
      <span class="corr">
        <xsl:apply-templates select="tei:corr"/>
      </span>
      <button class="toggle-choice-button" onclick="toggleChoice()">Toggle</button>
    </span>
  </xsl:template>
  
</xsl:stylesheet>
