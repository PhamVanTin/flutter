import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/user/bill/detail_order.dart';
import 'package:intl/intl.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final user = FirebaseAuth.instance.currentUser!;
  @override
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              // Xử lý sự kiện khi nút quay về được nhấn
              Navigator.pop(context);
            },
          ),
          backgroundColor: const Color(0xFFF1F5F8),
          automaticallyImplyLeading: false,
          title: Text(
            'Đơn hàng',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Outfit',
              color: Color(0xFF0F1113),
              fontSize: 32,
              letterSpacing: 0,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: const [],
          centerTitle: true,
          elevation: 0,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Users")
              .doc(user.email)
              .collection('bill')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final billDocs = snapshot.data!.docs;

              return ListView.builder(
                itemCount: billDocs.length,
                itemBuilder: (context, index) {
                  final billData =
                      billDocs[index].data() as Map<String, dynamic>;
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailOrder(
                                    billData: billData,
                                    id: billDocs[index].id,
                                    email: user.email!,
                                    status: billData['status'],
                                  )));
                    },
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                      child: Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(
                          maxWidth: 570,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFFE5E7EB),
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16, 12, 16, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 12, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      textScaler:
                                          MediaQuery.of(context).textScaler,
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: 'Order #: ',
                                            style: TextStyle(),
                                          ),
                                          TextSpan(
                                            text: (billData['timestamp']
                                                    as Timestamp)
                                                .toDate()
                                                .toString(),
                                            style: const TextStyle(
                                              color: Color(0xFF6F61EF),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                        style: const TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF15161E),
                                          fontSize: 16,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 4, 0, 0),
                                      child: Text(
                                        'Mon. July 3rd',
                                        style: TextStyle(
                                          fontFamily: 'Outfit',
                                          color: Color(0xFF606A85),
                                          fontSize: 14,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 12, 0, 0),
                                      child: Container(
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF1F4F8),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                            color: const Color(0xFFE5E7EB),
                                            width: 2,
                                          ),
                                        ),
                                        child: Align(
                                          alignment:
                                              const AlignmentDirectional(0, 0),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(7, 0, 7, 0),
                                            child: Text(
                                              (billData['billData']['products']
                                                      .length)
                                                  .toString(),
                                              style: const TextStyle(
                                                fontFamily: 'Outfit',
                                                color: Color(0xFF606A85),
                                                fontSize: 14,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 12),
                                    child: Text(
                                      NumberFormat.currency(
                                        symbol:
                                            'đ', // Ký hiệu tiền tệ, ví dụ: đ, $
                                        decimalDigits:
                                            0, // Số chữ số thập phân (0 nếu không cần)
                                      )
                                          .format(billData['billData']['total'])
                                          .toString(),
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF15161E),
                                        fontSize: 16,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 12, 0, 0),
                                    child: Container(
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: const Color(0x4D9489F5),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: const Color(0xFF6F61EF),
                                          width: 2,
                                        ),
                                      ),
                                      child: Align(
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(6, 0, 6, 0),
                                          child: Text(
                                            billData['status'],
                                            style: const TextStyle(
                                              fontFamily: 'Plus Jakarta Sans',
                                              color: Color(0xFF6F61EF),
                                              fontSize: 14,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Đã xảy ra lỗi: ${snapshot.error}'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
