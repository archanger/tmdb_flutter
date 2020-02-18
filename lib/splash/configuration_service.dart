import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/helpers/base_query.dart';
import 'package:movies/models/configuration.dart';
import 'package:movies/models/image_configuration.dart';
import 'package:movies/tools/base_url_provider_mixin.dart';

class MoviesLanguage {
  final String iso;
  final String englishName;
  final String name;

  MoviesLanguage(this.iso, this.englishName, this.name);
}

List<MoviesLanguage> _languagesFromJson(dynamic json) {
  final list = json as List<dynamic>;
  return list
      .map((i) => MoviesLanguage(
            i['iso_639_1'],
            i['english_name'],
            i['name'],
          ))
      .toList();
}

Configuration _configFromJson(dynamic json) {
  return Configuration(
    json['change_keys'].cast<String>(),
    ImageConfigurationParser().parse(json['images']),
  );
}

class ConfigurationService with BaseURLProviderMixin {
  Future<Configuration> fetchImageConfig() async {
    final query = BaseQuery();
    return await fetch(_url, query, _configFromJson);
  }

  Future<List<MoviesLanguage>> fetchLanguages() async {
    final url = Uri.parse(baseURL + '/configuration/languages');
    final query = BaseQuery();
    return await fetch(url, query, _languagesFromJson);
  }

  Uri get _url => Uri.parse(baseURL + '/configuration');
}

Future<T> fetch<T>(Uri url, BaseQuery query, T Function(dynamic) mapper) async {
  final response = await http.get(url.replace(query: query.toString()));
  if (response.statusCode == 200) {
    return mapper(json.decode(response.body));
  }

  throw ('Can\'t get configuration');
}

class ImageConfigurationParser {
  ImageConfiguration parse(Map<String, dynamic> json) {
    return ImageConfiguration(
      json['secure_base_url'],
      json['backdrop_sizes'].cast<String>(),
      json['logo_sizes'].cast<String>(),
      json['poster_sizes'].cast<String>(),
      json['profile_sizes'].cast<String>(),
      json['still_sizes'].cast<String>(),
    );
  }
}
