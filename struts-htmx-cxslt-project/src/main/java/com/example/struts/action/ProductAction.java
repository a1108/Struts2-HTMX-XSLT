package com.example.struts.action;

import com.example.struts.model.Product;
import org.apache.struts2.ActionSupport;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * =====================================================
 * PRODUCT ACTION (Struts 2 Action)
 * =====================================================
 * Key Concepts:
 *   - Extends ActionSupport (gives getText(), addActionError(), etc.)
 *   - Each method returns a result string ("success", "error")
 *   - Struts maps that result to a JSP in struts.xml
 *   - Fields with getters/setters are auto-populated
 *     from HTTP request parameters
 *
 * HTMX Integration:
 *   - HTMX sends partial AJAX requests
 *   - We return JSP fragments (not full pages)
 *   - HTMX swaps the fragment into the DOM
 *   - No full page reload needed!
 * =====================================================
 */
public class ProductAction extends ActionSupport {

    // ===== ACTION FIELDS =====
    // Struts auto-populates these from request params

    private String searchQuery;       // For search filter
    private int productId;            // For detail / delete
    private String productName;       // For add
    private String productCategory;   // For add
    private double productPrice;      // For add
    private String productDescription;// For add

    // ===== DATA FIELDS (set by action, read by JSP) =====

    private List<Product> products;   // Full list or filtered list
    private Product selectedProduct;  // Single product for detail view

    // ===== IN-MEMORY DATA STORE =====
    // In a real app, this would be a database.
    // Using a static list here so data persists across requests.

    private static final List<Product> DATABASE = new ArrayList<>();

    static {
        // Seed with sample data
        DATABASE.add(new Product(1, "Laptop", "Electronics", 999.99, "High-performance laptop with 16GB RAM"));
        DATABASE.add(new Product(2, "Smartphone", "Electronics", 699.99, "Latest model with AMOLED display"));
        DATABASE.add(new Product(3, "Desk Chair", "Furniture", 249.99, "Ergonomic office chair with lumbar support"));
        DATABASE.add(new Product(4, "Coffee Maker", "Kitchen", 79.99, "12-cup programmable coffee maker"));
        DATABASE.add(new Product(5, "Running Shoes", "Sports", 129.99, "Lightweight shoes for marathon training"));
        DATABASE.add(new Product(6, "Bookshelf", "Furniture", 149.99, "Wooden 5-tier bookshelf"));
    }

    private static int nextId = 7; // Auto-increment ID

    // =====================================================
    // ACTION METHODS
    // =====================================================

    /**
     * LIST - Returns all products.
     * Used by both full page load and HTMX partial load.
     */
    public String list() {
        products = new ArrayList<>(DATABASE);
        return SUCCESS;
    }

    /**
     * DETAIL - Returns a single product by ID.
     * HTMX calls this when user clicks a product row.
     * Only the detail fragment is returned and swapped in.
     */
    public String detail() {
        selectedProduct = DATABASE.stream()
                .filter(p -> p.getId() == productId)
                .findFirst()
                .orElse(null);

        if (selectedProduct == null) {
            addActionError("Product not found with ID: " + productId);
            return ERROR;
        }
        return SUCCESS;
    }

    /**
     * SEARCH - Filters products by name or category.
     * HTMX sends the search query on every keystroke (with debounce).
     * Returns only matching products in the list fragment.
     */
    public String search() {
        if (searchQuery == null || searchQuery.trim().isEmpty()) {
            products = new ArrayList<>(DATABASE);
        } else {
            String query = searchQuery.trim().toLowerCase();
            products = DATABASE.stream()
                    .filter(p -> p.getName().toLowerCase().contains(query)
                            || p.getCategory().toLowerCase().contains(query))
                    .collect(Collectors.toList());
        }
        return SUCCESS;
    }

    /**
     * ADD - Adds a new product to the list.
     * HTMX posts form data, action adds it, returns updated list.
     */
    public String add() {
        if (productName == null || productName.trim().isEmpty()) {
            addActionError("Product name is required.");
            products = new ArrayList<>(DATABASE);
            return ERROR;
        }

        Product newProduct = new Product(
                nextId++,
                productName.trim(),
                productCategory != null ? productCategory.trim() : "General",
                productPrice,
                productDescription != null ? productDescription.trim() : ""
        );

        DATABASE.add(newProduct);
        products = new ArrayList<>(DATABASE);
        return SUCCESS;
    }

    /**
     * DELETE - Removes a product by ID.
     * HTMX sends a DELETE-style request (via POST with _method override).
     * Returns the updated list fragment.
     */
    public String delete() {
        DATABASE.removeIf(p -> p.getId() == productId);
        products = new ArrayList<>(DATABASE);
        return SUCCESS;
    }

    // =====================================================
    // GETTERS & SETTERS (Struts uses these for data binding)
    // =====================================================

    public List<Product> getProducts() { return products; }
    public Product getSelectedProduct() { return selectedProduct; }

    public String getSearchQuery() { return searchQuery; }
    public void setSearchQuery(String searchQuery) { this.searchQuery = searchQuery; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getProductCategory() { return productCategory; }
    public void setProductCategory(String productCategory) { this.productCategory = productCategory; }

    public double getProductPrice() { return productPrice; }
    public void setProductPrice(double productPrice) { this.productPrice = productPrice; }

    public String getProductDescription() { return productDescription; }
    public void setProductDescription(String productDescription) { this.productDescription = productDescription; }
}
