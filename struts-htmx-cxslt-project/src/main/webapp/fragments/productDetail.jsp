<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="/struts-tags" prefix="s" %>

<!--
    =====================================================
    HTMX FRAGMENT - PRODUCT DETAIL
    =====================================================
    Another partial HTML fragment. When a user clicks
    "View" on a product, HTMX fetches this and swaps
    it into the #product-detail div.

    Only this small piece of HTML travels over the network.
    The rest of the page stays untouched.
    =====================================================
-->

<s:if test="selectedProduct != null">
    <div class="detail-card">
        <div class="detail-header">
            <h3><s:property value="selectedName"/></h3>
            <span class="badge badge-<s:property value="selectedCategory"/>">
                <s:property value="selectedCategory"/>
            </span>
        </div>

        <div class="detail-body">
            <div class="detail-row">
                <span class="detail-label">Product ID:</span>
                <span class="detail-value"><s:property value="productId"/></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Category:</span>
                <span class="detail-value"><s:property value="selectedCategory"/></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Price:</span>
                <span class="detail-value price">\$<s:property value="selectedPrice"/></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Description:</span>
                <span class="detail-value"><s:property value="selectedDescription"/></span>
            </div>
        </div>

        <!-- Close button clears the detail panel by hitting clearAction -->
        <button class="btn btn-close"
                hx-get="clearAction"
                hx-target="#product-detail"
                hx-swap="innerHTML"
        >
            ✕ Close
        </button>
    </div>
</s:if>

<s:if test="selectedProduct == null">
    <div class="detail-card error-card">
        <p>⚠ Product not found.</p>
    </div>
</s:if>
