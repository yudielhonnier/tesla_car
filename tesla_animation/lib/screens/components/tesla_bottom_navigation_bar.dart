import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tesla_animation/constanins.dart';

class TeslaBottomNavigationBar extends StatelessWidget {
  const TeslaBottomNavigationBar({
    super.key,
    required this.selectedTab,
    required this.onTap,
  });
  final int selectedTab;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: selectedTab,
        onTap: onTap,
        //default bar type is shifting and the color dont chamge
        // for that is added type fixed
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        items: List.generate(
          navIconSrc.length,
          (index) => BottomNavigationBarItem(
              icon: SvgPicture.asset(
                navIconSrc[index],
                colorFilter: ColorFilter.mode(
                    index == selectedTab ? primaryColor : Colors.white54,
                    BlendMode.srcIn),
              ),
              label: ""),
        ));
  }
}

List<String> navIconSrc = [
  "assets/icons/Lock.svg",
  "assets/icons/Charge.svg",
  "assets/icons/Temp.svg",
  "assets/icons/Tyre.svg",
];
