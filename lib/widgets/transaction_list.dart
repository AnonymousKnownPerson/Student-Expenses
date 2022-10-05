import 'package:business_app/widgets/user_transaction.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransaction;

  TransactionList({required this.userTransaction});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: userTransaction.map((t) {
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
                  '\$${t.amount}',
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.title.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    style: const TextStyle(color: Colors.grey),
                    DateFormat.yMMMd().format(t.date),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
