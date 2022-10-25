import 'package:flutter/material.dart';
import '../model/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> userTransaction;
  final Function deleteTransaction;

  const TransactionList({
    super.key,
    required this.userTransaction,
    required this.deleteTransaction,
  });

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420,
      child: widget.userTransaction.isEmpty
          ? Column(
              children: [
                const Text(
                  "No transactions yet!",
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 300,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
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
                              '\$${widget.userTransaction[index].amount.toStringAsFixed(2)}'),
                        ),
                      ),
                      title: Text(
                        widget.userTransaction[index].title.toString(),
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        DateFormat.yMMMd()
                            .format(widget.userTransaction[index].date),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => widget.deleteTransaction(
                            widget.userTransaction[index].id),
                      ),
                    ),
                  ),
                );
              },
              itemCount: widget.userTransaction.length,
            ),
    );
  }
}
