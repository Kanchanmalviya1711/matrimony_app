import 'package:flutter/material.dart';

class TextLabel extends StatelessWidget {
  final String title;
  final bool isRequired;
  const TextLabel({super.key, required this.title, required this.isRequired});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            Container(
                padding: const EdgeInsets.only(bottom: 10, right: 10),
                child: Text(
                  title,
                )),
            Positioned(
              right: 2,
              top: -3,
              child: Visibility(
                visible: isRequired,
                child: const Text(
                  "*",
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
