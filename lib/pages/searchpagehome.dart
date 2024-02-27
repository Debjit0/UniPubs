import 'package:flutter/material.dart';

class SearchPageHome extends StatelessWidget {
  const SearchPageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2)),
                child: Row(
                  children: [
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.filter_alt_off),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Show all Publications")
                      ],
                    )
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),

            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2)),
                child: Row(
                  children: [
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.school),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Search By Author")
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2)),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.title),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Search By Title")
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
