import 'package:flutter/material.dart';


//import './widgets/expenseitemmanager.dart';
import './widgets/expensechart.dart';
import './widgets/newexpenseitem.dart';
import './models/expenseitementry.dart';
import './widgets/expenseitem.dart';
import './widgets/scaffoldwithbottomsheet.dart';

void main() => runApp(PersonalExpenses());

class PersonalExpenses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PersonalExpensesState();
}

class _PersonalExpensesState extends State<PersonalExpenses> {
  final List<ExpenseItemEntry> _itemEntryList = [
    ExpenseItemEntry(
      itemId: 1,
      itemName: "Weekly Groceries",
      itemPrice: 10.99,
      purchaseDate: DateTime.now(),
    ),
    ExpenseItemEntry(
      itemId: 2,
      itemName: "Nike Shoes",
      itemPrice: 25.53,
      purchaseDate: DateTime.now(),
    ),
    ExpenseItemEntry(
      itemId: 3,
      itemName: "Medicines",
      itemPrice: 40.69,
      purchaseDate: DateTime.now(),
    ),
  ];

  var itemIdx = 4; // Tracks item-id

// Method to wire the user input from new expense item widget to the expense item list widget
  void _addNewExpenseItem(String newExpenseName, double newExpenseAmt) {
    print("Item name: $newExpenseName, Expense Amount: $newExpenseAmt");
    final ExpenseItemEntry newExpItem = ExpenseItemEntry(
      itemName: newExpenseName,
      itemPrice: newExpenseAmt,
      purchaseDate: DateTime.now(),
      itemId: itemIdx++,
    ); // Converted DateTime object to string and parsed to fetch an int

    setState(() {
      //_itemEntryList.add(newExpItem);
      _itemEntryList.insert(0, newExpItem);
    });
  }

// Method to pull up modal sheet from the bottom on button press to add new expense entry
  void _pullUpBottomModalSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: NewExpenseItem(newExpItemEventAction: _addNewExpenseItem),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
      useRootNavigator: true,
      elevation: 10,
    ); // The '_' ignores the input build context argument given by
    // showModalBottomSheet method itself.
  }

  List<ExpenseItem> _generateExpenseItemList() {
    return _itemEntryList.map((itemEntryInList) {
      // The ... in the front is to unpack the resultant list items (from .toList() in the end) to individual items, as part of the parent widget list and not a sub-list.
      // itemEntryInList is only in the scope of map() input argument
      return ExpenseItem(
        itemEntry: itemEntryInList,
      );
    }).toList();
  }
/* 
  Widget _generateExpenseItemList() {
    return StreamBuilder(
        stream: Firestore.instance.collection('expenses').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text("Loading..."); // If no data in firestore collection return message
          return ListView.builder( // else, return data in a list

          );
        });
  } */

  Widget build(BuildContext context) {
    return MaterialApp(
      // With the Scaffold widget holding the modal bottom sheet, there was an issue with MediaQuery widget not being available through the
      // ancestral context. So, split it up in to a separate widget. Other pieces of code seemd to be in place apart from the widget hierarchy
      // between MaterialApp (supposedly adds the MediaQuery widget) and Scaffold giving them different contexts.
      home: ScaffoldWithBottomSheet(
        itemList: _itemEntryList,
        addWithBottomSheetAction: _pullUpBottomModalSheet,
        generateItemList: _generateExpenseItemList,
      ),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Montserrat',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: 'Xpressive',
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    color: ThemeData.dark()
                        .accentColor, // To be used for the text styling in the appBar of Scaffold widget
                  ),
                ),
            actionsIconTheme: IconThemeData(
                color: ThemeData.dark()
                    .accentColor) // To be used as the appBar actions button color
            ),
      ),
    ); // ThemeData settings are at the app-level.
    // Other widgets in the widget tree can use the app-level settings in a generic way.
    // That way, changes can only be done here in one place with widgets re-painted and
    // changes reflected automatically through out the application.
    // The .of(context) can be used to fetch the desired state, like Theme, Navigator etc.
    // and then another '.' notation to access respective attributes/properties.
    // accentColor setting to be used in combination with primarySwatch, as fallback color.
  }
}
