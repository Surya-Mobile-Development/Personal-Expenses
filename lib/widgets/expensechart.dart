import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ExpenseChart extends StatelessWidget {
  // Will be evolved in near future to connect to a database(firebase) or local storage to extract stored data.
  final String title;

  ExpenseChart({@required this.title});

  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Align(
          child: Text(
            title, // Fetched as input to ExpenseItem class constructor.
            style: TextStyle(),
          ),
          alignment: Alignment.center,
        ),
        color: Colors.grey,
        elevation: 10,
        margin: EdgeInsets.all(8.0),
      ),
      padding: EdgeInsets.all(4.0),
      width: double.infinity,
      height: 50,
      //alignment: Alignment(0.0,0.0),
    );
  }
}
