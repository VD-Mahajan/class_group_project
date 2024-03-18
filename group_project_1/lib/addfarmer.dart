import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'modal_classes/farmer.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AddFarmer extends StatefulWidget {
  const AddFarmer({super.key});

  @override
  State<AddFarmer> createState() => _AddFarmerState();
}

//INSERT NEW DATA
Future insertData(Farmer obj) async {
  final localDB = await database;

  var val = await localDB
      .rawQuery('SELECT COUNT(*) FROM FARMERS WHERE id=?', [obj.id]);

  int count = val.isNotEmpty ? val[0]['COUNT(*)'] : 0;

  if (count == 0) {
    await localDB.insert(
      'FARMERS',
      obj.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return true;
  } else {
    return false;
  }
}

//FETCH FARMER DATA
Future<List<Farmer>> getFarmersData() async {
  final localDB = await database;
  List retVal = await localDB.query("FARMERS");

  return List.generate(retVal.length, (index) {
    return Farmer(
      id: retVal[index]['id'],
      name: retVal[index]['fname'],
      number: retVal[index]['number'],
      city: retVal[index]['city'],
      accNumber: retVal[index]['accNumber'],
    );
  });
}

//UPDATE FARMER DATA
updateData(Farmer obj) async {
  final localDB = await database;
  await localDB.update(
    'Farmers',
    obj.updateData(obj.id),
    where: 'id=?',
    whereArgs: [obj.id],
  );
  return false;
}

//DELETE DATA
deleteData(Farmer obj) async {
  final localDB = await database;
  await localDB.delete(
    'FARMERS',
    where: 'id=?',
    whereArgs: [obj.id],
  );
}

class _AddFarmerState extends State<AddFarmer> {
  //CONTROLLERS
  final TextEditingController _farmerNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _idController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List farmersList = [];

  //FETCH DATA
  fetchData() async {
    List tempList = await getFarmersData();
    setState(() {
      farmersList = tempList;
    });
  }

  //EDIT DETAILS
  void editFarmerDetails(Farmer obj) {
    showMyBottomSheet(obj);
  }

  //CLEARS CONTROLLERS
  clearControllers() {
    _idController.clear();
    _farmerNameController.clear();
    _addressController.clear();
    _accountNumberController.clear();
    _mobileNumberController.clear();
  }

  showMyBottomSheet([Farmer? obj]) {
    Farmer? tempObj = obj;
    if (obj != null) {
      setState(() {
        _idController.text = obj.id.toString();
        _farmerNameController.text = obj.name;
        _addressController.text = obj.city;
        _accountNumberController.text = obj.accNumber.toString();
        _mobileNumberController.text = obj.number.toString();
      });
    }

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: SizedBox(
                // height: 530,
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      child: Text(
                        'Add New Farmer',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20.0),
                          child: TextFormField(
                            controller: _idController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              label: Text((tempObj == null)
                                  ? 'Farmer ID'
                                  : 'Farmer ID (Cannot modify Farmer id)'),
                              hintText: 'Enter farmer ID',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter ID';
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.number,
                            readOnly: (tempObj == null) ? false : true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20.0),
                          child: TextFormField(
                            controller: _farmerNameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              label: const Text('Farmer name'),
                              hintText: 'Enter farmer name',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter name';
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20.0),
                          child: TextFormField(
                            controller: _mobileNumberController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              label: const Text('Mobile'),
                              hintText: 'Enter mobile number',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter number';
                              } else if (value.length != 10) {
                                return 'Please enter valid number';
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20.0),
                          child: TextFormField(
                            controller: _accountNumberController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              label: const Text('Account number'),
                              hintText: 'Enter account number',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter account number';
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20.0),
                      child: TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          label: const Text('City'),
                          hintText: 'Enter farmer address',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter address';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 4,
                      ),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            bool validated = _formKey.currentState!.validate();
                            if (validated) {
                              bool temp = false;
                              Farmer obj = Farmer(
                                id: int.parse(_idController.text),
                                name: _farmerNameController.text.toString(),
                                number: int.parse(_mobileNumberController.text),
                                city: _addressController.text.toString(),
                                accNumber:
                                    int.parse(_accountNumberController.text),
                              );
                              if (tempObj == null) {
                                temp = await insertData(obj);
                              } else {
                                await updateData(obj);
                              }
                              clearControllers();
                              await fetchData();
                              Navigator.pop(context);
                              if (temp == true) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Farmer added Successfully'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              } else if (tempObj != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Farmer record updated'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                setState(() {
                                  tempObj = null;
                                });
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Farmer id already present'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[800],
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Submit'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _idController.addListener(() {});
    _farmerNameController.addListener(() {});
    _addressController.addListener(() {});
    _accountNumberController.addListener(() {});
    _mobileNumberController.addListener(() {});
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text(
          "Farmers List",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green[800],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          // height: 700,
          height: MediaQuery.of(context).size.height * 1,
          child: (farmersList.isEmpty)
              ? const Center(
                  child: Text(
                    'No User found',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: farmersList.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      direction: Axis.horizontal,
                      endActionPane: ActionPane(
                        extentRatio: 0.2,
                        motion: const StretchMotion(),
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: IconButton(
                                    color: Colors.blue,
                                    onPressed: () {
                                      editFarmerDetails(farmersList[index]);
                                    },
                                    icon: const Icon(Icons.edit_outlined),
                                  ),
                                ),
                                Expanded(
                                  child: IconButton(
                                    onPressed: () async {
                                      await deleteData(farmersList[index]);
                                      fetchData();
                                    },
                                    color: Colors.red[800],
                                    icon: const Icon(Icons.delete_outline),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10),
                        child: Container(
                          height: 130,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 10,
                                offset: Offset(-5, 5),
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Farmer ID : ${farmersList[index].id}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'Name : ${farmersList[index].name}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'Phone Number : ${farmersList[index].number}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'Account Number : ${farmersList[index].accNumber}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'City : ${farmersList[index].city}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green[800],
          elevation: 5,
        ),
        onPressed: () {
          setState(() {
            clearControllers();
          });
          showMyBottomSheet();
        },
        child: const Text(
          "Add New farmer",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
