class Favorite {
  int? id;
  String? itemName;
  String? image;
  String? price;
  String? favStatus;
  int? item;
  int? user;

  Favorite(
      {this.id,
        this.itemName,
        this.image,
        this.price,
        this.favStatus,
        this.item,
        this.user});

  Favorite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['item_name'];
    image = json['image'];
    price = json['price'];
    favStatus = json['favStatus'];
    item = json['item'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_name'] = this.itemName;
    data['image'] = this.image;
    data['price'] = this.price;
    data['favStatus'] = this.favStatus;
    data['item'] = this.item;
    data['user'] = this.user;
    return data;
  }
}