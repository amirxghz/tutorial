import 'package:flutter/material.dart';
import 'package:vive_pubs_app/models/pubs.dart';

class PubCard extends StatelessWidget {
  final Pubs pub;

  const PubCard(this.pub);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Image.network(
            'http://192.168.1.36:1337${pub.picture.url}',
            width: 50,
            height: 50,
          ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(pub.name),
              Text(pub.address),
              Text(pub.avgPrice.toString() + ' €'),
            ],
          )
        ],
      ),
    );
  }
}