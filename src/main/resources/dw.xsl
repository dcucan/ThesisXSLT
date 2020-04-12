<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:o="http://www.semestralkaMS.cz/LS2019"
    exclude-result-prefixes="xs o" 
    version="2.0">
    
    <xsl:output method="html" version="5" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/">
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
        <html lang="cs">
            <head>
                <title>Invoice</title>
            </head>
            <body>
                <xsl:call-template name="Obsah"/>

            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="o:InvoiceDocument">
        <h1>Invoice</h1>
        <xsl:apply-templates select="o:Invoice" mode="header"/>
        
            <xsl:apply-templates select="o:Company"/>
        
            <xsl:apply-templates select="o:Invoice"/>
    </xsl:template>
    
    <xsl:template match="o:Invoice" mode="header">
        <header>
            InvoiceNumber: <xsl:value-of select="o:InvoiceNumber"/><br/>
            CreationDate: <xsl:value-of select="o:CreationDate"/><br/>
            DueDate: <xsl:value-of select="o:DueDate"/><br/>
        </header>
    </xsl:template>
    
    <xsl:template match="o:Company" >
        
            <table>
                <caption>
                    <h2><xsl:value-of select="./@type"/> </h2>
                </caption>
                <xsl:apply-templates/>
            </table>
        
    </xsl:template>
    
    <xsl:template match="o:Name">
        <tr>
            <td>
                <strong>Company: </strong>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>
    
    <xsl:template match="o:RecieverID">
        <tr>
            <td>
                <strong>ID: </strong>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>
    
    <xsl:template match="o:Adress/o:Street">
        <tr>
            <td>
                <strong>Street: </strong>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>
    
    <xsl:template match="o:Adress/o:City">
        <tr>
            <td>
                <strong>City: </strong>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>
    
    <xsl:template match="o:Adress/o:PostCode">
        <tr>
            <td>
                <strong>Postcode: </strong>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>
    
    <xsl:template match="o:Adress/o:Country">
        <tr>
            <td>
                <strong>Country: </strong>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>
    
    <xsl:template match="o:EmailAdress">
        <tr>
            <td>
                <strong>Email: </strong>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>
    
    <xsl:template match="o:PhoneNumber">
        <tr>
            <td>
                <strong>Phone: </strong>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>
    
    <xsl:template name="Obsah">
        <h3>Items</h3>
        <xsl:text>&#10;</xsl:text>
        <xsl:for-each select="//o:Item">
            <a href="Item{position()}.html">
                <xsl:value-of select="o:ItemID"/> - <xsl:value-of select="o:Description"/>
            </a>
            <br/>
        </xsl:for-each>
    </xsl:template>
                        
       
    <xsl:template match="o:Invoice">
        <xsl:apply-templates select="o:InvoiceItems"/>
        <xsl:apply-templates select="o:InvoiceTotals"></xsl:apply-templates>
    </xsl:template>
    
    
    
    <xsl:template match="o:InvoiceItems">
        <table >
            <caption>
                <h2>Items</h2>
            </caption>
            <tr>
                <th>ID</th>
                <th>Image</th>
                <th>Description</th>
                <th>Quantity</th>
                <th>Unit Price</th>
                <th>Total Price</th>
            </tr>
            
            <xsl:for-each select="//o:Invoice/o:InvoiceItems/o:Item">
                
            <tr>
                <td>
                   <xsl:value-of select="o:ItemID"/>
                </td>
                <td>
                    <xsl:if test="o:Picture/@href">
                        <img src="{o:Picture/@href}" alt="." style="width:128px;height:100px;" />
                    </xsl:if>
                </td>
                <td>
                    <xsl:value-of select="o:Description"/>
                </td>
                <td>
                    <xsl:value-of select="o:Quantity"/>
                </td>
                <td>
                    <xsl:value-of select="o:UnitPrice"/>
                </td>
                <td>
                    <xsl:value-of select="o:TotalPrice"/>
                </td>
            </tr>
            </xsl:for-each>
        </table>
        <xsl:for-each select="//o:InvoiceDocument/o:Invoice/o:InvoiceItems/o:Item">
            <xsl:result-document href="Item{position()}.html">
                <html lang="cs">
                    <head>
                        <link rel="stylesheet" href="stylesheet.css" type="text/css"/>
                        <title>
                            Item <xsl:value-of select="o:ItemID"/>
                        </title>
                    </head>
                    <body>
                        
                        <table>
                            <tr>
                                <th>Name</th>
                                <th><xsl:value-of select="o:Description"/></th>
                            </tr>
                            <tr>
                                <th>Quantity</th>
                                <th><xsl:value-of select="o:Quantity"/></th>
                            </tr>
                            <tr>
                                <th>UnitPrice</th>
                                <th><xsl:value-of select="o:UnitPrice"/></th>
                            </tr>
                            <tr>
                                <th>TotalPrice</th>
                                <th><xsl:value-of select="o:TotalPrice"/></th>
                            </tr>
                            <tr>
                                <th>Image</th>
                                <th>
                                    <xsl:if test="o:Picture/@href">
                                        <img src="{o:Picture/@href}" alt="." style="width:128px;height:100px;" />
                                    </xsl:if>
                                </th>
                            </tr>
                        </table>
                        <br> </br>
                        <a href="html.html">Back to Invoice</a>
                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
    
    
    
    <xsl:template match="o:InvoiceTotals">
        
            <table >
                <caption>
                    <h2>Totals</h2>
                </caption>
                <xsl:apply-templates/>
            </table>
        
    </xsl:template>
    
    <xsl:template match="o:Subtotal">
        <tr>
            <td>
                <strong>Subtotal: </strong>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>
    <xsl:template match="o:Discount">
        <tr>
            <td>
                <strong>Discount: </strong>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>
    <xsl:template match="o:TaxRate">
        <tr>
            <td>
                <strong>TaxRate: </strong>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>
    <xsl:template match="o:TaxAmount">
        <tr>
            <td>
                <strong>TaxAmount: </strong>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>
    <xsl:template match="o:Shipment">
        <tr>
            <td>
                <strong>Shipment: </strong>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>
    <xsl:template match="o:Total">
        <tr>
            <td>
                <strong>Total: </strong>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>
</xsl:stylesheet>