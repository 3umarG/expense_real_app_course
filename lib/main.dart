import 'package:expense_max_real_app/Widgets/charts.dart';
import 'package:expense_max_real_app/Widgets/input_transaction.dart';
import 'package:expense_max_real_app/Widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Models/TransactionModel.dart';

void main() {
  // ----For Choose the Only Portrait Mode----

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.red,
        fontFamily: 'OpenSans',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
              bodyLarge: const TextStyle(
                fontFamily: 'OpenSans-Bold',
                fontSize: 25,
                color: Colors.pink,
              ),
            ),
        appBarTheme: AppBarTheme(
          titleTextStyle: ThemeData.light()
              .textTheme
              .copyWith(
                titleLarge: const TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 25,
                    color: Colors.white60,
                    fontWeight: FontWeight.bold),
              )
              .titleLarge,
        ),
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transaction = [
    //   Transaction(
    //     id: 1,
    //     title: "Task 1",
    //     amount: 39.55,
    //     date: DateTime.now(),
    //   ),
    //   Transaction(
    //     id: 2,
    //     title: "Task 2",
    //     amount: 89.22,
    //     date: DateTime.now(),
    //   ),
  ];
  var id = 0;

// To Return Transactions in the previos 7 days (week)
  Iterable<Transaction> get _recentTransaction {
    // Return all Transaction That Achieve the Condidtion
    return _transaction.where((trans) {
      return trans.date.isAfter(
        DateTime.now().subtract(
          const Duration(
            days: 7,
          ),
        ),
      );
    });
  }

  void _addNewTransaction(
    int id,
    String title,
    double amount,
    DateTime dateTime,
  ) {
    final trans = Transaction(
      id: id,
      title: title,
      amount: amount,
      date: dateTime,
    );
    setState(() {
      _transaction.add(trans);
    });
  }

  void _deleteTransaction(int id) {
    setState(() {
      _transaction.removeWhere((element) => element.id == id);
    });
  }

  void _showButtomSheet(context) {
    setState(() {
      showModalBottomSheet(
        context: context,
        builder: (newCtx) {
          return InputTransaction(
            addTranasaction: _addNewTransaction,
            id: id++,
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      title: const Text(
        "Expenses App",
      ),
      actions: [
        IconButton(
          onPressed: () => _showButtomSheet(context),
          icon: const Icon(
            Icons.add,
          ),
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.3,
              child: Charts(
                transactionList: _recentTransaction.toList(),
              ),
            ),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  (1.0 - 0.3),
              child: TransactionList(
                transaction: _transaction,
                deleteTrans: _deleteTransaction,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showButtomSheet(context),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
