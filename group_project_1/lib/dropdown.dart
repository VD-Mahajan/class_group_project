import 'package:flutter/material.dart';
// import 'package:group_project_1/addfarmer.dart';
// import 'package:group_project_1/loginscreen.dart';
import 'package:group_project_1/modal_classes/Entry.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
import 'main.dart';
import 'slip.dart';

class DropDown extends StatefulWidget {
  const DropDown({super.key});

  @override
  State createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String? dropDownValue;
  String? animal;

  //CONTROLLERS
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _fatController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  //ANIMAL LIST
  List<String> animalList = [
    'Cow',
    'Buffalo',
    'Goat',
  ];

  //INSERT DATA
  Future<bool> insertEntry(Entry obj) async {
    final localDB = await database;

    var val = await localDB
        .rawQuery('SELECT COUNT(*) FROM FARMERS WHERE id=?', [obj.id]);

    int count = val.isNotEmpty ? val[0]['COUNT(*)'] : 0;

    if (count == 0) {
      return false;
    } else {
      await localDB.insert(
        'MILKENTRY',
        obj.toMap(),
        // conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return true;
    }
  }

  //AMOUNT GENERATE
  double totalAmount(double fat, double quantity) {
    return (fat * 10) * quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      // appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 150,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                // color: const Color(0xffCCD3CA),
                color: Colors.green[500],
              ),
              height: 520,
              width: 300,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 5),
                    child: Text(
                      "Enter Details",
                      style: GoogleFonts.quicksand(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  //Farmer id
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        // color: const Color(0xffF5E8DD),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.only(left: 20),
                      height: 50,
                      width: double.infinity,
                      child: TextFormField(
                        controller: _idController,
                        decoration: InputDecoration(
                          hintText: 'Enter id',
                          hintStyle: GoogleFonts.quicksand(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none,
                        ),
                        // keyboardType: TextInputType.number,
                      ),
                    ),
                  ),

                  //Select Animal
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        // color: const Color(0xffF5E8DD),
                        color: Colors.white,
                      ),
                      height: 50,
                      width: double.infinity,
                      child: Center(
                        child: DropdownButton<String>(
                          // underline: ,
                          // dropdownColor: const Color(0xffF5E8DD),
                          dropdownColor: Colors.white,
                          menuMaxHeight: 200,
                          hint: Text(
                            "Choose Animal",
                            style: GoogleFonts.quicksand(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          value: animal,
                          iconSize: 40,
                          onChanged: (String? value) {
                            if (value != null) {
                              setState(() {
                                animal = value;
                              });
                            }
                          },
                          items: List<DropdownMenuItem<String>>.generate(
                              animalList.length, (index) {
                            return DropdownMenuItem<String>(
                              value: animalList[index],
                              child: Text(animalList[index]),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),

                  //Fat amount
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        // color: const Color(0xffF5E8DD),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.only(left: 20),
                      height: 50,
                      width: double.infinity,
                      child: TextFormField(
                        controller: _fatController,
                        decoration: InputDecoration(
                          hintText: 'Enter amount of fat',
                          hintStyle: GoogleFonts.quicksand(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none,
                        ),
                        // keyboardType: TextInputType.number,
                      ),
                    ),
                  ),

                  //Quantity
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        // color: const Color(0xffF5E8DD),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.only(left: 20),
                      height: 50,
                      width: double.infinity,
                      child: TextField(
                        controller: _quantityController,
                        decoration: InputDecoration(
                          hintText: 'Enter quantity of milk',
                          hintStyle: GoogleFonts.quicksand(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none,
                        ),
                        // keyboardType: TextInputType.number,
                      ),
                    ),
                  ),

                  //Save Button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_fatController.text.isNotEmpty &&
                              _quantityController.text.isNotEmpty &&
                              animal!.isNotEmpty &&
                              _idController.text.isNotEmpty) {
                            Entry obj = Entry(
                              id: int.parse(_idController.text),
                              animal: animal!,
                              fat: double.parse(_fatController.text),
                              quantity: double.parse(_quantityController.text),
                              date: DateFormat.yMMMd().format(DateTime.now()),
                              total: totalAmount(
                                double.parse(_fatController.text),
                                double.parse(_quantityController.text),
                              ),
                            );

                            bool temp = await insertEntry(obj);
                            if (temp == true) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Slip(
                                  entryObj: obj,
                                );
                              }));
                              clearControllers();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('First Add Farmer'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Enter valid data'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            // backgroundColor: const Color(0xffEED3D9),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            )),
                        child: Text(
                          "Save Changes",
                          style: GoogleFonts.quicksand(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void clearControllers() {
    _fatController.clear();
    _idController.clear();
    _quantityController.clear();
  }
}
