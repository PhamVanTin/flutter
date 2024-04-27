import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/my_card.dart';
import 'package:flutter_application_1/controllers/product_controller.dart';
import 'package:flutter_application_1/model/product_model.dart';
import 'package:flutter_application_1/page/admin/product/create.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/page/user/products/flowerpage.dart';

class AdminAllProduct extends StatefulWidget {
  const AdminAllProduct({super.key});
  @override
  _AdminAllProductState createState() => _AdminAllProductState();
}

class _AdminAllProductState extends State<AdminAllProduct> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Product> _products = [];
  final ProductController _controller = ProductController();
  late List<Product> _filteredProducts;
  late String _searchKeyword;
  late bool isLiked;
  final currentUser = FirebaseAuth.instance.currentUser!;
  List<String> likes = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _filteredProducts = _products;
    _searchKeyword = ''; // Khởi tạo từ khóa tìm kiếm
  }

  Future<List<DocumentSnapshot>> getProducts() async {
    QuerySnapshot querySnapshot = await firestore.collection('products').get();
    return querySnapshot.docs;
  }

  void _filterProducts(String keyword) {
    setState(() {
      if (keyword != '') {
        _filteredProducts = _products.where((product) {
          return product.name.toLowerCase().contains(keyword.toLowerCase());
        }).toList();
      } else if (keyword == '') {
        _filteredProducts = _products;
      }
    });
  }

  Future<void> _loadProducts() async {
    List<Product> products = await _controller.getProducts();
    setState(() {
      _filteredProducts = products;
      _products = products;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          SafeArea(
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    // Khi người dùng thay đổi giá trị trong trường nhập, cập nhật từ khóa tìm kiếm và lọc danh sách sản phẩm
                    _searchKeyword = value;
                    _filterProducts(_searchKeyword);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Tìm kiếm',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: Container(
                    width: double.infinity,
                    height: 36,
                    decoration: const BoxDecoration(),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  _filterProducts('');
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  textStyle: GoogleFonts.getFont(
                                    'Outfit',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                                child: const Text('All'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("products")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Scaffold(
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                            body: Center(
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).colorScheme.primary),
                                ),
                              ),
                            ),
                          );
                        }
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 25,
                            childAspectRatio: 1,
                            mainAxisExtent: 270,
                          ),
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot
                              .data!.docs.length, // Số lượng items trong grid
                          itemBuilder: (BuildContext context, int index) {
                            final Map<String, dynamic> product =
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;

                            likes = List<String>.from(
                                snapshot.data!.docs[index]['like']);

                            isLiked = likes.contains(currentUser.email);
                            if (product['name']
                                .toString()
                                .toLowerCase()
                                .contains(_searchKeyword)) {
                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: InkWell(
                                  onLongPress: () {
                                    showCupertinoModalPopup(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return buildActionSheet(context,
                                            id: product['id']);
                                      },
                                    );
                                  },
                                  onTap: () {
                                    // Điều hướng sang trang chi tiết sản phẩm khi nhấn vào sản phẩm
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            FlowerPage(product: product),
                                      ),
                                    );
                                  },
                                  child: MyCard(
                                    imagePath: product['imagePath'],
                                    nameCard: product['name'],
                                    price: product['price'],
                                    star: product['Rating'].toString(),
                                    isLiked: isLiked,
                                    onTap: () {
                                      isLiked = !isLiked;

                                      DocumentReference ProductRef =
                                          FirebaseFirestore.instance
                                              .collection('products')
                                              .doc(product['id']);
                                      if (isLiked == true) {
                                        ProductRef.update({
                                          'like': FieldValue.arrayUnion(
                                              [currentUser.email])
                                        });
                                      } else {
                                        ProductRef.update({
                                          'like': FieldValue.arrayRemove(
                                              [currentUser.email])
                                        });
                                      }
                                    },
                                  ),
                                ),
                              );
                            }
                            return null;
                          },
                        );
                      }),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          // Trả về một widget mới mà không phải là Scaffold
                          return const Create03ProductWidget();
                        },
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.pink.shade200,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade600,
                            offset: Offset(4, 4),
                            blurRadius: 9,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(-4, -4),
                            blurRadius: 13,
                            spreadRadius: 1,
                          )
                        ]),
                    height: 50,
                    width: 50,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ));

  Widget buildActionSheet(BuildContext contextm, {required String id}) =>
      CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Detail',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              _controller.deleteProduct(id);
              Navigator.pop(context);
            },
            child: Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
}
