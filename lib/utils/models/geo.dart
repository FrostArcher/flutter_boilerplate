class Geo {
  final num latitude;
  final num longitude;

  Geo({
    required this.latitude,
    required this.longitude,
  });

  static Geo? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    return Geo(latitude: json["latitude"] ?? 0, longitude: json["longitude"] ?? 0);
  }

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}