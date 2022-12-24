import 'package:budgetory_v1/Controller/filter_array.dart';
import 'package:budgetory_v1/Controller/filter_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../DataBase/Models/ModalTransaction/transaction_modal.dart';
import '../DB/transaction_db_f.dart';
import '../colors/color.dart';

class ProviderIncomeGraph with ChangeNotifier {
  String? timeDropValue;
  List<TransactionModal> modalDummy = [];
  var timeDropList = [
    'Today',
    'Monthly',
  ];

  final colorId = ColorsID();
  final filterArray = FilterArray();

  void initState() {
    TransactionDB.instance.refreshUiTransaction();
    modalDummy = TransactionDB.instance.IncomeNotifier.value;
    timeDropValue = 'Today';
  }

  dropDownValueList({value, context}) {
    timeDropValue = value!;
    if (timeDropValue == filterArray.timeDropList[0]) {
      modalDummy = Filter.instance.incomeTodayNotifier.value;
      notifyListeners();
    }
    // ^month picker

    else if (timeDropValue == filterArray.timeDropList[1]) {
      showDialog(
        context: context,
        builder: (ctx) {
          return SimpleDialog(
            children: [
              Container(
                width: 300.00,
                height: 234.00,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: GridView.builder(
                  itemCount: filterArray.monthList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (context, index) {
                    final i = index;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: colorId.btnColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: TextButton(
                          onPressed: () async {
                            final customMonth = filterArray.newMonthList[i];

                            Filter.instance.filterTransactionFunction(
                                customMonth: customMonth);

                            modalDummy =
                                Filter.instance.incomeMonthlyNotifier.value;
                            notifyListeners();
                            Navigator.of(ctx).pop();
                          },
                          child: Text(
                            filterArray.monthList[index],
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: colorId.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        },
      );
    }
  }
}
