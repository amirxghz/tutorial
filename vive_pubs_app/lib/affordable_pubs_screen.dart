import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AffordablePubsScreen extends StatefulWidget {
  @override
  AffordablePubsScreenState createState() => AffordablePubsScreenState();
}

class AffordablePubsScreenState extends State<AffordablePubsScreen> {
  List<dynamic> pubList = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchAffordablePubs();
  }

  Future<void> fetchAffordablePubs() async {
    final response = await http.get(
      Uri.parse('http://192.168.1.36:1337/api/pubs/affordable?maxPrice=15'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        pubList = data;
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Affordable Pubs'),
        backgroundColor: Colors.green,
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: pubList.length,
              itemBuilder: (context, index) {
                final pub = pubList[index];
                return Card(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image.network(
                          'http://192.168.1.36:1337${pub['picture']['url']}',
                          width: 50,
                          height: 50,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(pub['name']),
                          Text(pub['address']),
                          Text(pub['avgPrice'].toString() + ' €'),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}