package models;

public class Stock {
    private String code;
    private Product product;
    private int quantity;

    public Stock(String code, Product product, int quantity) {
        this.code = code;
        this.product = product;
        this.quantity = quantity;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Product getProduct() {
        return product;
    }

    public int getQuantity() {
        return quantity;
    }
}
