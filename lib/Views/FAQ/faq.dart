import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hello_mobiles/Api/Api.dart';
import 'package:hello_mobiles/Views/FAQ/faqItemBody.dart';
import 'package:hello_mobiles/Widgets/defaultAppbar.dart';
import 'package:hello_mobiles/size/size_config.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    //get faqs data
    Future getFaqs() async {
      try {
        var response = await Api().getData('faqs');
        var category = json.decode(response.body)['data'];
        print(category);
        return category;
      } on SocketException {
        return null;
      }
    }

    return Scaffold(
      appBar: defaultappbar(context: context, titleText: 'FAQ'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder(
                future: getFaqs(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var mydata = snapshot.data[index];
                        return FAQItemBody(mydata: mydata);
                      },
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
            ),
          ],
        ),
      ),
    );
  }
}
