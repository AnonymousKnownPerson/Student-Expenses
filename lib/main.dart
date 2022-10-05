import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import './transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transaction = [
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Business App'),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            elevation: 6,
            child: Container(
              width: double.infinity,
              child: const Text("Chart"),
            ),
          ),
          Card(
            elevation: 5,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(children: const [
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                ),
                TextButton(
                  onPressed: null,
                  child: Text(
                    'Add Transaction',
                    style: TextStyle(color: Colors.amber),
                  ),
                ),
              ]),
            ),
          ),
          Column(
            children: transaction.map((t) {
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
          )
        ],
      ),
    );
  }
}
