# Struts 2 + HTMX + XSLT Demo

A modern demonstration of building interactive Java web applications using **Struts 2.7+**, **HTMX**, and **XSLT** (Custom XSLT). This project showcases how to achieve partial page updates and server-side XML transformation without the complexity of heavy JavaScript frameworks.

## 🚀 Tech Stack
- **Java 17** (Required)
- **Struts 7.0.3** (Jakarta EE 10 compatible)
- **HTMX 1.9** (Partial page updates via AJAX)
- **XSLT** (Server-side XML transformation via JRE XSLT engine)
- **Jetty 12** (Lightweight embedded server)
- **Maven** (Build and dependency management)

## 🛠 Prerequisites
- **JDK 17** or higher.
- **Maven 3.8+** installed and configured in your PATH.

## 🏃 How to Run the Project

1. **Clone the repository**:
   ```bash
   git clone <your-repo-url>
   cd struts-htmx-xslt-project
   ```

2. **Clean and Compile**:
   ```bash
   mvn clean compile
   ```

3. **Start the Jetty Server**:
   ```bash
   mvn jetty:run
   ```
   or 
    ```bash
   mvn org.eclipse.jetty.ee10:jetty-ee10-maven-plugin:run
   ```

4. **Access the Demos**:
   Once the server starts, open your browser and navigate to:
   - **Home Gateway**: [http://localhost:8080/indexAction](http://localhost:8080/indexAction)
   - **HTMX Demo**: [http://localhost:8080/productsAction](http://localhost:8080/productsAction)
   - **XSLT Demo**: [http://localhost:8080/xsltProductsAction](http://localhost:8080/xsltProductsAction)

## 💡 Key Features

### Flow A: HTMX + Struts
Uses HTMX to send AJAX requests to Struts Actions. The server returns **JSP Fragments** (partial HTML) which HTMX swaps into the DOM, providing a "Single Page App" feel for search, add, and delete operations.

### Flow B: XSLT Rendering
Demonstrates true separation of data and presentation. The Struts Action builds a **W3C DOM Document** (XML) which is then transformed into HTML using **XSLT stylesheets** on the server before being sent to the browser.

## 📁 Project Structure
- `src/main/java`: Java Actions and Model classes.
- `src/main/resources`: `struts.xml` configuration.
- `src/main/webapp/WEB-INF/xslt`: XSLT templates for rendering XML.
- `src/main/webapp/fragments`: JSP snippets for HTMX swaps.
- `src/main/webapp/css`: Modern UI styling.
