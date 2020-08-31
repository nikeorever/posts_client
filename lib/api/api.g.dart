// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// WebApiGenerator
// **************************************************************************

class _$Api extends Api {
  _$Api._(this.dartrofit) : super._();

  factory _$Api(Dartrofit dartrofit) {
    return _instance ??= _$Api._(dartrofit);
  }

  static _$Api _instance;

  final Dartrofit dartrofit;

  @override
  Future<Map<String, dynamic>> getCategories(bool enable) {
    final ptv0 = ParameterizedTypeValue(
        'dart.async', 'Future', 'Future<Map<String, dynamic>>');
    final ptv1 =
        ParameterizedTypeValue('dart.core', 'Map', 'Map<String, dynamic>');
    ptv0.upperBoundAtIndex0 = ptv1;
    final tv2 = TypeValue('dart.core', 'String', 'String');
    ptv1.upperBoundAtIndex0 = tv2;

    final annotationInfo = AnnotationInfo((b) => b
      ..httpMethod = 'GET'
      ..relativeUrl = 'posts-api/v1/categories'
      ..isMultipart = false
      ..isFormEncoded = false
      ..parameterHandlers.addAll([QueryHandler('enable', true)])
      ..returnType = ptv0);

    final args = [enable];

    return dartrofit
        .parseAnnotation<Map<String, dynamic>, Future<Map<String, dynamic>>>(
            annotationInfo)
        .invoke(args);
  }

  @override
  Future<Map<String, dynamic>> getPosts(
      int categoryId, Order order, bool enable) {
    final ptv0 = ParameterizedTypeValue(
        'dart.async', 'Future', 'Future<Map<String, dynamic>>');
    final ptv1 =
        ParameterizedTypeValue('dart.core', 'Map', 'Map<String, dynamic>');
    ptv0.upperBoundAtIndex0 = ptv1;
    final tv2 = TypeValue('dart.core', 'String', 'String');
    ptv1.upperBoundAtIndex0 = tv2;

    final annotationInfo = AnnotationInfo((b) => b
      ..httpMethod = 'GET'
      ..relativeUrl = 'posts-api/v1/posts'
      ..isMultipart = false
      ..isFormEncoded = false
      ..parameterHandlers.addAll([
        QueryHandler('category_id', true),
        QueryHandler('order', true),
        QueryHandler('enable', true)
      ])
      ..returnType = ptv0);

    final args = [categoryId, order, enable];

    return dartrofit
        .parseAnnotation<Map<String, dynamic>, Future<Map<String, dynamic>>>(
            annotationInfo)
        .invoke(args);
  }

  @override
  Future<ResponseBody> getContent(String relativeUrl) {
    final ptv0 =
        ParameterizedTypeValue('dart.async', 'Future', 'Future<ResponseBody>');
    final tv1 = TypeValue('dartrofit', 'ResponseBody', 'ResponseBody');
    ptv0.upperBoundAtIndex0 = tv1;

    final annotationInfo = AnnotationInfo((b) => b
      ..httpMethod = 'GET'
      ..relativeUrl = null
      ..isMultipart = false
      ..isFormEncoded = false
      ..parameterHandlers.addAll([RelativeUrlHandler()])
      ..returnType = ptv0);

    final args = [relativeUrl];

    return dartrofit
        .parseAnnotation<ResponseBody, Future<ResponseBody>>(annotationInfo)
        .invoke(args);
  }
}
