// ignore_for_file: avoid_print, use_build_context_synchronously
import 'package:budgetory_v1/Controller/DB/category_db_f.dart';
import 'package:budgetory_v1/Controller/DB/transaction_db_f.dart';
import 'package:budgetory_v1/Controller/colors/color.dart';
import 'package:budgetory_v1/Controller/provider/prv_transaction.dart';
import 'package:budgetory_v1/DataBase/Models/ModalCategory/category_model.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../category_screen/widgets/pop_up_btn_category_radio.dart';

class AddTransaction extends StatelessWidget {
  AddTransaction({super.key});

//   @override
//   State<AddTransaction> createState() => _AddTransactionState();
// }

// class _AddTransactionState extends State<AddTransaction> {

  // ^Global keys--------->
  final formKey = GlobalKey<FormState>();
  // ^*********************^

// //*setting up default radio selection
//   @override
//   void initState() {
//     _selectedCategoryType = CategoryType.income;
//     CategoryDB().refreshUI();
//     TransactionDB.instance.refreshUiTransaction();
//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    final OfPrvTrans = Provider.of<ProviderTransaction>(context, listen: false);
    // Future.delayed(
    //     Duration.zero, () => context.read<ProviderTransaction>().initState());
    CategoryDB.instance.refreshUI();
    TransactionDB.instance.refreshUiTransaction();
    // ?colors class
    final colorId = ColorsID();
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 100.00, right: 30.00, left: 30.00),
            child: ListView(
              children: [
                // ^ main container------->
                Column(
                  children: [
                    //^ radio button----------->
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // ^ income radio------------>
                        Radio(
                          value: CategoryType.income,
                          groupValue: Provider.of<ProviderTransaction>(
                            context,
                          ).selectedCategoryType,
                          onChanged: (value) {
                            OfPrvTrans.categoryRadioFun(value!);
                          },
                        ),
                        const Text("Income"),
                        // ^Expenses radio btn start---->
                        Radio(
                            value: CategoryType.expense,
                            groupValue: Provider.of<ProviderTransaction>(
                              context,listen: false
                            ).selectedCategoryType,
                            onChanged: (value) {
                              OfPrvTrans.categoryRadioFun(value!);
                            }),
                        const Text("Expense"),
                      ],
                    ),
                    const SizedBox(height: 30.00),

                    //^calender----------------->

                    TextFormField(
                      controller: OfPrvTrans.dateController,
                      decoration: InputDecoration(
                        hintText: 'Date',
                        // _selectedDate == null
                        //     ? 'Select Date'
                        //     : DateFormat.yMMMMd().format(_selectedDate!)
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: colorId.black), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      //?-------------------------------------
                      onTap: (() async {
                        final selectedDateDUplicate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now()
                              .subtract(const Duration(days: 365)),
                          lastDate: DateTime.now(),
                        );
                        OfPrvTrans.selectedDateFun(
                            selectedDateDUplicate: selectedDateDUplicate);
                      }),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'choose date';
                        } else {
                          return null;
                        }
                      },
                      // ?---------------------------------------
                    ),
                    const SizedBox(height: 30.00),
                    //^ category , Add btn --------------->
                    Container(
                      width: 500.00,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        border: Border.all(),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.00),
                            child: SizedBox(
                              child: DropdownButton(
                                underline: Container(),
                                hint: const Text('Select Category'),
                                value: OfPrvTrans.categoryValue,
                                items: (OfPrvTrans.selectedCategoryType ==
                                            CategoryType.expense
                                        ? CategoryDB().expenseCategoryModelList
                                        : CategoryDB().incomeCategoryModelList)
                                    .value
                                    .map((e) {
                                  return DropdownMenuItem(
                                    value: e.id,
                                    child: Text(e.name),
                                    onTap: () {
                                      OfPrvTrans.selectedCategoryModel = e;
                                      print("🪦${e.name}");
                                    },
                                  );
                                }).toList(),
                                onChanged: (selectedValue) {
                                  OfPrvTrans.selectCategoryFun(selectedValue);
                                },
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () => popUpCaBtnCategoryRadio(
                                  context: context,
                                  selectedTypeCat:
                                      OfPrvTrans.selectedCategoryType),
                              icon:
                                  const Icon(Icons.add_circle_outline_outlined))
                        ],
                      ),
                    ),
                    const SizedBox(height: 30.00),
                    //^notes--------------------->
                    TextFormField(
                      maxLength: 10,
                      controller: OfPrvTrans.notesController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: 'Note',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: colorId.black), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a Note';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.00),
                    //^Amount--------------------->
                    TextFormField(
                      maxLength: 10,
                      controller: OfPrvTrans.amountController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Amount',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: colorId.black),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Amount ';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 10.00),
                    //^add transaction button---------------->
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            OfPrvTrans.transactionAddButtons(context, formKey);
                          }
                        },
                        style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 14, 58, 97)),
                        child: const Text("Add Transactions"),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  final colorId = ColorsID();
}
