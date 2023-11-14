import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tesla_animation/constanins.dart';

class DoorLock extends StatelessWidget {
  const DoorLock({
    super.key,
    required this.press,
    required this.isLock,
  });

  final VoidCallback press;
  final bool isLock;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: press,
        child: AnimatedSwitcher(
          switchInCurve: Curves.easeInOutBack,
          transitionBuilder: ((child, animation) => ScaleTransition(
                scale: animation,
                child: child,
              )),
          duration: defaultDuration,
          child: isLock
              ? SvgPicture.asset(
                  "assets/icons/door_lock.svg",
                  width: 50,
                  key: const ValueKey("lock"),
                )
              : SvgPicture.asset(
                  "assets/icons/door_unlock.svg",
                  width: 50,
                  key: const ValueKey("unlock"),
                ),
        ));
  }
}
