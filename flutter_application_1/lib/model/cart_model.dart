import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/product_model.dart';

class CartModel extends ChangeNotifier {
  final List<Product> _products = [];
  List quantity = [];
  List<Product> get products => _products;
  int count = 1;
  int total = 0;
  int s = 0;
  int get _count => count;
  int get _total => total;
  final user = FirebaseAuth.instance.currentUser!;

  void addProduct(Product product, int t) async {
    final existingIndex = _products.indexWhere((p) => p.id == product.id);

    if (existingIndex != -1) {
      quantity[existingIndex] += t;
      total += (int.parse(product.price) * t);
    } else {
      // Sản phẩm chưa tồn tại, thêm vào danh sách
      _products.add(product);
      quantity.add(t);
      s = int.parse(product.price) * t;
      total += s;
    }
    notifyListeners();
  }

  void removeProduct(int index) {
    s = int.parse(_products[index].price) *
        int.parse(quantity[index].toString());

    total -= s;
    _products.removeAt(index);
    quantity.removeAt(index);
    notifyListeners();
  }

  void clearCart() {
    _products.clear();
    quantity.clear();
    total = 0;
    notifyListeners();
  }

  void increment(int index) {
    quantity[index]++;
    total += int.parse(_products[index].price);
    notifyListeners();
  }

  void decrement(int index) async {
    if (quantity[index] == 1) {
      removeProduct(index);
    } else {
      quantity[index]--;
      total -= int.parse(_products[index].price);
      notifyListeners();
    }
  }

  Future<void> checkout(int shipcost, String address, String payment) async {
    List<Map<String, dynamic>> mergedList =
        List.generate(_products.length, (index) {
      Product product = _products[index];
      dynamic productQuantity =
          quantity.length > index ? quantity[index] : null;
      return {
        'id': product.id,
        'name': product.name,
        'price': product.price,
        'saleprice': product.salePrice,
        'quantity': productQuantity,
        'imagePath': product.imagePath
      };
    });

    Map<String, dynamic> billData = {
      'address': address,
      'payment': payment,
      'shipcost': shipcost,
      'status': 'Chờ duyệt',
      'total': total // Danh sách các mặt hàng
      // Thêm các trường dữ liệu khác của hóa đơn
    };
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.email)
        .collection('bill')
        .add({
      'billData': billData,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
