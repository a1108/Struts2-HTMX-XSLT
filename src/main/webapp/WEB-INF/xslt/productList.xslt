<?xml version="1.0" encoding="UTF-8"?>
<!--
    =====================================================
    XSLT STYLESHEET - FRAGMENT ONLY (for HTMX)
    =====================================================
    This stylesheet outputs ONLY the product table —
    no <html>, <head>, or <body> tags.

    This is the HTMX + XSLT pattern combined:
      1. HTMX sends a request for fresh data
      2. Struts runs the Java Action (builds XML)
      3. This XSLT transforms XML → HTML fragment
      4. HTMX swaps the fragment into the page

    This proves that XSLT and HTMX work great together!
    =====================================================
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" encoding="UTF-8"/>

    <!-- Match the root and output just the table -->
    <xsl:template match="/">
        <table class="product-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Description</th>
                </tr>
            </thead>
            <tbody>
                <xsl:for-each select="products/product">
                    <xsl:sort select="name" order="ascending"/>
                    <tr class="product-row">
                        <td><xsl:value-of select="@id"/></td>
                        <td><xsl:value-of select="name"/></td>
                        <td>
                            <span class="badge">
                                <xsl:value-of select="category"/>
                            </span>
                        </td>
                        <td class="price">$<xsl:value-of select="price"/></td>
                        <td><xsl:value-of select="description"/></td>
                    </tr>
                </xsl:for-each>

                <!-- Conditional: show message if no products -->
                <xsl:if test="count(products/product) = 0">
                    <tr>
                        <td colspan="5" class="no-results">No products available.</td>
                    </tr>
                </xsl:if>
            </tbody>
        </table>

        <!-- Show total count below table -->
        <p class="result-count">
            Showing <xsl:value-of select="count(products/product)"/> products
            (sorted alphabetically by name)
        </p>
    </xsl:template>

</xsl:stylesheet>
