<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Products - HTMX Demo</title>
    <link rel="stylesheet" href="css/style.css"/>

    <!-- HTMX Library -->
    <script src="https://unpkg.com/htmx.org@1.9.10"></script>
</head>
<body>

    <header class="app-header">
        <h1>⚡ HTMX Product Manager</h1>
        <p class="subtitle">All interactions happen without full page reloads</p>
        <a href="indexAction" class="back-link">← Back to Home</a>
    </header>

    <main class="container">

        <!-- ===== HOW HTMX WORKS (Comment in code for learning) ===== -->
        <!--
            =====================================================
            HTMX ATTRIBUTES EXPLAINED:
            =====================================================

            hx-get="/struts-app/searchProducts"
              → When triggered, send a GET request to this URL

            hx-post="/struts-app/addProduct"
              → When triggered, send a POST request with form data

            hx-target="#product-list"
              → Put the response HTML into the element with id="product-list"

            hx-swap="innerHTML"
              → Replace the inner content of the target element

            hx-trigger="keyup changed delay:300ms"
              → Trigger on keyup, but wait 300ms after the last keystroke
                (debouncing — avoids sending a request on every single keystroke)

            hx-indicator="#spinner"
              → Show this element while the request is in progress

            hx-push-url="true"
              → Update the browser URL bar (for bookmarkability)
            =====================================================
        -->

        <!-- ===== SEARCH BAR ===== -->
        <section class="search-section">
            <h2>Search Products</h2>
            <div class="search-box">
                <input type="text"
                       name="searchQuery"
                       placeholder="Search by name or category..."
                       class="search-input"

                       hx-get="searchProductsAction"
                       hx-target="#product-list"
                       hx-swap="innerHTML"
                       hx-trigger="keyup changed delay:300ms"
                       hx-indicator="#spinner"
                />
                <!-- Spinner shown while HTMX request is pending -->
                <span id="spinner" class="htmx-indicator spinner">⟳</span>
            </div>
        </section>

        <!-- ===== ADD PRODUCT FORM ===== -->
        <section class="add-section">
            <h2>Add Product</h2>

            <!--
                =====================================================
                HTMX FORM (no <form> action needed!)
                =====================================================
                hx-post sends all named inputs as POST parameters.
                Struts 2 automatically maps them to ProductAction fields.

                After success, the response (updated product list)
                replaces the content of #product-list.

                hx-swap-oob is NOT used here — we simply target
                the list div and swap it in.
                =====================================================
            -->
            <div class="add-form"
                 hx-post="addProductAction"
                 hx-target="#product-list"
                 hx-swap="innerHTML"
                 hx-indicator="#spinner"
            >
                <div class="form-row">
                    <input type="text" name="productName" placeholder="Product Name" required class="form-input"/>
                    <input type="text" name="productCategory" placeholder="Category" class="form-input"/>
                    <input type="number" name="productPrice" placeholder="Price" step="0.01" class="form-input short"/>
                    <input type="text" name="productDescription" placeholder="Description" class="form-input"/>
                    <button type="button" class="btn btn-add">+ Add</button>
                </div>
            </div>
        </section>

        <!-- ===== PRODUCT LIST ===== -->
        <section class="list-section">
            <h2>Product List</h2>

            <!--
                =====================================================
                TARGET CONTAINER
                =====================================================
                This div with id="product-list" is where HTMX
                swaps in partial HTML responses from the server.

                The initial content is loaded via JSP include.
                After that, HTMX replaces only this inner content.
                =====================================================
            -->
            <div id="product-list">
                <%@ include file="fragments/productList.jsp" %>
            </div>
        </section>

        <!-- ===== DETAIL PANEL ===== -->
        <section class="detail-section">
            <h2>Product Details</h2>
            <!--
                This div is the target for product detail clicks.
                When a user clicks a product row, HTMX fetches
                the detail fragment and swaps it in here.
            -->
            <div id="product-detail">
                <p class="placeholder-text">Click a product above to see details here.</p>
            </div>
        </section>

    </main>

    <footer class="app-footer">
        <p>⚡ All updates above happen via HTMX — no full page reload!</p>
    </footer>

</body>
</html>
