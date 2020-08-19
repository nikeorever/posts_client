import 'package:flutter/material.dart';
import 'package:posts_client/common/LoadState.dart';

abstract class LoadingRetryErrorPageState<T extends StatefulWidget>
    extends State<T> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  LoadState _loadState;

  @mustCallSuper
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1500),
        vsync: this,
        animationBehavior: AnimationBehavior.preserve)
      ..forward();

    _animation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.9, curve: Curves.fastOutSlowIn),
      reverseCurve: Curves.fastOutSlowIn,
    )..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          _controller.forward();
        } else if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
      });

    _loadState = LoadState.START;
    loadDataAsync();
  }

  @mustCallSuper
  @override
  void dispose() {
    _controller.stop();
    cancel();
    super.dispose();
  }

  Widget buildBody(BuildContext context) {
    Widget body;
    switch (_loadState) {
      case LoadState.START:
        body = Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, _) => CircularProgressIndicator(),
              ),
            ),
          ),
        );
        break;
      case LoadState.SUCCESS:
        _controller.stop();
        body = buildContent(context);
        break;
      case LoadState.ERROR:
        _controller.stop();
        body = Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: FlatButton(
                child: const Text('Retry', style: TextStyle(fontSize: 20)),
                onPressed: () {
                  changeLoadStatus(LoadState.START);
                  loadDataAsync();
                },
              ),
            ),
          ),
        );
        break;
    }
    return body;
  }

  /// Build  content you want to show to users.
  Widget buildContent(BuildContext context);

  /// Asynchronously execute time-consuming tasks.
  /// You should call [changeLoadStatus] with [LoadStatus.SUCCESS] when
  /// the task is successfully executed,otherwise call [changeLoadStatus] with
  /// [LoadStatus.ERROR] to update ui.
  void loadDataAsync();

  /// Cancel the task loaded asynchronously by [loadDataAsync].
  void cancel();

  void changeLoadStatus(LoadState newStatus, [void Function() fn]) {
    setState(() {
      _loadState = newStatus;
      fn?.call();
    });
  }
}
