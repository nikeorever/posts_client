import 'package:flutter/material.dart';
import 'package:posts_client/api/Order.dart';
import 'package:posts_client/api/api.dart';
import 'package:posts_client/api/http.dart';
import 'package:posts_client/common/theme.dart';
import 'package:posts_client/common/times.dart';
import 'package:posts_client/models/BaseResponse.dart';
import 'package:posts_client/models/Category.dart';
import 'package:posts_client/models/Post.dart';
import 'package:posts_client/models/nikeo_theme_model.dart';
import 'package:provider/provider.dart';
import 'package:timeconsuming_page_builder/timeconsuming_page_builder.dart';
import 'package:wedzera/collection.dart';

class MyPosts extends StatelessWidget {
  MyPosts({Key key, this.title}) : super(key: key);

  final String title;
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return TimeConsumingPageBuilder(
        futureBuilder: () => Api(dartrofit).getCategories(true),
        waitingWidgetBuilder: (BuildContext context) => BuiltInWaitingWidget(
              progressIndicatorValueColor: (BuildContext context) => context
                  .watch<NikeoThemeModel>()
                  .theme
                  .progressIndicatorValueColor,
            ),
        errorWidgetBuilder: (BuildContext context, RetryCaller caller) =>
            BuiltInErrorWidget(onRetryClick: caller),
        dataWidgetBuilder: (BuildContext context, Map<String, dynamic> json) {
          final categories = BaseResponse<Category>.fromJson(json).data;
          if (categories.isNullOrEmpty) {
            return BuiltInEmptyWidget(emptyText: 'No data yet',);
          }

          return DefaultTabController(
              length: categories.length,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    title,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(kToolbarHeight - 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: TabBar(isScrollable: true, tabs: [
                          for (final category in categories)
                            Tab(text: category.name)
                        ]),
                      ),
                    ),
                  ),
                ),
                body: TabBarView(
                  children: [
                    for (final category in categories) _postsWidget(category)
                  ],
                ),
                drawer: _drawerWidget(context),
                floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.arrow_upward),
                  onPressed: () => controller.animateTo(0,
                      duration: Duration(seconds: 1), curve: Curves.easeOut),
                ),
              ));
        });
  }

  Widget _postsWidget(Category category) {
    return TimeConsumingPageBuilder(
        futureBuilder: () =>
            Api(dartrofit).getPosts(category.id, Order.DESC, true),
        waitingWidgetBuilder: (BuildContext context) => BuiltInWaitingWidget(
              progressIndicatorValueColor: (BuildContext context) => context
                  .watch<NikeoThemeModel>()
                  .theme
                  .progressIndicatorValueColor,
            ),
        errorWidgetBuilder: (BuildContext context, RetryCaller caller) =>
            BuiltInErrorWidget(onRetryClick: caller),
        dataWidgetBuilder: (BuildContext context, Map<String, dynamic> json) {
          final posts = BaseResponse<Post>.fromJson(json).data;
          if (posts.isNullOrEmpty) {
            return BuiltInEmptyWidget(emptyText: 'No data yet',);
          }
          return ListView.builder(
              controller: controller,
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
                          Navigator.pushNamed(context, '/reading',
                              arguments: post);
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
        });
  }

  Widget _drawerWidget(BuildContext context) {
    return Drawer(
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
    );
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
