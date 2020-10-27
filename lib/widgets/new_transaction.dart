import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void addTransaction() {
    final newTitle = titleController.text;
    final newAmount = double.parse(amountController.text);
    if (newTitle.isEmpty || newAmount <= 0) return;

    //"widget." is used to access properties of widget to which the state class belongs
    widget.addTx(
      titleController.text,
      double.parse(amountController.text),
    );

    //closes the bottomsheet one txn is added
    Navigator.of(context).pop();

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: titleController,
              //(_)because onsubmitted accepts a string but we dont need it. so _ means faltu argument rcvd
              onSubmitted: (_) => addTransaction(),
              decoration: InputDecoration(
                labelText: "Title",
              ),
            ),
            TextField(
              controller: amountController,
              onSubmitted: (_) => addTransaction(),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Amount",
              ),
            ),
            FlatButton(
              textColor: Color(0xff0081a7),
              onPressed: addTransaction,
              child: Text("Add Transaction"),
            ),
          ],
        ),
      ),
    );
  }
}
