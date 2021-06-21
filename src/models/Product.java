package models;

public class Product {
    private String id;
    private String description;
    private double price;
    private Category category;

    public Product(String id, String description, double price, Category category) {
        this.id = id;
        this.description = description;
        this.price = price;
        this.category = category;
    }

    public String getId() {
        return id;
    }

    public String getDescription() {
        return description;
    }

    public double getPrice() {
        return price;
    }

    public Category getCategory() {
        return category;
    }
}
