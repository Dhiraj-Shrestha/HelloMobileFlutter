import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:hello_mobiles/Api/Api.dart';
import 'package:hello_mobiles/Views/search/searchItem.dart';
import 'package:hello_mobiles/routes/router_constants.dart';

class DataSearch extends SearchDelegate<String> {
  final String q;
  bool voice = true;

  DataSearch({this.q});
  @override
  String get searchFieldLabel => q;

  //Get Products data
  Future getProductsData(String query) async {
    var response = await Api().getData('searchProduct?name=$query');
    var products = json.decode(response.body)['data'];
    // print(products);
    return products;
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    // final ColorScheme colorScheme = theme.colorScheme;
    assert(theme != null);
    return theme.copyWith(
      inputDecorationTheme: InputDecorationTheme(
        // hintStyle: searchFieldStyle ?? theme.inputDecorationTheme.hintStyle,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      Row(
        children: [
          IconButton(
            icon: Icon(Icons.clear, color: Colors.white),
            onPressed: () {
              query = '';
            },
          ),
        ],
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        Navigator.pushReplacementNamed(context, mainRoute);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => LandingPage()),
        // );

        // close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Scaffold(body: SearchItem(query: query));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: (query == '' && q != null)
              ? getProductsData(q)
              : getProductsData(query),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return snapshot.data.length == 0
                  ? _fileNotFound(context)
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, int index) {
                        var mydata = snapshot.data[index];
                        return ListTile(
                          onTap: () {
                            this.query = mydata['name'].toString();
                            showResults(context);
                          },
                          // Image.network(mydata["featureImage"])
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(mydata["featureImage"]),
                          ),
                          title: Text(mydata['name'].toString()),
                        );
                      },
                    );
            } else if (snapshot.hasError) {
              return Text('Error');
            } else {
              return Text('Loading');
            }
          },
        ),
      ),
    );
  }

  Widget _fileNotFound(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Container(
      width: 500.0,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding:
                    EdgeInsets.only(top: mediaQueryData.padding.top + 100.0)),
            Image.asset(
              "assets/images/productNotFound.png",
              height: 200.0,
            ),
            Padding(padding: EdgeInsets.only(bottom: 30.0)),
            Text(
              "Searched product is not found",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.5,
                  color: Colors.black54,
                  fontFamily: "Gotik"),
            ),
          ],
        ),
      ),
    );
    // return Container(
    //     child: Column(
    //   children: [
    //     Center(
    //       child: Container(

    //         child: Image.asset(
    //           "assets/images/productNotFound.png",
    //         ),
    //       ),
    //     ),
    //   ],
    // ));
  }
}
