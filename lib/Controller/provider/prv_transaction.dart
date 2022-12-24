import 'dart:developer';

import 'package:budgetory_v1/Controller/DB/category_db_f.dart';
import 'package:budgetory_v1/Controller/DB/transaction_db_f.dart';
import 'package:budgetory_v1/Controller/colors/color.dart';
import 'package:budgetory_v1/DataBase/Models/ModalCategory/category_model.dart';
import 'package:budgetory_v1/DataBase/Models/ModalTransaction/transaction_modal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProviderTransaction with ChangeNotifier {
//  Non-Final variable
  DateTime? selectedDate;
  CategoryType selectedCategoryType = CategoryType.income;
  CategoryModel? selectedCategoryModel;
  String? categoryValue;

  /// Finalized Variable
  final notesController = TextEditingController();
  final amountController = TextEditingController();
  final dateController = TextEditingController();

  /// Class Objects
  final colorId = ColorsID();

  /// Init state fun
  void initState() {
    TransactionDB.instance.totalTransaction();
    CategoryDB.instance.refreshUI();
    TransactionDB.instance.refreshUiTransaction();
    notifyListeners();
  }

  /// Radio button form choosing Category type
  categoryRadioFun(CategoryType value) {
    selectedCategoryType = value;
    // categoryValue = null;
    log(selectedCategoryType.toString());
    notifyListeners();
  }

  /// Select date using a show datepicker widget
  /// setting the value as the selected value
  selectedDateFun({DateTime? selectedDateDUplicate}) {
    if (selectedDateDUplicate == null) {
      notifyListeners();
      return;
    } else {
      dateController.text = DateFormat.yMMMd().format(selectedDateDUplicate);
      selectedDate = selectedDateDUplicate;
      notifyListeners();
    }
  }

  /// Select category from the list of category
  selectCategoryFun(selectedValue) {
    categoryValue = selectedValue;
    notifyListeners();
  }

  Future<void> transactionAddButtons(context, formKey) async {
    TransactionDB.instance.refreshUiTransaction();
    if (notesController.text.isEmpty &&
        amountController.text.isEmpty &&
        (categoryValue == null || categoryValue!.isEmpty) &&
        (selectedDate == null) &&
        (selectedCategoryModel == null)) {
      const snackBar = SnackBar(content: Text('enter complete data!!!!'));
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      notifyListeners();
      return;
    } else {
      if (formKey.currentState!.validate()) {
        final parsedAmount = double.tryParse(amountController.text.trim());
        notifyListeners();
        final modelTransaction = TransactionModal(
            notes: notesController.text,
            amount: parsedAmount!,
            date: selectedDate!,
            type: selectedCategoryType,
            categoryTransaction: selectedCategoryModel!,
            id: DateTime.now().microsecondsSinceEpoch.toString());
        notifyListeners();
        await TransactionDB.instance.refreshUiTransaction();

        // ^clear controllers
        notesController.clear();
        amountController.clear();
        dateController.clear();
        notifyListeners();

        //  amount db function

        await TransactionDB.instance.addTransaction(modelTransaction);
        // await TransactionDB.instance.amountTransaction(pieAmount);
        final snackBar = SnackBar(
          content: Text(
            'Successfully transaction added',
            style: TextStyle(color: colorId.black),
          ),
          backgroundColor: (colorId.lightGreen),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        notifyListeners();
      }
    }
    notifyListeners();
  }

  dropD() {
    DropdownButton(
      // underline: Container(),
      hint: const Text('Select Category'),
      value: categoryValue,
      items: (selectedCategoryType == CategoryType.expense
              ? CategoryDB().expenseCategoryModelList
              : CategoryDB().incomeCategoryModelList)
          .value
          .map((e) {
        return DropdownMenuItem(
          value: e.id,
          child: Text(e.name),
          onTap: () {
            selectedCategoryModel = e;
            notifyListeners();
          },
        );
      }).toList(),
      onChanged: (selectedValue) {
        categoryValue = selectedValue;
        TransactionDB.instance.refreshUiTransaction();
        notifyListeners();
      },
    );
  }
}
