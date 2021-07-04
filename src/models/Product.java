package models;

public class Product {
    private Integer id;
    private String description;
    private String code;
    private double price;
    private Category category;
    private String nameProduct;

    public Product(String codigo, String description, double price, Category category, String nomeProduto) {
        this.code = codigo;
        this.description = description;
        this.price = price;
        this.category = category;
        this.nameProduct = nomeProduto;
    }

    public String getNameProduct() {
        return nameProduct;
    }
    public Integer getId() {
        return id;
    }

    public void setId(Integer idProduto){
        this.id = idProduto;
    }

    public String getDescription() {
        return description;
    }

    public double getPrice() {
        return price;
    }

    public String getCode() {
        return code;
    }

    public Category getCategory() {
        return category;
    }
}
