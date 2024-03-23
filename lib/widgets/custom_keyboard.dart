import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomKeyboard extends StatelessWidget {
  final Function(String) onKeyPressed;

  const CustomKeyboard({super.key, required this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: 0.39 * height,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: width * 0.033),
      child: GridView.count(
        crossAxisCount: 3,
        padding: EdgeInsets.zero,
        crossAxisSpacing: width * 0.1004,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          12,
          (index) {
            Widget keyWidget;
            if (index == 10) {
              // Render '0' key
              keyWidget = GestureDetector(
                onTap: () => onKeyPressed('0'),
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  margin: const EdgeInsets.all(10),
                  child: const Text(
                    '0',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 28,
                      fontFamily: 'SFProDisplay',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            } else if (index == 9) {
              // Render '*' key
              keyWidget = GestureDetector(
                onTap: () => onKeyPressed('*'),
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  margin: const EdgeInsets.all(10),
                  child: const Text(
                    '*',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 30,
                      fontFamily: 'SFProDisplay',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            } else if (index == 11) {
              // Render 'delete' key
              keyWidget = GestureDetector(
                onTap: () => onKeyPressed('delete'),
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  margin: const EdgeInsets.all(10),
                  child: const Icon(
                    CupertinoIcons.delete_left,
                    size: 20,
                    color: Color(0xFF111827),
                  ),
                ),
              );
            } else {
              // Render numeric keys 1-9
              keyWidget = GestureDetector(
                onTap: () => onKeyPressed('${index + 1}'),
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  margin: const EdgeInsets.all(10),
                  child: Text(
                    '${index + 1}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 28,
                      fontFamily: 'SFProDisplay',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }
            return keyWidget;
          },
        ),
      ),
    );
  }
}
