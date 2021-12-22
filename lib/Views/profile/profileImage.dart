import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:hello_mobiles/Api/Api.dart';
import 'package:hello_mobiles/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hello_mobiles/Widgets/buttonWidget.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({
    Key key,
  }) : super(key: key);

  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  int customerId;
  bool showUpload = false;
  @override
  void initState() {
    super.initState();
    getuserDetails();
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        // save(customerId);
        setState(() {});
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Success"),
      content: Text("Profile picture updated successfully"),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  List<Asset> imagePicker = List<Asset>();
  String _error;
  //For Image
  File imageFile;

  Future<void> loadAssets() async {
    setState(() {
      imagePicker = List<Asset>();
    });

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
      );
      showUpload = true;
    } on Exception catch (e) {
      error = e.toString();
    }

    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      imagePicker = resultList;
      if (error == null) _error = 'No Error Dectected';
    });
  }

  Future getuserDetails() async {
    var response = await Api().getData('user');
    var data = json.decode(response.body);
    customerId = data['id'];
    setState(() {});
  }

  Future save(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');
    final uri = Uri.parse(url + 'api/profile/$id?_method=PUT');
    MultipartFile multipartFile;

    MultipartRequest request = http.MultipartRequest('POST', uri);

    List<int> imageData = [];
    for (var image in imagePicker) {
      ByteData byteData = await image.getByteData();
      imageData = byteData.buffer.asInt8List();
      multipartFile = MultipartFile.fromBytes('profile_image[]', imageData,
          filename: image.name);
    }
    request.files.add(multipartFile);
    request.headers['Authorization'] = 'Bearer ' + token;
    var response = await request.send();
    print(response.statusCode);
    showAlertDialog(context);
    setState(() {
      imagePicker = null;
    });
  }

  //getprofile image
  Future getProfileImage() async {
    try {
      var response = await Api().getData('user');
      var profile = json.decode(response.body);
      print(profile);
      return profile;
    } on SocketException {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 115,
              width: 115,
              child: Stack(
                fit: StackFit.expand,
                overflow: Overflow.visible,
                children: [
                  FutureBuilder(
                    future: getProfileImage(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data['profile_image'] == null
                            ? CircleAvatar(
                                backgroundImage: AssetImage(
                                  'assets/images/userImage.png',
                                ),
                              )
                            : CircleAvatar(
                                backgroundImage: NetworkImage(
                                  url +
                                      'profileImage/' +
                                      snapshot.data['profile_image'],
                                ),
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
                  Positioned(
                    right: -15,
                    bottom: 0,
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(color: Colors.white),
                        ),
                        color: Color(0xFFF5F6F9),
                        onPressed: () {
                          loadAssets();
                        },
                        child: Center(
                          child: Icon(
                            Icons.camera_alt,
                            color: appColor,
                            size: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            imagePicker != null && showUpload != false
                ? SizedBox(
                    width: 150,
                    child: ButtonWidget(
                      borderColor: appColor,
                      borderRadius: 12,
                      buttonColor: appColor,
                      textColor: Colors.white,
                      buttonName: 'Upload Image',
                      onPressed: () {
                        save(customerId);
                      },
                    ),
                  )
                : Container(),

            // // buildGridView(),
            // imagePicker != null && showUpload != false
            //     ? SizedBox(
            //         child: RaisedButton(
            //           onPressed: () {
            //             save(customerId);
            //           },
            //           child: Text('Upload'),
            //         ),
            //       )
            //     : Container(),
          ],
        ),
      ),
    );
  }
}
