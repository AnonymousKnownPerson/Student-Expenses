import 'package:flutter/material.dart';
import './new_transaction.dart';
import './transaction_list.dart';
import '../models/transaction.dart';

class UserTransaction extends StatefulWidget {
  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _userTransaction = [
    Transaction(
      id: 1,
      title: 'Udemy course - Flutter',
      amount: 22.12,
      date: DateTime.now(),
    ),
    Transaction(
      id: 2,
      title: 'Udemy course - JavaScript',
      amount: 34.12,
      date: DateTime.now(),
    ),
    Transaction(
      id: 3,
      title: 'Spotify Subscription',
      amount: 20.23,
      date: DateTime.now(),
    ),
    Transaction(
      id: 4,
      title: 'Frog shop',
      amount: 37.23,
      date: DateTime.now(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      NewTransaction(),
      TransactionList(
        userTransaction: _userTransaction,
      ),
    ]);
  }
}
