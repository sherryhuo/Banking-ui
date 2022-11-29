import 'package:flutter/material.dart';
void main() => runApp(InsertDataTable());
class Persons {
  int ID, time, account, To;
  double money, money2;
  Persons(this.ID, this.account, this.To, this. time ,this.money, this.money2);
}


class InsertDataTable extends StatefulWidget {
  @override
  _InsertDataTableState createState() => new _InsertDataTableState();
}

class _InsertDataTableState extends State<InsertDataTable> {
  List<Persons> PersonsLst = <Persons>[
    Persons(1, 0001, 0002, 3, 18, 30),
    Persons(2, 0002, 0001, 4, 24, 30),
  ];

  final formKey = new GlobalKey<FormState>();
  var ID_Controller = new TextEditingController();
  var Account_Controller = new TextEditingController();
  var To_Controller = new TextEditingController();
  var Money_Controller = new TextEditingController();
  var Money2_Controller = new TextEditingController();
  var Time_Controller = new TextEditingController();

  var lastID = 2;

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
  validate() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      String ID = ID_Controller.text;
      String A = Account_Controller.text;
      String LN = To_Controller.text;
      String M = Money_Controller.text;
      String M2 = Money2_Controller.text;
      String T = Time_Controller.text;
      Persons p = Persons(int.parse(ID), int.parse(A), int.parse(LN), int.parse(T), double.parse(M), double.parse(M2));
      PersonsLst.add(p);
      lastID++;
      refreshList();
      Account_Controller.text = "";
      To_Controller.text = "";
      Money_Controller.text = "";
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
        appBar: AppBar(
          title: Text("Banking app"),
        ),
        body: ListView(
          children: <Widget>[
            Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Number"),
                    TextField(
                      controller: ID_Controller,
                      enabled: false,
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
                    Text("Time"),
                    TextFormField(
                      controller: Time_Controller,
                      keyboardType: TextInputType.number,
                      validator: (val) => NotIntCheck(val)
                          ? 'Enter sometime less then 24hrs'
                          : null,
                    ),
                    Text("Balance"),
                    TextFormField(
                      controller: Money_Controller,
                      keyboardType: TextInputType.number,
                      validator: (val) => NotIntCheck(val)
                          ? 'Enter Balance,Numbers Required'
                          : null,
                    ),
                    Text("Balance2"),
                    TextFormField(
                      controller: Money2_Controller,
                      keyboardType: TextInputType.number,
                      validator: (val) => NotIntCheck(val)
                          ? 'Enter Balance,Numbers Required'
                          : null,
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
                    label: Text("To"),
                  ),
                  DataColumn(
                    label: Text("Time"),
                  ),
                  DataColumn(
                    label: Text("Balance"),
                  ),
                  DataColumn(
                    label: Text("Balance2"),
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
                      Text(p.To.toString()),
                    ),
                        DataCell(
                          Text(p.time.toString()),
                        ),
                    DataCell(
                      Text("\$"+p.money.toString()),
                    ),
                        DataCell(
                          Text("\$"+p.money2.toString()),
                        ),
                  ]),
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
