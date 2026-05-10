class ClothingItem {
  final int id;
  final String name;
  final String category;
  final String color;
  final String imageUrl;

  ClothingItem({
    required this.id,
    required this.name,
    required this.category,
    required this.color,
    required this.imageUrl,
  });

  factory ClothingItem.fromJson(Map<String, dynamic> json) {
    return ClothingItem(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      color: json['color'],
      imageUrl: json['image_url'],
    );
  }
}