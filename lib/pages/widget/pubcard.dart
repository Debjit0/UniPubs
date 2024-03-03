import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni/Models/Publication.dart';
import 'package:uni/pages/publicationsdetails.dart';

Widget displayPubs2(Publication data) {
  return GestureDetector(
    onTap: () {
      Get.to(PublicationDetails(
        data: data,
      ));
    },
    child: Card(
      child: Column(
        children: [
          Text("${data.authors?.a1},${data.affiliations?.af1}"),
          Text("${data.authors?.a2},${data.affiliations?.af2}"),
          Text("${data.authors?.a3},${data.affiliations?.af3}"),
          Text("${data.authors?.a4},${data.affiliations?.af4}"),
          Text("${data.authors?.a5},${data.affiliations?.af5}"),
          Text("${data.authors?.a6},${data.affiliations?.af6}"),
          Text("${data.title}")
        ],
      ),
    ),
  );
}

Widget displayPubs(Publication data) {
  return GestureDetector(
    onTap: () {
      Get.to(PublicationDetails(
        data: data,
      ));
    },
    child: Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${data.title}",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Text(
                '${data.authors?.a1}, ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Text(
                  '${data.affiliations?.af1}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '${data.authors?.a2}, ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Text(
                  '${data.affiliations?.af2}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '${data.authors?.a3}, ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Text(
                  '${data.affiliations?.af3}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '${data.authors?.a4}, ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Text(
                  '${data.affiliations?.af4}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '${data.authors?.a5}, ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Text(
                  '${data.affiliations?.af5}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '${data.authors?.a6}, ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Text(
                  '${data.affiliations?.af6}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
