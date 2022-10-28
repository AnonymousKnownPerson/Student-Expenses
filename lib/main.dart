import 'dart:math';
import 'package:business_app/widget/chart.dart';
import 'package:business_app/widget/new_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'db/transaction_database.dart';
import 'widget/transaction_list.dart';
import 'model/transaction.dart';
import 'package:getwidget/getwidget.dart';

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
  List<Transaction> _userTransaction = [];
  bool _isLoading = false;

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
    setState(() => _isLoading = true);
    _userTransaction = await TransactionDatabase.instance.readAllTransactions();
    setState(() => _isLoading = false);
  }

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((element) {
      return element.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  bool _showChart = false;

  Future _addNewTransaction(
    String newTitle,
    double newAmount,
    DateTime newDate,
  ) async {
    final newVal = Transaction(
      title: newTitle,
      amount: newAmount,
      date: newDate,
    );
    await TransactionDatabase.instance.create(newVal);
    refreshTransactions();
  }

  Future _deleteNewTransaction(
    int id,
  ) async {
    await TransactionDatabase.instance.delete(id);
    refreshTransactions();
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
        child: !_isLoading
            ? Column(
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
              )
            : const Positioned.fill(
                child: Center(child: GFLoader()),
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
