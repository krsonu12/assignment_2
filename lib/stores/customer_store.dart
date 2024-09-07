import 'package:customer_app/models/customer.dart';
import 'package:customer_app/services/database_service.dart';
import 'package:mobx/mobx.dart';
part 'customer_store.g.dart';

class CustomerStore = CustomerStoreBase with _$CustomerStore;

abstract class CustomerStoreBase with Store {
  final DatabaseService _databaseService;

  CustomerStoreBase(this._databaseService);

  @observable
  ObservableList<Customer> customers = ObservableList<Customer>();

  @action
  Future<void> loadCustomers() async {
    final loadedCustomers = await _databaseService.getCustomers();
    customers.clear();
    customers.addAll(loadedCustomers);
  }

  @action
  Future<void> addCustomer(Customer customer) async {
    await _databaseService.insertCustomer(customer);
    await loadCustomers();
  }
}
