import 'dart:math';
import 'package:business_app/widgets/chart.dart';
import 'package:business_app/widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Expenses',
      home: MyHomePage(),
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Colors.green,
              secondary: Colors.grey,
            ),
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          toolbarTextStyle: TextStyle(fontFamily: 'Quicksand'),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    Transaction(
      id: 1,
      title: 'Udemy course - Flutter',
      amount: 22.12,
      date: DateTime.parse('2022-10-10 11:05:47.352843'),
    ),
    Transaction(
      id: 2,
      title: 'Udemy course - JavaScript',
      amount: 34.12,
      date: DateTime.parse('2022-10-11 11:05:47.352843'),
    ),
    Transaction(
      id: 3,
      title: 'Spotify Subscription',
      amount: 20.23,
      date: DateTime.parse('2022-10-09 11:05:47.352843'),
    ),
    Transaction(
      id: 4,
      title: 'Frog shop',
      amount: 37.23,
      date: DateTime.parse('2022-10-07 11:05:47.352843'),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((element) {
      return element.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _addNewTransaction(String newTitle, double newAmount, DateTime newDate) {
    final newVal = Transaction(
      title: newTitle,
      amount: newAmount,
      date: newDate,
      id: Random().nextInt(100000),
    );
    setState(() {
      _userTransaction.add(newVal);
    });
  }

  void _deleteNewTransaction(int id) {
    setState(() {
      _userTransaction.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  void _addButtonAction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(
              addNewTransaction: _addNewTransaction,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Student Expenses',
          style: TextStyle(
            fontFamily: 'OpenSans',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              elevation: 6,
              child: Container(
                width: double.infinity,
                child: Chart(
                  recentTransaction: _recentTransactions,
                ),
              ),
            ),
            TransactionList(
              userTransaction: _userTransaction,
              deleteTransaction: _deleteNewTransaction,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () => _addButtonAction(context),
          child: const Icon(
            Icons.account_balance_wallet_outlined,
            color: Colors.white,
          )),
    );
  }
}
