class AddtoCart {
  int? id;
  String? itemname;
  String? image;
  String? quantity;
  String? totalPrice;
  String? category;
  String? cartStatus;
  String? expday;
  int? item;
  int? user;

  AddtoCart(
      {this.id,
        this.itemname,
        this.image,
        this.quantity,
        this.totalPrice,
        this.category,
        this.cartStatus,
        this.expday,
        this.item,
        this.user});

  AddtoCart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemname = json['itemname'];
    image = json['image'];
    quantity = json['quantity'];
    totalPrice = json['total_price'];
    category = json['category'];
    cartStatus = json['cart_status'];
    expday = json['expday'];
    item = json['item'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['itemname'] = this.itemname;
    data['image'] = this.image;
    data['quantity'] = this.quantity;
    data['total_price'] = this.totalPrice;
    data['category'] = this.category;
    data['cart_status'] = this.cartStatus;
    data['expday'] = this.expday;
    data['item'] = this.item;
    data['user'] = this.user;
    return data;
  }
}