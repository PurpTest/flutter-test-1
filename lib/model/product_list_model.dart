// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductListModel {
  final String title;
  final double price;
  final String description;
  final String image;
  final Map<String, dynamic> rating;

  const ProductListModel({
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.rating,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
      title: json['title'] ?? '',
      price: (json['price'] as num).toDouble(),
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      rating: json['rating'],
    );
  }

  @override
  String toString() =>
      'ProductListModel(title: $title, price: $price, description: $description, rating: $rating,)';
}
