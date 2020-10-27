import 'package:expense_tracker/widgets/transaction_list.dart';

import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import 'models/transaction.dart';

//primary colour - 0xff0081a7
//secondary color dark -  0xff002147
//secondary color light - 0xff80FFE8
//other swatch D64933

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expense Tracker",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

final List<Transaction> _userTransactions = [
  Transaction(
    id: "t1",
    amount: 250,
    date: DateTime.now(),
    title: "sex",
  ),
  Transaction(
    id: "t2",
    amount: 350,
    date: DateTime.now(),
    title: "sex again",
  ),
];

class _MyHomePageState extends State<MyHomePage> {
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  void _addNewTransaction(String newTitle, double newAmount) {
    final newTx = Transaction(
      title: newTitle,
      amount: newAmount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Card(
                child: Text(
                  "chart!!",
                  textAlign: TextAlign.center,
                ),
                color: Colors.blue,
              ),
            ),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
