import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/component/button.dart';
import 'package:flutter_application_1/component/time_line_component.dart';
import 'package:flutter_application_1/config/const.dart';
import 'package:flutter_application_1/controllers/bill_controller.dart';
import 'package:flutter_application_1/controllers/product_controller.dart';
import 'package:flutter_application_1/model/cart_model.dart';
import 'package:flutter_application_1/model/product_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/Auth/admin_or_user.dart';

class DetailOrder extends StatefulWidget {
  final Map<String, dynamic> billData;
  final String id;
  final String email, status;
  const DetailOrder({
    super.key,
    required this.billData,
    required this.id,
    required this.email,
    required this.status,
  });

  @override
  State<DetailOrder> createState() => _DetailOrderState();
}

class _DetailOrderState extends State<DetailOrder> {
  String dropdownValue = 'Chờ duyệt';
  final BillController _billController = BillController();
  bool shipped = false, waiting = false, shipping = false;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    setStatus();
  }

  void setStatus() {
    setState(() {
      if (widget.billData['status'] == 'Chờ duyệt') {
        shipped = false;
        waiting = true;
        shipping = false;
      }
      if (widget.billData['status'] == 'Đang giao') {
        shipped = false;
        waiting = true;
        shipping = true;
      }
      if (widget.billData['status'] == 'Đã giao') {
        shipped = true;
        waiting = true;
        shipping = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setStatus();
    return Scaffold(
        backgroundColor: Color(0xFFF1F5F8),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              // Xử lý sự kiện khi nút quay về được nhấn
              Navigator.pop(context);
            },
          ),
          backgroundColor: Color(0xFFF1F5F8),
          automaticallyImplyLeading: false,
          title: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Text(
              'Chi tiết hóa đơn',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Outfit',
                color: Color(0xFF0F1113),
                fontSize: 32,
                letterSpacing: 0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                child: Timeline(
                  shipped: shipped,
                  shipping: shipping,
                  waiting: waiting,
                ),
              ),
              !isUser
                  ? Center(
                      child: DropdownButton<String>(
                        value: widget.billData['status'],
                        icon: const Icon(Icons.arrow_drop_down),
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.black,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            widget.billData['status'] = newValue!;
                            _billController.updateStatus(
                                widget.email, widget.id, newValue!);
                          });
                        },
                        items: const [
                          DropdownMenuItem<String>(
                            child: Text('Chờ duyệt'),
                            value: 'Chờ duyệt',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('Đang giao'),
                            value: 'Đang giao',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('Đã giao'),
                            value: 'Đã giao',
                          ),
                          DropdownMenuItem<String>(
                            child: Text('Đã hủy'),
                            value: 'Đã hủy',
                          ),
                        ],
                      ),
                    )
                  : Container(),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                child: Text(
                  'Shipping Address',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    letterSpacing: 0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x320E151B),
                        offset: Offset(
                          0.0,
                          1,
                        ),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 318,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: FaIcon(
                                  FontAwesomeIcons.mapMarkerAlt,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Container(
                                  width: 259,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        6, 0, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1, 0),
                                          child: Text(
                                            'Home',
                                            style: GoogleFonts.lato(
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          widget.billData['billData']
                                              ['address'],
                                          style: GoogleFonts.lato(
                                            fontSize: 14,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.bold,
                                          ),
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                        child: Container(
                          width: 34,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: FaIcon(
                              FontAwesomeIcons.angleRight,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                child: Text(
                  'Order List',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    letterSpacing: 0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: widget.billData['billData']['products'].length,
                  itemBuilder: (BuildContext context, int index) {
                    final products = widget.billData['billData']['products'];
                    return Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
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
                          padding: EdgeInsetsDirectional.fromSTEB(12, 8, 8, 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Theme(
                                data: ThemeData(
                                  checkboxTheme: CheckboxThemeData(
                                    visualDensity: VisualDensity.compact,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  unselectedWidgetColor: Colors.white,
                                ),
                                child: Checkbox(
                                  value: false,
                                  onChanged: (newValue) async {
                                    setState(() => true);
                                  },
                                  side: BorderSide(
                                    width: 2,
                                    color: Colors.white,
                                  ),
                                  activeColor: Colors.white,
                                  checkColor: Colors.blue,
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  products[index]['imagePath'],
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 8),
                                        child: Text(
                                          products[index]['name'],
                                          style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: Color(0xFF0F1113),
                                            fontSize: 18,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        products[index]['price'],
                                        style: TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF57636C),
                                          fontSize: 14,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Container(
                                  width: 80,
                                  height: 27,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: Color.fromARGB(49, 156, 195, 229),
                                      width: 2,
                                    ),
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Text(
                                      products[index]['quantity'].toString(),
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x320E151B),
                        offset: Offset(
                          0.0,
                          1,
                        ),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 219,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: FaIcon(
                                  FontAwesomeIcons.donate,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                child: Text(
                                  'Phương thức thanh toán',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    letterSpacing: 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        'Tiền mặt',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            // context.pushNamed('Payment');
                          },
                          child: Container(
                            width: 34,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: FaIcon(
                                FontAwesomeIcons.angleRight,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 15),
                child: Container(
                  width: double.infinity,
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x320E151B),
                        offset: Offset(
                          0.0,
                          1,
                        ),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 6, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: FaIcon(
                                FontAwesomeIcons.receipt,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            Text(
                              'Chi tiết thanh toán',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                letterSpacing: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                        child: Container(
                          width: double.infinity,
                          height: 88,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 260,
                                height: 61,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Tổng tiền hàng',
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 12,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Tổng tiền phí vận chuyển',
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 12,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Tổng thanh toán',
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 86,
                                height: 61,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 12, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        NumberFormat.currency(
                                          symbol:
                                              'đ', // Ký hiệu tiền tệ, ví dụ: đ, $
                                          decimalDigits:
                                              0, // Số chữ số thập phân (0 nếu không cần)
                                        )
                                            .format(widget.billData['billData']
                                                ['total'])
                                            .toString(),
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                          fontSize: 12,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        NumberFormat.currency(
                                          symbol:
                                              'đ', // Ký hiệu tiền tệ, ví dụ: đ, $
                                          decimalDigits:
                                              0, // Số chữ số thập phân (0 nếu không cần)
                                        )
                                            .format(widget.billData['billData']
                                                ['shipcost'])
                                            .toString(),
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                          fontSize: 12,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        NumberFormat.currency(
                                          symbol:
                                              'đ', // Ký hiệu tiền tệ, ví dụ: đ, $
                                          decimalDigits:
                                              0, // Số chữ số thập phân (0 nếu không cần)
                                        )
                                            .format(widget.billData['billData']
                                                    ['total'] +
                                                widget.billData['billData']
                                                    ['shipcost'])
                                            .toString(),
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                          letterSpacing: 0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: widget.billData['billData']['products'].length,
                itemBuilder: (BuildContext context, int index) {
                  final products = widget.billData['billData']['products'];
                  List<TextEditingController>? _comment = List.generate(
                      widget.billData['billData']['products'].length,
                      (index) => TextEditingController());
                  List<double> star = List.generate(
                      widget.billData['billData']['products'].length,
                      (index) => 5);
                  if (products[index]['rating'] == 0 &&
                      widget.billData['status'] == 'Đã giao')
                    return Column(
                      children: [
                        Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                        Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            'Đánh giá đơn hàng của bạn',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                          child: Container(
                            width: double.infinity,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
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
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(12, 8, 8, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Theme(
                                    data: ThemeData(
                                      checkboxTheme: CheckboxThemeData(
                                        visualDensity: VisualDensity.compact,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                      unselectedWidgetColor: Colors.white,
                                    ),
                                    child: Checkbox(
                                      value: false,
                                      onChanged: (newValue) async {
                                        setState(() => true);
                                      },
                                      side: BorderSide(
                                        width: 2,
                                        color: Colors.white,
                                      ),
                                      activeColor: Colors.white,
                                      checkColor: Colors.blue,
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      products[index]['imagePath'],
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 8),
                                            child: Text(
                                              products[index]['name'],
                                              style: TextStyle(
                                                fontFamily: 'Plus Jakarta Sans',
                                                color: Color(0xFF0F1113),
                                                fontSize: 18,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            products[index]['price'],
                                            style: TextStyle(
                                              fontFamily: 'Plus Jakarta Sans',
                                              color: Color(0xFF57636C),
                                              fontSize: 14,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(-1, 0),
                                    child: Container(
                                      width: 80,
                                      height: 27,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        shape: BoxShape.rectangle,
                                        border: Border.all(
                                          color:
                                              Color.fromARGB(49, 156, 195, 229),
                                          width: 2,
                                        ),
                                      ),
                                      child: Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Text(
                                          products[index]['quantity']
                                              .toString(),
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Center(
                          child: RatingBar.builder(
                            itemSize: 40,
                            initialRating: 5,
                            minRating: 1,
                            direction: Axis.horizontal,
                            itemBuilder: (context, _) => Row(
                              children: [
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  FontAwesomeIcons.solidStar,
                                  color: Colors.amber[700],
                                ),
                              ],
                            ),
                            onRatingUpdate: (rating) {
                              star[index] = rating;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            color: Colors.grey.shade300,
                            height: 200,
                            child: TextFormField(
                              controller: _comment![index],
                              maxLines:
                                  null, // Cho phép ô TextField tự điều chỉnh chiều cao
                              expands:
                                  true, // Cho phép TextField mở rộng theo chiều cao của Container
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Nhập văn bản của bạn tại đây',
                              ),
                            ),
                          ),
                        ),
                        GFButton(
                          onPressed: () {
                            DocumentReference productRef = FirebaseFirestore
                                .instance
                                .collection('products')
                                .doc(products[index]['id']);

                            productRef.update({
                              'comment': FieldValue.arrayUnion([
                                {
                                  widget.email: _comment![index].text,
                                  'rating': star[index],
                                }
                              ])
                            });

                            _billController.updateRating(
                                widget.email,
                                widget.id,
                                star[index],
                                _comment![index].text,
                                index);
                            setState(() {});
                          },
                          text: 'Đánh giá',
                          color: Colors.amber,
                        ),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    );
                  else {
                    return Container();
                  }
                  ;
                },
              ),
            ],
          ),
        ));
  }
}
