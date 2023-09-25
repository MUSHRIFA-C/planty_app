class DetailData {
  int? id;
  String? name;
  String? price;
  String? description;
  String? size;
  String? humidity;
  String? temparature;
  Null? rating;
  String? image;
  String? category;

  DetailData(
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

  factory DetailData.fromJson(Map<String, dynamic> json) {
    return DetailData(
      id : json['id'],
      name : json['name'],
      price : json['price'],
      description : json['description'],
      size : json['size'],
      humidity : json['humidity'],
      temparature : json['temparature'],
      rating : json['rating']==null? '': json['rating'],
      image : json['image']==null? '': json['image'],
      category : json['category'],
    );
  }
/*
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
  }*/
}