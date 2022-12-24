import 'package:budgetory_v1/Controller/DB/transaction_db_f.dart';
import 'package:flutter/foundation.dart';

import '../../DataBase/Models/ModalTransaction/transaction_modal.dart';

class ProviderGraphAll with ChangeNotifier {
  String dropDownValue = 'Today';
  Map<TransactionModal, double> dataMap = {};

  List<TransactionModal> pieData = [];
  List<TransactionModal> modalDummyList = [];

  var timeDropList = [
    'Today',
    'Monthly',
  ];

  void initState() {
    modalDummyList = TransactionDB.instance.transactionListNotifier.value;
    notifyListeners();
  }
}
