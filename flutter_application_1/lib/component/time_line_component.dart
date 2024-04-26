import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/my_time_line_title.dart';

class Timeline extends StatelessWidget {
  final bool shipped, waiting, shipping;
  const Timeline(
      {super.key,
      required this.shipped,
      required this.shipping,
      required this.waiting});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        MyTimeLineTitle(
          isFist: true,
          isLast: false,
          isPast: waiting,
          child: Text(
            'Chờ duyệt',
            style: TextStyle(
                color: waiting
                    ? Colors.deepPurple.shade300
                    : Colors.deepPurple.shade100),
          ),
        ),
        MyTimeLineTitle(
          isFist: false,
          isLast: false,
          isPast: shipping,
          child: Text(
            'Đang giao',
            style: TextStyle(
                color: shipping
                    ? Colors.deepPurple.shade300
                    : Colors.deepPurple.shade100),
          ),
        ),
        MyTimeLineTitle(
          isFist: false,
          isLast: true,
          isPast: shipped,
          child: Text(
            'Đã giao',
            style: TextStyle(
                color: shipped
                    ? Colors.deepPurple.shade300
                    : Colors.deepPurple.shade100),
          ),
        ),
      ],
    );
  }
}
