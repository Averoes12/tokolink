class Carousel {
  String category;
  String createdAt;
  String idCarousel;
  String image;
  String title;

  Carousel({
    this.category,
    this.createdAt,
    this.idCarousel,
    this.image,
    this.title,
  });

  factory Carousel.fromJson(Map<String, dynamic> json) {
    return Carousel(
      category: json['category'],
      createdAt: json['created_at'],
      idCarousel: json['id_carousel'],
      image: json['image'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['category'] = category;
    data['created_at'] = createdAt;
    data['id_carousel'] = idCarousel;
    data['image'] = image;
    data['title'] = title;
    return data;
  }
}
