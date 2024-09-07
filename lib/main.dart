// lib/main.dart
import 'package:customer_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'ui/login_page.dart';
import 'ui/customer_list_page.dart';
import 'stores/auth_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthStore _authStore = GetIt.I<AuthStore>();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: _authStore.checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _authStore.isLoggedIn
                ? const CustomerListPage()
                : LoginPage();
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
