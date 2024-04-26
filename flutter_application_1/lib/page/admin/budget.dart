import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_application_1/page/user/bill/detail_order.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_application_1/page/admin/bar%20graph/bar_graph.dart';
import 'package:intl/intl.dart';

class Budget extends StatefulWidget {
  const Budget({super.key});

  @override
  State<Budget> createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  List<double> weeklySummary = [
    4.40,
    2.50,
    42.42,
    10.50,
    100.20,
    88.99,
    90.10,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 90,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Hero(
                  tag: 'chart',
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade600,
                                  offset: const Offset(4, 4),
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                  inset: true,
                                ),
                                const BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-4, -4),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                  inset: true,
                                )
                              ]),
                          child: SizedBox(
                              height: 200,
                              child: MyBarGraph(
                                weeklySummary: weeklySummary,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 600,
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("Users")
                        .where("role", isEqualTo: "user")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final listUser = snapshot.data!.docs;
                        return ListView.builder(
                          itemCount: listUser.length,
                          itemBuilder: (context, index) {
                            final userDoc = listUser[index];
                            return StreamBuilder<QuerySnapshot>(
                                stream: userDoc.reference
                                    .collection('bill')
                                    .snapshots(),
                                builder: (context, billSnapshot) {
                                  if (billSnapshot.hasData) {
                                    final billDatas = billSnapshot.data!.docs;
                                    return ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: billDatas.length,
                                        itemBuilder: (context, index) {
                                          final billData = billDatas[index]
                                              .data() as Map<String, dynamic>;
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailOrder(
                                                            billData: billData,
                                                            id: billDatas[index]
                                                                .id,
                                                            email: userDoc.id,
                                                            status: billData[
                                                                'status'],
                                                          )));
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(16, 0, 16, 0),
                                              child: Container(
                                                width: double.infinity,
                                                constraints:
                                                    const BoxConstraints(
                                                  maxWidth: 570,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xFFE5E7EB),
                                                    width: 2,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          16, 12, 16, 12),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                0, 0, 12, 0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            RichText(
                                                              textScaler:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .textScaler,
                                                              text: TextSpan(
                                                                children: [
                                                                  const TextSpan(
                                                                    text:
                                                                        'Order #: ',
                                                                    style:
                                                                        TextStyle(),
                                                                  ),
                                                                  TextSpan(
                                                                    text: (billData['timestamp']
                                                                            as Timestamp)
                                                                        .toDate()
                                                                        .toString(),
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Color(
                                                                          0xFF6F61EF),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  )
                                                                ],
                                                                style:
                                                                    const TextStyle(
                                                                  fontFamily:
                                                                      'Plus Jakarta Sans',
                                                                  color: Color(
                                                                      0xFF15161E),
                                                                  fontSize: 16,
                                                                  letterSpacing:
                                                                      0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ),
                                                            const Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          4,
                                                                          0,
                                                                          0),
                                                              child: Text(
                                                                'Mon. July 3rd',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: Color(
                                                                      0xFF606A85),
                                                                  fontSize: 14,
                                                                  letterSpacing:
                                                                      0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      0,
                                                                      12,
                                                                      0,
                                                                      0),
                                                              child: Container(
                                                                height: 32,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: const Color(
                                                                      0xFFF1F4F8),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  border: Border
                                                                      .all(
                                                                    color: const Color(
                                                                        0xFFE5E7EB),
                                                                    width: 2,
                                                                  ),
                                                                ),
                                                                child: Align(
                                                                  alignment:
                                                                      const AlignmentDirectional(
                                                                          0, 0),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                            7,
                                                                            0,
                                                                            7,
                                                                            0),
                                                                    child: Row(
                                                                      children: [
                                                                        const Text(
                                                                          'số lượng: ',
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'Outfit',
                                                                            color:
                                                                                Color(0xFF606A85),
                                                                            fontSize:
                                                                                14,
                                                                            letterSpacing:
                                                                                0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          (billData['billData']['products'].length)
                                                                              .toString(),
                                                                          style:
                                                                              const TextStyle(
                                                                            fontFamily:
                                                                                'Outfit',
                                                                            color:
                                                                                Color(0xFF606A85),
                                                                            fontSize:
                                                                                14,
                                                                            letterSpacing:
                                                                                0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(0,
                                                                    0, 0, 12),
                                                            child: Text(
                                                              NumberFormat
                                                                      .currency(
                                                                symbol:
                                                                    'đ', // Ký hiệu tiền tệ, ví dụ: đ, $
                                                                decimalDigits:
                                                                    0, // Số chữ số thập phân (0 nếu không cần)
                                                              )
                                                                  .format(billData[
                                                                          'billData']
                                                                      ['total'])
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily:
                                                                    'Outfit',
                                                                color: Color(
                                                                    0xFF15161E),
                                                                fontSize: 16,
                                                                letterSpacing:
                                                                    0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(0,
                                                                    12, 0, 0),
                                                            child: Container(
                                                              height: 32,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: const Color(
                                                                    0x4D9489F5),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                border:
                                                                    Border.all(
                                                                  color: const Color(
                                                                      0xFF6F61EF),
                                                                  width: 2,
                                                                ),
                                                              ),
                                                              child: Align(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                          6,
                                                                          0,
                                                                          6,
                                                                          0),
                                                                  child: Text(
                                                                    billData[
                                                                        'status'],
                                                                    style:
                                                                        const TextStyle(
                                                                      fontFamily:
                                                                          'Plus Jakarta Sans',
                                                                      color: Color(
                                                                          0xFF6F61EF),
                                                                      fontSize:
                                                                          14,
                                                                      letterSpacing:
                                                                          0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
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
                                        });
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: Text(
                                          'Đã xảy ra lỗi: ${snapshot.error}'),
                                    );
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                });
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
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
