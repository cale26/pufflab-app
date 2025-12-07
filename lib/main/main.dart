import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project1/AdminNewOrder.dart';
import 'package:project1/addReview.dart';
import 'package:project1/adminViewReview.dart';
import 'package:project1/orderConfirmation.dart';
//import 'package:project1/reviewHistory.dart';

import 'firebase_options.dart';
//user file
import 'package:project1/OrderSummary.dart';
import 'package:project1/create_profile_account.dart';
import 'package:project1/homepage.dart';
import 'package:project1/profile.dart';
import 'login.dart';
import 'new_account.dart';
import 'home.dart';

import 'userMenu.dart';
import 'payment.dart';
import 'contact.dart';
//import 'addReview.dart';

//admin file
import 'package:project1/upload_area.dart';
import 'personal_details_page.dart';
import 'AddProductPage.dart';
import 'adminMainPage.dart';
import 'cloudHomePage.dart';
import 'orderStatus.dart';
import 'orderCompleted.dart';
import 'loginAdmin.dart';
import 'editProduct.dart';

//import 'AdminViewMenu.dart';
//import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title', // Add your app title here
      theme: ThemeData(
        primarySwatch: Colors.blue, // Customize your theme here
      ),
      home: HomepageScreen(), // Set the initial screen
      routes: {
        'homepage': (context) => const HomepageScreen(),
        'home': (context) => Home(),
        'Login': (context) => Login(),
        'NewAccount': (context) => NewAccount(),
        'profilePage': (context) => const ProfilePage(),
        'personalDetailsPage': (context) => const PersonalDetailsPage(),
        'createAcc': (context) => CreateProfileAccount(),
        'OrderSummaryPage': (context) => OrderSummaryPage(),
        'uploadArea': (context) => UploadArea(),
        'ProductCatalogPage': (context) => ProductCatalogPage(),
        'adminMainPage': (context) => AdminMainPage(),
        'UserMenuPage': (Context) => UserMenuPage(),
        'LoginAdminPage': (context) => LoginAdminPage(),
        'OrderStatusPage': (context) => OrderStatus(),
        'OrderCompleted': (Contect) => OrderCompleted(),
        'payment': (context) => PaymentPage(),
        'AdminViewReview': (context) => AdminViewReview(),
        'NewOrderPage': (context) => NewOrderPage(),
        'ContactPage': (context) => ContactPage(),
        'AdminAddOrder': (context) => AddProductPage(),
        'addReview': (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments as Map;
          final orderDetails = arguments['orderDetails'];
          final userEmail = arguments['userEmail'];
          return AddReviewPage(
              orderDetails: orderDetails, userEmail: userEmail);
        },
        'OrderConfirmation': (context) => OrderConfirmationPage(
              orders: ModalRoute.of(context)!.settings.arguments
                  as List<Map<String, dynamic>>,
            ),
        'EditProductPage': (context) => EditProductPage(
              productId: '',
              productData: {},
            ),
      },
    );
  }
}
