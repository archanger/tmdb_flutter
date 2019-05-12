import 'web_server.dart';

void main() async {
  final server = FakeServer();
  await server.start();
}
