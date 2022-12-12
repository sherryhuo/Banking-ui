import 'package:flutter/material.dart';
import 'Persons.dart';

void main() => runApp(InsertDataTable());

class InsertDataTable extends StatefulWidget {
  @override
  _InsertDataTableState createState() => new _InsertDataTableState();
}

class _InsertDataTableState extends State<InsertDataTable> {
  List<Persons> PersonsLst = <Persons>[];

// create variables for text boxes
  final formKey = new GlobalKey<FormState>();
  var ID_Controller = new TextEditingController();
  var Account_Controller = new TextEditingController();
  var To_Controller = new TextEditingController();
  var Money_Controller = new TextEditingController();
  var Name_Controller = new TextEditingController();
  var LastName_Controller = new TextEditingController();
  var Time_Controller = new TextEditingController();

  var more = ElevatedButton(
      onPressed: () {
        builder:
        (BuildContext context) {
          return SizedBox(
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text('GeeksforGeeks'),
                ],
              ),
            ),
          );
        };
      },
      child: const Text('showModalBottomSheet'));
  var lastID = 0;

  @override
  void initState() {
    super.initState();
    lastID++;
    ID_Controller.text = lastID.toString();
  }

  refreshList() {
    setState(() {
      ID_Controller.text = lastID.toString();
    });
  }

// Validate function creates entry for the table
  validate() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      String ID = ID_Controller.text;
      String A = Account_Controller.text;
      String name = Name_Controller.text;
      String M = Money_Controller.text;
      String LastName = LastName_Controller.text;
      int timestamp = DateTime.now().millisecondsSinceEpoch;
      if (PersonsLst.every((element) => element.account.toString() != A)) {
        ElevatedButton el = more;
        print(timestamp); //output: 1638592424384
        int ts = 1638592424384;
        DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(timestamp);
        String datetime = tsdate.year.toString() +
            "/" +
            tsdate.month.toString() +
            "/" +
            tsdate.day.toString() +
            " " +
            tsdate.hour.toString() +
            ":" +
            tsdate.minute.toString();
        print(datetime); //output: 2021/12/4
        String T = datetime;
        Persons p = Persons(int.parse(ID), name.toString(), LastName.toString(),
            int.parse(A), T.toString(), double.parse(M), el);
        PersonsLst.add(p);
        lastID++;
      }

      refreshList();
      /*   To_Controller.text = " ";
      Account_Controller.text = " ";
      Money_Controller.text = " ";
      LastName_Controller.text = " ";
      Name_Controller.text = " ";*/
    }
  }

// Deposite allows for each entry to gain money in balance
  deposite() {
    String A = Account_Controller.text;
    String M = Money_Controller.text;
    PersonsLst.forEach((element) {
      if (element.account.toString() == A)
        element.money = element.money + double.parse(M);
    });

    refreshList();
    /*  To_Controller.text = " ";
    Account_Controller.text = " ";
    Money_Controller.text = " ";
    LastName_Controller.text = " ";
    Name_Controller.text = " ";*/
  }

// Transfer allows for balance of one user to be sent to another
  transfer() {
    String A = Account_Controller.text;
    String M = Money_Controller.text;
    String T = To_Controller.text;
    PersonsLst.forEach((element) {
      if (element.account.toString() == A)
        element.money = element.money - double.parse(M);
      else if (element.account.toString() == T)
        element.money = element.money + double.parse(M);
    });

    refreshList();
  }

// Withdraw command removes money from the user entry in the table
  withdraw() {
    // if (formKey.currentState!.validate()) {
    //  formKey.currentState!.save();

    String ID = ID_Controller.text;
    String A = Account_Controller.text;
    String name = Name_Controller.text;
    String M = Money_Controller.text;
    String LastName = LastName_Controller.text;
    int timestamp = DateTime.now().millisecondsSinceEpoch;

    PersonsLst.forEach((element) {
      if (element.account.toString() == A)
        element.money = element.money - double.parse(M);
    });

    refreshList();
  }

/*  trans() {
    SizedBox (width: 200.0,
      height: 300.0,
      child: Card(child: Text('Hello World!')),
    );
  }   */

  bool NotIntCheck(var N) {
    final V = int.tryParse(N);

    if (V == null) {
      print("Not Int");
      return true;
    } else {
      print("Int");
      return false;
    }
  }
  
// Adds media query function to allow for modal to work (placeholder)
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        // Make the home provide the scaffold instead of returning it for the Widget build
      home: Scaffold(        
        appBar: AppBar(
          title: Text("Banking app"),
        ),
        body: ListView(
          
          children: <Widget>[
            Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Amount"),
                    TextField(
                      controller: Money_Controller,
                      keyboardType: TextInputType.text,
                      enabled: true,
                    ),
                    Text("Account"),
                    TextFormField(
                      controller: Account_Controller,
                      keyboardType: TextInputType.text,
                      validator: (val) =>
                          val?.length == 0 ? 'Enter Person Name' : null,
                    ),
                    Text("To"),
                    TextFormField(
                      controller: To_Controller,
                      keyboardType: TextInputType.text,
                      validator: (val) =>
                          val?.length == 0 ? 'Enter Person LastName' : null,
                    ),
                    Text("Name"),
                    TextFormField(
                      controller: Name_Controller,
                      keyboardType: TextInputType.text,
                      validator: (val) =>
                          val?.length == 0 ? 'Enter Person LastName' : null,
                    ),
                    Text("LastName"),
                    TextFormField(
                      controller: LastName_Controller,
                      keyboardType: TextInputType.text,
                      validator: (val) =>
                          val?.length == 0 ? 'Enter Person LastName' : null,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: MaterialButton(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Text(
                          'Insert Person',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: validate,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: MaterialButton(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Text(
                          'Deposite',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: deposite,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: MaterialButton(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Text(
                          'Withdraw',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: withdraw,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: MaterialButton(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Text(
                          'Send',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: transfer,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(
                    label: Text("ID"),
                  ),
                  DataColumn(
                    label: Text("Account"),
                  ),
                  DataColumn(
                    label: Text("Time"),
                  ),
                  DataColumn(
                    label: Text("Balance"),
                  ),
                  DataColumn(
                    label: Text("Name"),
                  ),
                  DataColumn(
                    label: Text("LastName"),
                  ),
                  DataColumn(
                    label: Text("More"),
                  ),
                ],
                rows: PersonsLst.map(
                  (p) => DataRow(cells: [
                    DataCell(
                      Text(p.ID.toString()),
                    ),
                    DataCell(
                      Text(p.account.toString()),
                    ),
                    DataCell(
                      Text(p.time.toString()),
                    ),
                    DataCell(
                      Text(p.money.toString()),
                    ),
                    DataCell(
                      Text(p.name.toString()),
                    ),
                    DataCell(
                      Text(p.lastName.toString()),
                    ),
                    DataCell(
                      ElevatedButton(
                          onPressed: () {}, child: const Text('Transactions')),
                    ),
                  ]),
                ).toList(),
              ),
            ),
            Divider(
              color: Colors.black
            ),
          ],
        ),
      ),
    ),
    );
  }
}

