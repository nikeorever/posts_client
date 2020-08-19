import 'package:json_annotation/json_annotation.dart';
import 'package:posts_client/models/Category.dart';
import 'package:posts_client/models/Post.dart';

part 'BaseResponse.g.dart';

@JsonSerializable(createToJson: false)
class BaseResponse<T> {
  @JsonKey(name: "error_code", nullable: true)
  int errorCode;
  @JsonKey(name: "success")
  final bool success;
  @JsonKey(name: "message")
  final String message;
  @JsonKey(name: "data")
  @_DataConverter()
  final List<T> data;

  BaseResponse({
    this.success,
    this.message,
    this.data,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);
}

class _DataConverter<T> implements JsonConverter<T, Object> {
  const _DataConverter();

  @override
  T fromJson(Object json) {
    final map = json as Map<String, dynamic>;
    // Only support Post or Category
    if (map.containsKey("category_id")) {
      return Post.fromJson(map) as T;
    } else {
      return Category.fromJson(map) as T;
    }
  }

  @override
  Object toJson(T object) {
    return object;
  }
}
