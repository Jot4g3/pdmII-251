import 'package:flutter/foundation.dart';
import 'package:prova_pratica_02/data/models/customer_model.dart';

class CustomerProvider extends ChangeNotifier {
  final List<CustomerModel> _customers = [];

  List<CustomerModel> get customers => _customers;

  void addCustomer(CustomerModel customer){
    _customers.add(customer);
    notifyListeners();
  }

  void removeCustomer(String id) {
    _customers.removeWhere((customer) => customer.id == id);
    notifyListeners();
  }
}