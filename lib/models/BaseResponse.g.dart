// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BaseResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse<T> _$BaseResponseFromJson<T>(Map<String, dynamic> json) {
  return BaseResponse<T>(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)?.map(_DataConverter<T>().fromJson)?.toList(),
  )..errorCode = json['error_code'] as int;
}
