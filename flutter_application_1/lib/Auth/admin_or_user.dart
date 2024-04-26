import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/user_controller.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/page/admin/dashboard.dart';
import 'package:flutter_application_1/page/user/Information/complete_profile.dart';
import 'package:flutter_application_1/page/user/Information/place.dart';
import 'package:flutter_application_1/page/user/home._page.dart';
import 'package:flutter_application_1/config/const.dart';

class AdminOrUser extends StatefulWidget {
  final user;
  const AdminOrUser({super.key, required this.user});

  @override
  State<AdminOrUser> createState() => _AdminOrUserState();
}

class _AdminOrUserState extends State<AdminOrUser> {
  bool isLoading = true; // Trạng thái đang chờ
  final UserController _controller = UserController();

  @override
  void initState() {
    super.initState();
    checkRole(); // Gọi hàm kiểm tra vai trò trong initState
  }

  Future<void> checkRole() async {
    isUser = true;
    isNew = false;
    isSetAddress = false;
    if (widget.user != null) {
      Users? userRole = await _controller.getUserById(widget.user.email);

      setState(() {
        isLoading = false; // Cập nhật trạng thái khi kiểm tra hoàn tất
        if (userRole!.role == 'admin') {
          isUser = false;
        }

        if (userRole.phone == null) {
          isNew = true;
        }

        if (userRole.address == null) {
          isSetAddress = true;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Hiển thị giao diện tải khi đang chờ
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      // Hiển thị giao diện dựa trên kết quả của quá trình kiểm tra vai trò
      if (isUser) {
        if (isNew) {
          return CompleteProfile(
            userEmail: widget.user.email,
          );
        } else if (isSetAddress) {
          return SearcPlacesScreen(
            userEmail: widget.user.email,
          );
        }
        return const UserHomePage();
      } else {
        return const AdminDashboard();
      }
    }
  }
}
