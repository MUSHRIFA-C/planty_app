class OrderItems {
  List<Data>? data;
  String? message;
  bool? success;

  OrderItems({this.data, this.message, this.success});

  OrderItems.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Data {
  int? id;
  String? productName;
  String? orderdate;
  String? quantity;
  int? totalPrice;
  String? image;
  String? category;
  String? expday;
  String? orderStatus;
  int? user;
  int? product;

  Data(
      {this.id,
        this.productName,
        this.orderdate,
        this.quantity,
        this.totalPrice,
        this.image,
        this.category,
        this.expday,
        this.orderStatus,
        this.user,
        this.product});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    orderdate = json['orderdate'];
    quantity = json['quantity'];
    totalPrice = json['total_price'];
    image = json['image'];
    category = json['category'];
    expday = json['expday'];
    orderStatus = json['order_status'];
    user = json['user'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['orderdate'] = this.orderdate;
    data['quantity'] = this.quantity;
    data['total_price'] = this.totalPrice;
    data['image'] = this.image;
    data['category'] = this.category;
    data['expday'] = this.expday;
    data['order_status'] = this.orderStatus;
    data['user'] = this.user;
    data['product'] = this.product;
    return data;
  }
}