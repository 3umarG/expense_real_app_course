import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputTransaction extends StatefulWidget {
  final Function addTranasaction;
  var id;

  InputTransaction({required this.addTranasaction, required this.id});

  @override
  State<InputTransaction> createState() => _InputTransactionState();
}

class _InputTransactionState extends State<InputTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime datePicked = DateTime(2002);

  VoidCallback? addDataTran() {
    if (amountController.text.isEmpty) return null;
    final titleText = titleController.text;
    final amountText =
        amountController == null ? 0 : double.parse(amountController.text);
    if (titleText.isEmpty ||
        amountText <= 0 ||
        amountText.isNaN ||
        datePicked == DateTime(2002)) {
      return null;
    }
    setState(() {
      widget.id++;
      widget.addTranasaction(widget.id, titleText, amountText, datePicked);
      Navigator.pop(context);
      //return null;
    });
  }

  VoidCallback? _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) return;
      setState(() {
        datePicked = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: "Title",
              ),
              controller: titleController,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: "Amount",
              ),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => addDataTran,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      (datePicked == null || datePicked == DateTime(2002))
                          ? "No Date Choosen yet ...!!"
                          : DateFormat.yMd().format(datePicked),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  TextButton(
                    child: const Text(
                      "Choose Date",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    onPressed: _showDatePicker,
                  )
                ],
              ),
            ),
            ElevatedButton(
              child: const Text(
                "Compelete",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              onPressed: addDataTran,
            ),
          ],
        ),
      ),
    );
  }
}
