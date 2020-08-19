import 'package:dartrofit/dartrofit.dart';
import 'package:dartrofit_adapter_rx/dartrofit_adapter_rx.dart';
import 'package:dartrofit_converter_json/dartrofit_converter_json.dart';
import 'package:dartrofit_converter_xml/dartrofit_converter_xml.dart';

bool get isProd => false;

String get baseUrl {
  if (isProd) {
    return 'https://nikeo.cn:443/';
  } else {
    return 'http://207.246.102.100:80/';
  }
}

Dartrofit get dartrofit => Dartrofit(Uri.parse(baseUrl))
  ..adapterFactories.add(SubjectAdaptFactory())
  ..converterFactories.addAll([XmlConverterFactory(), JsonConverterFactory()]);
