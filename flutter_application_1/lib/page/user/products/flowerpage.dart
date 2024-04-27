import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/config/const.dart';
import 'package:flutter_application_1/model/cart_model.dart';
import 'package:flutter_application_1/model/product_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class FlowerPage extends StatefulWidget {
  final Map<String, dynamic> product;
  final CartModel cartModel = CartModel();
  FlowerPage({
    super.key,
    required this.product,
  });

  @override
  State<FlowerPage> createState() => _FlowerPageState();
}

class _FlowerPageState extends State<FlowerPage> {
  int quantity = 1;
  int commet_count = 0;
  void increment() {
    setState(() {
      quantity++;
    });
  }

  void decrement() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) => SafeArea(
          child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              // Xử lý sự kiện khi nút quay về được nhấn
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: Hero(
                        tag: 'mainImage',
                        transitionOnUserGestures: true,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: Image.network(
                            widget.product['imagePath'],
                            width: double.infinity,
                            height: 430,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                      child: Text(
                        widget.product['name'],
                        style: const TextStyle(
                          fontFamily: 'Outfit',
                          color: Color(0xFF14181B),
                          fontSize: 24,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 16),
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          color: Color(0xFF57636C),
                          fontSize: 14,
                          letterSpacing: 0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 40),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            NumberFormat.currency(
                              symbol: 'đ', // Ký hiệu tiền tệ, ví dụ: đ, $
                              decimalDigits:
                                  0, // Số chữ số thập phân (0 nếu không cần)
                            ).format(double.parse(
                                  widget.product['price'],
                                ) *
                                quantity),
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontFamily: 'Outfit',
                              color: Color(0xFF14181B),
                              fontSize: 24,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                              width: 130,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: const Color(0xFFE0E3E7),
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: decrement,
                                  ),
                                  Text(
                                    quantity.toString(),
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: increment,
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Đánh Giá Sản Phẩm',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              RatingBar.builder(
                                ignoreGestures: true,
                                itemSize: 18,
                                initialRating: double.parse(
                                    widget.product['Rating'].toString()),
                                allowHalfRating: false,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber[700],
                                ),
                                onRatingUpdate: (rating) {},
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(widget.product['Rating'].toString() + '/5',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  )),
                              SizedBox(
                                width: 8,
                              ),
                              widget.product['comment'].length != null
                                  ? Text(
                                      '(' +
                                          widget.product['comment'].length
                                              .toString() +
                                          'Đánh giá)',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    )
                                  : Text(
                                      '(0 Đánh giá)',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                          Container(
                            height: 400,
                            child: StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('products')
                                  .doc(widget.product['id'])
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final listComment = snapshot.data!.data()
                                      as Map<String, dynamic>?;
                                  if (listComment!['comment'].length != null) {
                                    commet_count =
                                        listComment!['comment'].length;

                                    return ListView.builder(
                                        itemCount:
                                            listComment!['comment'].length,
                                        itemBuilder: (context, index) {
                                          final comment =
                                              listComment['comment'][index];

                                          List<String> keys =
                                              comment.keys.toList();
                                          return Container(
                                            height: 100,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(keys[0],
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    )),
                                                RatingBar.builder(
                                                  itemSize: 13,
                                                  initialRating: double.parse(
                                                      comment['rating']
                                                          .toString()),
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  ignoreGestures: true,
                                                  itemBuilder: (context, _) =>
                                                      Icon(
                                                    Icons.star,
                                                    color: Colors.amber[700],
                                                  ),
                                                  onRatingUpdate: (rating) {},
                                                ),
                                                Text('lorem'),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  '2024-12-2',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    wordSpacing: 5.0,
                                                    fontSize: 11,
                                                  ),
                                                ),
                                                Divider(
                                                  thickness: 0.5,
                                                  color: Colors.grey[400],
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  } else {
                                    return Center(
                                        child: Text('chưa có đánh giá nào'));
                                  }
                                } else {
                                  return Center(
                                      child: Text('chưa có đánh giá nào'));
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Generated code for this fullWidthBG Widget...
            Material(
              color: Colors.transparent,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F4F8),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x320F1113),
                        offset: Offset(
                          0.0,
                          -2,
                        ),
                      )
                    ],
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: isUser
                      ? GFButton(
                          onPressed: () {
                            context.read<CartModel>().addProduct(
                                Product.fromMap(widget.product), quantity);

                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.topSlide,
                              title: 'Success',
                              desc: '',
                              btnOkOnPress: () {},
                            ).show();
                          },
                          text: 'Add to Cart',
                          textStyle: const TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Colors.white,
                            fontSize: 16,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500,
                          ),
                          size: GFSize.LARGE,
                          fullWidthButton: true,
                          color: const Color(0xFF4B39EF),
                          type: GFButtonType.solid,
                        )
                      : SizedBox(
                          height: 1,
                        )),
            ),
          ],
        ),
      ));
}
