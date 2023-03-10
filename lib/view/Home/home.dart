// ignore_for_file: avoid_print

import 'package:budgetory_v1/Controller/DB/category_db_f.dart';
import 'package:budgetory_v1/Controller/DB/transaction_db_f.dart';
import 'package:budgetory_v1/Controller/colors/color.dart';
import 'package:budgetory_v1/Controller/provider/prv_transaction.dart';
import 'package:budgetory_v1/controller/filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../all_transaction_screen/home_screen/main_screen/filterd_trasnaction.dart';
import 'list_tile.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        Duration.zero, () => context.read<ProviderTransaction>().initState());

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 400.00,
                height: 300.00,
                decoration: BoxDecoration(
                  color: colorId.mainBlue,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.00, top: 75.00),
                child: ValueListenableBuilder(
                  valueListenable:
                      TransactionDB.instance.transactionListNotifier,
                  builder: (context, value, child) => Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: colorId.btnColor,
                    ),
                    width: 360.00,
                    height: 202.00,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  // ? balance section---------->
                                  Text(
                                    TransactionDB.instance
                                                .totalTransaction()[0] <
                                            0
                                        ? 'Lose'
                                        : 'Balance',
                                    style: GoogleFonts.lato(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 24.00,
                                        color: TransactionDB.instance
                                                    .totalTransaction()[0] <
                                                0
                                            ? colorId.red
                                            : colorId.lightGreen),
                                  ),

                                  amounts(0)
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 30.00, right: 35.00, left: 35.00),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: colorId.white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                            ),
                                            child: Icon(
                                              Icons.trending_up,
                                              color: colorId.lightGreen,
                                            ),
                                          ),
                                          // ?Income section----------------------->
                                          Text(' Income ',
                                              style: GoogleFonts.lato(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 24.00,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                      amounts(1)
                                    ],
                                  )
                                ],
                              ),
                              //?expense section ---------->
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: colorId.white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                            ),
                                            child: Icon(
                                              Icons.trending_down_rounded,
                                              color: colorId.red,
                                            ),
                                          ),
                                          Text(' Expense ',
                                              style: GoogleFonts.lato(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 24.00,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                      amounts(2)
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                      //*first column
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.00),
// ? view all button--->
// ^ Navigator---> ScreenAllT()---->
          Padding(
            padding: const EdgeInsets.only(left: 16.00, right: 10.00),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Transactions',
                  style: TextStyle(fontSize: 15.00),
                ),
                TextButton(
                  onPressed: () async {
                    Filter.instance
                        .filterTransactionFunction(customMonth: null);
                    TransactionDB().refreshUiTransaction();
                    CategoryDB.instance.refreshUI();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AllTransactionsNew(),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 13.00),
                    child: Text(
                      'View all',
                      style: TextStyle(fontSize: 15.00),
                    ),
                  ),
                )
              ],
            ),
          ),

// ?Recent  transactions
          Flexible(child: Tile())
        ],
      ),
    );
  }

  Text amounts(value) {
    return Text(
      TransactionDB.instance.totalTransaction()[value] == null
          ? '0.0'
          : TransactionDB.instance.totalTransaction()[value].toString(),
      style: TextStyle(
          fontWeight: FontWeight.w900, fontSize: 28.000, color: colorId.white),
    );
  }

  final colorId = ColorsID();
}

// !x x x x x  x x x x x x x x  x x x x x x x x x x x x x x x x x x x x x x x x x x x x  x x x x  x xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


