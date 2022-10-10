import 'package:business_app/models/transaction.dart';
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
      for (var transaction in recentTransaction) {
        if (transaction.date.day == weekday.day &&
            transaction.date.month == weekday.month &&
            transaction.date.year == weekday.year) {
          totalSum += transaction.amount;
        }
      }
      return {'day': DateFormat.E().format(weekday), 'amount': totalSum};
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupedTransactionValues.map((data) {
          return Text(data[day] + ' : ' + data[amount]);
        }).toList(),
      ),
      //child: Row(children: [,]),
    );
  }
}
