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
      try {
        switch (request.uri.path) {
          case '/movies':
            var json = File(Directory.current.path + '/movies_list.json').readAsStringSync();
            request.response
              ..write(json)
              ..close();
            break;
          default:
            request.response
              ..statusCode = HttpStatus.notFound
              ..write('')
              ..close();
        }
      } catch (e) {
        request.response
          ..statusCode = HttpStatus.internalServerError
          ..write(e.toString())
          ..close();
      }

      print('Path: ' + request.uri.path);
    }
  }
}
