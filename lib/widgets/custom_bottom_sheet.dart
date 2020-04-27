import 'package:flutter/material.dart';

import 'package:test_task/state_manager.dart';
import '../provider.dart';

class CustomBottomSheet extends StatefulWidget {
  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  StateManager animationManager;

  Size baseSize;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    baseSize = MediaQuery.of(context).size;

    animationManager = Provider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationManager.bottomSheetAnimationController,
      builder: (BuildContext context, Widget child) {
        return GestureDetector(
          //prevent tapping on the sheet body
          onTap: () {},
          child: Container(
            height: (baseSize.height * 0.35) *
                animationManager.bottomSheetAnimation.value,
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
                  CloseIconButton(onTap: animationManager),
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
      color: Color(0xFFfcd846),
      padding: EdgeInsets.only(left: 0.0, right: 0.0),
      onPressed: () {
        //empty call
      },
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
    @required this.onTap,
  }) : super(key: key);

  final StateManager onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: () => onTap.startAnimation(),
        child: Icon(
          Icons.close,
          size: 25,
        ),
      ),
    );
  }
}
