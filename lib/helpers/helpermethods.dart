import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:hoover_driver/datamodels/directiondetails.dart';
import 'package:hoover_driver/helpers/requesthelper.dart';
import 'package:hoover_driver/widgets/ProgressDialog.dart';

import '../globalvariables.dart';

class HelperMethods {
  static Future<DirectionDetails> getDirectionDetails(
      LatLng startPosition, LatLng endPosition) async {
    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${startPosition.latitude},${startPosition.longitude}&destination=${endPosition.latitude},${endPosition.longitude}&mode=driving&key=$mapKey';
    var response = await RequestHelper.getRequest(url);

    if (response == 'Failed') {
      return null;
    }

    DirectionDetails directionDetails = DirectionDetails();
    directionDetails.durationText =
        response['routes'][0]['legs'][0]['duration']['text'];
    directionDetails.durationValue =
        response['routes'][0]['legs'][0]['duration']['value'];

    directionDetails.distanceText =
        response['routes'][0]['legs'][0]['distance']['text'];
    directionDetails.distanceValue =
        response['routes'][0]['legs'][0]['distance']['value'];

    directionDetails.encodedPoints =
        response['routes'][0]['overview_polyline']['points'];

    return directionDetails;
  }

  static int estimateFares(DirectionDetails details, int durationValue) {
    //mile = 1.1
    //min = 0.3
    //base = 5
    double baseFare = 3;
    double distanceFare = details.distanceValue / 1000 * 1.1;
    double durationFare = durationValue / 60 * 0.3;

    double totalFare = baseFare + distanceFare + durationFare;

    return totalFare.truncate();
  }

  static double generateRandomNumber(int max) {
    var randomNumberGenerator = Random();
    int randInt = randomNumberGenerator.nextInt(max);

    return randInt.toDouble();
  }

  static void disableHomeTabLocationUpdates() {
    homeTabPositionStream.pause();
    Geofire.removeLocation(currentFirebaseUser.uid);
  }

  static void enableHomeTabLocationUpdates() {
    homeTabPositionStream.resume();
    Geofire.setLocation(currentFirebaseUser.uid, currentPosition.latitude,
        currentPosition.longitude);
  }

  static void showProgressDialog(context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(status: 'Just a Bit..'),
    );
  }
}
