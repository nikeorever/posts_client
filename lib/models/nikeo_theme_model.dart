import 'package:flutter/material.dart';
import 'package:posts_client/common/theme.dart';

class NikeoThemeModel with ChangeNotifier {
  NikeoTheme _theme = NikeoDartTheme();

  NikeoTheme get theme => _theme;

  void change(NikeoTheme theme) {
    if (this.theme != theme) {
      this._theme = theme;
      notifyListeners();
    }
  }
}
