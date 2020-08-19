import 'package:async/async.dart';
import 'package:dartrofit/dartrofit.dart';
import 'package:flutter/material.dart';
import 'package:posts_client/api/Order.dart';
import 'package:posts_client/api/api.dart';
import 'package:posts_client/api/http.dart';
import 'package:posts_client/common/LoadState.dart';
import 'package:posts_client/common/LoadingRetryErrorPageState.dart';
import 'package:posts_client/common/theme.dart';
import 'package:posts_client/common/times.dart';
import 'package:posts_client/models/BaseResponse.dart';
import 'package:posts_client/models/Category.dart';
import 'package:posts_client/models/Post.dart';
import 'package:posts_client/models/nikeo_theme_model.dart';
import 'package:provider/provider.dart';

class MyPosts extends StatefulWidget {
  MyPosts({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends LoadingRetryErrorPageState<MyPosts> {
  final controller = ScrollController();

  CancelableOperation<Response<Map<String, dynamic>>> _operation;
  List<Category> categories = <Category>[];

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  @override
  Widget buildContent(BuildContext context) {
    return DefaultTabController(
        length: categories.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              widget.title,
              style: Theme.of(context).textTheme.headline1,
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight-10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: TabBar(isScrollable: true, tabs: [
                    for (final category in categories) Tab(text: category.name)
                  ]),
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              for (final category in categories)
                _PostsPage(category: category, controller: controller)
            ],
          ),
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage('assets/images/nikeo.jpeg')),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Nikeo',
                        style: context
                            .watch<NikeoThemeModel>()
                            .theme
                            .drawerHeaderThemeData
                            .subtitle1,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text('Github: https://github.com/nikeorever',
                          style: context
                              .watch<NikeoThemeModel>()
                              .theme
                              .drawerHeaderThemeData
                              .subtitle2),
                      Text('Email:   nikeorever@gmail.com',
                          style: context
                              .watch<NikeoThemeModel>()
                              .theme
                              .drawerHeaderThemeData
                              .subtitle2),
                    ],
                  ),
                  decoration: context
                      .watch<NikeoThemeModel>()
                      .theme
                      .drawerHeaderThemeData
                      .decoration,
                ),
                ThemeMenu(),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.arrow_upward),
            onPressed: () => controller.animateTo(0,
                duration: Duration(seconds: 1), curve: Curves.easeOut),
          ),
        ));
  }

  @override
  void cancel() {
    _operation?.cancel();
  }

  @override
  void loadDataAsync() {
    final api = Api(dartrofit);
    _operation = api.getCategories(true);
    _operation.value.then((response) {
      // TODO EMPTY PAGE?
      if (response.isSuccessful()) {
        final br = BaseResponse<Category>.fromJson(response.body);
        changeLoadStatus(LoadState.SUCCESS, () {
          if (categories.isNotEmpty) categories.clear();
          categories.addAll(br.data);
        });
      } else {
        changeLoadStatus(LoadState.ERROR);
      }
    }, onError: (error, stackTrace) {
      changeLoadStatus(LoadState.ERROR);
    });
  }
}

class ThemeMenu extends StatefulWidget {
  @override
  _ThemeMenuState createState() => _ThemeMenuState();
}

class _ThemeMenuState extends State<ThemeMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<NikeoTheme>(
      padding: EdgeInsets.zero,
      initialValue: context.watch<NikeoThemeModel>().theme,
      onSelected: (value) => context.read<NikeoThemeModel>().change(value),
      itemBuilder: (context) => NikeoTheme.validNikeoThemes()
          .map((theme) => PopupMenuItem<NikeoTheme>(
              value: theme,
              child: Text(
                theme.name,
                style: Theme.of(context).textTheme.subtitle1,
              )))
          .toList(),
      child: ListTile(
        title: Text(
          'Theme: ${context.watch<NikeoThemeModel>().theme.name}',
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(color: Colors.black87),
        ),
      ),
    );
  }
}

class _PostsPage extends StatefulWidget {
  final Category category;
  final ScrollController controller;

  const _PostsPage({Key key, this.category, this.controller}) : super(key: key);

  @override
  __PostsPageState createState() => __PostsPageState();
}

class __PostsPageState extends LoadingRetryErrorPageState<_PostsPage> {
  CancelableOperation<Response<Map<String, dynamic>>> _operation;
  List<Post> posts = <Post>[];

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  @override
  Widget buildContent(BuildContext context) {
    return ListView.builder(
        controller: widget.controller,
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                    '${monthShorthand(post.date.month)} ${post.date.day}, ${post.date.year}',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(color: Colors.black54)),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/reading', arguments: post);
                  },
                  child: Text(post.title,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(color: Colors.teal)),
                ),
              ],
            ),
          );
        });
  }

  @override
  void cancel() {
    _operation?.cancel();
  }

  @override
  void loadDataAsync() {
    final api = Api(dartrofit);
    _operation = api.getPosts(widget.category.id, Order.DESC, true);
    _operation.value.then((response) {
      if (response.isSuccessful()) {
        final br = BaseResponse<Post>.fromJson(response.body);
        changeLoadStatus(LoadState.SUCCESS, () {
          if (posts.isNotEmpty) posts.clear();
          posts.addAll(br.data);
        });
      } else {
        changeLoadStatus(LoadState.ERROR);
      }
    }, onError: (error, stackTrace) {
      changeLoadStatus(LoadState.ERROR);
    });
  }
}
