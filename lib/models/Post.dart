import 'package:json_annotation/json_annotation.dart';

part 'Post.g.dart';

@JsonSerializable(createToJson: false)
@_DateTimeConverter()
class Post {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "title")
  final String title;
  @JsonKey(name: "date")
  final DateTime date;
  @JsonKey(name: "tags", nullable: true)
  String tags;
  @JsonKey(name: "path")
  final String path;
  @JsonKey(name: "enable")
  final bool enable;
  @JsonKey(name: "category_id")
  final int categoryId;

  Post(
      {this.id,
      this.title,
      this.date,
      this.path,
      this.enable,
      this.categoryId});

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}

class _DateTimeConverter implements JsonConverter<DateTime, String> {
  const _DateTimeConverter();

  @override
  DateTime fromJson(String json) {
    return DateTime.parse(json);
  }

  @override
  String toJson(DateTime object) {
    return object.toString();
  }
}
