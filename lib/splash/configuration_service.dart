import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/models/configuration.dart';
import 'package:movies/models/serializers.dart';
import 'package:movies/tools/base_url_provider_mixin.dart';

class ConfigurationService with BaseURLProviderMixin {
  Future<Configuration> fetchConfig() async {
    var response = await http.get(_url);
    if (response.statusCode == 200) {
      final result = serializers.deserializeWith(
        Configuration.serializer,
        json.decode(response.body),
      );

      return result;
    }

    throw ('Can\'t get configuration');
  }

  Uri get _url => Uri.parse(baseURL + '/configuration?api_key=27f041b87264c855c1f8d198c9d73cfe');
}
