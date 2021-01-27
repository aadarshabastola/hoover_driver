import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hoover_driver/globalvariables.dart';
import 'package:hoover_driver/screens/brand_colors.dart';
import 'package:hoover_driver/screens/mainpage.dart';
import 'package:hoover_driver/widgets/TaxiButton.dart';

import 'main.dart';

class VehicleInfoPage extends StatelessWidget {
  static const String id = 'vehicleInfo';

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String title) {
    final snackbar = SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  var carModelController = TextEditingController();
  var carColorController = TextEditingController();
  var lisencePlateController = TextEditingController();

  void updateProfile(context) {
    String id = currentFirebaseUser.uid;

    DatabaseReference driverRef = FirebaseDatabase.instance
        .reference()
        .child('/drivers/$id/vehicle_details');

    Map map = {
      'car_color': carColorController.text,
      'car_model': carModelController.text,
      'lisence_number': lisencePlateController.text,
    };

    driverRef.set(map);

    Navigator.pushNamed(context, MainPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'images/logo.png',
                height: 110,
                width: 110,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 20, 30, 30),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'What will you be Driving?',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 25),
                    TextField(
                      controller: carModelController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Car Model',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 25),
                    TextField(
                      controller: carColorController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Color',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 25),
                    TextField(
                      controller: lisencePlateController,
                      maxLength: 8,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        counterText: '',
                        labelText: 'Lisence Plate Number',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TaxiButton(
                      title: 'PROCEED',
                      color: BrandColors.colorAccentPurple,
                      onPressed: () {
                        if (carModelController.text.length < 3) {
                          showSnackBar('Please Provide a Valid Car Model');
                          return;
                        }
                        if (carColorController.text.length < 3) {
                          showSnackBar('Please Provide a Valid Color');
                          return;
                        }
                        if (lisencePlateController.text.length < 5) {
                          showSnackBar('Please Provide a Valid Color');
                          return;
                        }

                        updateProfile(context);
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
