import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:showwcase_flutter_challenge/core/utils/colors.dart';
import 'package:showwcase_flutter_challenge/core/utils/enums.dart';

class AppRoundedButton extends StatelessWidget {

  final String? text;
  final Function()? onTap;
  final AppButtonType buttonType;
  final Color? backgroundColor;
  final Color? textColor;
  final double elevation;
  final LayoutSize layoutSize;

  const AppRoundedButton({
    Key? key,
    this.elevation = 5,
    this.text, this.onTap, this.buttonType = AppButtonType.primary , this.backgroundColor, this.textColor, this.layoutSize = LayoutSize.standard})
  :super(key: key)
  ;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    double? buttonWidth;
    if(layoutSize == LayoutSize.wrapContent){
      buttonWidth = null;
    }else if(layoutSize == LayoutSize.matchParent){
      buttonWidth = double.infinity;
    }else if(layoutSize == LayoutSize.standard){
      buttonWidth = size.width / 1.8;
    }

    return SizedBox(
        width: buttonWidth,
        child: ElevatedButton(
          onPressed: onTap, child: Text(text ?? "", style: TextStyle(fontWeight: FontWeight.w500, color: textColor ?? Colors.white),).tr(),
          style: ButtonStyle(
            padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>((states) => const EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                )
            ),
            elevation: MaterialStateProperty.resolveWith<double>((states) => elevation),
            backgroundColor:  MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {

                    if(backgroundColor != null){
                      return backgroundColor!;
                    }

                if (states.contains(MaterialState.pressed)) {
                  return buttonType == AppButtonType.primary ? accent : Theme.of(context).primaryColor;
                }

                return buttonType == AppButtonType.primary ? Theme.of(context).primaryColor : accent;
              },
            ),

          ),
        ),
    );
  }
}
