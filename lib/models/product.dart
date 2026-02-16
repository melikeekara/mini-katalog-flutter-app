class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;
  final String category;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: (json['id'] as num).toInt(),
    title: json['title'] as String,
    description: json['description'] as String,
    price: (json['price'] as num).toDouble(),
    image: json['image'] as String,
    category: json['category'] as String,
  );
}
