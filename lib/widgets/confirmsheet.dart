import 'package:flutter/material.dart';
import 'package:hoover_driver/screens/brand_colors.dart';
import 'package:hoover_driver/widgets/TaxiOutlineButton.dart';

import 'TaxiButton.dart';

class ConfirmSheet extends StatelessWidget {
  final String title;
  final String subTitle;
  final Function onPressed;

  ConfirmSheet({this.title, this.subTitle, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 15,
          spreadRadius: 5,
          offset: Offset(0.7, 0.7),
        ),
      ]),
      height: 220,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Brand-Bold',
                color: BrandColors.colorText,
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              subTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: BrandColors.colorTextLight,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              children: [
                Expanded(
                  child: TaxiOutlineButton(
                    title: 'Back',
                    color: BrandColors.colorLightGray,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: TaxiButton(
                    title: 'Confirm',
                    color: (title == 'GO ONLINE')
                        ? BrandColors.colorGreen
                        : BrandColors.colorOrange,
                    onPressed: onPressed,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
