import 'package:budgetory_v1/Controller/DB/transaction_db_f.dart';
import 'package:budgetory_v1/Controller/filter_array.dart';
import 'package:budgetory_v1/controller/filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../DataBase/Models/ModalTransaction/transaction_modal.dart';
import '../colors/color.dart';

class ProviderGraphExpence with ChangeNotifier {
  List<TransactionModal> modalDummyList = [];
  String dropDownValue = 'Today';

  var timeDropList = [
    'Today',
    'Monthly',
  ];

  void initState() {
    modalDummyList = TransactionDB.instance.expenceNotifier.value;
  }

  final filterArray = FilterArray();
  final colorId = ColorsID();

  dropDownListItems({newValue, context}) {
    dropDownValue = newValue!;
    if (dropDownValue == timeDropList[0]) {
      Filter.instance.filterTransactionFunction();

      modalDummyList = Filter.instance.expenceTodayNotifier.value;
      notifyListeners();
    } else if (dropDownValue == timeDropList[1]) {
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
                            modalDummyList =
                                Filter.instance.expenceMonthlyNotifier.value;
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
    notifyListeners();
  }
}
