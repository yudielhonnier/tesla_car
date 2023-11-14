import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tesla_animation/constanins.dart';
import 'package:tesla_animation/home_controller.dart';
import 'package:tesla_animation/models/tyre_psi.dart';
import 'package:tesla_animation/screens/components/battery_status.dart';
import 'package:tesla_animation/screens/components/door_lock.dart';
import 'package:tesla_animation/screens/components/temp_details.dart';
import 'package:tesla_animation/screens/components/tesla_bottom_navigation_bar.dart';
import 'package:tesla_animation/screens/components/tyre_psy_card.dart';
import 'package:tesla_animation/screens/components/tyres.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final HomeController _controller = HomeController();

  late AnimationController _batteryAnimationController;
  late AnimationController _tempAnimationController;
  late AnimationController _tyreAnimationController;

  late Animation<double> _batteryAnimation;
  late Animation<double> _batteryStatusAnimation;
  late Animation<double> _carShiftAnimation;
  late Animation<double> _tempInfoAnimation;
  late Animation<double> _glowAnimation;

  //tyres animations
  late Animation<double> _tyre1Animation;
  late Animation<double> _tyre2Animation;
  late Animation<double> _tyre3Animation;
  late Animation<double> _tyre4Animation;

  late List<Animation<double>> _tyresAnimations;

  void setupBatteryAnimation() {
    _batteryAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _batteryAnimation = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: const Interval(0, 0.5),
    );
    _batteryStatusAnimation = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: const Interval(0.6, 1),
    );
  }

  void setupTempAnimation() {
    _tempAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _carShiftAnimation = CurvedAnimation(
      parent: _tempAnimationController,
      curve: const Interval(0.2, 0.4),
    );
    _tempInfoAnimation = CurvedAnimation(
      parent: _tempAnimationController,
      curve: const Interval(0.45, 0.65),
    );
    _glowAnimation = CurvedAnimation(
      parent: _tempAnimationController,
      curve: const Interval(0.70, 1),
    );
  }

  void setupTyreAnimation() {
    _tyreAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _tyre1Animation = CurvedAnimation(
      parent: _tyreAnimationController,
      curve: const Interval(0.35, 0.5),
    );
    _tyre2Animation = CurvedAnimation(
      parent: _tyreAnimationController,
      curve: const Interval(0.5, 0.66),
    );
    _tyre3Animation = CurvedAnimation(
      parent: _tyreAnimationController,
      curve: const Interval(0.66, 0.82),
    );
    _tyre4Animation = CurvedAnimation(
      parent: _tyreAnimationController,
      curve: const Interval(0.82, 1),
    );
  }

  @override
  void initState() {
    super.initState();
    setupBatteryAnimation();
    setupTempAnimation();
    setupTyreAnimation();
    _tyresAnimations = [
      _tyre1Animation,
      _tyre2Animation,
      _tyre3Animation,
      _tyre4Animation
    ];
  }

  @override
  void dispose() {
    _batteryAnimationController.dispose();
    _tempAnimationController.dispose();
    _tyreAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: Listenable.merge([
          _controller,
          _batteryAnimationController,
          _tempAnimationController,
          _tyreAnimationController
        ]),
        builder: (context, _) {
          return Scaffold(
              bottomNavigationBar: TeslaBottomNavigationBar(
                onTap: (int value) {
                  if (value == 1) {
                    _batteryAnimationController.forward();
                  } else if (_controller.selectedBottomTap == 1 && value != 1) {
                    _batteryAnimationController.reverse(from: 0.7);
                  }
                  if (value == 2) {
                    _tempAnimationController.forward();
                  } else if (_controller.selectedBottomTap == 2 && value != 2) {
                    _tempAnimationController.reverse(from: 0.4);
                  }
                  if (value == 3) {
                    _tyreAnimationController.forward();
                  } else if (_controller.selectedBottomTap == 3 && value != 3) {
                    _tyreAnimationController.reverse(from: 0.4);
                  }
                  _controller.showTyreController(value);
                  _controller.showTyreStatusController(value);

                  _controller.onBottomTapSelected(value);
                },
                selectedTab: _controller.selectedBottomTap,
              ),
              body: SafeArea(
                child: LayoutBuilder(builder: (context, constrains) {
                  return Stack(alignment: Alignment.center, children: [
                    SizedBox(
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                    ),
                    Positioned(
                      left:
                          constrains.maxWidth / 2 * (_carShiftAnimation.value),
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: constrains.maxHeight * 0.1),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: double.infinity,
                            maxHeight: double.infinity,
                          ),
                          child: SvgPicture.asset(
                            "assets/icons/Car.svg",
                            width: double.infinity,
                          ),
                        ),
                      ),
                    ),
                    //lock -unlock icons
                    AnimatedPositioned(
                      duration: defaultDuration,
                      right: _controller.selectedBottomTap == 0
                          ? constrains.maxWidth * 0.05
                          : constrains.maxWidth / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTap == 0 ? 1 : 0,
                        child: DoorLock(
                          press: _controller.updateRightDoor,
                          isLock: _controller.isRightDoorLock,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      left: _controller.selectedBottomTap == 0
                          ? constrains.maxWidth * 0.05
                          : constrains.maxWidth / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTap == 0 ? 1 : 0,
                        child: DoorLock(
                          press: _controller.updateLeftDoor,
                          isLock: _controller.isLeftDoorLock,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      top: _controller.selectedBottomTap == 0
                          ? constrains.maxHeight * 0.15
                          : constrains.maxHeight * 0.5,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTap == 0 ? 1 : 0,
                        child: DoorLock(
                          press: _controller.updateTopDoor,
                          isLock: _controller.isToptDoorLock,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      bottom: _controller.selectedBottomTap == 0
                          ? constrains.maxHeight * 0.18
                          : constrains.maxHeight * 0.5,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTap == 0 ? 1 : 0,
                        child: DoorLock(
                          press: _controller.updateBottomDoor,
                          isLock: _controller.isBottomDoorLock,
                        ),
                      ),
                    ),
                    // baterry
                    Opacity(
                        opacity: _batteryAnimation.value,
                        child: SvgPicture.asset(
                          "assets/icons/Battery.svg",
                          width: constrains.maxWidth * 0.4,
                        )),
                    //battery status
                    Positioned(
                      top: 50 * (1 - _batteryStatusAnimation.value),
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                      child: Opacity(
                        opacity: _batteryStatusAnimation.value,
                        child: BatteryStatus(
                          constrains: constrains,
                        ),
                      ),
                    ),

                    //temp
                    Positioned(
                      top: 60 * (1 - _tempInfoAnimation.value),
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                      child: Opacity(
                          opacity: _tempInfoAnimation.value,
                          child: TempDetails(controller: _controller)),
                    ),
                    //glow
                    Positioned(
                        right: -180 * (1 - _glowAnimation.value),
                        child: AnimatedSwitcher(
                          duration: defaultDuration,
                          child: _controller.isCoolSelected
                              ? Image.asset(
                                  key: UniqueKey(),
                                  "assets/images/Cool_glow_2.png",
                                  width: 200,
                                )
                              : Image.asset(
                                  key: UniqueKey(),
                                  "assets/images/Hot_glow_4.png",
                                  width: 200,
                                ),
                        )),
                    //tyres
                    if (_controller.isShowTyre) ...tyres(constrains),
                    if (_controller.isShowTyreStatus)
                      GridView.builder(
                          itemCount: 4,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: defaultPadding,
                                  crossAxisSpacing: defaultPadding,
                                  childAspectRatio: constrains.maxWidth /
                                      constrains.maxHeight),
                          itemBuilder: (context, index) => ScaleTransition(
                                scale: _tyresAnimations[index],
                                child: TyrePsiCard(
                                  isBottomTwoTyre: index > 1,
                                  tyrePsi: demoPsiList[index],
                                ),
                              ))
                  ]);
                }),
              ));
        });
  }
}
