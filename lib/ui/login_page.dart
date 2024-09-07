// lib/ui/login_page.dart
import 'package:customer_app/widgets/custom_text_filed.dart';
import 'package:customer_app/widgets/enable_button.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../stores/auth_store.dart';
import 'customer_list_page.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  AuthStore get _authStore => GetIt.I<AuthStore>();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Login with your credential',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  CustomTextFiled(
                    controller: _emailController,
                    label: 'Email',
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextFiled(
                    controller: _passwordController,
                    label: "Password",
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: Enablebutton(
                      title: "Login",
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          bool success = await _authStore.login(
                            _emailController.text,
                            _passwordController.text,
                          );
                          if (success) {
                            if (!context.mounted) return;
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (_) => const CustomerListPage()),
                            );
                          } else {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Invalid credentials')),
                            );
                          }
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
