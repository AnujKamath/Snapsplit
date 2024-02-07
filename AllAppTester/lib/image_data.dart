class ImageData {
  int? id; // Add an id field for database operations
  String description;
  String imagePath;

  ImageData({this.id, required this.description, required this.imagePath});

  // Convert ImageData to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id, // Note: 'id' will be automatically populated by the database
      'description': description,
      'imagePath': imagePath,
    };
  }

  // Create ImageData from a Map
  factory ImageData.fromMap(Map<String, dynamic> map) {
    return ImageData(
      id: map['id'],
      description: map['description'],
      imagePath: map['imagePath'],
    );
  }
}
