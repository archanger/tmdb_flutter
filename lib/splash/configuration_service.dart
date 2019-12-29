import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/helpers/base_query.dart';
import 'package:movies/models/configuration.dart';
import 'package:movies/models/serializers.dart';
import 'package:movies/tools/base_url_provider_mixin.dart';

class ConfigurationService with BaseURLProviderMixin {
  Future<Configuration> fetchConfig() async {
    final query = BaseQuery();
    final response = await http.get(_url.replace(query: query.toString()));
    if (response.statusCode == 200) {
      final result = serializers.deserializeWith(
        Configuration.serializer,
        json.decode(response.body),
      );

      return result;
    }

    throw ('Can\'t get configuration');
  }

  Uri get _url => Uri.parse(baseURL + '/configuration');
}
