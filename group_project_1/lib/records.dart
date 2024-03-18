import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:group_project_1/modal_classes/Entry.dart';
import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

// Future<String> getName(Entry obj) async {
//   final localDB = await database;

//   var val =
//       await localDB.rawQuery('SELECT fname FROM FARMERS WHERE id=?', [obj.id]);

//   String name = val[0]['fname'];

//   return name;
// }

//FETCH DATA
Future getData(String date, [int? id]) async {
  final localDB = await database;
  var data;
  if (id == null) {
    data =
        await localDB.rawQuery('SELECT * FROM MILKENTRY WHERE date=?', [date]);
    print("simple query executed");
  } else {
    data = await localDB
        .rawQuery('SELECT * FROM MILKENTRY WHERE date=? and id=?', [date, id]);
    print("id query executed");
  }
  return List.generate(data.length, (index) {
    return Entry(
        id: data[index]['id'],
        animal: data[index]['animal'],
        fat: data[index]['fat'],
        quantity: data[index]['quantity'],
        date: data[index]['date'],
        total: data[index]['total']);
  });
}

class _SearchScreenState extends State<SearchScreen> {
  fetchData(String date, [int? id]) async {
    List tempList;
    if (id == null) {
      tempList = await getData(date);
    } else {
      tempList = await getData(date, id);
    }
    setState(() {
      list = tempList;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData(
      DateFormat.yMMMd().format(DateTime.now()),
    );
  }

  List<dynamic> list = [];
  String date = DateFormat.yMMMd().format(DateTime.now());
  final TextEditingController _idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(
          "Search Records",
          style: GoogleFonts.quicksand(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green[800],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 270,
              child: CalendarDatePicker(
                initialDate: DateTime.now(),
                lastDate: DateTime(2026),
                firstDate: DateTime(2018),
                onDateChanged: (DateTime value) async {
                  setState(() {
                    date = DateFormat.yMMMd().format(value);
                  });
                  if (_idController.text.isNotEmpty) {
                    await fetchData(date, int.parse(_idController.text));
                  } else {
                    await fetchData(date);
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: TextField(
                controller: _idController,
                onChanged: (value) async {
                  if (value.isEmpty) {
                    await fetchData(date);
                  } else {
                    await fetchData(date, int.parse(_idController.text));
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Search by Id',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      // setState(() {
                      //   fetchData(date, int.parse(_idController.text));
                      // });
                    },
                    icon: const Icon(Icons.search_outlined),
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
            ),
            SizedBox(
              height: 390,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 5,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 6,
                            offset: Offset(-5, 5),
                            color: Colors.grey,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Id : ${list[index].id}',
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Text(
                          //   'Name : ${list[index].animal}',
                          //   style: GoogleFonts.quicksand(
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          Text(
                            'Animal : ${list[index].animal}',
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Fat : ${list[index].fat}',
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Quantity : ${list[index].quantity}',
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Total : ${list[index].total}',
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
