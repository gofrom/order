import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'sell.dart';
import 'package:order/login.dart';

const String _kAsset0 = 'people/square/trevor.png';
const String _kAsset1 = 'people/square/stella.png';
const String _kAsset2 = 'people/square/sandra.png';
const String _kGalleryAssetsPackage = 'flutter_gallery_assets';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Человек-кладовщик',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,

      ),
      //home: new MainPage(title: 'Склад'),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => MainPage(),
        '/login': (BuildContext context) => LoginPage()
      },

    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  int _counter = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _showNotImplementedMessage() {
    Navigator.pop(context); // Dismiss the drawer.
    _scaffoldKey.currentState.showSnackBar(const SnackBar(
        content: Text("The drawer's items don't do anything")
    ));
  }

  static final Animatable<Offset> _drawerDetailsTween = Tween<Offset>(
    begin: const Offset(0.0, -1.0),
    end: Offset.zero,
  ).chain(CurveTween(
    curve: Curves.fastOutSlowIn,
  ));

  AnimationController _controller;
  Animation<double> _drawerContentsOpacity;
  Animation<Offset> _drawerDetailsPosition;
  bool _showDrawerContents = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200)
    );
    _drawerContentsOpacity = CurvedAnimation(
      parent: ReverseAnimation(_controller),
      curve: Curves.fastOutSlowIn,
    );
    _drawerDetailsPosition = _controller.drive(_drawerDetailsTween);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: const Text('Гофман Роман'),
              accountEmail: const Text('roman@gofman.pro'),
              onDetailsPressed: () {
                print("qw");
                 _showDrawerContents = !_showDrawerContents;
                 if (_showDrawerContents)
                   _controller.reverse();
                 else
                   _controller.forward();
              },
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage(
                  _kAsset0,
                  package: _kGalleryAssetsPackage,
                ),
              ),
              otherAccountsPictures: <Widget>[
                GestureDetector(
                  onTap: () {
                    _onOtherAccountsTap(context);
                  },
                  child: Semantics(
                    label: 'Switch to Account B',
                    child: const CircleAvatar(
                      backgroundImage: AssetImage(
                        _kAsset1,
                        package: _kGalleryAssetsPackage,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _onOtherAccountsTap(context);
                  },
                  child: Semantics(
                    label: 'Switch to Account C',
                    child: const CircleAvatar(
                      backgroundImage: AssetImage(
                        _kAsset2,
                        package: _kGalleryAssetsPackage,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            MediaQuery.removePadding(
              context: context,
              // DrawerHeader consumes top MediaQuery padding.
              removeTop: true,
              child: Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(top: 8.0),
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        // The initial contents of the drawer.
                        FadeTransition(
                          opacity: _drawerContentsOpacity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              ListTile(
                                title: Text('Поступления'),
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => InputPage()));
                                },
                              ),
                              ListTile(
                                title: Text('Реализации'),
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => SellPage()));
                                },
                              ),
                            ]

                          ),
                        ),
                        // The drawer's "details" view.
                        SlideTransition(
                          position: _drawerDetailsPosition,
                          child: FadeTransition(
                            opacity: ReverseAnimation(_drawerContentsOpacity),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                ListTile(
                                  leading: const Icon(Icons.add),
                                  title: const Text('Add account'),
                                  onTap: (){
                                    Navigator.pushNamed(context, '/login');
                                  }
                                ),
                                ListTile(
                                  leading: const Icon(Icons.settings),
                                  title: const Text('Manage accounts'),
                                  onTap: _showNotImplementedMessage,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text("123"),

      ),
      body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug paint" (press "p" in the console where you ran
          // "flutter run", or select "Toggle Debug Paint" from the Flutter tool
          // window in IntelliJ) to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'Нажми на кнопку:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: '+ 1',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  void _onOtherAccountsTap(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Account switching not implemented.'),
          actions: <Widget>[
            FlatButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

class InputPage extends StatefulWidget {
  InputPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _InputPageState createState() => new _InputPageState();
}

class InputDocument {
  InputDocument(this.date, this.number, this.ca, this.sum);
  final String date;
  final String number;
  final String ca;
  final double sum;

  bool selected = false;
}

class InputDocumentsDataSource extends DataTableSource {
  void addInputDocument(key, value) {
    print('$key:$value');
  }

  void loadData() async {
    String dataURL =
        "http://192.168.10.2:8080/utapr/hs/mce/%D0%9E%D1%82%D1%87%D0%B5%D1%82?Report=001&BeginDate=20180801000000";

    //    "http://echo.jsontest.com/date/12-12-2018/number/3459/ca/IPBabayan/sum/5273.50";

//    var client = new http.Client();
//    client.post(dataURL, headers: {
//      "Authorization": "Basic c2VydmljZTpzZXJ2aWNl"
//    }, body: {
//      "Report": "001",
//      "BeginDate": "20180801000000",
//      "EndDate": "20180801235959"
//    }).then((response) => print(response.body));

//    print("GH1" + dataURL);
//    http.Response response = await http.post(dataURL, headers: {
//      "Authorization": "Basic c2VydmljZTpzZXJ2aWNl"
//    }, body: {
//      "Report": "001",
//      "BeginDate": "20180801000000",
//      "EndDate": "20180801235959"
//    });

    http.Response response = await http.get(dataURL, headers: {
      "Authorization": "Basic c2VydmljZTpzZXJ2aWNl"
    }); // "Content-type": "application/x-www-form-urlencoded",

    //"Период": {"Начало": "20180801000000", "Окончание": "20180801235959"}
    print(response.body);

    //Map<String, dynamic> data = json.decode(response.body);

    //data.forEach(this.addInputDocument);

    /* _documents.add(InputDocument(
        data['date'], data['number'], data['ca'], double.parse(data['sum'])));

    notifyListeners();*/
  }

  List<InputDocument> _documents = <InputDocument>[
    InputDocument(
        '12/12/2018', '3432', 'ИП Попов Сергей Владимирович', 5643.33),
    InputDocument('13/12/2018', '3433', 'ИП Попов Сергей Владимирович', 564.00),
    InputDocument('14/12/2018', '3434', 'ИП Попов Сергей Владимирович', 423.60)
  ];

  int _selectedCount = 0;

  //DataCell dataCell = DataCell(child);

  void onTapDataCell(document) {
    print(document.ca);
  }

  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    if (index >= _documents.length) {
      return null;
    }

    final InputDocument document = _documents[index];

    return DataRow.byIndex(
        index: index,
        selected: document.selected,
        onSelectChanged: (bool value) {
          if (document.selected != value) {
            _selectedCount += value ? 1 : -1;
            assert(_selectedCount >= 0);
            document.selected = value;
            notifyListeners();
          }
        },
        cells: <DataCell>[
          DataCell(Text('${document.date}'), onTap: () {
            print(document.date);
          }),
          DataCell(Text('${document.number}'), onTap: () {
            print(document.number);
          }),
          DataCell(Text('${document.ca}')),
          DataCell(Text('${document.sum}'))
        ]);
  }

  @override
  int get rowCount => _documents.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

class _InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    InputDocumentsDataSource _inputDocumentsDataSource =
        InputDocumentsDataSource();
    _inputDocumentsDataSource.loadData();

    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text('Задания на приемку'),
//      ),
      body: new Center(
          child: ListView(children: <Widget>[
        PaginatedDataTable(
            header: const Text('Документы поступления'),
            rowsPerPage: PaginatedDataTable.defaultRowsPerPage,
            columns: <DataColumn>[
              DataColumn(label: const Text('Дата')),
              DataColumn(label: const Text('Номер')),
              DataColumn(label: const Text('Контрагент')),
              DataColumn(label: const Text('Сумма'), numeric: true)
            ],
            source: _inputDocumentsDataSource)
      ])),
    );
  }
}
