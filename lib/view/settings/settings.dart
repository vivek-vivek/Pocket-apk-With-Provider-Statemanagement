// ignore_for_file: avoid_print

import 'package:budgetory_v1/Controller/DB/category_db_f.dart';
import 'package:budgetory_v1/Controller/DB/transaction_db_f.dart';
import 'package:budgetory_v1/view/settings/about_us.dart';
import 'package:budgetory_v1/view/settings/privacy_policey.dart';
import 'package:budgetory_v1/view/settings/terms.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:budgetory_v1/Controller/colors/color.dart';
import '../splash_screen/splash.dart';

class UserPage extends StatelessWidget {
  UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: colorId.grey),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: ListTile(
                  title: Text(
                    "About Us",
                    style: TextStyle(color: colorId.btnColor),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AboutUs()));
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: colorId.grey),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: ListTile(
                  title: Text(
                    "Privacy Policy",
                    style: TextStyle(color: colorId.btnColor),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PrivacyPolices()));
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: colorId.white,
                  border: Border.all(color: colorId.grey),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: ListTile(
                  title: Text("Terms & Conditions",
                      style: TextStyle(color: colorId.btnColor)),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TermsAndCondition()));
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: colorId.white,
                  border: Border.all(color: colorId.grey),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: ListTile(
                  trailing: const Icon(Icons.restart_alt_outlined),
                  title: Text("Reset app",
                      style: TextStyle(color: colorId.btnColor)),
                  onTap: () {
                    newMethod(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 300),
                child: Text(
                  "version 1.0",
                  style: TextStyle(color: colorId.grey),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  newMethod(BuildContext context) async {
    showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          children: [
            Center(
              child: Text(
                "Dou want to Reset App?",
                style: GoogleFonts.lato(
                    color: colorId.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () async {
                    await CategoryDB.instance.deleteDBAll();
                    await TransactionDB.instance.deleteDBAll();

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>  SplashScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "reset",
                    style: GoogleFonts.lato(
                        color: colorId.red,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "cancel",
                    style: GoogleFonts.lato(
                        color: colorId.lightGreen,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }

  final colorId = ColorsID();

  clear() async {
    TransactionDB.instance.totalListNotifier.value.clear();
    TransactionDB.instance.totalListNotifier.notifyListeners();

    TransactionDB.instance.incomeTotalListNotifier.value.clear();
    TransactionDB.instance.incomeTotalListNotifier.notifyListeners();

    TransactionDB.instance.expenceTotalListNotifier.value.clear();
    TransactionDB.instance.expenceTotalListNotifier.notifyListeners();
  }
}
