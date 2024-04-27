import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/my_card.dart';
import 'package:flutter_application_1/controllers/category_controller.dart';
import 'package:flutter_application_1/model/category.dart';

class MyCategory extends StatefulWidget {
  const MyCategory({super.key});

  @override
  State<MyCategory> createState() => _MyCategoryState();
}

class _MyCategoryState extends State<MyCategory> {
  final TextEditingController textController = TextEditingController();
  final CategoryController _categoryController = CategoryController();

  void openInputBox() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textController,
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Category category = Category(
                        id: DateTime.now().toString(),
                        name: textController.text,
                      );
                      _categoryController.addCategory(category);

                      textController.clear();
                      Navigator.pop(context);
                    },
                    child: Text('Add'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
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
          'Category',
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
      body: Stack(alignment: AlignmentDirectional.bottomCenter, children: [
        Container(
          child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("category").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Scaffold(
                    backgroundColor: Theme.of(context).colorScheme.background,
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
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 25,
                    mainAxisSpacing: 35,
                    childAspectRatio: 1,
                    mainAxisExtent: 150,
                  ),
                  scrollDirection: Axis.vertical,
                  itemCount:
                      snapshot.data!.docs.length, // Số lượng items trong grid
                  itemBuilder: (BuildContext context, int index) {
                    final Map<String, dynamic> category =
                        snapshot.data!.docs[index].data()
                            as Map<String, dynamic>;
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Theme.of(context).colorScheme.background,
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.black
                                      : Colors.grey.shade500,
                                  offset: const Offset(4, 4),
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                ),
                                BoxShadow(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.grey.shade800
                                      : Colors.white,
                                  offset: const Offset(-4, -4),
                                  blurRadius: 8,
                                )
                              ]),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              category['name'],
                              style: TextStyle(
                                fontSize: 25,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: GestureDetector(
            onTap: () {
              openInputBox();
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
        )
      ]),
    );
  }
}
