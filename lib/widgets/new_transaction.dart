import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction({required this.addNewTransaction});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void addNewData() {
    final newTitle = titleController.text;
    final newAmount = double.parse(amountController.text);
    print('bonk');
    if (newTitle.isEmpty || newAmount <= 0) {
      return;
    }
    widget.addNewTransaction(
      newTitle,
      newAmount,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
            controller: titleController,
            onSubmitted: (_) => addNewData(), //i don't use val
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Amount'),
            controller: amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => addNewData(), //i don't use val
          ),
          TextButton(
            onPressed: addNewData,
            child: Text(
              'Add Transaction',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
