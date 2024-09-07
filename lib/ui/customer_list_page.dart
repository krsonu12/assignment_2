import 'dart:io';
import 'package:customer_app/models/customer.dart';
import 'package:customer_app/stores/auth_store.dart';
import 'package:customer_app/ui/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';
import '../stores/customer_store.dart';
import 'add_customer_page.dart';

class CustomerListPage extends StatefulWidget {
  const CustomerListPage({super.key});

  @override
  State<CustomerListPage> createState() => _CustomerListPageState();
}

class _CustomerListPageState extends State<CustomerListPage> {
  CustomerStore get _customerStore => GetIt.I<CustomerStore>();
  AuthStore get _authStore => GetIt.I<AuthStore>();

  @override
  void initState() {
    super.initState();
    _customerStore.loadCustomers();
  }

  Future<void> _openGoogleMaps(Customer customer) async {
    try {
      Position currentPosition = await Geolocator.getCurrentPosition();

      final url = Uri.parse(
          'https://www.google.com/maps/dir/?api=1&origin=${currentPosition.latitude},${currentPosition.longitude}&destination=${customer.latitude},${customer.longitude}&travelmode=driving');

      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error opening maps: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer List'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
            ),
            onPressed: () async {
              await _authStore.logout();
              if (!context.mounted) return;
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => LoginPage(),
                ),
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20),
            child: Text("LogOut"),
          ),
        ],
      ),
      body: Observer(
        builder: (_) => ListView.builder(
          itemCount: _customerStore.customers.length,
          itemBuilder: (context, index) {
            final customer = _customerStore.customers[index];
            return ListTile(
              titleAlignment: ListTileTitleAlignment.top,
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: FileImage(
                  File(customer.imagePath),
                ),
              ),
              title: Text(customer.fullName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(customer.mobileNo),
                  Text(customer.email),
                  Text(customer.geoAddress),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.directions,
                  size: 40,
                  color: Colors.blue,
                ),
                onPressed: () => _openGoogleMaps(customer),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const AddCustomerPage(),
              ),
            );
          },
          label: const Text("Add Customer"),
        ),
      ),
    );
  }
}
