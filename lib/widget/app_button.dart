import 'package:flutter/material.dart';
import 'package:workout_routines_app/utils/utils.dart';

class AppButton extends StatelessWidget {
  final void Function() onTap;
  final double buttonHeight;
  final double buttonWidth;
  final double buttonRadius;
  final Color? buttonColor;
  final String buttonTitle;
  final Color? titleColor;
  final Color? borderColor;
  final FontWeight fontWeight;
  final double titleSize;
  final EdgeInsetsGeometry margin;

  const AppButton({
    super.key,
    required this.onTap,
    required this.buttonTitle,
    this.buttonHeight = 48.0,
    this.buttonWidth = double.infinity,
    this.buttonColor,
    this.buttonRadius = 12,
    this.borderColor,
    this.titleSize = 16,
    this.fontWeight = FontWeight.w400,
    this.titleColor,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(buttonRadius),
      ),
      child: Material(
        color: buttonColor ?? AppColor.black,
        child: InkWell(
          onTap: onTap,
          overlayColor: MaterialStateColor.resolveWith(
            (Set<MaterialState> states) {
              return Colors.black.withOpacity(0.1);
            },
          ),
          child: Container(
            alignment: Alignment.center,
            margin: margin,
            // padding: const EdgeInsets.symmetric(vertical: 18),
            height: buttonHeight,
            width: buttonWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(buttonRadius),
              ),
              border: Border.all(
                color: borderColor ?? AppColor.black,
              ),
              color: Colors.transparent,
            ),
            child: Text(
              buttonTitle,
              style: TextStyle(
                fontWeight: fontWeight,
                fontSize: titleSize,
                color: titleColor ?? AppColor.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
