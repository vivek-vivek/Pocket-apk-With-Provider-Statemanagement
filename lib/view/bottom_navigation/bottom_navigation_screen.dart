import 'package:budgetory_v1/Controller/DB/category_db_f.dart';
import 'package:budgetory_v1/Controller/DB/transaction_db_f.dart';
import 'package:budgetory_v1/Controller/colors/color.dart';
import 'package:budgetory_v1/view/Add%20New2/add_new.dart';
import 'package:budgetory_v1/view/Graph/Index%20screen/graph_home.dart';
import 'package:budgetory_v1/view/Home/home.dart';
import 'package:budgetory_v1/view/category_screen/main_screen/category_home.dart';
import 'package:budgetory_v1/view/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final _controller = PageController();

  @override
  void initState() {
    TransactionDB.instance.refreshUiTransaction();
    CategoryDB.instance.refreshUI();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children:  [
          HomeScreen(),
          AddTransaction(),
          AllCategories(),
          HomeGraph(),
          UserPage()
        ],
      ),
      extendBody: true,
      bottomNavigationBar: RollingBottomBar(
        itemColor: Colors.white,
        color: colorId.mainBlue,
        activeItemColor: colorId.white,
        controller: _controller,
        flat: true,
        useActiveColorByDefault: true,
        items: const [
          RollingBottomBarItem(Icons.home),
          RollingBottomBarItem(Icons.add_circle_outline_rounded),
          RollingBottomBarItem(Icons.category),
          RollingBottomBarItem(Icons.bar_chart_rounded),
          RollingBottomBarItem(Icons.settings),
        ],
        enableIconRotation: true,
        onTap: (index) async {
          await CategoryDB.instance.refreshUI();
          await TransactionDB.instance.refreshUiTransaction();
          _controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
        },
      ),
    );
  }

  final colorId = ColorsID();
}
