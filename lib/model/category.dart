class Category {
  String createdAt;
  String idCategory;
  String image;
  String name;
  String parent;

  Category({
    this.createdAt,
    this.idCategory,
    this.image,
    this.name,
    this.parent,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      createdAt: json['created_at'],
      idCategory: json['id_category'],
      image: json['image'],
      name: json['name'],
      parent: json['parent'],
    );
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['id_category'] = idCategory;
    data['image'] = image;
    data['name'] = name;
    data['parent'] = parent;
    return data;
  }
}
