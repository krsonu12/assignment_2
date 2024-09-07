// lib/di/service_locator.dart
import 'package:customer_app/stores/location_store.dart';
import 'package:get_it/get_it.dart';
import '../services/database_service.dart';
import '../stores/auth_store.dart';
import '../stores/customer_store.dart';

final getIt = GetIt.instance;

Future<void> setServiceLocator() async {
  getIt.registerSingleton<DatabaseService>(DatabaseService());

  getIt.registerLazySingleton<AuthStore>(
    () => AuthStore(),
  );
  getIt.registerLazySingleton<CustomerStore>(
    () => CustomerStore(
      getIt<DatabaseService>(),
    ),
  );
  getIt.registerLazySingleton<LocationStore>(
    () => LocationStore(),
  );
}
