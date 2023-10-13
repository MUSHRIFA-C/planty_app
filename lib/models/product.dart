class Product {
  List<DetailData>? detaildata;
  String? message;
  bool? success;

  Product({this.detaildata, this.message, this.success});

  Product.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      detaildata = [];
      json['data'].forEach((v) {
        detaildata!.add(DetailData.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.detaildata != null) {
      data['data'] = this.detaildata!..map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class DetailData {
  int? id;
  String? name;
  String? price;
  String? description;
  String? size;
  String? humidity;
  String? temparature;
  String? image;
  String? category;
  String? expdate;
  double? rating;
  int? ratingCount;

  DetailData(
      {this.id,
        this.name,
        this.price,
        this.description,
        this.size,
        this.humidity,
        this.temparature,
        this.image,
        this.category,
        this.expdate,
        this.rating,
        this.ratingCount});

  DetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    size = json['size'];
    humidity = json['humidity'];
    temparature = json['temparature'];
    image = json['image'];
    category = json['category'];
    expdate = json['expdate'];
    rating = json['rating']==null?0.0:json['rating'];
    ratingCount = json['rating_count'];
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
    data['image'] = this.image;
    data['category'] = this.category;
    data['expdate'] = this.expdate;
    data['rating'] = this.rating;
    data['rating_count'] = this.ratingCount;
    return data;
  }
}