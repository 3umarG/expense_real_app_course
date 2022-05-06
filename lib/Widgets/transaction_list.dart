import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Models/TransactionModel.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTrans;

  const TransactionList({
    required this.transaction,
    required this.deleteTrans,
  });
  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "No Transaction Yet",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Container(
                height: 200,
                child: Image.asset(
                  'lib/assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        : ListView.builder(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            itemCount: transaction.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          child: Text(
                            transaction[index].id.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 25,
                            ),
                          ),
                          radius: 25,
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              transaction[index].title,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              DateFormat.yMMMd()
                                  .format(transaction[index].date),
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            // const SizedBox(
                            //   height: 5,
                            // ),
                            Text(
                              "${transaction[index].amount.toStringAsFixed(2)} \$",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => deleteTrans(transaction[index].id),
                          icon: const Icon(
                            Icons.delete,
                          ),
                          color: Theme.of(context).errorColor,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            // children: transaction.map((transaction) {}).toList(),
          );
  }
}
