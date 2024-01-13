import 'package:flutter/material.dart';
import 'package:tourist_guide/misc/colors.dart';
import 'package:tourist_guide/widgets/app_text.dart';

class ResponsiveButton extends StatelessWidget {
  bool? isResponsive;
  double? width;
  ResponsiveButton({Key? key, this.width, this.isResponsive = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: width,
        height: 45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.mainColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.network(
            // 'https://cdn.pixabay.com/photo/2012/04/01/18/42/blue-23954_1280.png',
            //  semanticLabel: 'Description of the image',
            //  )
            AppText(
              text: "Park Now",
              color: Colors.white,
              size: 12,
            )
          ],
        ),
      ),
    );
  }
}
