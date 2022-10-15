import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction({required this.addNewTransaction});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _pickedDate;

  void _addNewData() {
    final newTitle = _titleController.text;
    final newAmount = double.parse(_amountController.text);
    final newDate = _pickedDate;
    print('bonk');
    if (newTitle.isEmpty || newAmount <= 0 || newDate == null) {
      return;
    }
    widget.addNewTransaction(newTitle, newAmount, newDate);
    Navigator.of(context).pop();
  }

  void _showDatePick() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((chosenData) {
      if (chosenData == null) {
        return;
      }
      setState(() {
        _pickedDate = chosenData;
      });
    });
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
            controller: _titleController,
            onSubmitted: (_) => _addNewData(), //i don't use val
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Amount'),
            controller: _amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _addNewData(), //i don't use val
          ),
          Container(
            height: 60,
            child: Row(
              children: [
                Text(_pickedDate == null
                    ? 'No Date Chosen!'
                    : DateFormat.yMMMd().format(_pickedDate as DateTime)),
                TextButton(
                    onPressed: _showDatePick,
                    child: const Text(
                      'Choose Date',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: _addNewData,
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Add Transaction',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
