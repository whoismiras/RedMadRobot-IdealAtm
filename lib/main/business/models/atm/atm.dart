import 'dart:convert';

class Atm {
  final int? id;
  final String? name;
  final String? location;
  final double? latitude;
  final double? longitude;
  final String? status;
  final String? city;

  const Atm({
    this.id,
    this.name,
    this.location,
    this.latitude,
    this.longitude,
    this.status,
    this.city,
  });

  Atm copyWith({
    int? id,
    String? name,
    String? location,
    double? latitude,
    double? longitude,
    String? status,
    String? city,
  }) {
    return Atm(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      status: status ?? this.status,
      city: city ?? this.city,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (location != null) {
      result.addAll({'location': location});
    }
    if (latitude != null) {
      result.addAll({'latitude': latitude});
    }
    if (longitude != null) {
      result.addAll({'longitude': longitude});
    }
    if (status != null) {
      result.addAll({'status': status});
    }
    if (status != null) {
      result.addAll({'city': city});
    }

    return result;
  }

  factory Atm.fromMap(Map<String, dynamic> map) {
    return Atm(
      id: map['id']?.toInt(),
      name: map['name'],
      location: map['location'],
      latitude: double.tryParse('${map['latitude']}'),
      longitude: double.tryParse('${map['longitude']}'),
      status: map['status'],
      city: map['city'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Atm.fromJson(String source) => Atm.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Atm(id: $id, name: $name, location: $location, latitude: $latitude, longitude: $longitude, status: $status, city: $city)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Atm &&
        other.id == id &&
        other.name == name &&
        other.location == location &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.status == status &&
        other.city == city;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        location.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        status.hashCode ^
        city.hashCode;
  }
}
