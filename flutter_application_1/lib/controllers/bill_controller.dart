import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/model/product_model.dart';
import 'package:flutter_application_1/model/user_model.dart';

class BillController {
  Future<void> updateStatus(String email, String id, String status) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(email)
        .collection('bill')
        .doc(id)
        .update({'status': status});
  }
}
