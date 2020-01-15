//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/expenseitementry.dart';

class ExpenseItem extends StatelessWidget {
  final ExpenseItemEntry itemEntry;

  ExpenseItem({
    @required this.itemEntry,
  });

  /* final DocumentSnapshot document;

  ExpenseItem({
    @required this.document,
  }); */

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              child: Text(
                ("\$${itemEntry.itemPrice.toStringAsFixed(2)}" /* document['expense amount'] */), // Fetched as input to ExpenseItem class constructor.
                style: TextStyle(
                  color: Theme.of(context)
                      .primaryColor, // Fetches primaryColor from the primarySwatch color scheme set at app-level
                  // in the "theme" attribute of MaterialApp widget.
                  // The of(context) method fetches the Theme state that is part of the context.
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2.5,
                ),
              ),
              padding: EdgeInsets.all(14.0),
              margin: EdgeInsets.all(10.0),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Text(
                    "${itemEntry.itemName}" /* document['expense name'] */,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    DateFormat.yMMMd().format(itemEntry
                        .purchaseDate /* document['transaction date'] */),
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
        ),
        //color: Colors.grey,
        elevation: 10,
        margin: EdgeInsets.all(8.0),
      ),
      padding: EdgeInsets.all(4.0),
      width: double.infinity,
      height: 100,
      //decoration: BoxDecoration(border: Border.all(width: 4.0)),
      //alignment: Alignment(0.0,0.0),
    );
  }
}
