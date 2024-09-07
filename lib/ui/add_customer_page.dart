// lib/ui/add_customer_page.dart
import 'dart:io';
import 'package:customer_app/stores/location_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import '../models/customer.dart';
import '../stores/customer_store.dart';

class AddCustomerPage extends StatefulWidget {
  const AddCustomerPage({super.key});

  @override
  AddCustomerPageState createState() => AddCustomerPageState();
}

class AddCustomerPageState extends State<AddCustomerPage> {
  final _formKey = GlobalKey<FormState>();
  CustomerStore get _customerStore => GetIt.I<CustomerStore>();
  LocationStore get _locationStore => GetIt.I<LocationStore>();

  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Customer'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Observer(builder: (context) {
            return Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Required' : null,
                ),
                TextFormField(
                  controller: _mobileController,
                  decoration: const InputDecoration(labelText: 'Mobile No'),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Required' : null,
                  keyboardType: TextInputType.phone,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Required' : null,
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Required' : null,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _locationStore.getLocation,
                  child: const Text('Capture Current Location'),
                ),
                if (_locationStore.geoAddress != null)
                  Text(_locationStore.geoAddress!),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _customerStore.pickImage,
                  child: const Text('Take Customer Photo'),
                ),
                if (_customerStore.imagePath != null)
                  Image.file(File(_customerStore.imagePath!), height: 100),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      if (_locationStore.latitude == null ||
                          _locationStore.longitude == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please capture location')),
                        );
                        return;
                      }
                      if (_customerStore.imagePath == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please take a photo')),
                        );
                        return;
                      }
                      final customer = Customer(
                        fullName: _nameController.text,
                        mobileNo: _mobileController.text,
                        email: _emailController.text,
                        address: _addressController.text,
                        latitude: _locationStore.latitude!,
                        longitude: _locationStore.longitude!,
                        geoAddress: _addressController.text +
                            _locationStore.geoAddress!,
                        imagePath: _customerStore.imagePath!,
                      );
                      await _customerStore.addCustomer(customer);
                      if (!context.mounted) return;
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Save Customer'),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
