// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    id: json['id'] as int,
    title: json['title'] as String,
    date: const _DateTimeConverter().fromJson(json['date'] as String),
    path: json['path'] as String,
    enable: json['enable'] as bool,
    categoryId: json['category_id'] as int,
  )..tags = json['tags'] as String;
}
