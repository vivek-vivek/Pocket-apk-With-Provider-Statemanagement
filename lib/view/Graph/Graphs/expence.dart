import 'package:budgetory_v1/Controller/DB/transaction_db_f.dart';
import 'package:budgetory_v1/Controller/provider/prv_graph_exp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../DataBase/Models/ModalTransaction/transaction_modal.dart';
import 'package:budgetory_v1/Controller/colors/color.dart';
import '../../../controller/filter_array.dart';
import '../../all_transaction_screen/widgets/pop_up_transaction.dart';

class Expences extends StatelessWidget {
  Expences({super.key});

//   @override
//   State<Expences> createState() => _ExpencesState();
// }

// class _ExpencesState extends State<Expences> {
  // List<TransactionModal> modalDummyList = [];
  // String dropDownValue = 'Today';

  // var timeDropList = [
  //   'Today',
  //   'Monthly',
  // ];
  // @override
  // void initState() {
  //   modalDummyList = TransactionDB.instance.expenceNotifier.value;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
      Future.delayed(
        Duration.zero, () => context.read<ProviderGraphExpence>().initState());
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 110),
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                        color: colorId.btnColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: DropdownButton(
                      dropdownColor: colorId.btnColor,
                      borderRadius: BorderRadius.circular(20),
                      underline: const SizedBox(),
                      value: Provider.of<ProviderGraphExpence>(context)
                          .dropDownValue,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: colorId.white,
                      ),
                      items: Provider.of<ProviderGraphExpence>(context)
                          .timeDropList
                          .map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(
                              items,
                              style: TextStyle(color: colorId.white),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        Provider.of<ProviderGraphExpence>(context,listen: false)
                            .dropDownListItems(
                                context: context, newValue: newValue);
                      },
                    ),
                  ),
                ),
              ],
            ),
            ValueListenableBuilder(
              valueListenable: TransactionDB.instance.transactionListNotifier,
              builder: (BuildContext context, List<TransactionModal> newList,
                  Widget? _) {
                return Provider.of<ProviderGraphExpence>(context, listen: false)
                        .modalDummyList
                        .isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Image(
                                image: AssetImage('Assets/empty1.jpeg')),
                            Text(
                              "No Transactions Found",
                              style: TextStyle(color: colorId.grey),
                            )
                          ],
                        ),
                      )
                    : 
                    Padding(
                        padding: const EdgeInsets.only(bottom: 100),
                        child: SfCircularChart(
                          backgroundColor: colorId.white,
                          legend: Legend(isVisible: true),
                          series: <CircularSeries>[
                            // Render pie chart
                            DoughnutSeries<TransactionModal, String>(
                              dataSource:
                                  Provider.of<ProviderGraphExpence>(context)
                                      .modalDummyList,
                              xValueMapper: (TransactionModal data, _) =>
                                  data.notes,
                              yValueMapper: (TransactionModal data, _) =>
                                  data.amount.round(),
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true),
                              enableTooltip: true,
                            )
                          ],
                        ),
                      );
              },
            )
          ],
        ),
      ),
    );
  }

  final filterArray = FilterArray();
  final colorId = ColorsID();
  final popTransaction = PopUpTransaction();
}
