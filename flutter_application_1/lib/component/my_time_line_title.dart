import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/event_card.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyTimeLineTitle extends StatelessWidget {
  final bool isFist;
  final bool isLast;
  final bool isPast;
  final child;

  const MyTimeLineTitle({
    super.key,
    required this.isFist,
    required this.isLast,
    required this.isPast,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 140,
          height: 80,
          child: TimelineTile(
            axis: TimelineAxis.horizontal,
            isFirst: isFist,
            isLast: isLast,
            beforeLineStyle: LineStyle(
                thickness: 2,
                color: isPast
                    ? Colors.deepPurple.shade300
                    : Colors.deepPurple.shade100),
            indicatorStyle: IndicatorStyle(
                height: 20,
                color: isPast
                    ? Colors.deepPurple.shade300
                    : Colors.deepPurple.shade100,
                iconStyle: IconStyle(
                  iconData: Icons.done,
                  color: isPast ? Colors.white : Colors.deepPurple.shade100,
                )),
            endChild: AnimatedSwitcher(
              duration: Duration(milliseconds: 500), // Thời gian hoạt ảnh
              transitionBuilder: (Widget child, Animation<double> animation) {
                // Hiệu ứng chuyển đổi
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: EventCard(
                isPast: isPast,
                child: child,
                key: ValueKey(
                    child), // Đảm bảo rằng mỗi lần thay đổi, một key mới được sử dụng
              ),
            ),
          ),
        ),
      ],
    );
  }
}
