import 'package:budgetory_v1/Controller/DB/transaction_db_f.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../DataBase/Models/ModalCategory/category_model.dart';
import '../../DataBase/Models/ModalTransaction/transaction_modal.dart';
import 'package:budgetory_v1/Controller/colors/color.dart';

class Tile extends StatelessWidget {
  Tile({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refreshUiTransaction();

    // ^Recent transaction tile------------->

    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.transactionListNotifier,
      // changed
      builder:
          (BuildContext context, List<TransactionModal> newList, Widget? _) {
        return MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: ListView.builder(
            itemCount: newList.length <= 4 ? newList.length : 4,
            itemBuilder: (context, index) {
              final newValue = newList[index];
              return Card(
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 9,
                      backgroundColor: newValue.type == CategoryType.income
                          ? colorId.lightGreen
                          : colorId.lightRed,
                    ),
                  ),
                  title: Text(newValue.notes),
                  subtitle: Text(DateFormat.yMMMMd().format(newValue.date)),
                  trailing: Text(newValue.amount.toString()),
                ),
              );
            },
          ),
        );
      },
    );
  }

  final colorId = ColorsID();
}
