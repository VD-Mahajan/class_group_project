import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'main.dart';
import 'modal_classes/Entry.dart';

class Slip extends StatefulWidget {
  final Entry entryObj;

  const Slip({
    super.key,
    required this.entryObj,
  });

  @override
  State<Slip> createState() => _SlipState();
}

Future<String> getName(Entry obj) async {
  final localDB = await database;

  var val =
      await localDB.rawQuery('SELECT fname FROM FARMERS WHERE id=?', [obj.id]);

  String name = val[0]['fname'];

  print(name);

  return name;
}

class _SlipState extends State<Slip> {
  String? name;
  fetchData() async {
    String tempName = await getName(widget.entryObj);
    setState(() {
      name = tempName;
    });
  }

  String todaysDate() {
    DateTime date = DateTime.now();
    String formatedDate = DateFormat.yMMMd().format(date);
    return formatedDate;
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.green[100],
      body: Center(
        child: Container(
          height: 500,
          width: 350,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //Logo and Slip text
              SizedBox(
                // color: Colors.red,
                height: 130,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/tick.png',
                      height: 80,
                    ),
                    const Text(
                      "Transaction Slip",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              //
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                // color: Colors.amber,
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //name
                    SizedBox(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Name: ",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              '$name',
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ]),
                    ),
                    //Animal
                    SizedBox(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Animal: ",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              widget.entryObj.animal,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ]),
                    ),
                    //Fat
                    SizedBox(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Amount of Fat: ",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              '${widget.entryObj.fat}',
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ]),
                    ),
                    //Quantity
                    SizedBox(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Quantity of Milk: ",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              '${widget.entryObj.quantity}',
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ]),
                    ),
                    //Date
                    SizedBox(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Date of Delivery: ",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              todaysDate(),
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ]),
                    ),
                    //Total
                    SizedBox(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Total: ",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${widget.entryObj.total}",
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
