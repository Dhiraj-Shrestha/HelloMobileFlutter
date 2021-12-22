import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hello_mobiles/Api/Api.dart';
import 'package:hello_mobiles/Widgets/defaultAppbar.dart';
import 'package:hello_mobiles/models/notificationModel.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Future getNotificationData() async {
    try {
      var response = await Api().getData('notifications');
      var notifications = json.decode(response.body)['data'];
      print(notifications);
      return notifications;
    } on SocketException {
      return null;
    }
  }

  Future getData(int index) async {
    try {
      var response = await Api().getData('notifications');
      var notifications = json.decode(response.body)['data'];
      print(notifications);
      var data = json.decode(notifications[index]['data']);
      print(data);
      return data;
    } on SocketException {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: defaultappbar(context: context, titleText: 'Notification'),
      body: FutureBuilder(
        future: getNotificationData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return snapshot.data.length == 0
                ? NoItemNotifications()
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return FutureBuilder(
                        future: getData(index),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                                height: 88.0,
                                child: Column(
                                  children: <Widget>[
                                    Divider(height: 5.0),
                                    ListTile(
                                      title: Text(
                                        snapshot.data['message'].toString(),
                                        style: TextStyle(
                                            fontSize: 17.5,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      // title: ListView.builder(
                                      //   physics: NeverScrollableScrollPhysics(),
                                      //   shrinkWrap: true,
                                      //   itemCount: mydata['data'][0].length,
                                      //   itemBuilder:
                                      //       (BuildContext context, int index) {
                                      //     return Text(
                                      //         mydata['data']['message'].toString());
                                      //   },
                                      // ),
                                      subtitle: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 6.0),
                                        child: Container(
                                          width: 440.0,
                                          // child: Text(
                                          //   'Hello',
                                          //   style: new TextStyle(
                                          //       fontSize: 15.0,
                                          //       fontStyle: FontStyle.italic,
                                          //       color: Colors.black38),
                                          //   overflow: TextOverflow.ellipsis,
                                          // ),
                                        ),
                                      ),
                                      leading: Column(
                                        children: <Widget>[
                                          Container(
                                            height: 40.0,
                                            width: 40.0,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(60.0)),
                                              // image: DecorationImage(image: AssetImage('${items[index].image}'),fit: BoxFit.cover)
                                            ),
                                            child: Icon(Icons.notifications),
                                          )
                                        ],
                                      ),
                                      // onTap: () =>
                                      //     _onTapItem(context, mydata),
                                    ),
                                    Divider(height: 5.0),
                                  ],
                                ));
                          } else if (snapshot.hasError) {
                            return Text('Cannot load at this time');
                          } else {
                            return Center(child: LinearProgressIndicator());
                          }
                        },
                      );
                    },
                  );
          } else {
            return LinearProgressIndicator();
          }
        },
      ),
    );
  }
}

class NoItemNotifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              "assets/images/notification.png",
              height: 200.0,
            ),
            Padding(padding: EdgeInsets.only(bottom: 30.0)),
            Text(
              "You don't have any notifications",
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
  }
}
