<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Struts 2 + HTMX + CXSLT Demo</title>
    <link rel="stylesheet" href="css/style.css"/>

    <!--
        =====================================================
        HTMX LIBRARY
        =====================================================
        HTMX is a lightweight JS library (~14kb).
        It allows you to do AJAX requests directly from
        HTML attributes (no JavaScript needed!).

        Key attributes:
          hx-get     → sends a GET request
          hx-post    → sends a POST request
          hx-target  → which element to swap the response into
          hx-swap    → how to swap (innerHTML, outerHTML, etc.)
          hx-trigger → when to trigger (click, keyup, etc.)
        =====================================================
    -->
    <script src="https://unpkg.com/htmx.org@1.9.10"></script>
</head>
<body>

    <header class="app-header">
        <h1>Struts 2 + HTMX + CXSLT</h1>
        <p class="subtitle">A practical demo of server-side rendering with partial page updates</p>
    </header>

    <main class="container">

        <!-- ===== CONCEPT OVERVIEW ===== -->
        <section class="concept-card">
            <h2>How It Works</h2>
            <div class="concept-grid">
                <div class="concept-item">
                    <div class="concept-icon">1</div>
                    <h3>Struts 2</h3>
                    <p>Handles routing, data binding, and action logic on the server.</p>
                </div>
                <div class="concept-item">
                    <div class="concept-icon">2</div>
                    <h3>HTMX</h3>
                    <p>Sends AJAX requests from HTML attributes. Swaps partial HTML responses into the page — no full reload.</p>
                </div>
                <div class="concept-item">
                    <div class="concept-icon">3</div>
                    <h3>CXSLT</h3>
                    <p>Transforms XML data into HTML using XSLT stylesheets. Separates data from presentation.</p>
                </div>
            </div>
        </section>

        <!-- ===== NAVIGATION TO DEMOS ===== -->
        <section class="nav-cards">
            <h2>Choose a Demo</h2>
            <div class="nav-grid">

                <!--
                    =====================================================
                    HTMX DEMO LINK
                    =====================================================
                    hx-get="/products"      → Fetch the products page
                    This is a regular link, but demonstrates that
                    HTMX can also work with full pages.
                    =====================================================
                -->
                <a href="productsAction" class="nav-card htmx-card">
                    <div class="nav-icon">⚡</div>
                    <h3>HTMX Demo</h3>
                    <p>Interactive product list with live search, add, delete — all without page reloads.</p>
                    <span class="nav-tag">Partial Page Updates</span>
                </a>

                <!--
                    =====================================================
                    CXSLT DEMO LINK
                    =====================================================
                    This loads a page where XML data is transformed
                    into HTML entirely via XSLT on the server.
                    =====================================================
                -->
                <a href="xsltProductsAction" class="nav-card xslt-card">
                    <div class="nav-icon">🔄</div>
                    <h3>CXSLT Demo</h3>
                    <p>Product list rendered by transforming XML data using XSLT stylesheets on the server.</p>
                    <span class="nav-tag">XML → XSLT → HTML</span>
                </a>

            </div>
        </section>

        <!-- ===== TECH STACK ===== -->
        <section class="tech-stack">
            <h2>Tech Stack</h2>
            <div class="stack-grid">
                <span class="stack-badge">Java 17</span>
                <span class="stack-badge">Struts 2.7</span>
                <span class="stack-badge">Tomcat 10.1+</span>
                <span class="stack-badge">Jakarta EE</span>
                <span class="stack-badge">HTMX 1.9</span>
                <span class="stack-badge">XSLT 1.0</span>
                <span class="stack-badge">Saxon HE</span>
                <span class="stack-badge">Maven</span>
            </div>
        </section>

    </main>

    <footer class="app-footer">
        <p>Struts 2 + HTMX + CXSLT Learning Project</p>
    </footer>

</body>
</html>
