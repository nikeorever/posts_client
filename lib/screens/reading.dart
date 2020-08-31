import 'package:dartrofit/dartrofit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:posts_client/api/api.dart';
import 'package:posts_client/api/http.dart';
import 'package:posts_client/common/times.dart';
import 'package:posts_client/models/Post.dart';
import 'package:posts_client/models/nikeo_theme_model.dart';
import 'package:timeconsuming_page_builder/timeconsuming_page_builder.dart';
import 'package:provider/provider.dart';
import 'package:wedzera/core.dart';

class MyReading extends StatelessWidget {
  MyReading({Key key, this.title}) : super(key: key);

  final controller = ScrollController();
  final String title;

  @override
  Widget build(BuildContext context) {
    final post = ModalRoute.of(context).settings.arguments as Post;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: TimeConsumingPage<ResponseBody>(
          futureBuilder: () => Api(dartrofit).getContent(post.path),
          waitingWidgetBuilder: (BuildContext context) => BuiltInWaitingWidget(
                progressIndicatorValueColor: (BuildContext context) => context
                    .watch<NikeoThemeModel>()
                    .theme
                    .progressIndicatorValueColor,
              ),
          errorWidgetBuilder: (BuildContext context, RetryCaller caller) =>
              BuiltInErrorWidget(onRetryClick: caller),
          dataWidgetBuilder: (BuildContext context, ResponseBody body) {
            if (body.string.orEmpty().isEmpty) {
              return BuiltInEmptyWidget();
            }
            return SafeArea(
                child:
                    Markdown(controller: controller, selectable: true, data: '''
## ${post.title}
#### ${monthShorthand(post.date.month)} ${post.date.day}, ${post.date.year}
${body.string}
          '''));
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_upward),
        onPressed: () => controller.animateTo(0,
            duration: Duration(seconds: 1), curve: Curves.easeOut),
      ),
    );
  }
}
