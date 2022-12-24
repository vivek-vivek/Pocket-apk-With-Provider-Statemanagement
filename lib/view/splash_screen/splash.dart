import 'package:budgetory_v1/Controller/DB/transaction_db_f.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import '../bottom_navigation/bottom_navigation_screen.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //  CategoryDB.instance.refreshUI();
    TransactionDB.instance.totalTransaction();
    TransactionDB.instance.refreshUiTransaction();
    return SplashScreenView(
      navigateRoute: const BottomNavigationScreen(),
      duration: 5000,
      imageSize: 130,
      imageSrc: 'Assets/logo.png',
      backgroundColor: Colors.white,
    );
  }
}
