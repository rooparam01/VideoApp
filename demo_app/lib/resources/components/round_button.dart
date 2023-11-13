
import 'package:flutter/material.dart';
import '../colors.dart';

class RoundButton extends StatelessWidget {

  final String title;
  final bool loading;
  final VoidCallback onPress;
  final Color color;

  const RoundButton({super.key,
    required this.title,
    this.loading=false,
    this.color=AppColors.appThemeColor,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      child: Align(
        alignment: Alignment.center, // Center the button within the container
        child: ElevatedButton(
          onPressed: loading ? null : onPress,
          child: Text(title, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(loading?AppColors.disableColor:color),
            fixedSize: MaterialStateProperty.all(Size(320, 50)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
            )),
          ),
        ),
      ),
    );
  }
}
