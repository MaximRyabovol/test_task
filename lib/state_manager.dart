import 'package:flutter/material.dart';

/* 
Время основных анимаций в миллисекундах:
появление главного фрагмента - 300ms
появление прогрессбара - 200ms
заполнение прогрессбара 0..100 - 600ms
появление надписи Error - 280ms
появление диалога снизу - 420ms
*/

class StateManager {
  AnimationController mainWidgetAnimationController;
  Animation mainWidgetFadeAnimation;

  AnimationController progressBarAndErrorLabelAnimationController;
  Animation progressBarAppearingAnimation;
  Animation progressBarFillingAnimation;
  Animation progressBarErrorsLableAndTitleAppearing;

  AnimationController bottomSheetAnimationController;
  Animation bottomSheetAnimation;

  void initAnimation(TickerProvider tickerProvider) {
    //появление главного фрагмента - 300ms
    mainWidgetAnimationController = AnimationController(
        vsync: tickerProvider, duration: const Duration(milliseconds: 300));
    mainWidgetAnimationController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          progressBarAndErrorLabelAnimationController.forward();
        }
      },
    );
    mainWidgetFadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(mainWidgetAnimationController);

    /*
    появление прогрессбара - 200ms
    заполнение прогрессбара 0..100 - 600ms
    появление надписи Error - 280ms
    Итого, время анимации индикатора и надписи занимает: 200 + 600 + 280 = 1080 ms
    */
    progressBarAndErrorLabelAnimationController = AnimationController(
        vsync: tickerProvider, duration: Duration(milliseconds: 1080));
    progressBarAndErrorLabelAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        bottomSheetAnimationController.forward();
      }
    });
    progressBarAppearingAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: progressBarAndErrorLabelAnimationController,
        curve: Interval(
          0.0,
          0.185,
        ),
      ),
    );
    progressBarFillingAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: progressBarAndErrorLabelAnimationController,
      curve: Interval(0.185, 0.75),
    ));
    progressBarErrorsLableAndTitleAppearing =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: progressBarAndErrorLabelAnimationController,
      curve: Interval(0.75, 1.0),
    ));

    //появление диалога снизу - 420ms
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
      progressBarAndErrorLabelAnimationController.reset();
      await mainWidgetAnimationController.reverse();
    } else {
      mainWidgetAnimationController.forward();
    }
  }

  void dispose() {
    mainWidgetAnimationController.dispose();
    progressBarAndErrorLabelAnimationController.dispose();
    bottomSheetAnimationController.dispose();
  }
}
