// import 'dart:convert';
// import 'dart:html';

// ignore_for_file: prefer_typing_uninitialized_variables

// import 'dart:ui';

import 'package:chesstournament/draw_viewer.dart';
// import 'package:chesstournament/showFixtures.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';

const _credentials = r'''{
  "type": "service_account",
  "project_id": "gsheets-404214",
  "private_key_id": "c1720405d8d59f27b58c5f8e40a7fcaff667f2bd",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCsQ1JsOXO+ZHV+\nx2aMUpP8K9qUIWPFV0/5BiEmR8IifnsaU67/frOcFTUCNTM+DxvMlNbawWBGOI56\nfkYY91k8NPMt1ylObLUI2tc+VSIs48ciaYXaYmN2dGqsGtAG8pBiCCuj8D59tYVV\n22B6Gwkhw13FTKwd0XhoPRtWtoFDkmtWNym6x5X8KWi5lHvkTKVKCwVxY5zVPsKu\nNGSzjMT02QVooH9LDNMswJMZNB6MSSY5iQqFIF2C3BFN+rKC9VS6sQ4BptIQ9Ovt\nH9iEev7PD3VsOHtafmsh2soKO0URoPNLAOIMsuEQi6YfJaejVstoAB6vHCLIfZXx\nSElOlg0vAgMBAAECggEALCz1iaBwIK61fOYY07pnjd8XJi6r3dMmxJdAUAdN7zed\nTSKRuZ6d49SCbAcFlZAdUmkG8kFt9YQScbJJOqTP4wM3K5XGV4DEKjmowijl4zok\nepwyAc+Cb0Gqi2ky2N1CjolG27tD40v2Hg7snlOpk1l9BhhD+T+bD6xAAww5eQC7\nEk/oJAUjqQVDHkSfoH0cz+T1E1dclLknbkGFiDdlqgdbaiq+zL+tBBq190CPqfac\nAHK5LBVzt+YtjFy+sPgeH0cl4Tob/+MmthYAb4+6aPeLAKrPXMHdf/QqWQAwPyaD\nzWz8g8g7fEOpb5sxZYrA2Z6fnhvzm12E2w3VVMYe2QKBgQDfQkMQ7vkgc1UPa2HM\ne8ackrHdOMBid+v9xDFgENU/dlXGRsN3AQmPTFw6Aa1vDsfeIkEgEffTGL0NwAfy\ndTY/iBrtJwuNyWwG+eTCFl7+Pe8kuFn0saFmCY9PweaORe/JCM1KRUgtcrQObWRX\nKbYI34SQfCePueEff7KIJaiPFwKBgQDFhom/EHgPL9gZ+iScu14sphvi047Dw+yB\nZhQsPFei9kaKHrsSm+i4EEF3F5/tMg5Fek1SSHfdifc0kEBfaOQmIyzJouExvey7\neB70EqsAp8MSYHnNeR1TiyKwWMIfiOUVsi8tLBz1wzB0RI2zMvS0ybrs6Mnp0o5q\nS351aJOBqQKBgBbtLQnuIHMupMuCkXZ4N3sYrV80Vr1F51wV66Qb1mo/8qr71VLB\nLoQiqU3jojXHZMrw5ZMvhS2OWsuwrqA9XSbFCU7VNaCH0Koeu1kbBwJAxfAVZld0\nbkiWLrtYBB8UG32fg8Veu/y+zLK2lRlGVUUv/uL/fOiLhAzCBklo5JhdAoGAdrLV\nngqwizfOHjYywDjca+paQaGuXjgjrNMB9l9Arr5eP2weMR2d6NZj8MQyp+B3sQrA\n4lyII4pgEqdI98zZpY1nwbfuqeyfET0rJLL/LgKieC2fpHlOxUCMVPrRlQ+30qTk\nMroaoRltycDUgkZxxR6hBPMTOz77tCav1LBGTBkCgYBgN8HbP9O74Nv4nGrMurg9\nyjni/uLWTeEb9neh7JZPTR/L/xRxK310cXh7Z5NhUr6ZV3BqD8JYnWqeZCYkixsC\nEdNDMSSNzVfDsRpecuzBOKHL93jzX17X0I7K/GoEiXKPWPF7g3iOk+8Cw9YhPcBY\nJafQB9+rZcyQzm79hdtt5g==\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@gsheets-404214.iam.gserviceaccount.com",
  "client_id": "104698606245651718523",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gsheets-404214.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}''';
const _soreadsgeetId = '1UJP1Q227ZMTwZ37uXzmbJiZwCM6cJ2VWHlKgK0HsXGw';
var rounds;
Iterable<String> rds = [];
final gsheets = GSheets(_credentials);
var ss;
var sheet1;
var sheet2;
var currentRound, groupName;
// List<Widget> rows, cols;
void main_bkp() async {
  ss = await gsheets.spreadsheet(_soreadsgeetId);
  groupName = 'Beginners1';
  //ShowFixtures.showFixtures(ss, groupName);
  sheet1 = ss.worksheetByTitle(groupName);
  sheet2 = ss.worksheetByTitle('big2Round');
  rounds = await sheet1!.values.allRows(fromRow: 1);
  rds = rounds[1];
  currentRound = rds.elementAt(0);
  for (int i = 1; i < 5; i++) {
    await sheet2!.values.insertValue(i, column: i, row: 7);
  }

  // debugPrint(await sheet1.values.column(4, fromRow: 2));
  debugPrint(await sheet1.values.value(column: 6, row: 4));
  for (int i = 1; i < rounds.length; i++) {
    rds = rounds[i];
    for (int j = 1; j < rds.length; j++) {
      debugPrint(rds.elementAt(j));
      // cols.add(Text(rds[j]));
    }
    // rows.add(cols.join(',') as Widget);
  }
  runApp(const MyApp());
}

