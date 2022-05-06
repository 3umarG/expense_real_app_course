import 'package:expense_max_real_app/Models/TransactionModel.dart';
import 'package:expense_max_real_app/Widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Charts extends StatelessWidget {
  // The Whole Transaction List
  final List<Transaction> transactionList;

  Charts({required this.transactionList});

  // To Get the List in Previos 7 Days .
  List<Map<String, Object>> get getTransactionList {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalAmountInTheDay = 0.0;
//      هتعمل مقارنة على كل ال Transaction عشان تجيب الي كانو في يوم واحد
      for (var i = 0; i < transactionList.length; i++) {
        if (transactionList[i].date.day == weekDay.day &&
            transactionList[i].date.month == weekDay.month &&
            transactionList[i].date.year == weekDay.year) {
          totalAmountInTheDay += transactionList[i].amount;
          break;
        }
      }
      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "amount": totalAmountInTheDay,
      };
    });
  }

  double get totalAmountInTheWeek {
    return getTransactionList.fold(0.0, (sum, element) {
      return sum += (element["amount"] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    getTransactionList;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        elevation: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: getTransactionList.map((e) {
            return ChartBar(
              label: e["day"] as String,
              spendingAmount: double.parse(e["amount"].toString()),
              spendingPercent: totalAmountInTheWeek == 0
                  ? 0
                  : (e['amount'] as double) / totalAmountInTheWeek,
            );
          }).toList(),
        ),
      ),
    );
  }
}
