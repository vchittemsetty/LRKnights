import 'dart:ui';

import 'package:flutter/material.dart';
// import 'package:gsheets/gsheets.dart';

var sheet, ss;
var currentRound, groupName;
var rounds;
Iterable<String> rds = [];

class ShowFixtures {
  ShowFixtures(ss, groupName) {
    this.ss = ss;
    this.groupName = groupName;
  }
  set groupName(String groupName) {
    this.groupName = groupName;
  }

  set ss(ss) {
    this.ss = ss;
  }

  static void showFixtures(dynamic ss, String groupName) async {
    debugPrint('test $groupName');
    sheet = ss.worksheetByTitle(groupName);
    rounds = await sheet.values.allRows(fromRow: 1);

    rds = rounds[1];
    currentRound = rds.elementAt(0);
    runApp(const MyApp());
  }
}

Future getAll() async {
  sheet = ss.worksheetByTitle(groupName);
  rounds = await sheet!.values.allRows(fromRow: 1);
}

class MyApp extends StatelessWidget {
  // final String groupName;
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LRKnights Tournament',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  // final String groupName;
  @override
  State<MyHomePage> createState() => _MyHomePageState(groupName: groupName);
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage = 0;
  final String groupName;
  _MyHomePageState({required this.groupName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // title: Text(widget.title),
        leading: BackButton(
          onPressed: () => {
            Navigator.pop(context),
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Group:   $groupName    Round     $currentRound',
                style: TextStyle(
                  fontSize: 20.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
                width: double.infinity,
              ),
              moreRows(),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: getAll,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );

    // bottomNavigationBar: NavigationBar(
    //   destinations: const [
    //     NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
    //     NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
    //   ],
    //   onDestinationSelected: (int index) {
    //     setState(() {
    //       currentPage = index;
    //     });
    //   },
    //   selectedIndex: currentPage,
    // );
  }

  Future<void> _refresh() async {}
  Table moreRows() {
    var trs = <TableRow>[];
    var writeHeader = true;
    for (Iterable<String> rdd in rounds) {
      var cells = <TableCell>[];

      // cells.add(
      //   TableCell(
      //     child: Text(rdd.elementAt(0)),
      //   ),
      // );

      cells.add(
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              rdd.elementAt(1),
              style: TextStyle(
                fontSize: 20.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
      cells.add(
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              rdd.elementAt(3),
              style: TextStyle(
                fontSize: 20.0,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
      cells.add(
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              rdd.elementAt(5),
              style: TextStyle(
                fontSize: 20.0,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
      var trow;
      if (writeHeader) {
        trow = TableRow(
          children: cells,
          decoration: BoxDecoration(color: Colors.amberAccent),
        );
        writeHeader = false;
      } else {
        trow = TableRow(children: cells);
      }
      trs.add(trow);
    }

    var tbl = Table(
      defaultColumnWidth: IntrinsicColumnWidth(),
      children: trs,
      border: TableBorder.all(color: Colors.black),
    );
    return tbl;
  }

  Future getAll() async {
    sheet = ss.worksheetByTitle(groupName);
    rounds = await sheet!.values.allRows(fromRow: 1);
    setState(() {});
  }
}