Future getAll() async {
  ss = await gsheets.spreadsheet(_soreadsgeetId);
  sheet1 = ss.worksheetByTitle('big1Round');
  sheet2 = ss.worksheetByTitle('big2Round');
  rounds = await sheet1!.values.allRows(fromRow: 1);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LRKnights Tournament',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'LRKnights Tournament'),
    );
  }
}

String title = 'LRKnights Tournament';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage = 0;

  // ShowFixtures sf = ShowFixtures(ss, groupName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      // body: RefreshIndicator(
      //   onRefresh: _refresh,
      //   child: Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         Text(
      //           'Group:   $groupName    Round     $currentRound',
      //           style: TextStyle(
      //             fontSize: 20.0,
      //             fontStyle: FontStyle.normal,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //         SizedBox(
      //           height: 20,
      //           width: double.infinity,
      //         ),
      //         moreRows(),
      //       ],
      //     ),
      //   ),
      // ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              // style: ButtonStyle(
              //   backgroundColor:
              // ),
              child: Text('$groupName Draws'),
              onPressed: () => {
                // Navigator.push(context, ShowFixtures()),
                // ShowFixtures.showFixtures(ss, groupName),
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DrawViewer1(
                          groupName: groupName,
                          title: title,
                          sheet: sheet1,
                          rounds: rounds,
                          currentRound: currentRound,
                        )))
              },
            ),
          ],
        ),
      ),
      //  floatingActionButton: FloatingActionButton(
      //     onPressed: getAll,
      //     tooltip: 'Refresh',
      //     child: const Icon(Icons.refresh),
      //   ), // This trailing comma makes auto-formatting nicer for build methods.
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
    ss = await gsheets.spreadsheet(_soreadsgeetId);
    sheet1 = ss.worksheetByTitle('big1Round');
    sheet2 = ss.worksheetByTitle('big2Round');
    rounds = await sheet1!.values.allRows(fromRow: 1);
    setState(() {});
  }
}
// Widget build(BuildContext context) {
//   // This method is rerun every time setState is called, for instance as done
//   // by the _incrementCounter method above.
//   //
//   // The Flutter framework has been optimized to make rerunning build methods
//   // fast, so that you can just rebuild anything that needs updating rather
//   // than having to individually change instances of widgets.
//   return Scaffold(
//     appBar: AppBar(
//       // TRY THIS: Try changing the color here to a specific color (to
//       // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//       // change color while the other colors stay the same.
//       backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//       // Here we take the value from the MyHomePage object that was created by
//       // the App.build method, and use it to set our appbar title.
//       title: Text(widget.title),
//     ),
//     body: Center(
//       // Center is a layout widget. It takes a single child and positions it
//       // in the middle of the parent.
//       child: Column(
//         // Column is also a layout widget. It takes a list of children and
//         // arranges them vertically. By default, it sizes itself to fit its
//         // children horizontally, and tries to be as tall as its parent.
//         //
//         // Column has various properties to control how it sizes itself and
//         // how it positions its children. Here we use mainAxisAlignment to
//         // center the children vertically; the main axis here is the vertical
//         // axis because Columns are vertical (the cross axis would be
//         // horizontal).
//         //
//         // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//         // action in the IDE, or press "p" in the console), to see the
//         // wireframe for each widget.
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[

//           Container(
//             child: ListView(children: rounds.map((value) {
//               return Container(
//                 child: Text(value[0]),
//               );
//             })),
//           )
//           // for (var r in rounds)
//           //   [
//           //     Text(r.toString().split(",")[0]),
//           //     Text(r.toString().split(",")[1]),
//           //   ],

//           // const Text(
//           //   'You have pushed the button this many times:',
//           // ),
//           // Text(
//           //   '$_counter',
//           //   style: Theme.of(context).textTheme.headlineMedium,
//           // ),
//         ],
//       ),
//     ),
//     floatingActionButton: FloatingActionButton(
//       onPressed: _incrementCounter,
//       tooltip: 'Increment',
//       child: const Icon(Icons.add),
//     ), // This trailing comma makes auto-formatting nicer for build methods.
//   );
// }
// }
//  class Get1Row extends StatelessWidget {
//   final Iterable<String> rd;
//     const Get1Row({super.key, required this.rd});

//     @override
//     Widget build(BuildContext context) {
//       return Row(children: List.generate(4, (index) => Text(rd.elementAt(index)),),);
//     }
//   }
// class Round {
//   const Round(
//       {required this.rd,
//       required this.bd,
//       required this.white,
//       required this.black});
//   final int? rd;
//   final int? bd;
//   final String white;
//   final String black;

//   @override
//   String toString() => 'Round{rd: $rd, bd: $bd, white: $white, black: $black}';

//   factory Round.fromGsheets(Map<String, dynamic> json) {
//     return Round(
//       rd: int.tryParse(json['rd'] ?? ''),
//       bd: int.tryParse(json['bd'] ?? ''),
//       white: json['white'],
//       black: json['black'],
//     );
//   }
//   Map<String, dynamic> toGsheets() {
//     return {
//       'rd': rd,
//       'bd': bd,
//       'white': white,
//       'black': black,
//     };
//   }
// }

// class RoundManager {
//   final GSheets _gSheets = GSheets(_credentials);
//   late Spreadsheet? _spreadsheet;
//   late Worksheet? _roundSheet;

//   Future<void> init() async {
//     _spreadsheet ??= await _gSheets.spreadsheet(_soreadsgeetId);
//     _roundSheet ??= _spreadsheet?.worksheetByTitle('big1Round');
//   }

// }
