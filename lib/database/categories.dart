class categories {
  final int id;
  final String name;

  const categories ({
    required this.id,
    required this.name,
  });

  factory categories.fromJson(Map<String, dynamic> json) {
    return categories(
      id: json['id'],
      name: json['name'],
    );
  }
}