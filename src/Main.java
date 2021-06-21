import database.Database;
import models.Category;
import models.Product;

import java.util.Scanner;

public class Main {
    static Database db;
    public static void main(String[] args) {
        db = new Database();
        int option;
        do {
            Scanner scanner = new Scanner(System.in);

            System.out.println("---------PEDIDO DE VENDAS---------");
            System.out.println("1 - Cadastrar categoria");
            System.out.println("2 - Listar categorias cadastradas");
            System.out.println("3 - Cadastrar produtos");
            System.out.println("4 - Listar produtos cadastrados");
            System.out.println("5 - Criar novo estoque de produto");
            System.out.println("6 - Realizar novo pedido de venda");

            option = scanner.nextInt();
            process(option);
        } while(option != 0);
    }

    public static void process(int option) {
        switch(option) {
            case 1: {
                Scanner scanner = new Scanner(System.in);
                System.out.println("-----CADASTRANDO NOVA CATEGORIA-----");
                System.out.print("Qual o ID da categoria?: ");
                String id = scanner.nextLine();
                System.out.print("Qual a descrição da categoria?: ");
                String description = scanner.nextLine();

                Category newCategory = new Category(id, description);
                db.addNewCategory(newCategory);
                break;
            }

            case 2: {
                System.out.println("-----LISTANDO CATEGORIAS CADASTRADAS-----");

                Category[] persistedCategories = db.getCategories();

                for(Category category : persistedCategories) {
                    if (category != null) {
                        System.out.println("ID: " + category.getId());
                        System.out.println("Descrição: " + category.getDescription());
                        System.out.println("---------------------------");
                    }
                }

                break;
            }

            case 3: {
                Scanner scanner = new Scanner(System.in);
                System.out.println("-----CADASTRANDO NOVO PRODUTO-----");
                System.out.print("Qual a descrição do novo produto?: ");
                String description = scanner.nextLine();
                System.out.print("Qual o ID do novo produto?: ");
                String id = scanner.nextLine();
                System.out.print("Qual a categoria do novo produto (digite o ID de uma categoria cadastrada)?: ");
                String categoryId = scanner.nextLine();
                System.out.print("Qual o preço do novo produto?: ");
                double price = scanner.nextDouble();

                Category category = db.getCategoryById(categoryId);
                Product newProduct = new Product(id, description, price, category);

                db.addNewProduct(newProduct);
                break;
            }

            case 4: {
                System.out.println("-----LISTANDO PRODUTOS CADASTRADOS-----");

                for (Product product : db.getProducts()) {
                    if (product != null) {
                        System.out.println("ID: " + product.getId());
                        System.out.println("Descrição: " + product.getDescription());
                        System.out.println("Preço: " + product.getPrice());
                        System.out.println("Categoria: " + product.getCategory().getId() + " - " + product.getCategory().getDescription());
                        System.out.println("---------------------------");
                    }
                }

                break;
            }
        }
    }
}
