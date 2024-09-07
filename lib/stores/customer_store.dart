import 'package:customer_app/models/customer.dart';
import 'package:customer_app/services/database_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
part 'customer_store.g.dart';

class CustomerStore = CustomerStoreBase with _$CustomerStore;

abstract class CustomerStoreBase with Store {
  final DatabaseService _databaseService;

  CustomerStoreBase(this._databaseService) {
    loadCustomers();
  }

  @observable
  String? imagePath;

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

  @action
  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath = pickedFile.path;
    }
  }
}
