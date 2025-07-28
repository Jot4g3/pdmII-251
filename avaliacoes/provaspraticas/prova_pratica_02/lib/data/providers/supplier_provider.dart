import 'package:flutter/material.dart';
import '../models/supplier_model.dart';

class SupplierProvider extends ChangeNotifier {
  final List<SupplierModel> _suppliers = [];

  List<SupplierModel> get suppliers => _suppliers;

  void addSupplier(SupplierModel supplier) {
    _suppliers.add(supplier);
    notifyListeners();
  }

  void removeSupplier(String id) {
    _suppliers.removeWhere((supplier) => supplier.id == id);
    notifyListeners();
  }
}