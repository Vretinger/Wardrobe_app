class ClothingItem {
  final String name;
  final String category;
  final String color;
  final String style;
  final String season;
  final String image;

  ClothingItem({
    required this.name,
    required this.category,
    required this.color,
    required this.style,
    required this.season,
    required this.image,
  });

  factory ClothingItem.fromJson(Map<String, dynamic> json) {
    return ClothingItem(
      name: json['name']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      color: json['color']?.toString() ?? '',
      style: json['style']?.toString() ?? '',
      season: json['season']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
    );
  }
}