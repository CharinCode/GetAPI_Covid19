import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as Http;

class GetAPI extends StatefulWidget {
  const GetAPI({super.key, required this.title});

  final String title;

  @override
  State<GetAPI> createState() => _GetAPIState();
}

class _GetAPIState extends State<GetAPI> {
  var datajson;
  Map<String, int> data = {}; //สร้างmapเอาไว้เก็บ json
  Future<String> _GetCovid19Today() async {
    //Get JSON From URL
    final url =
        Uri.parse('https://covid19.ddc.moph.go.th/api/Cases/today-cases-all');
    var response = await Http.get(url);
    //End Get JSON
    datajson = jsonDecode(utf8.decode(response.bodyBytes)); // create JSON

    // Loop เพื่อดึงข้อมูลจาก JSON มาแสดง
    for (var element in datajson) {
      data['year'] = element['year'];

      data['new_case'] = element['new_case'];
      data['total_case'] = element['total_case'];
      data['new_recovered'] = element['new_recovered'];
      data['total_recovered'] = element['total_recovered'];
    }
    return 'ok';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: FutureBuilder(
        future: _GetCovid19Today(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: Column(children: [
                Text('Year'),
                Text('${data['year']}'),
                SizedBox(
                  height: 10,
                ),
                Text('New_case'),
                Text('${data['new_case']}'),
                SizedBox(
                  height: 10,
                ),
                Text('Total_case'),
                Text('${data['total_case']}'),
                SizedBox(
                  height: 10,
                ),
                Text('New_recovered'),
                Text('${data['new_recovered']}'),
                SizedBox(
                  height: 10,
                ),
                Text('Total_recovered'),
                Text('${data['total_recovered']}')
              ]),
            );
          } else {
            return Center(
              child: Column(
                children: [CircularProgressIndicator()],
              ),
            );
          }
        },
      )),
    );
  }
}
