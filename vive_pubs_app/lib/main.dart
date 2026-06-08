// ignore_for_file: prefer_const_constructors, use_super_parameters, unnecessary_null_comparison
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:vive_pubs_app/models/pubs.dart';
import 'package:vive_pubs_app/pub_card.dart';
import 'package:vive_pubs_app/affordable_pubs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      title: 'Vive Pubs',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget 
{
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> 
{
  List<Pubs> pubList = [];
  late Future<String> futurePubs;

  @override
  void initState() {
    super.initState();
    futurePubs = getPubs(pubList);
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text('Vive Pubs'),
        backgroundColor: Colors.green,
      ),
      body: Column
      (
        children: 
        [
          Expanded(child: _buildPubs()),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton
            (
              style: ElevatedButton.styleFrom
              (
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              onPressed: () 
              {
                Navigator.push
                (
                  context,
                  MaterialPageRoute
                  (
                    builder: (context) => AffordablePubsScreen(),
                  ),
                );
              },
              child: Text('Show Affordable Pubs'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPubs() 
  {
    return FutureBuilder
    (
      builder: (context, projectSnap) 
      {
        if (projectSnap.hasData == false) 
        {
          return Text("No data");
        }
        else if (projectSnap.connectionState == ConnectionState.none)  
        {
          return Text("No connection");
        }
        return ListView.builder
        (
          itemCount: pubList.length,
          itemBuilder: (context, index) 
          {
            return PubCard(pubList[index]);
          },
        );
      },
      future: futurePubs,
    );
  }
}

Future<String> getPubs(pubList) async 
{
  final Response response = await get
  (
    Uri.parse('http://192.168.1.36:1337/api/pubs'),
  );

  if (response.statusCode == 200) 
  {
    List<dynamic> rawList = jsonDecode(response.body);
    for (int i = 0; i < rawList.length; i++) 
    {
      pubList.add(Pubs.fromJson(rawList[i]));
    }
    return "Success!";
  } 
  else 
  {
    throw Exception();
  }
}