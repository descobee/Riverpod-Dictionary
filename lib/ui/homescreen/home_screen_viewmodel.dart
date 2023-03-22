import 'package:dictionary_app/model/dictionary_response.dart';
import 'package:dictionary_app/services/dictionary_service/dictionary_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dictionaryController = FutureProvider.family<List<WordsModel>, String>(
  (ref, query) async {
    return ref.watch(repoProvider).getWords(query);
  },
);