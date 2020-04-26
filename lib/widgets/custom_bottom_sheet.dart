import 'package:flutter/material.dart';
import 'package:test_task/state_manager.dart';

import '../provider.dart';

class CustomBottomSheet extends StatefulWidget {
  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet>
    with TickerProviderStateMixin {
  StateManager manager;

  AnimationController _bottomSheetAnimationController;
  Animation _bottomSheetAnimation;

  Size baseSize;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    baseSize = MediaQuery.of(context).size;

    manager = Provider.of(context);
    manager.initCustomBotomSheetAnimation(this);
    _bottomSheetAnimationController = manager.bottomSheetAnimationController;

    _bottomSheetAnimation = manager.bottomSheetAnimation;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _bottomSheetAnimationController,
      builder: (BuildContext context, Widget child) {
        return GestureDetector(
          //prevent tapping on the sheet body
          onTap: () {},
          child: Container(
            height: (baseSize.height * 0.35) * _bottomSheetAnimation.value,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            padding: EdgeInsets.only(
              top: 25.0,
              left: 25.0,
              right: 25.0,
            ),
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CloseIconButton(manager: manager),
                  SizedBox(
                    height: baseSize.width * 0.02,
                  ),
                  Text(
                    'Something went wrong',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: baseSize.width * 0.07,
                    ),
                  ),
                  SizedBox(
                    height: baseSize.width * 0.04,
                  ),
                  Text(
                    'We couldn\'t process your request. Please try again.',
                    style: TextStyle(
                      fontSize: baseSize.width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: baseSize.width * 0.08,
                  ),
                  CustomBottomSheetButton(baseSize: baseSize),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomBottomSheetButton extends StatelessWidget {
  const CustomBottomSheetButton({
    Key key,
    @required this.baseSize,
  }) : super(key: key);

  final Size baseSize;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.yellow,
      padding: EdgeInsets.only(left: 0.0, right: 0.0),
      onPressed: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        height: baseSize.height * 0.07,
        width: baseSize.width,
        child: Center(
          child: Text(
            'Try again',
            style: TextStyle(fontSize: baseSize.width * 0.05),
          ),
        ),
      ),
    );
  }
}

class CloseIconButton extends StatelessWidget {
  const CloseIconButton({
    Key key,
    @required this.manager,
  }) : super(key: key);

  final StateManager manager;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: () async {
          manager.startAnimation();
        },
        child: Icon(
          Icons.close,
          size: 25,
        ),
      ),
    );
  }
}
