import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:tesla_animation/home_controller.dart';
import 'package:tesla_animation/screens/components/tesla_bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final HomeController _controller = HomeController();

  late AnimationController _batteryAnimationController;
  late Animation<double> _batteryAnimation;

  void setupBatteryAnimation() {
    _batteryAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 1000),
    );

    _batteryAnimation = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: const Interval(0, 1),
    );
  }

  @override
  void initState() {
    super.initState();
    setupBatteryAnimation();
    _batteryAnimationController.forward();
  }

  @override
  void dispose() {
    _batteryAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _batteryAnimationController,
        builder: (context, _) {
          return Scaffold(
              bottomNavigationBar: TeslaBottomNavigationBar(
                onTap: (int value) {},
                selectedTab: _controller.selectedBottomTap,
              ),
              body: SafeArea(
                child: LayoutBuilder(builder: (context, constrains) {
                  return Stack(alignment: Alignment.center, children: [
                    Opacity(
                        opacity: _batteryAnimation.value,
                        child: SvgPicture.asset(
                          "assets/icons/Battery.svg",
                          width: constrains.maxWidth * 0.4,
                        ))
                  ]);
                }),
              ));
        });
  }
}
