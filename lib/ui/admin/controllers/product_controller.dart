
import 'package:get/get.dart';

class ProductController extends GetxController {


  var products = <Product>[].obs;

  var database;

  @override
  void onInit() {
    products.bindStream(database.getProducts());
    super.onInit();
  }

  var newProduct = {}.obs;

  get price => newProduct['price'];
  get quantity => newProduct['quantity'];
  get isRecommended => newProduct['isRecommended'];
  get isPopular => newProduct['isPopular'];

  void updateProductPrice(
    int index,
    Product product,
    double value,
  ) {
    product.price = value;
    products[index] = product;
  }

  void saveNewProductPrice(
    Product product,
    String field,
    double value,
  ) {
    database.updateField(product, field, value);
  }

  void updateProductQuantity(
    int index,
    Product product,
    int value,
  ) {
    product.quantity = value;
    products[index] = product;
  }

  void saveNewProductQuantity(
    Product product,
    String field,
    int value,
  ) {
    database.updateField(product, field, value);
  }
}

class Product {
  late int quantity;

  late double price;

  static var products;
}
