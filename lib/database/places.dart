class places {
  final int id;
  final String name;
  final String description;
  final String address;
  final int latitude;
  final int longitude;
  final bool active;

  static var point;

  const places ({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.active,
  });

  factory places.fromJson(Map<String, dynamic> json) {
    return places(
        id: json['id'] as int,
        name: json['name'] as String,
        description: json['description'] as String,
        address: json['address'] as String,
        latitude: json['latitude'] as int,
        longitude: json['longitude'] as int,
        active: json['active'] as bool,
    );
  }
}