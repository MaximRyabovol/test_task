import 'package:flutter/material.dart';

class StateManager {
  AnimationController mainWidgetAnimationController;
  Animation mainWidgetFadeAnimation;

  AnimationController progressBarAnimationController;
  Animation progressBarAppearingAnimation;
  Animation progressBarFillingAnimation;
  Animation progressBarErrorsLableAndTitleAppearing;

  AnimationController bottomSheetAnimationController;
  Animation bottomSheetAnimation;

  void initAnimation(TickerProvider tickerProvider) {
    mainWidgetAnimationController = AnimationController(
        vsync: tickerProvider, duration: const Duration(milliseconds: 300));

    mainWidgetAnimationController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          progressBarAnimationController.forward();
        }
      },
    );

    mainWidgetFadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(mainWidgetAnimationController);

    progressBarAnimationController = AnimationController(
        vsync: tickerProvider, duration: Duration(milliseconds: 1080));

    progressBarAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        bottomSheetAnimationController.forward();
      }
    });

    progressBarAppearingAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: progressBarAnimationController,
        curve: Interval(
          0.0,
          0.185,
        ),
      ),
    );

    progressBarFillingAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: progressBarAnimationController,
      curve: Interval(0.185, 0.75),
    ));

    progressBarErrorsLableAndTitleAppearing =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: progressBarAnimationController,
      curve: Interval(0.75, 1.0),
    ));

    bottomSheetAnimationController = AnimationController(
      vsync: tickerProvider,
      duration: Duration(milliseconds: 420),
    );

    bottomSheetAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(bottomSheetAnimationController);
  }

  void startAnimation() async {
    if (bottomSheetAnimationController.status == AnimationStatus.completed) {
      await bottomSheetAnimationController.reverse();
      progressBarAnimationController.reset();
      await mainWidgetAnimationController.reverse();
    } else {
      mainWidgetAnimationController.forward();
    }
  }

  void dispose() {
    mainWidgetAnimationController.dispose();
    progressBarAnimationController.dispose();
    bottomSheetAnimationController.dispose();
  }
}
