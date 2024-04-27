import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/like_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyCard extends StatelessWidget {
  Function()? onTap;
  final String nameCard, star, price, imagePath;
  final bool isLiked;
  MyCard({
    super.key,
    required this.nameCard,
    required this.price,
    required this.star,
    required this.imagePath,
    required this.isLiked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).colorScheme.background,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black
                    : Colors.grey.shade500,
                offset: const Offset(4, 4),
                blurRadius: 5,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade800
                    : Colors.white,
                offset: const Offset(-4, -4),
                blurRadius: 8,
              )
            ]),
        child: Column(
          children: [
            Image.network(
              imagePath,
              height: 190,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(nameCard),
                      Container(
                        child: Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.solidStar,
                              color: Colors.amber.shade600,
                              size: 14,
                            ),
                            Text(star)
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(price),
                      Container(
                        child: Row(
                          children: [
                            LikeButton(isLiked: isLiked, onTap: onTap),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
