import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'di_config.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() => getIt.init();

@module
abstract class RegisterModule {
  @injectable
  Client get client => Client();
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
