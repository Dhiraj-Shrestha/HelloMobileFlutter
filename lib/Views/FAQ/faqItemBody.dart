import 'package:flutter/material.dart';

class FAQItemBody extends StatelessWidget {
  final mydata;

  const FAQItemBody({Key key, this.mydata}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
      child: Card(
        child: DecoratedBox(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Theme.of(context).focusColor.withOpacity(0),
              offset: Offset(0, 5),
              blurRadius: 15,
            )
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5))),
                child: Text(
                  "* " + mydata['title'],
                  textAlign: TextAlign.justify,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .merge(TextStyle(color: Theme.of(context).primaryColor)),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5))),
                child: Text(
                  "- " + mydata['detail'],
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
