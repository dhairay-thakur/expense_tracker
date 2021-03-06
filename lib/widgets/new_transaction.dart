import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _addTransaction() {
    if (_amountController.text.isEmpty) return;
    final newTitle = _titleController.text;
    final newAmount = double.parse(_amountController.text);
    if (newTitle.isEmpty || newAmount <= 0) return;

    //"widget." is used to access properties of widget to which the state class belongs
    widget.addTx(_titleController.text, double.parse(_amountController.text),
        _selectedDate);

    //closes the bottomsheet one txn is added
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).orientation == Orientation.landscape
          ? EdgeInsets.all(0)
          : MediaQuery.of(context).viewInsets,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _titleController,
                //(_)because onsubmitted accepts a string but we dont need it. so _ means faltu argument rcvd
                //onSubmitted: (_) => _addTransaction, - submits on pressing enter
                textInputAction: TextInputAction
                    .next, // this along with next line moves to next focusable field on pressing enter
                onSubmitted: (_) => FocusScope.of(context)
                    .nextFocus(), // this line also required after previous
                decoration: InputDecoration(
                  labelText: "Title",
                ),
              ),
              TextField(
                controller: _amountController,
                onSubmitted: (_) => _addTransaction(),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Amount",
                ),
              ),
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime.now())
                            .then((pickedDate) {
                          setState(() {
                            _selectedDate = pickedDate;
                          });
                        });
                      },
                      child: Text(
                        _selectedDate == null
                            ? DateFormat.yMMMd().format(DateTime.now())
                            : DateFormat.yMMMd().format(_selectedDate),
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              FlatButton(
                textColor: Colors.black,
                color: Theme.of(context).accentColor,
                onPressed: _addTransaction,
                child: Text(
                  "Add Transaction",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
