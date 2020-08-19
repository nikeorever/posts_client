import 'package:json_annotation/json_annotation.dart';

part 'Category.g.dart';

@JsonSerializable(createToJson: false)
class Category {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "enable")
  final bool enable;

  const Category({this.id, this.name, this.enable});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}
