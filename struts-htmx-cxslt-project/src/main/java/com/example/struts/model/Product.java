package com.example.struts.model;

/**
 * =====================================================
 * PRODUCT MODEL
 * =====================================================
 * Simple POJO (Plain Old Java Object).
 * Struts 2 uses JavaBean conventions:
 *   - private fields
 *   - public getters/setters
 *
 * This also serves as the data object that gets
 * serialized to XML for XSLT transformations.
 * =====================================================
 */
public class Product {

    private int id;
    private String name;
    private String category;
    private double price;
    private String description;

    // ===== CONSTRUCTORS =====

    public Product() {
        // Default no-arg constructor (required by Struts 2)
    }

    public Product(int id, String name, String category, double price, String description) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.price = price;
        this.description = description;
    }

    // ===== GETTERS & SETTERS =====

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    @Override
    public String toString() {
        return "Product{id=" + id + ", name='" + name + "', category='" + category + "', price=" + price + "}";
    }
}
