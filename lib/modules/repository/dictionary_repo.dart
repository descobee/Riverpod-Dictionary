import 'dart:io';

import 'package:dictionary_app/modules/domain/model/dictionary_response.dart';
import 'package:dictionary_app/utils/api_client.dart';

class DictionaryRepository {
  Future<List<WordsModel>?> getWords(String query) async {
    ApiClient client = ApiClient();

    final response = await client.get(query);

    try {
      if (response.statusCode == 200) {
        final result = wordsModelFromJson(response.body);
        return result;
      } else {
        return null;
      }
    } on SocketException {
      rethrow;
    } on HttpException {
      rethrow;
    } on FormatException {
      rethrow;
    }
  }
}
