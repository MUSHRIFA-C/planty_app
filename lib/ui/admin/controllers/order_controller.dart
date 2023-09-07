
import 'package:get/get.dart';

class OrderController extends GetxController {
  

  var orders = <Order>[].obs;
  var pendingOrders = <Order>[].obs;

  var database;

  @override
  void onInit() {
    orders.bindStream(database.getOrders());
    pendingOrders.bindStream(database.getPendingOrders());
    super.onInit();
  }

  void updateOrder(
    Order order,
    String field,
    bool value,
  ) {
    database.updateOrder(order, field, value);
  }
}

class Order {
}
