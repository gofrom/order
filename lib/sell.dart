import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SellDocument {

  SellDocument(this.date, this.number, this.ca, this.sum);

  bool active;
  String manager;
  String date;
  String number;
  double sum;
  String ca;
  bool mobileAgent;
  bool deleted;
  String exp;

  bool selected = false;
}

class SellDocumentsDataSource extends DataTableSource {

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

  List<SellDocument> _documents = <SellDocument>[
    SellDocument(
        '12/12/2018', '3432', 'ИП Попов Сергей Владимирович', 5643.33),
    SellDocument('13/12/2018', '3433', 'ИП Попов Сергей Владимирович', 564.00),
    SellDocument('14/12/2018', '3434', 'ИП Попов Сергей Владимирович', 423.60)
  ];

  int _selectedCount = 0;

  //DataCell dataCell = DataCell(child);


  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    if (index >= _documents.length) {
      return null;
    }

    final SellDocument document = _documents[index];

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

class sellPage extends StatefulWidget {
  sellPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _sellPageState createState() => new _sellPageState();
}

class _sellPageState extends State<sellPage> {
  @override
  Widget build(BuildContext context) {
    SellDocumentsDataSource _inputDocumentsDataSource = SellDocumentsDataSource();
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
