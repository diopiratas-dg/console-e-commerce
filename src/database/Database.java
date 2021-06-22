package database;

import models.Category;
import models.Orders;
import models.Product;
import models.Stock;

public class Database {
    private Category[] categories;
    private Product[] products;
    private Stock[] stocks;
    private Orders[] orders;

    public Database() {
        this.categories = new Category[10];
        this.products = new Product[20];
        this.stocks = new Stock[20];
        this.orders = new Orders[30];
    }

    public void addNewCategory(Category newCategory) {
        for(int i = 0; i < categories.length; i++) {
            if (categories[i] == null) {
                categories[i] = newCategory;
                return;
            }
        }
    }

    public Category getCategoryById(String categoryId) {
        Category category = null;
        for (int i = 0; i < categories.length; i++) {
            if (categories[i].getId().equals(categoryId)) {
                category = categories[i];
                break;
            }
        }
        return category;
    }

    public void addNewProduct(Product newProduct) {
        for(int i = 0; i < products.length; i++) {
            if (products[i] == null) {
                products[i] = newProduct;
                return;
            }
        }
    }

    public void addNewStock(Stock newStock) {
        for(int i = 0; i < stocks.length; i++) {
            if (stocks[i] == null) {
                stocks[i] = newStock;
                return;
            }
        }
    }

    public Product getProductById(String productId) {
        Product product = null;
        for (int i = 0; i < products.length; i++) {
            if (products[i].getId().equals(productId)) {
                product = products[i];
                break;
            }
        }
        return product;
    }

    public Category[] getCategories() {
        return categories;
    }

    public Product[] getProducts() {
        return products;
    }

    public Stock[] getStocks() {
        return stocks;
    }

    public Orders[] getOrders() {
        return orders;
    }
}
