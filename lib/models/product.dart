class Product {
  Data? data;
  String? message;
  bool? success;

  Product({this.data, this.message, this.success});

  Product.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? price;
  String? description;
  String? size;
  String? humidity;
  String? temparature;
  String? rating;
  String? image;
  String? category;

  Data(
      {this.id,
        this.name,
        this.price,
        this.description,
        this.size,
        this.humidity,
        this.temparature,
        this.rating,
        this.image,
        this.category});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    size = json['size'];
    humidity = json['humidity'];
    temparature = json['temparature'];
    rating = json['rating'];
    image = json['image'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['size'] = this.size;
    data['humidity'] = this.humidity;
    data['temparature'] = this.temparature;
    data['rating'] = this.rating;
    data['image'] = this.image;
    data['category'] = this.category;
    return data;
  }
}