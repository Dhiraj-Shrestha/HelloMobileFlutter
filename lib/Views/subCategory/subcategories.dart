import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hello_mobiles/Api/Api.dart';
import 'package:hello_mobiles/Views/subCategory/subCategoryDetails.dart';
import 'package:hello_mobiles/Widgets/defaultAppbar.dart';

class SubCategories extends StatelessWidget {
  final catid;

  const SubCategories({Key key, this.catid}) : super(key: key);
  Future getCategoryData() async {
    try {
      var response = await Api().getData('categories/$catid');
      var subcategory = json.decode(response.body)['data'];

      return subcategory;
    } on SocketException {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultappbar(titleText: 'Sub Categories ', context: context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: getCategoryData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data.length);
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      //scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        var mydata = snapshot.data[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SubCategoryDetail(mydata: mydata)),
                              );
                            },
                            child: Container(
                              height: 130.0,
                              width: 400.0,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
                              child: Hero(
                                tag: 'hero-tag-subcategory${mydata['id']}',
                                child: Material(
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      // backgroundBlendMode: BlendMode.dstOver,
                                      // color: Colors.red,
                                      color: Colors.black.withOpacity(0.6),
                                      backgroundBlendMode: BlendMode.color,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                      image: DecorationImage(
                                        image: NetworkImage(mydata['image']),
                                        fit: BoxFit.cover,
                                        colorFilter: new ColorFilter.mode(
                                            Colors.black.withOpacity(0.5),
                                            BlendMode.darken),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFFABABAB)
                                              .withOpacity(0.3),
                                          blurRadius: 1.0,
                                          spreadRadius: 2.0,
                                        ),
                                      ],
                                      gradient: LinearGradient(
                                        begin: FractionalOffset.topCenter,
                                        end: FractionalOffset.bottomCenter,
                                        colors: [
                                          Colors.black.withOpacity(0.0),
                                          Color(0xff0069ff).withOpacity(0.8),
                                        ],
                                      ),
                                      // gradient: LinearGradient(
                                      //   colors: [Colors.black, Colors.black26],
                                      // ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                        color: Colors.black12.withOpacity(0.1),
                                      ),
                                      child: Center(
                                        child: Text(
                                          mydata['name'],
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            fontFamily: "Berlin",
                                            fontSize: 35.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );

                        // return Card(
                        //   child: InkWell(
                        //     onTap: () {
                        //       print("ggg");
                        //     },
                        //     child: ListTile(
                        //       title: Text(mydata["name"]),
                        //     ),
                        //   ),
                        // );
                      });
                  // return Text(mydata.length.toString());
                  // return Text(snapshot.data[0]['discount'].toString());
                  // return ListView.builder(
                  //   physics: NeverScrollableScrollPhysics(),
                  //   shrinkWrap: true,
                  //   itemCount: snapshot.data.length,
                  //   itemBuilder: (context, index) {
                  //     var mydata = snapshot.data[index];
                  //     return Text(mydata['discount'].toString());
                  //   },
                  // );
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
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:treva_shop_flutter/UI/BrandUIComponent/BrandDetail.dart';
// import 'package:treva_shop_flutter/ListItem/BrandDataList.dart';
// import 'package:treva_shop_flutter/UI/HomeUIComponent/Search.dart';

// class brand extends StatefulWidget {
//   @override
//   _brandState createState() => _brandState();
// }

// class _brandState extends State<brand> {
//   @override
//   Widget build(BuildContext context) {

//     return Padding(
//       padding: const EdgeInsets.only(top: 8.0),
//       child: Scaffold(
//         /// Calling variable appbar
//           appBar: _appbar,
//           body: Container(
//             color: Colors.white,
//             child: CustomScrollView(
//               /// Create List Menu
//               slivers: <Widget>[
//                 SliverPadding(
//                   padding: EdgeInsets.only(top: 0.0),
//                   sliver: SliverFixedExtentList(
//                       itemExtent: 145.0,
//                       delegate: SliverChildBuilderDelegate(
//                         /// Calling itemCard Class for constructor card
//                               (context, index) => itemCard(brandData[index]),
//                           childCount: brandData.length)),
//                 ),
//               ],
//             ),
//           )),
//     );
//   }
// }

// /// Constructor for itemCard for List Menu
// class itemCard extends StatelessWidget {
//   /// Declaration and Get data from BrandDataList.dart
//   final Brand brand;
//   itemCard(this.brand);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding:
//       const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
//       child: InkWell(
//         onTap: () {
//           Navigator.of(context).push(
//             PageRouteBuilder(
//                 pageBuilder: (, _, _) => new brandDetail(brand),
//                 transitionDuration: Duration(milliseconds: 600),
//                 transitionsBuilder:
//                     (, Animation<double> animation, _, Widget child) {
//                   return Opacity(
//                     opacity: animation.value,
//                     child: child,
//                   );
//                 }),
//           );
//         },
//         child: Container(
//           height: 130.0,
//           width: 400.0,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.circular(15.0))),
//           child: Hero(
//             tag: 'hero-tag-${brand.id}',
//             child: Material(
//               child: DecoratedBox(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                   image: DecorationImage(
//                       image: AssetImage(brand.img), fit: BoxFit.cover),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color(0xFFABABAB).withOpacity(0.3),
//                       blurRadius: 1.0,
//                       spreadRadius: 2.0,
//                     ),
//                   ],
//                 ),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                     color: Colors.black12.withOpacity(0.1),
//                   ),
//                   child: Center(
//                     child: Text(
//                       brand.name,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: "Berlin",
//                         fontSize: 35.0,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
