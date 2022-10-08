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
      child: userTransaction.isEmpty
          ? Column(
              children: [
                Text(
                  "No transactions yet!",
                ),
                Image.asset('assets/images/waiting.png'),
              ],
            )
          : ListView.builder(
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
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          '\$${userTransaction[index].amount.toStringAsFixed(2)}',
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userTransaction[index].title.toString(),
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            DateFormat.yMMMd()
                                .format(userTransaction[index].date),
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
