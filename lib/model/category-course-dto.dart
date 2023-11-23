class Category {
  String id;
  String title;
  final dynamic description;
  String key;
  final dynamic displayOrder;
  String createdAt;
  String updatedAt;
  // Add other properties as needed

  Category({
    required this.id,
    required this.title,
    required this.description,
    required this.key,
    required this.displayOrder,
    required this.createdAt,
    required this.updatedAt
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      key: json['key'],
      displayOrder: json['displayOrder'],
      createdAt:  json['createdAt'],
      updatedAt: json['updatedAt']
      // Add other properties as needed
    );
  }
}