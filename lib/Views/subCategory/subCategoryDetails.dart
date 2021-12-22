import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:hello_mobiles/Api/Api.dart';
import 'package:hello_mobiles/Views/HomeScreen/components/products/subcategoryProduct/subCategoryProduct.dart';
import 'package:hello_mobiles/Widgets/richText.dart';

class SubCategoryDetail extends StatefulWidget {
  final mydata;

  const SubCategoryDetail({Key key, this.mydata}) : super(key: key);

  @override
  _SubCategoryDetailState createState() => _SubCategoryDetailState();
}

class _SubCategoryDetailState extends State<SubCategoryDetail> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  var childCount;
  Future getProductData() async {
    try {
      var response =
          await Api().getData('subcategories/${widget.mydata['id']}');
      var subcategory = json.decode(response.body)['data'];
      print('........................................');
      // print(subcategory.length);
      print(childCount);
      childCount = subcategory.length;

      print(childCount);

      return subcategory;
    } on SocketException {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();

    getProductData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          /// Appbar Custom using a SliverAppBar
          SliverAppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            expandedHeight: 380.0,
            elevation: 0.1,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  widget.mydata['name'],
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 17.0,
                      fontFamily: "Popins",
                      fontWeight: FontWeight.w700),
                ),
                background: Material(
                  child: Hero(
                    tag: 'hero-tag-subcategory${widget.mydata['id']}',
                    child: new DecoratedBox(
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: new NetworkImage(widget.mydata['image']),
                        ),
                        shape: BoxShape.rectangle,
                      ),
                      child: Container(
                        margin: EdgeInsets.only(top: 120.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: <Color>[
                                new Color(0x00FFFFFF),
                                new Color(0xFFFFFFFF),
                              ],
                              stops: [
                                0.0,
                                1.0
                              ],
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(0.0, 1.0)),
                        ),
                      ),
                    ),
                  ),
                )),
          ),

          /// Container for description to Sort and Refine
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    richText(
                        simpleText: 'Total Items available',
                        colorText: widget.mydata['productCount'].toString())
                  ],
                ),
              ),
            ),
          ),

          /// Create Grid Item

          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return FutureBuilder(
                  future: getProductData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(childCount);

                      var mydata = snapshot.data[index];
                      return SubCategoryProduct(mydata: mydata);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                );
              },
              childCount: widget.mydata['productCount'],
            ),

            /// Setting Size for Grid Item
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 290.0,
              mainAxisSpacing: 7.0,
              crossAxisSpacing: .940,
              childAspectRatio: 0.750,
            ),
          ),
        ],
      ),
    );
  }
}
