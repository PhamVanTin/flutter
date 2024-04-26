import 'package:flutter/material.dart';
import 'package:flutter_application_1/Auth/auth_page.dart';
import 'package:flutter_application_1/component/button.dart';
import 'package:flutter_application_1/controllers/user_controller.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'package:lottie/lottie.dart';

class SearcPlacesScreen extends StatefulWidget {
  final String userEmail;
  const SearcPlacesScreen({super.key, required this.userEmail});

  @override
  State<SearcPlacesScreen> createState() => _SearcPlacesScreenState();
}

class _SearcPlacesScreenState extends State<SearcPlacesScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Color color = Colors.grey.shade300;
  TextEditingController _placeController = TextEditingController();
  final UserController _controller = UserController();
  void complete() async {
    await updateUser();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AuthPage()));
  }

  Future<void> updateUser() async {
    Map<String, dynamic> user = {
      'address': _placeController.text,
    };

    await _controller.updateUser(widget.userEmail, user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios,
            )),
        title: Text(
          "Enter Your Location",
          style: GoogleFonts.inter(
              textStyle: TextStyle(fontWeight: FontWeight.normal)),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: color)),
                child: Row(
                  children: [
                    Icon(
                      FeatherIcons.search,
                      size: 30,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _placeController,
                        cursorColor: Colors.deepPurple.shade400,
                        validator: (value) {
                          // add email validation
                          if (value == null || value.isEmpty) {
                            setState(() {
                              color = Colors.red.shade300;
                            });
                          } else {
                            setState(() {
                              color = Colors.grey.shade300;
                            });
                          }
                          ;
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter your location',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: GestureDetector(
                      onTap: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          complete();
                        }
                      },
                      child: Lottie.network(
                        'https://lottie.host/73bf9054-4fee-499e-833f-5910162925a2/XODObLVmeq.json',
                        height: 120,
                      ),
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
