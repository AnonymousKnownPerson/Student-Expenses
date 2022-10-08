import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransaction;

  TransactionList({required this.userTransaction});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 390,
      child: ListView.builder(
        itemBuilder: (contx, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 6,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.amber,
                      width: 2,
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.amber),
                    '\$${userTransaction[index].amount}',
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userTransaction[index].title.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      style: const TextStyle(color: Colors.grey),
                      DateFormat.yMMMd().format(userTransaction[index].date),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        itemCount: userTransaction.length,
      ),
    );
  }
}
