import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedButton extends StatelessWidget {
  final String btnText;
  final Function onBtnPressed;

  const RoundedButton(
      {Key? key, required this.btnText, required this.onBtnPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return ScreenUtilInit(
      builder: (BuildContext context, Widget? child) =>
       Material(
        elevation: 5,
        color: Colors.green,
        borderRadius: BorderRadius.circular(30),
        child: MaterialButton(
          onPressed: () {
            onBtnPressed();
          },
          minWidth: double.infinity,
          height: (h * 0.09) - 10,
          child: Text(
            btnText,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
