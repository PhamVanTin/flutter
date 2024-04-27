import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/product_controller.dart';
import 'package:flutter_application_1/model/product_model.dart';
import 'package:flutter_application_1/page/admin/dashboard.dart';
import 'package:flutter_application_1/page/user/home._page.dart';
import 'package:flutter_application_1/services/firestore.dart';
import 'package:getwidget/getwidget.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class Create03ProductWidget extends StatefulWidget {
  const Create03ProductWidget({super.key});

  @override
  State<Create03ProductWidget> createState() => _Create03ProductWidgetState();
}

class _Create03ProductWidgetState extends State<Create03ProductWidget> {
  final FirestoreService firestoreService = FirestoreService();

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productSalePriceController =
      TextEditingController();

  final ProductController _controller = ProductController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String imageUrl = '';

  PlatformFile? pickedFile;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);
    String downloadUrl = await FirebaseStorage.instance
        .ref('files/${pickedFile!.name}')
        .getDownloadURL();
    setState(() {
      imageUrl = downloadUrl;
    });
    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);
  }

  void navigateToNextScreen() {
    if (pickedFile == null) {
      // Hiển thị thông báo cho người dùng biết họ cần chọn một tệp
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng chọn hình ảnh!')),
      );
    } else {
      // Chuyển đến màn hình tiếp theo hoặc thực hiện hành động tiếp theo
      uploadAndSaveProduct();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const AdminDashboard()));
    }
  }

  Future<void> uploadAndSaveProduct() async {
    await uploadFile(); // Đợi quá trình tải lên hoàn thành
    String imageUrl =
        this.imageUrl; // Sử dụng giá trị imageUrl đã được cập nhật
    Product product = Product(
      id: DateTime.now().toString(),
      name: _productNameController.text,
      price: _productPriceController.text,
      imagePath: imageUrl,
      salePrice: _productSalePriceController.text,
      Rating: 5,
    );

    _controller.addProduct(product);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              // Xử lý sự kiện khi nút quay về được nhấn
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: const Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Product',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  color: Color(0xFF15161E),
                  fontSize: 24,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Fill out the information below to post a product',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  color: Color(0xFF606A85),
                  fontSize: 14,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Generated code for this Container Widget...
                  // if (pickedFile != null)
                  Container(
                    height: 330,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F4F8),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color(0xFFE5E7EB),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: pickedFile != null
                            ? Image.file(
                                File(pickedFile!.path!),
                                width: 300,
                                height: 200,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/fl1.jpg', // Đường dẫn đến hình ảnh mặc định
                                width: 300,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // ImagePicker imagePicker = ImagePicker();
                      // imagePicker.pickImage(source: ImageSource.gallery);
                      selectFile();
                    },
                    child: const Text('Selected File'),
                  ),
                  // Generated code for this productName Widget...
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextFormField(
                      validator: (value) {
                        // add email validation
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }

                        return null;
                      },
                      controller: _productNameController,
                      autofocus: false,
                      textCapitalization: TextCapitalization.words,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Product name...',
                        labelStyle: const TextStyle(
                          fontFamily: 'Outfit',
                          color: Color(0xFF606A85),
                          fontSize: 24,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w500,
                        ),
                        hintStyle: const TextStyle(
                          fontFamily: 'Outfit',
                          color: Color(0xFF606A85),
                          fontSize: 14,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w500,
                        ),
                        errorStyle: const TextStyle(
                          fontFamily: 'Figtree',
                          color: Color(0xFFFF5963),
                          fontSize: 12,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFFE5E7EB),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFF6F61EF),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFFFF5963),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFFFF5963),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsetsDirectional.fromSTEB(
                            16, 20, 16, 20),
                      ),
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        color: Color(0xFF15161E),
                        fontSize: 24,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w500,
                      ),
                      cursorColor: const Color(0xFF6F61EF),
                    ),
                  ),

                  Padding(
                      padding: const EdgeInsets.all(15),
                      child: // Generated code for this Row Widget...
                          Row(mainAxisSize: MainAxisSize.max, children: [
                        Expanded(
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Starting Price',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF606A85),
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextFormField(
                                  validator: (value) {
                                    // add email validation
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }

                                    return null;
                                  },
                                  controller: _productPriceController,
                                  autofocus: false,
                                  textCapitalization: TextCapitalization.words,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelStyle: const TextStyle(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF606A85),
                                      fontSize: 16,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    alignLabelWithHint: true,
                                    hintStyle: const TextStyle(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF606A85),
                                      fontSize: 14,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    errorStyle: const TextStyle(
                                      fontFamily: 'Figtree',
                                      color: Color(0xFFFF5963),
                                      fontSize: 12,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xFFE5E7EB),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xFF6F61EF),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xFFFF5963),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xFFFF5963),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            16, 16, 16, 16),
                                  ),
                                  style: const TextStyle(
                                    fontFamily: 'Figtree',
                                    color: Color(0xFF15161E),
                                    fontSize: 16,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  minLines: 1,
                                  cursorColor: const Color(0xFF6F61EF),
                                ),
                              ]),
                        ),
                        Expanded(
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Sale Price',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF606A85),
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextFormField(
                                  controller: _productSalePriceController,
                                  autofocus: false,
                                  textCapitalization: TextCapitalization.words,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelStyle: const TextStyle(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF606A85),
                                      fontSize: 16,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    alignLabelWithHint: true,
                                    hintStyle: const TextStyle(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF606A85),
                                      fontSize: 14,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    errorStyle: const TextStyle(
                                      fontFamily: 'Figtree',
                                      color: Color(0xFFFF5963),
                                      fontSize: 12,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xFFE5E7EB),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xFF6F61EF),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xFFFF5963),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xFFFF5963),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            16, 16, 16, 16),
                                  ),
                                  style: const TextStyle(
                                    fontFamily: 'Figtree',
                                    color: Color(0xFF15161E),
                                    fontSize: 16,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  minLines: 1,
                                  cursorColor: const Color(0xFF6F61EF),
                                ),
                              ]),
                        ),
                      ])),
                  SizedBox(
                    width: 300,
                    child: GFButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          navigateToNextScreen();
                        }
                      },
                      text: "save",
                      shape: GFButtonShape.standard,
                      fullWidthButton: true,
                      size: GFSize.LARGE,
                      type: GFButtonType.outline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
