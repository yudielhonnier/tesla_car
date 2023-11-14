import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tesla_animation/constanins.dart';

class TempBtn extends StatelessWidget {
  const TempBtn({
    super.key,
    required this.title,
    this.isActive = false,
    required this.svgSrc,
    required this.press,
    this.activeColor = primaryColor,
  });

  final String title;
  final bool isActive;
  final String svgSrc;
  final VoidCallback press;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOutBack,
              width: isActive ? 75 : 50,
              height: isActive ? 75 : 50,
              child: SvgPicture.asset(
                svgSrc,
                colorFilter: ColorFilter.mode(
                    isActive ? activeColor : Colors.white38, BlendMode.srcIn),
              )),
          const SizedBox(
            height: defaultPadding / 2,
          ),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 100),
            style: TextStyle(
                fontSize: 18,
                color: isActive ? activeColor : Colors.white38,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal),
            child: Text(
              title.toUpperCase(),
            ),
          )
        ],
      ),
    );
  }
}
