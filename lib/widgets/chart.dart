import '../models/transaction.dart';
import './chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Chart({required this.recentTransaction});

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;
      var totalTotalSum = 0.0;
      var percentage = 0.0;
      print(DateTime.now());
      for (var transaction in recentTransaction) {
        if (transaction.date.day == weekday.day &&
            transaction.date.month == weekday.month &&
            transaction.date.year == weekday.year) {
          totalSum += transaction.amount;
        }
        totalTotalSum += transaction.amount; //zła logika, poprawić później
      }
      percentage = totalSum / totalTotalSum;
      if (percentage.isNaN) percentage = 0.0;
      return {
        'day': DateFormat.E().format(weekday).substring(0, 3),
        'amount': totalSum,
        'percentage': percentage,
      };
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Expanded(
              child: ChartBar(
                label: data["day"].toString(),
                barAmount: data["amount"] as double,
                barAmountPercentage: data["percentage"] as double,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
