import 'package:dictionary_app/core/app/service_locator.dart';
import 'package:dictionary_app/model/dictionary_response.dart';
import 'package:dictionary_app/services/network_service/network_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final repoProvider =
    Provider<DictionaryRepository>((ref) => DictionaryRepository());

class DictionaryRepository {
  Future<List<WordsModel>> getWords(String query) async {
    final client = locator.get<NetworkService>();
    final List response = await client.get(query);
    try {
      final result = response.map((e) => WordsModel.fromJson(e)).toList();
      return result;
    } on Exception {
      rethrow;
    }
  }
}
