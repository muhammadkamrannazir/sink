import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

enum CategoryType { EXPENSE, INCOME }

class Category {
  final String id;
  final String name;
  final String icon;
  final Color? color;
  final CategoryType? type;

  Category({
    required this.id,
    required this.name,
    required this.icon,
     this.color,
     this.type,
  });

static Category fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> document) {
  return Category(
    id: document['id'] as String,
    name: document['name'] as String,
    icon: document['icon'] as String,
    color: Color(document['color'] as int),
    type: document['type'] != null
        ? CategoryType.values[document['type'] as int]
        : CategoryType.values[0],
  );
}


  @override
  String toString() {
    return 'Category{id: $id, name: $name, icon: $icon, color: $color, type: $type}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          icon == other.icon &&
          color == other.color &&
          type == other.type;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      icon.hashCode ^
      color.hashCode ^
      type.hashCode;
}
