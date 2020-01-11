import 'dart:io';

class FakeServer {
  HttpServer _server;

  Future<void> start() async {
    _server = await HttpServer.bind(
      InternetAddress.loopbackIPv4,
      8080,
    );

    _startListening();
  }

  Future<void> stop() async {
    _server?.close();
  }

  void _startListening() async {
    await for (HttpRequest request in _server) {
      print('FAKE SERVER:: Request Path: ' + request.uri.path);
      print('FAKE SERVER:: Query Params: ' + request.uri.queryParameters.toString());
      try {
        final path = request.uri.path;
        if (path == '/discover/movie') {
          discoverMovies(request);
        } else if (path == '/configuration') {
          discoverConfig(request);
        } else if (path.contains('/details/')) {
          discoverDetails(request);
        } else {
          notFound(request);
        }
      } catch (error) {
        internalError(error, request);
      }
    }
  }

  Future<dynamic> discoverDetails(HttpRequest request) async {
    var json = File(Directory.current.path + '/web_server/details_530915.json').readAsStringSync();
    request.response
      ..write(json)
      ..close();
  }
}

Future<dynamic> discoverMovies(HttpRequest request) async {
  final page = int.tryParse(request.uri.queryParameters['page'] ?? '1');
  if (page > 2) {
    _emptyMoviesList(request, page);
  } else {
    var json = File(Directory.current.path + '/web_server/movies_list_$page.json').readAsStringSync();
    request.response
      ..write(json)
      ..close();
  }
}

Future<dynamic> discoverConfig(HttpRequest request) async {
  var json = File(Directory.current.path + '/web_server/configuration.json').readAsStringSync();
  request.response
    ..write(json)
    ..close();
}

Future<dynamic> notFound(HttpRequest request) async {
  request.response
    ..statusCode = HttpStatus.notFound
    ..write('')
    ..close();
}

Future<dynamic> internalError(dynamic error, HttpRequest request) async {
  request.response
    ..statusCode = HttpStatus.internalServerError
    ..write(error.toString())
    ..close();
  print('Error: ' + error);
}

Future<void> _emptyMoviesList(HttpRequest request, int page) async {
  request.response
    ..write('''
{
  "page": $page,
  "total_results": 24,
  "total_pages": 2,
  "results": []
}
      ''')
    ..close();
}
