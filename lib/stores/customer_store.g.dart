// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CustomerStore on CustomerStoreBase, Store {
  late final _$customersAtom =
      Atom(name: 'CustomerStoreBase.customers', context: context);

  @override
  ObservableList<Customer> get customers {
    _$customersAtom.reportRead();
    return super.customers;
  }

  @override
  set customers(ObservableList<Customer> value) {
    _$customersAtom.reportWrite(value, super.customers, () {
      super.customers = value;
    });
  }

  late final _$loadCustomersAsyncAction =
      AsyncAction('CustomerStoreBase.loadCustomers', context: context);

  @override
  Future<void> loadCustomers() {
    return _$loadCustomersAsyncAction.run(() => super.loadCustomers());
  }

  late final _$addCustomerAsyncAction =
      AsyncAction('CustomerStoreBase.addCustomer', context: context);

  @override
  Future<void> addCustomer(Customer customer) {
    return _$addCustomerAsyncAction.run(() => super.addCustomer(customer));
  }

  @override
  String toString() {
    return '''
customers: ${customers}
    ''';
  }
}
