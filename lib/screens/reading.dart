import 'package:async/async.dart';
import 'package:dartrofit/dartrofit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:posts_client/api/api.dart';
import 'package:posts_client/api/http.dart';
import 'package:posts_client/common/LoadState.dart';
import 'package:posts_client/common/LoadingRetryErrorPageState.dart';
import 'package:posts_client/common/times.dart';
import 'package:posts_client/models/Post.dart';

class MyReading extends StatelessWidget {
  MyReading({Key key, this.title}) : super(key: key);

  final controller = ScrollController();
  final String title;

  @override
  Widget build(BuildContext context) {
    final post = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: MyReadingPage(
        post: post,
        controller: controller,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_upward),
        onPressed: () => controller.animateTo(0,
            duration: Duration(seconds: 1), curve: Curves.easeOut),
      ),
    );
  }
}

class MyReadingPage extends StatefulWidget {
  const MyReadingPage({Key key, @required this.post, @required this.controller})
      : super(key: key);

  final Post post;
  final ScrollController controller;

  @override
  _MyReadingPageState createState() => _MyReadingPageState();
}

class _MyReadingPageState extends LoadingRetryErrorPageState<MyReadingPage> {
  String markdownData = "";
  CancelableOperation<ResponseBody> _operation;

  @override
  void loadDataAsync() {
    final api = Api(dartrofit);
    _operation = api.getContent(widget.post.path);
    _operation.value.then((body) {
      changeLoadStatus(LoadState.SUCCESS, () {
        markdownData = '''
## ${widget.post.title}
#### ${monthShorthand(widget.post.date.month)} ${widget.post.date.day}, ${widget.post.date.year}
${body.string}
        ''';
      });
    }, onError: (error, stackTrace) {
      changeLoadStatus(LoadState.ERROR);
    });
  }

  @override
  void cancel() {
    _operation?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  @override
  Widget buildContent(BuildContext context) {
    return SafeArea(
      child: Markdown(
        controller: widget.controller,
        selectable: true,
        data: markdownData,
      ),
    );
  }
}
