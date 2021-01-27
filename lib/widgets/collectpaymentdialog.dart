import 'package:flutter/material.dart';
import 'package:hoover_driver/helpers/helpermethods.dart';
import 'package:hoover_driver/screens/brand_colors.dart';
import 'package:hoover_driver/widgets/BrandDivider.dart';
import 'package:hoover_driver/widgets/TaxiButton.dart';

class CollectPaymentDialog extends StatelessWidget {
  final String paymentMethod;
  final int fares;

  CollectPaymentDialog({this.paymentMethod, this.fares});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Container(
        margin: EdgeInsets.all(4.0),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20),
            Text('${paymentMethod.toUpperCase()} PAYMENT'),
            SizedBox(height: 20),
            BrandDivider(),
            SizedBox(height: 16),
            Text(
              '\$ $fares',
              style: TextStyle(fontSize: 50, fontFamily: 'Brand-Bold'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('Total fare to be charged from the rider.'),
            ),
            SizedBox(height: 30),
            Container(
              width: 230,
              child: TaxiButton(
                color: BrandColors.colorGreen,
                title: (paymentMethod == 'cash') ? 'COLLECT CASH' : 'CONFIRM',
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);

                  HelperMethods.enableHomeTabLocationUpdates();
                },
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
