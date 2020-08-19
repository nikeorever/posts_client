import 'package:dartrofit/dartrofit.dart';
import 'package:posts_client/api/Order.dart';
import 'package:async/async.dart';

part 'api.g.dart';

@webApi
abstract class Api {
  Api._();

  factory Api(Dartrofit dartrofit) = _$Api;

  @GET('posts-api/v1/categories')
  CancelableOperation<Response<Map<String, dynamic>>> getCategories(
      @Query('enable', encoded: true) bool enable);

  @GET('posts-api/v1/posts')
  CancelableOperation<Response<Map<String, dynamic>>> getPosts(
    @Query('category_id', encoded: true) int categoryId,
    @Query('order', encoded: true) Order order,
    @Query('enable', encoded: true) bool enable,
  );

  @GET()
  CancelableOperation<ResponseBody> getContent(@url String relativeUrl);
}
