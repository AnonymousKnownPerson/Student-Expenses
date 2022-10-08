import 'package:flutter/material.dart';
import './user_transaction.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function addNewTransaction;

  NewTransaction({required this.addNewTransaction});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Title'),
            controller: titleController,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Amount'),
            controller: amountController,
          ),
          TextButton(
            onPressed: () {
              addNewTransaction(
                titleController.text,
                double.parse(amountController.text),
              );
            },
            child: const Text(
              'Add Transaction',
              style: TextStyle(color: Colors.amber),
            ),
          ),
        ]),
      ),
    );
  }
}
