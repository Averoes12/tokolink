class Product {
  String category;
  String createdAt;
  String description;
  String idProduct;
  List<String> images;
  String name;
  String price;
  int review;
  String weight;

  Product({
    this.category,
    this.createdAt,
    this.description,
    this.idProduct,
    this.images,
    this.name,
    this.price,
    this.review,
    this.weight,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      category: json['category'],
      createdAt: json['created_at'],
      description: json['description'],
      idProduct: json['id_product'],
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      name: json['name'],
      price: json['price'],
      review: json['review'],
      weight: json['weight'],
    );
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['category'] = category;
    data['created_at'] = createdAt;
    data['description'] = description;
    data['id_product'] = idProduct;
    data['name'] = name;
    data['price'] = price;
    data['review'] = review;
    data['weight'] = weight;
    if (images != null) {
      data['images'] = images;
    }
    return data;
  }
}
