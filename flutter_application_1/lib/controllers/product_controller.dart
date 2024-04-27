import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/product_model.dart';

class ProductController {
  Future<List<Product>> getProducts() async {
    await Firebase.initializeApp();
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('products').get();
    List<Product> products = snapshot.docs.map((doc) {
      return Product.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();

    return products;
  }

  Future<void> addProduct(Product product) async {
    await FirebaseFirestore.instance
        .collection('products')
        .doc(product.id)
        .set(product.toMap());
  }

  // Future<void> addComment(Product product, String email) async {
  //   await FirebaseFirestore.instance
  //       .collection('products')
  //       .doc(product.id).collection(email)
  //       .set(product.toMap());
  // }

  Future<void> updateProduct(Map<String, dynamic> product, String id) async {
    await FirebaseFirestore.instance
        .collection('products')
        .doc(id)
        .update(product);
  }

  Future<void> deleteProduct(String productId) async {
    await FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
        .delete();
  }

  Future<bool> isLiked(String useremail, String productId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(useremail)
              .collection('wishlist')
              .doc(productId)
              .get();

      if (documentSnapshot.exists) {
        return true;
      } else {
        // Không tìm thấy tài liệu
        return false;
      }
    } catch (e) {
      print('Error getting user: $e');
      return false;
    }
  }
}
