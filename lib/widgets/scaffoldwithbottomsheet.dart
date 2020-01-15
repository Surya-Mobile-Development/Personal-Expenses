// Standard Library
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

// User-defined
import './expensechart.dart';
import '../models/expenseitementry.dart';
import './expenseitem.dart';

class ScaffoldWithBottomSheet extends StatelessWidget {
  final List<ExpenseItemEntry> itemList;
  final Function addWithBottomSheetAction , generateItemList;

  ScaffoldWithBottomSheet({
    @required this.itemList,
    @required this.addWithBottomSheetAction,
    @required this.generateItemList,
  });

/*   // Method to pull up modal sheet from the bottom on button press to add new expense entry
void pullUpBottomModalSheet(BuildContext ctx){
  showModalBottomSheet(context: ctx, builder: (_) {
    return GestureDetector(child:NewExpenseItem(newExpItemEventAction: addNewItemAction), onTap: () {},);
  },
  useRootNavigator: true,
  elevation: 10,); // The '_' ignores the input build context argument given by 
                                                      // showModalBottomSheet method itself.
} */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: /* Theme.of(context).appBarTheme.textTheme.title, */ Text(
          "Personal Expenses",
          style: Theme.of(context).appBarTheme.textTheme.title,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Theme.of(context).appBarTheme.actionsIconTheme.color,
            ),
            onPressed: () => addWithBottomSheetAction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ExpenseChart(title: "Expense Chart"),
            //ExpenseItemManager(itemEntryList: _itemEntryList),
            Container(
              child: Column(
                // Expense item list
                children: <Widget>[
                  ...(generateItemList() /* itemList.map((itemEntryInList) {
        // The ... in the front is to unpack the resultant list items (from .toList() in the end) to individual items, as part of the parent widget list and not a sub-list.
        // itemEntryInList is only in the scope of map() input argument
        return ExpenseItem(
          itemEntry: itemEntryInList,
        );
      }).toList() */
                  )
                  /* StreamBuilder(
                      stream:
                          Firestore.instance.collection('expenses').snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData)
                          return const Text(
                              "Loading..."); // If no data in firestore collection return message
                        return ListView.builder(// else, return data in a list
                              itemExtent: 80.0,
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (context, index) => ExpenseItem(document: snapshot.data.documents[index]),
                            );
                      }) */,
                ],
                //mainAxisAlignment: MainAxisAlignment.start,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => addWithBottomSheetAction(context),
      ),
    );
  }
}
