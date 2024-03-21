import 'package:flutter/cupertino.dart';

class CustomKeyboard extends StatelessWidget {
  final Function(String) onKeyPressed;

  const CustomKeyboard({super.key, required this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      //width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: GridView.count(
        crossAxisCount: 3,
        padding: EdgeInsets.zero,
        crossAxisSpacing: 45,
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
