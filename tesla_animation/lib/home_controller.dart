import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  int selectedBottomTap = 0;

  void onBottomTapSelected(int index) {
    selectedBottomTap = index;

    notifyListeners();
  }

  bool isRightDoorLock = true;
  bool isLeftDoorLock = true;
  bool isToptDoorLock = true;
  bool isBottomDoorLock = true;

  void updateRightDoor() {
    isRightDoorLock = !isRightDoorLock;
    notifyListeners();
  }

  void updateLeftDoor() {
    isLeftDoorLock = !isLeftDoorLock;
    notifyListeners();
  }

  void updateTopDoor() {
    isToptDoorLock = !isToptDoorLock;
    notifyListeners();
  }

  void updateBottomDoor() {
    isBottomDoorLock = !isBottomDoorLock;
    notifyListeners();
  }

  bool isCoolSelected = true;

  void updateCoolSelected() {
    isCoolSelected = !isCoolSelected;
    notifyListeners();
  }

  bool isShowTyre = false;

  void showTyreController(int index) {
    if (selectedBottomTap != 3 && index == 3) {
      Future.delayed(const Duration(milliseconds: 400), () {
        isShowTyre = true;
        notifyListeners();
      });
    } else {
      isShowTyre = false;
      notifyListeners();
    }
  }

  bool isShowTyreStatus = false;

  void showTyreStatusController(int index) {
    if (selectedBottomTap != 3 && index == 3) {
      Future.delayed(const Duration(milliseconds: 400), () {
        isShowTyreStatus = true;
        notifyListeners();
      });
    } else {
      Future.delayed(const Duration(milliseconds: 400), () {
        isShowTyreStatus = false;
        notifyListeners();
      });
    }
  }
}
