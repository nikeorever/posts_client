import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

part 'Order.g.dart';

class Order extends EnumClass {
  static const Order ASC = _$ASC;
  static const Order DESC = _$DESC;

  const Order._(String name) : super(name);

  static BuiltSet<Order> get values => _$values;

  static Order valueOf(String name) => _$valueOf(name);
}
