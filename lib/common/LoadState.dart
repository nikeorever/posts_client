import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'LoadState.g.dart';

class LoadState extends EnumClass {
  static const LoadState START   = _$START;
  static const LoadState ERROR = _$ERROR;
  static const LoadState SUCCESS = _$SUCCESS;

  const LoadState._(String name) : super(name);

  static BuiltSet<LoadState> get values => _$values;

  static LoadState valueOf(String name) => _$valueOf(name);
}
