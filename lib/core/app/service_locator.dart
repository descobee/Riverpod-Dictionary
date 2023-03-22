import 'package:dictionary_app/services/dictionary_service/dictionary_service.dart';
import 'package:dictionary_app/services/network_service/i_network_service.dart';
import 'package:dictionary_app/services/network_service/network_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory<INetworkService>(NetworkService.new);
  locator.registerLazySingleton<DictionaryRepository>(DictionaryRepository.new);
}
