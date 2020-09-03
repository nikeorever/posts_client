import 'package:dartrofit/dartrofit.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:posts_client/api/api.dart';
import 'package:posts_client/api/http.dart';
import 'package:posts_client/common/theme.dart';
import 'package:posts_client/common/times.dart';
import 'package:posts_client/models/Post.dart';
import 'package:posts_client/models/nikeo_theme_model.dart';
import 'package:timeconsuming_page_builder/timeconsuming_page_builder.dart';
import 'package:provider/provider.dart';
import 'package:wedzera/core.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:url_launcher/url_launcher.dart';

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
      body: TimeConsumingPageBuilder<ResponseBody>(
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

            final markdownData = '''
## ${post.title}
#### ${monthShorthand(post.date.month)} ${post.date.day}, ${post.date.year}

${body.string}
          ''';
            return SafeArea(
                child: Markdown(
                    styleSheet: markdownStyleSheet(context),
                    extensionSet: md.ExtensionSet.gitHubWeb,
                    styleSheetTheme: MarkdownStyleSheetBaseTheme.material,
                    onTapLink: (String href) async {
                      await _launchURL(context, href);
                    },
                    controller: controller,
                    selectable: true,
                    data: markdownData));
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_upward),
        onPressed: () => controller.animateTo(0,
            duration: Duration(seconds: 1), curve: Curves.easeOut),
      ),
    );
  }

  _launchURL(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      final snackbar = SnackBar(content: Text('Could not launch $url'));
      Scaffold.of(context).showSnackBar(snackbar);
    }
  }
}
