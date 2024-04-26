import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/my_card.dart';
import 'package:flutter_application_1/controllers/product_controller.dart';
import 'package:flutter_application_1/model/cart_model.dart';
import 'package:flutter_application_1/model/product_model.dart';
import 'package:flutter_application_1/page/user/cart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/page/user/products/flowerpage.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class AllProduct extends StatefulWidget {
  const AllProduct({super.key});
  @override
  _AllProductState createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final List<Product> _products = [];
  final ProductController _controller = ProductController();
  late List<Product> _filteredProducts;
  String _searchKeyword = '';
  late bool isLiked;
  final currentUser = FirebaseAuth.instance.currentUser!;
  List<String> likes = [];

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

  // Future<void> _loadProducts() async {
  //   List<Product> products = await _controller.getProducts();
  //   setState(() {
  //     _filteredProducts = products;
  //     _products = products;
  //   });
  // }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.background,
              automaticallyImplyLeading: false,
              title: Align(
                alignment: Alignment.center,
                child: Text(
                  'HOME',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    'Outfit',
                    fontWeight: FontWeight.w500,
                    fontSize: 32,
                  ),
                ),
              ),
              actions: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      badges.Badge(
                        badgeContent: Text(
                          context.watch<CartModel>().products.length.toString(),
                        ),
                        badgeAnimation: const badges.BadgeAnimation.slide(
                          animationDuration: Duration(seconds: 1),
                          colorChangeAnimationDuration: Duration(seconds: 1),
                          loopAnimation: false,
                          curve: Curves.fastOutSlowIn,
                          colorChangeAnimationCurve: Curves.easeInCubic,
                        ),
                        badgeStyle: const badges.BadgeStyle(
                          shape: badges.BadgeShape.circle,
                          badgeColor: Colors.red,
                        ),
                        child: InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Cart()),
                          ),
                          child: const Hero(
                            tag: 'Cart',
                            child: Icon(
                              Icons.shopping_bag_outlined,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                      badges.Badge(
                        badgeContent: Text(
                          context.watch<CartModel>().products.length.toString(),
                        ),
                        badgeAnimation: const badges.BadgeAnimation.slide(
                          animationDuration: Duration(seconds: 1),
                          colorChangeAnimationDuration: Duration(seconds: 1),
                          loopAnimation: false,
                          curve: Curves.fastOutSlowIn,
                          colorChangeAnimationCurve: Curves.easeInCubic,
                        ),
                        badgeStyle: const badges.BadgeStyle(
                          shape: badges.BadgeShape.circle,
                          badgeColor: Colors.red,
                        ),
                        child: InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Cart()),
                          ),
                          child: const Hero(
                            tag: '',
                            child: FaIcon(
                              FontAwesomeIcons.solidBell,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              centerTitle: false,
              elevation: 0,
            ),
            body: SafeArea(
              top: true,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextField(
                      onChanged: (value) {
                        // Khi người dùng thay đổi giá trị trong trường nhập, cập nhật từ khóa tìm kiếm và lọc danh sách sản phẩm
                        setState(() {
                          _searchKeyword = value.toLowerCase();
                        });
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
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _searchKeyword = '';
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
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
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("products")
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Theme.of(context).colorScheme.primary),
                                  ),
                                ),
                              );
                            }
                            return GridView.builder(
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 25,
                                childAspectRatio: 1,
                                mainAxisExtent: 270,
                              ),
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.docs
                                  .length, // Số lượng items trong grid
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: InkWell(
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
                                        star: '5',
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
                  ],
                ),
              ),
            ),
          ),
        ],
      );
}
