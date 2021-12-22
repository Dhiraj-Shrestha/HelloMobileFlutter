import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hello_mobiles/Api/Api.dart';
import 'package:hello_mobiles/Views/subCategory/subcategories.dart';

class Categories extends StatelessWidget {
  Future getCategoryData() async {
    try {
      var response = await Api().getData('categories');
      var category = json.decode(response.body)['data'];
      return category;
    } on SocketException {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: getCategoryData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...List.generate(snapshot.data.length, (index) {
                      var mydata = snapshot.data[index];

                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 1.0, left: 5.0, bottom: 5.0, right: 5.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SubCategories(catid: mydata["id"])),
                            );
                          },
                          child: Container(
                            width: 100,
                            child: Column(
                              children: [
                                Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Image.network(
                                    mydata['image'],
                                    fit: BoxFit.fill,
                                    height: 80,
                                  ),
                                ),
                                Text(
                                  mydata['name'],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(width: 20),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Cannot load at this time');
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
