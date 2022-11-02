import 'package:http/http.dart' as http;

class ApiClient {
  http.Client client = http.Client();
  String baseURL = 'https://api.dictionaryapi.dev/api/v2/entries/en/';

  Future<http.Response> get(String url) async {
    final sentURL = Uri.parse(baseURL + url);

    http.Response response;

    try {
      response = await client.get(sentURL);
    } catch (e) {
      rethrow;
    }
    return response;
  }
}
