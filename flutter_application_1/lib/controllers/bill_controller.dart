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

  Future<void> updateRating(
      String email, String id, double rating, String comment, int index) async {
    // Truy cập tài liệu dựa trên email và id
    DocumentReference billRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(email)
        .collection('bill')
        .doc(id);

    // Lấy dữ liệu của tài liệu
    DocumentSnapshot billSnapshot = await billRef.get();

    // Kiểm tra xem tài liệu có tồn tại không và truy cập đến trường 'billData'
    if (billSnapshot.exists) {
      Map<String, dynamic>? data = billSnapshot.data() as Map<String, dynamic>?;

      // Kiểm tra xem 'billData' có tồn tại không
      if (data != null && data.containsKey('billData')) {
        Map<String, dynamic> billData =
            data['billData'] as Map<String, dynamic>;

        // Kiểm tra xem 'products' có tồn tại trong 'billData' không
        if (billData.containsKey('products')) {
          List<Map<String, dynamic>> products =
              List<Map<String, dynamic>>.from(billData['products']);

          // Kiểm tra index có hợp lệ không
          if (index >= 0 && index < products.length) {
            // Cập nhật giá trị rating và comment tại vị trí index
            products[index]['rating'] = rating;
            products[index]['comment'] = comment;

            // Cập nhật lại trường 'products' trong 'billData'
            billData['products'] = products;

            // Cập nhật lại trường 'billData' trong tài liệu
            await billRef.update({'billData': billData});
          } else {
            print("Index out of range.");
          }
        } else {
          print("Field 'products' not found in 'billData'.");
        }
      } else {
        print("Field 'billData' not found in the document.");
      }
    } else {
      print("Document not found.");
    }
  }
}
