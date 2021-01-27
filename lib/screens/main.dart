import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hoover_driver/globalvariables.dart';
import 'package:hoover_driver/screens/loginscreen.dart';
import 'package:hoover_driver/screens/mainpage.dart';
import 'package:hoover_driver/screens/registrationpage.dart';
import 'package:hoover_driver/screens/vehicleinfo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'db2',
    options: Platform.isIOS
        ? FirebaseOptions(
            appId: '1:192536061178:ios:ae8d8d1f07677696c75543',
            apiKey: 'AIzaSyCwN40u4S-ptB-0clf67AZIKAzRmYgQ8aY',
            projectId: 'hoover-8274a',
            messagingSenderId: '192536061178',
            databaseURL: 'https://hoover-8274a-default-rtdb.firebaseio.com',
          )
        : FirebaseOptions(
            appId: '1:192536061178:android:5d0bf3d3d5e8fd47c75543',
            apiKey: 'AIzaSyAMV5YSpC5NsTKeCLCMsA8xUE_mfTqleJ4 ',
            projectId: 'hoover-8274a',
            messagingSenderId: '192536061178',
            databaseURL: 'https://hoover-8274a-default-rtdb.firebaseio.com',
          ),
  );

  currentFirebaseUser = FirebaseAuth.instance.currentUser;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Brand-Regular ',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: (currentFirebaseUser == null) ? LoginPage.id : MainPage.id,
      routes: {
        MainPage.id: (context) => MainPage(),
        RegistrationPage.id: (context) => RegistrationPage(),
        VehicleInfoPage.id: (context) => VehicleInfoPage(),
        LoginPage.id: (context) => LoginPage(),
      },
    );
  }
}
