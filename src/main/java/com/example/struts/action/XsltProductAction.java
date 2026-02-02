package com.example.struts.action;

import org.apache.struts2.ActionSupport;
import org.apache.struts2.ModelDriven;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import java.util.ArrayList;
import java.util.List;

/**
 * =====================================================
 * XSLT PRODUCT ACTION (XSLT Demo)
 * =====================================================
 *
 * XSLT = Custom XSLT Processing
 * How it works:
 *   1. This action builds an XML Document (DOM)
 *   2. Returns it as the "model" object
 *   3. Struts 2's XsltResult takes that XML
 *   4. Applies the .xslt stylesheet to transform it
 *   5. Returns the resulting HTML to the browser
 *
 * This is a classic server-side rendering pattern:
 *   DATA (Java) → XML (DOM) → XSLT → HTML
 *
 * Why use this?
 *   - Separates data logic (Java) from presentation (XSLT)
 *   - XSLT files can be changed without recompiling Java
 *   - Useful for XML data sources (feeds, APIs, legacy systems)
 * =====================================================
 */
public class XsltProductAction extends ActionSupport implements ModelDriven<Document> {

    // The XML document that Struts will pass to the XSLT engine
    private Document xmlDocument;

    // ===== SAMPLE DATA (same as ProductAction) =====
    private static final List<String[]> PRODUCTS = new ArrayList<>();

    static {
        // Format: { id, name, category, price, description }
        PRODUCTS.add(new String[]{"1", "Laptop", "Electronics", "999.99", "High-performance laptop with 16GB RAM"});
        PRODUCTS.add(new String[]{"2", "Smartphone", "Electronics", "699.99", "Latest model with AMOLED display"});
        PRODUCTS.add(new String[]{"3", "Desk Chair", "Furniture", "249.99", "Ergonomic office chair with lumbar support"});
        PRODUCTS.add(new String[]{"4", "Coffee Maker", "Kitchen", "79.99", "12-cup programmable coffee maker"});
        PRODUCTS.add(new String[]{"5", "Running Shoes", "Sports", "129.99", "Lightweight shoes for marathon training"});
    }

    /**
     * EXECUTE - Builds the XML DOM and returns it.
     *
     * The XML structure produced:
     * <products>
     *     <product id="1">
     *         <name>Laptop</name>
     *         <category>Electronics</category>
     *         <price>999.99</price>
     *         <description>...</description>
     *     </product>
     *     ...
     * </products>
     */
    public String execute() throws Exception {

        // ===== STEP 1: Create a new XML Document =====
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        xmlDocument = builder.newDocument();

        // ===== STEP 2: Build the root element <products> =====
        Element rootElement = xmlDocument.createElement("products");
        xmlDocument.appendChild(rootElement);

        // ===== STEP 3: Add each product as a child element =====
        for (String[] p : PRODUCTS) {
            Element productElement = xmlDocument.createElement("product");
            productElement.setAttribute("id", p[0]);

            // Add child elements for each field
            addChild(xmlDocument, productElement, "name", p[1]);
            addChild(xmlDocument, productElement, "category", p[2]);
            addChild(xmlDocument, productElement, "price", p[3]);
            addChild(xmlDocument, productElement, "description", p[4]);

            rootElement.appendChild(productElement);
        }

        // ===== STEP 4: Return SUCCESS =====
        // Struts will take xmlDocument and pass it to XSLT
        return SUCCESS;
    }

    /**
     * Helper: Creates a child element with text content.
     *   <tagName>value</tagName>
     */
    private void addChild(Document doc, Element parent, String tagName, String value) {
        Element child = doc.createElement(tagName);
        child.appendChild(doc.createTextNode(value));
        parent.appendChild(child);
    }

    /**
     * ===== GETTER =====
     * Struts 2's XsltResult looks for a method called getModel()
     * or uses the default result. We expose the XML document here.
     */
    public Document getModel() {
        return xmlDocument;
    }
}
