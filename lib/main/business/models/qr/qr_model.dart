import 'dart:convert';

class QrModel {
  final int? id;
  final int? atmId;
  final String? name;

  const QrModel({
    this.id,
    this.atmId,
    this.name,
  });

  QrModel copyWith({
    int? id,
    int? atmId,
    String? name,
  }) {
    return QrModel(
      id: id ?? this.id,
      atmId: atmId ?? this.atmId,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (atmId != null) {
      result.addAll({'atmId': atmId});
    }
    if (name != null) {
      result.addAll({'name': name});
    }

    return result;
  }

  factory QrModel.fromMap(Map<String, dynamic> map) {
    return QrModel(
      id: int.tryParse('${map['id']}'),
      atmId: int.tryParse('${map['place_id']}'),
      name: map['name'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory QrModel.fromJson(String source) =>
      QrModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'QrModel(id: $id, atmId: $atmId, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QrModel &&
        other.id == id &&
        other.atmId == atmId &&
        other.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ atmId.hashCode ^ name.hashCode;
  }
}
