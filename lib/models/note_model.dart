// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NotelModel {
  String title;
  String description;
  DateTime dateTime;
  NotelModel({
    required this.title,
    required this.description,
    required this.dateTime,
  });

  NotelModel copyWith({
    String? title,
    String? description,
    DateTime? dateTime,
  }) {
    return NotelModel(
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'dateTime': dateTime.millisecondsSinceEpoch,
    };
  }

  factory NotelModel.fromMap(Map<String, dynamic> map) {
    return NotelModel(
      title: map['title'] as String,
      description: map['description'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory NotelModel.fromJson(String source) =>
      NotelModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'NotelModel(title: $title, description: $description, dateTime: $dateTime)';

  @override
  bool operator ==(covariant NotelModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.description == description &&
        other.dateTime == dateTime;
  }

  @override
  int get hashCode => title.hashCode ^ description.hashCode ^ dateTime.hashCode;
}
