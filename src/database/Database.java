package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import models.Category;
import models.Orders;
import models.Product;
import models.Stock;

public class Database {
    private Orders[] orders;
    
    private Statement executorQuery;
    private Connection conn;

    public Database() {
        this.orders = new Orders[30];

        
        try {
            String url = "jdbc:mysql://localhost:3306/loja_virtual";
            String usuario = "root";
            String senha = "KRIUQ0hx6At2YwbS";
            conn = DriverManager.getConnection(url, usuario, senha);
            
            this.executorQuery  = conn.createStatement();
        } catch (SQLException e) {
            //TODO: handle exception
            System.out.println(e.getMessage());
        }
    }

    public void addNewCategory(Category newCategory) {
        try {
            String query = "INSERT INTO categoria (id,descricao) VALUES (?,?)";

            PreparedStatement preparedStmt = conn.prepareStatement(query);
            preparedStmt.setInt(1, Integer.parseInt(newCategory.getId()));
            preparedStmt.setString(2, newCategory.getDescription());
            preparedStmt.execute();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public Category getCategoryById(Integer categoryId) {
        Statement outroExecutor = null;
        Connection conn2 = null;
        try {
            String url = "jdbc:mysql://localhost:3306/loja_virtual";
            String usuario = "root";
            String senha = "KRIUQ0hx6At2YwbS";
            conn2 = DriverManager.getConnection(url, usuario, senha);
            
           
            
        } catch (SQLException e) {
            //TODO: handle exception
            System.out.println(e.getMessage());
        }
        ResultSet resultado = null;
        try {
            outroExecutor  = conn2.createStatement();
           
            resultado = outroExecutor.executeQuery("SELECT * from categoria " + 
            "WHERE id = " + categoryId + " LIMIT 1");
            if (resultado.next()){
                Category category = new Category(resultado.getString("id"), resultado.getString("descricao"));
                return category;
            }else{
                System.out.println("Erro ao buscar categoria! ");
                return null;
            }
            
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return null;
        }
    }

    public void addNewProduct(Product newProduct) {
        try {
            String query = "INSERT INTO produto (codigo,nome,descricao,preco,id_categoria) " 
            + "VALUES (?,?,?,?,?)";

            PreparedStatement preparedStmt = conn.prepareStatement(query);
            preparedStmt.setString(1, newProduct.getCode());
            preparedStmt.setString(2, newProduct.getNameProduct());
            preparedStmt.setString(3, newProduct.getDescription());
            preparedStmt.setDouble(4, newProduct.getPrice());
            preparedStmt.setString(5, newProduct.getCategory().getId());
            preparedStmt.execute();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public void addNewStock(Stock newStock) {
        try {
            String query = "INSERT INTO estoque (codigo,id_produto,quantidade) VALUES (?,?,?)";

            PreparedStatement preparedStmt = conn.prepareStatement(query);
            preparedStmt.setInt(1, Integer.parseInt(newStock.getCode()));
            preparedStmt.setInt(2, newStock.getProduct().getId());
            preparedStmt.setInt(3, newStock.getQuantity());
            preparedStmt.execute();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public Product getProductById(String productId) {
        Statement executorProduct = null;
        Connection conn3 = null;
        try {
            String url = "jdbc:mysql://localhost:3306/loja_virtual";
            String usuario = "root";
            String senha = "KRIUQ0hx6At2YwbS";
            conn3 = DriverManager.getConnection(url, usuario, senha);
            
           
            
        } catch (SQLException e) {
            //TODO: handle exception
            System.out.println(e.getMessage());
        }
        ResultSet resultado2 = null;
        try {
            executorProduct  = conn3.createStatement();
           
            resultado2 = executorProduct.executeQuery("SELECT * from produto " + 
            "WHERE id_produto = " + productId + " LIMIT 1");
            if (resultado2.next()){
                Integer idProduto = resultado2.getInt("id_produto");
                String codigo = resultado2.getString("codigo");
                String descricao = resultado2.getString("descricao");
                Double preco = resultado2.getDouble("preco");
                String nome =  resultado2.getString("nome");

                Category cat = this.getCategoryById(resultado2.getInt("id_categoria"));

                Product product = new Product(codigo,
                descricao,
                preco,
                 cat,
                nome);
                product.setId(idProduto);

                return product;
            }else{
                System.out.println("Erro ao buscar categoria! ");
                return null;
            }
            
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return null;
        }
    }

    public ArrayList<Category> getCategories() {
        ArrayList listaCategoria = new ArrayList<Category>();
        ResultSet resultado;
        try {
            resultado = this.executorQuery.executeQuery("SELECT * from categoria");
            
            while(resultado.next()){
                Category categoria = new Category(resultado.getString("id"),
                resultado.getString("descricao"));
                listaCategoria.add(categoria);
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return listaCategoria;
    }

    public  ArrayList<Product> getProducts() {
        ArrayList listaProduto = new ArrayList<Product>();
        ResultSet resultado2;
        try {
            resultado2 = this.executorQuery.executeQuery("SELECT * from produto");
            
            while(resultado2.next()){
                Integer idProduto = resultado2.getInt("id_produto");
                String codigo = resultado2.getString("codigo");
                String descricao = resultado2.getString("descricao");
                Double preco = resultado2.getDouble("preco");
                String nome =  resultado2.getString("nome");

                Category cat = this.getCategoryById(resultado2.getInt("id_categoria"));

                Product product = new Product(codigo,
                descricao,
                preco,
                 cat,
                nome);
                product.setId(idProduto);
                
                listaProduto.add(product);
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return listaProduto;
    }

    public ArrayList<Stock> getStocks() {
        ArrayList stocks = new ArrayList<Stock>();
        ResultSet resultado3;
        try {
            resultado3 = this.executorQuery.executeQuery("SELECT * from estoque");
            
            while(resultado3.next()){
                Integer code = resultado3.getInt("codigo");
                Integer qtd = resultado3.getInt("quantidade");

                Product prd = this.getProductById(resultado3.getString("id_produto"));

                Stock stock = new Stock(code.toString(), prd, qtd);
                
                stocks.add(stock);
            }

            return stocks;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return null;
        }
    }

    public Orders[] getOrders() {
        return orders;
    }
}
