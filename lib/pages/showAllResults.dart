import 'package:flutter/material.dart';

class showAllResults extends StatelessWidget {
  const showAllResults({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search Results")),
      body: Column(children: [
        Text("Showing all results")
      ]),
    );
  }
}