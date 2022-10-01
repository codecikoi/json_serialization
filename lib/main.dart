import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:json_1/offices.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSON Demo',
      home: JsonPage(),
    );
  }
}

class JsonPage extends StatefulWidget {
  @override
  State<JsonPage> createState() => _JsonPageState();
}

class _JsonPageState extends State<JsonPage> {

  late Future<OfficesList> officesList;

  @override
  void initState() {
    super.initState();
    officesList = getOfficesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Json serialization. Manual'
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text('${snapshot.data?.offices[index].name}'),
                subtitle: Text('${snapshot.data?.offices[index].address}'),
                leading: Image.network(
                    '${snapshot.data?.offices[index].image}'),
                isThreeLine: true,
              ),
            );
          });
        } else if (snapshot.hasError) {
          return Text('Error');
        }
        return Center(
            child: CircularProgressIndicator()
        );
      },
      ),
    );
  }
}}
}

}
