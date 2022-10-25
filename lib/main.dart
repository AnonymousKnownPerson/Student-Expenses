import 'dart:math';
import 'package:business_app/widget/chart.dart';
import 'package:business_app/widget/new_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'db/transaction_database.dart';
import 'widget/transaction_list.dart';
import 'model/transaction.dart';

void main() {
  /*
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  */
  runApp(MyApp());
}

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
        appBarTheme: const AppBarTheme(
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
  /*final List<Transaction> _userTransaction = [
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
  ];*/
  List<Transaction> _userTransaction = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshTransactions();
  }

  @override
  void dispose() {
    TransactionDatabase.instance.close();
    super.dispose();
  }

  Future refreshTransactions() async {
    setState(() => isLoading = true);
    _userTransaction = await TransactionDatabase.instance.readAllTransactions();
    setState(() => isLoading = false);
  }

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((element) {
      return element.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  bool _showChart = false;

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
    final appBar = AppBar(
      title: const Text(
        'Student Expenses',
        style: TextStyle(
          fontFamily: 'OpenSans',
        ),
      ),
      centerTitle: true,
    );
    final mainHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: mainHeight * 0.1,
              child: Row(
                children: [
                  const Text('Show Chart'),
                  Switch(
                    value: _showChart,
                    activeColor: Theme.of(context).colorScheme.primary,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  ),
                ],
              ),
            ),
            _showChart
                ? SizedBox(
                    height: mainHeight * 0.25,
                    child: Chart(
                      recentTransaction: _recentTransactions,
                    ),
                  )
                : Container(),
            SizedBox(
              height: _showChart ? mainHeight * 0.65 : mainHeight * 0.90,
              child: TransactionList(
                userTransaction: _userTransaction,
                deleteTransaction: _deleteNewTransaction,
              ),
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
