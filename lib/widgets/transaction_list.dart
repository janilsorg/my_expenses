import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraints) {
                return Column(
                  children: <Widget>[
                    Text(
                      'No transactions added yet!',
                      style: Theme.of(context).textTheme.title,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset('assets/images/waiting.png',
                          fit: BoxFit.cover),
                    ),
                  ],
                );
              },
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: FittedBox(
                                child: Text('\$${transactions[index].amount}')),
                          ),
                        ),
                        title: Text(
                          transactions[index].title,
                          style: Theme.of(context).textTheme.title,
                        ),
                        subtitle: Text(DateFormat.yMMMd()
                            .format(transactions[index].date)),
                        trailing: MediaQuery.of(context).size.width > 450
                            ? FlatButton.icon(
                                onPressed: () => deleteTx(transactions[index].id),
                                icon: Icon(Icons.delete),
                                label: Text('Delete'),
                                textColor: Theme.of(context).errorColor,
                              )
                            : IconButton(
                                icon: Icon(Icons.delete),
                                color: Theme.of(context).errorColor,
                                onPressed: () =>
                                    deleteTx(transactions[index].id),
                              )),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
