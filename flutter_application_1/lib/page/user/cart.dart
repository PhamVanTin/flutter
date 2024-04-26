import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/cart_model.dart';
import 'package:flutter_application_1/page/user/bill/CheckOut.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartModel cartModel = CartModel();

  bool isButtonEnabled = true;
  @override
  Widget build(BuildContext context) {
    if (context.watch<CartModel>().products.isEmpty) {
      isButtonEnabled = false;
    }

    return GestureDetector(
        child: Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            // Xử lý sự kiện khi nút quay về được nhấn
            Navigator.pop(context);
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        automaticallyImplyLeading: false,
        title: Text(
          'My Cart',
          textAlign: TextAlign.center,
          style: GoogleFonts.getFont(
            'Outfit',
            fontWeight: FontWeight.w500,
            fontSize: 32,
          ),
        ),
        actions: const [],
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Below are the items in your cart.',
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFF57636C),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Hero(
                            tag: 'clear-cart',
                            child: InkWell(
                              onTap: () {
                                context.read<CartModel>().clearCart();
                              },
                              child: const Text(
                                'clear',
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color.fromARGB(255, 86, 172, 238),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Hero(
                    tag: 'Cart',
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: context.watch<CartModel>().products.length,
                        itemBuilder: (BuildContext context, index) {
                          final product =
                              context.watch<CartModel>().products[index];
                          final quantitypd =
                              context.watch<CartModel>().quantity[index];
                          return Dismissible(
                            key: Key(product.id), // Key duy nhất cho mỗi mục
                            direction: DismissDirection
                                .endToStart, // Cho phép trượt sang trái để xóa
                            background: Container(
                              color: Colors.redAccent, // Màu nền khi trượt
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Icon(
                                Icons.delete,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            onDismissed: (direction) {
                              // Thực hiện hành động khi người dùng trượt để xóa
                              // Ví dụ: Xóa mục trong giỏ hàng
                              context.read<CartModel>().removeProduct(index);
                            },
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16, 8, 16, 0),
                              child: Container(
                                width: double.infinity,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 4,
                                      color: Color(0x320E151B),
                                      offset: Offset(
                                        0.0,
                                        1,
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      12, 8, 8, 8),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          product.imagePath,
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(12, 0, 0, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 0, 8),
                                                child: Text(
                                                  product.name,
                                                  style: const TextStyle(
                                                    fontFamily:
                                                        'Plus Jakarta Sans',
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                product.price,
                                                style: const TextStyle(
                                                  fontFamily:
                                                      'Plus Jakarta Sans',
                                                  color: Color(0xFF57636C),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(-1, 0),
                                        child: SizedBox(
                                          child: Container(
                                            width: 120,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              shape: BoxShape.rectangle,
                                              border: Border.all(
                                                color: const Color(0xFFE0E3E7),
                                                width: 2,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  icon:
                                                      const Icon(Icons.remove),
                                                  onPressed: () {
                                                    context
                                                        .read<CartModel>()
                                                        .decrement(index);
                                                  },
                                                ),
                                                Text(
                                                  quantitypd.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 18),
                                                ),
                                                IconButton(
                                                  icon: const Icon(Icons.add),
                                                  onPressed: () {
                                                    context
                                                        .read<CartModel>()
                                                        .increment(index);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
              width: 350,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: const LinearGradient(colors: <Color>[
                          Color.fromARGB(255, 209, 52, 209),
                          Color.fromARGB(255, 88, 148, 238),
                          Color.fromARGB(255, 154, 181, 223),
                        ]),
                      ),
                    ),
                  ),
                  GFButton(
                    onPressed: () {
                      if (isButtonEnabled == true) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CheckOutWidget()));
                      }
                    },
                    text: 'Thanh toán',
                    textStyle: const TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 16,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w500,
                    ),
                    size: GFSize.LARGE,
                    fullWidthButton: true,
                    type: GFButtonType.transparent,
                  ),
                ],
              )),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    ));
  }
}
