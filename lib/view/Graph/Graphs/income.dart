// ignore_for_file: avoid_print

import 'package:budgetory_v1/Controller/DB/transaction_db_f.dart';
import 'package:budgetory_v1/Controller/provider/prv_graph_all.dart';
import 'package:budgetory_v1/Controller/provider/prv_graph_income.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../DataBase/Models/ModalTransaction/transaction_modal.dart';
import 'package:budgetory_v1/Controller/colors/color.dart';
import '../../../controller/filter_array.dart';
import '../../../controller/filter_controller.dart';

class Income extends StatelessWidget {
  Income({super.key});
//   @override
//   State<Income> createState() => _IncomeState();
// }

// class _IncomeState extends State<Income> {
  // String? timeDropValue;
  // List<TransactionModal> modalDummy = [];
  // var timeDropList = [
  //   'Today',
  //   'Monthly',
  // ];

  // @override
  // void initState() {
  //   TransactionDB.instance.refreshUiTransaction();
  //   modalDummy = TransactionDB.instance.IncomeNotifier.value;
  //   timeDropValue = 'Today';
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        Duration.zero, () => context.read<ProviderIncomeGraph>().initState());
    return Scaffold(
      body: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
              height: 30.000,
              decoration: BoxDecoration(
                  color: colorId.btnColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.only(left: 5, top: 4),
                child: DropdownButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: colorId.white,
                  ),
                  dropdownColor: colorId.btnColor,
                  borderRadius: BorderRadius.circular(20),
                  elevation: 0,
                  isDense: true,
                  underline: const SizedBox(),
                  value:
                      Provider.of<ProviderIncomeGraph>(context).timeDropValue,
                  items: Provider.of<ProviderIncomeGraph>(context)
                      .timeDropList
                      .map(
                    (String timeDropList) {
                      return DropdownMenuItem(
                        value: timeDropList,
                        child: SizedBox(
                          height: 40.00,
                          width: 60.00,
                          child: Text(
                            timeDropList,
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: colorId.white,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (value) {
                    Provider.of<ProviderIncomeGraph>(context)
                        .dropDownValueList(context: context, value: value);
                  },
                ),
              ),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.only(
              top: 100.00,
            ),
            child: ValueListenableBuilder(
              valueListenable: TransactionDB.instance.IncomeNotifier,
              builder: (BuildContext context, List<TransactionModal> newList,
                  Widget? _) {
                return Provider.of<ProviderIncomeGraph>(context, listen: false)
                        .modalDummy
                        .isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Image(
                                image: AssetImage('Assets/empty3.jpeg')),
                            Text(
                              "No Transactions Found",
                              style: TextStyle(color: colorId.veryLightGrey),
                            )
                          ],
                        ),
                      )
                    : SfCircularChart(
                        backgroundColor: colorId.white,
                        legend: Legend(isVisible: true),
                        series: <CircularSeries>[
                          // Render pie chart
                          DoughnutSeries<TransactionModal, String>(
                            dataSource: Provider.of<ProviderIncomeGraph>(
                                    context,
                                    listen: false)
                                .modalDummy,
                            xValueMapper: (TransactionModal data, _) =>
                                data.notes,
                            yValueMapper: (TransactionModal data, _) =>
                                data.amount.round(),
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true),
                            enableTooltip: true,
                          )
                        ],
                      );
              },
            ),
          )
        ],
      ),
    );
  }

// ^-------------------------------------------------------------------------------------------------------

  final filterArray = FilterArray();
  final colorId = ColorsID();
}
