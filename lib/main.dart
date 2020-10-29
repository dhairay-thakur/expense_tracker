import 'package:expense_tracker/widgets/chart.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
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
      title: "Personal Expenses",
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        accentColor: Colors.amber,
        fontFamily: 'OpenSans',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

final List<Transaction> _userTransactions = [
  Transaction(
    id: "t1",
    amount: 250,
    date: DateTime.now(),
    title: "test",
  ),
  Transaction(
    id: "t2",
    amount: 1300,
    date: DateTime.now(),
    title: "had sex",
  ),
  Transaction(
    id: "t3",
    amount: 250,
    date: DateTime.now(),
    title: "test1",
  ),
  Transaction(
    id: "t1",
    amount: 250,
    date: DateTime.now(),
    title: "test2",
  ),
  Transaction(
    id: "t1",
    amount: 250,
    date: DateTime.now(),
    title: "test3",
  ),
  Transaction(
    id: "t1",
    amount: 250,
    date: DateTime.now(),
    title: "test",
  ),
];
bool _showChart = false;

List<Transaction> get _recentTransactions {
  return _userTransactions.where((tx) {
    return tx.date.isAfter(
      DateTime.now().subtract(
        Duration(days: 7),
      ),
    );
  }).toList();
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  void _addNewTransaction(String newTitle, double newAmount, DateTime newDate) {
    final newTx = Transaction(
      title: newTitle,
      amount: newAmount,
      date: newDate != null ? newDate : DateTime.now(),
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text("Expense Tracker"),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );

    // since it is common in both prtrt and lndscp mode
    final txListWidget = Container(
      child: TransactionList(_userTransactions, _deleteTransaction),
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.74,
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (_isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Last Week Transactions"),
                  Switch(
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      })
                ],
              ),
            if (!_isLandscape)
              Container(
                child: Chart(_recentTransactions),
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.26,
              ),
            if (!_isLandscape) txListWidget,
            if (_isLandscape)
              _showChart
                  ? Container(
                      child: Chart(_recentTransactions),
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.65,
                    )
                  : txListWidget,
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
