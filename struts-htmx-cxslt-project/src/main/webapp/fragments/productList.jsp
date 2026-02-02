<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="/struts-tags" prefix="s" %>

<!--
    =====================================================
    HTMX FRAGMENT - PRODUCT LIST
    =====================================================
    This is NOT a full HTML page — no <html>, <head>, <body>.
    It's a partial HTML snippet that HTMX swaps into the
    #product-list div on the parent page.

    This is the core concept of HTMX:
      Server returns a FRAGMENT → HTMX swaps it in → Done!
    =====================================================
-->

<table class="product-table">
    <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Category</th>
            <th>Price</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <s:iterator value="products" var="product">
            <tr class="product-row">
                <td><s:property value="#product.id"/></td>
                <td><s:property value="#product.name"/></td>
                <td>
                    <span class="badge badge-<s:property value="#product.category"/>">
                        <s:property value="#product.category"/>
                    </span>
                </td>
                <td class="price">\$<s:property value="#product.price"/></td>
                <td class="actions">

                    <!--
                        =====================================================
                        VIEW DETAIL BUTTON
                        =====================================================
                        hx-get  → Fetches the detail fragment for this product
                        hx-target="#product-detail" → Swaps into the detail panel
                        hx-swap="innerHTML" → Replaces inner content
                        =====================================================
                    -->
                    <button class="btn btn-view"
                            hx-get="productDetailAction?productId=<s:property value="#product.id"/>"
                            hx-target="#product-detail"
                            hx-swap="innerHTML"
                    >
                        👁 View
                    </button>

                    <!--
                        =====================================================
                        DELETE BUTTON
                        =====================================================
                        hx-post → Sends a POST to delete this product
                        hx-target="#product-list" → Updates the list
                        hx-swap="outerHTML" → Replaces the ENTIRE table
                        hx-confirm → Shows a native browser confirm dialog
                        =====================================================
                    -->
                    <button class="btn btn-delete"
                            hx-post="deleteProductAction?productId=<s:property value="#product.id"/>"
                            hx-target="#product-list"
                            hx-swap="innerHTML"
                            hx-confirm="Are you sure you want to delete this product?"
                    >
                        🗑 Delete
                    </button>
                </td>
            </tr>
        </s:iterator>

        <!-- Show message if no products found -->
        <s:if test="products.size == 0">
            <tr>
                <td colspan="5" class="no-results">No products found.</td>
            </tr>
        </s:if>
    </tbody>
</table>
