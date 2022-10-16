import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransaction;
  final Function deleteTransaction;

  TransactionList({
    required this.userTransaction,
    required this.deleteTransaction,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420,
      child: userTransaction.isEmpty
          ? Column(
              children: [
                const Text(
                  "No transactions yet!",
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                  height: 300,
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (contx, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        child: FittedBox(
                          child: Text(
                              '\$${userTransaction[index].amount.toStringAsFixed(2)}'),
                        ),
                      ),
                      title: Text(
                        userTransaction[index].title.toString(),
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        DateFormat.yMMMd().format(userTransaction[index].date),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () =>
                            deleteTransaction(userTransaction[index].id),
                      ),
                    ),
                  ),
                );
              },
              itemCount: userTransaction.length,
            ),
    );
  }
}
