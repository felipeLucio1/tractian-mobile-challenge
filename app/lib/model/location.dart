class Location {
  final String id;
  final String name;
  final String? parentId;

  const Location({required this.id, required this.name, this.parentId});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        id: json['id'] as String,
        name: json['name'] as String,
        parentId: json['parentId'] as String?);
  }
}
