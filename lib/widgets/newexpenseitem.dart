import 'package:flutter/material.dart';

class NewExpenseItem extends StatefulWidget { // Converted to StatefulWidget to retain text on the bottom sheet even after completion
                                              // of typing through digital keypad and also after adding the expense item to the 
                                              // scrollable list. 
                                              // Short cut for code refactoring/formatting: Ctrl+Shift+R 
                                              // (use ',' in the end of arg list for automatic code formatting)
  final Function newExpItemEventAction;

  NewExpenseItem({@required this.newExpItemEventAction});

  @override
  _NewExpenseItemState createState() => _NewExpenseItemState();
}

class _NewExpenseItemState extends State<NewExpenseItem> {
  final expenseNameController = TextEditingController();

  final expenseAmountController = TextEditingController();

  void newItemEventActionWrapper() {

    final expName = expenseNameController.text;
    final expAmtStr = expenseAmountController.text;
 
    // Check for some value entry in the fields
    if (expName.isEmpty || expAmtStr.isEmpty){
      return;
    } 
     
    final expAmt = double.parse(expAmtStr);

    // Check for converted value
    if(expAmt <= 0)
      return;

    widget.newExpItemEventAction(expName, expAmt,); // Attributes of Widget class are accessible in the corresponding State class 
                                                    // through "widget" keyword.
    Navigator.of(context).pop(); // To automatically close the bottom sheet after typing in the two fields.
                                 // Navigator tracks a widget state (so, probably used in a state class of a stateful widget ?) in a
                                 // stack and its state on the UI can be managed with stack operations like, push, pop.
                                 // It is a Stateful widget itself (maintains widget tree in a stack) with the "of" method to fetch the 
                                 // current stored state that is part of the widget "context" (created/maintained by flutter). Here, as
                                 // our goal is to automatically close the bottom sheet, pop() operation is being performed on the retrieved
                                 // state. 
                                 // ****Also, needs to be in the method that is tied to the FlatButton click enabling the add operation.                                          
  } 

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            FlatButton(
              child: Text(
                "Add Expense",
                style: TextStyle(color: Theme.of(context).primaryColor,),
              ),
              onPressed: newItemEventActionWrapper, // Flutter implicitly calls this wrapper method on button press.
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Expense Name",
                labelStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              controller: expenseNameController,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Expense Amount",
                labelStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              controller: expenseAmountController,
            ),
          ],
        ),
      ),
    );
  }
}
