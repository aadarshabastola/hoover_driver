import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hoover_driver/datamodels/tripdetails.dart';
import 'package:hoover_driver/helpers/helpermethods.dart';
import 'package:hoover_driver/screens/brand_colors.dart';
import 'package:hoover_driver/screens/newtrippage.dart';
import 'package:hoover_driver/widgets/BrandDivider.dart';
import 'package:hoover_driver/widgets/ProgressDialog.dart';
import 'package:hoover_driver/widgets/TaxiButton.dart';
import 'package:hoover_driver/widgets/TaxiOutlineButton.dart';
import 'package:hoover_driver/globalvariables.dart';
import 'package:toast/toast.dart';

class NotificationDialog extends StatelessWidget {
  final TripDetails tripDetails;
  NotificationDialog({this.tripDetails});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(4),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30),
            Image.asset('images/taxi.png', width: 100),
            SizedBox(height: 16),
            Text('NEW TRIP REQUEST',
                style: TextStyle(fontSize: 18, fontFamily: 'Brand-Bold')),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('images/pickicon.png'),
                      SizedBox(width: 18),
                      Expanded(
                        child: Container(
                          child: Text(tripDetails.pickupAddress,
                              style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('images/desticon.png'),
                      SizedBox(width: 18),
                      Expanded(
                        child: Container(
                          child: Text(tripDetails.destinationAddress,
                              style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            BrandDivider(),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      child: TaxiButton(
                        color: BrandColors.colorGreen,
                        title: 'ACCEPT',
                        onPressed: () {
                          assetsAudioPlayer.stop();
                          checkAvailability(context);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      child: TaxiOutlineButton(
                        color: BrandColors.colorGreen,
                        title: 'DECLINE',
                        onPressed: () {
                          assetsAudioPlayer.stop();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkAvailability(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          ProgressDialog(status: 'Accepting Request'),
    );

    DatabaseReference newRideRef = FirebaseDatabase.instance
        .reference()
        .child('drivers/${currentFirebaseUser.uid}/newTrip');

    newRideRef.once().then((DataSnapshot snapshot) {
      Navigator.pop(context);
      Navigator.pop(context);

      String thisRideID = '';
      if (snapshot.value != null) {
        thisRideID = snapshot.value.toString();
      } else {
        print('Thre was some error');
      }

      if (thisRideID == tripDetails.rideID) {
        newRideRef.set('accepted');
        HelperMethods.disableHomeTabLocationUpdates();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewTripPage(tripDetails: tripDetails)));
      } else if (thisRideID == 'canceled') {
        Toast.show("This Ride Has Been Canceled", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      } else if (thisRideID == 'timeout') {
        Toast.show("This Ride Has Timed Out", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      } else {
        Toast.show("Ride Not Found", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    });
  }
}
