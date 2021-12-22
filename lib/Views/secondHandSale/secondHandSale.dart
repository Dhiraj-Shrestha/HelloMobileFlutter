import 'dart:convert';
import 'dart:io';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hello_mobiles/Widgets/buttonWidget.dart';
import 'package:hello_mobiles/Widgets/defaultAppbar.dart';
import 'package:hello_mobiles/Widgets/snackBarSimple.dart';
import 'package:hello_mobiles/Widgets/textFieldWidgetValidateOnSubmit.dart';
import 'package:hello_mobiles/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondHandSale extends StatefulWidget {
  @override
  _SecondHandSaleState createState() => _SecondHandSaleState();
}

class _SecondHandSaleState extends State<SecondHandSale> {
  int _radioValue1 = 0;
  int _showDetail = 0;
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate;
  bool flag = false;
  bool isSwitched = false;
  // ZefyrController

  TextEditingController nameController = new TextEditingController();

  TextEditingController priceController = new TextEditingController();

  TextEditingController descriptionController = new TextEditingController();

  TextEditingController imageController = new TextEditingController();

  TextEditingController exireDateController = new TextEditingController();

  List<Asset> imagePicker = List<Asset>();
  String _error;
  //For Image
  File imageFile;

  void clear() {
    nameController.text = '';
    priceController.text = '';
    imageController.text = '';
    descriptionController.text = '';
    _radioValue1 = 0;
    _showDetail = 0;
    imagePicker.clear();
  }

  Widget buildGridView() {
    if (imagePicker != null)
      return GridView.count(
        crossAxisCount: 3,
        children: List.generate(imagePicker.length, (index) {
          Asset asset = imagePicker[index];
          return AssetThumb(
            asset: asset,
            width: 300,
            height: 300,
          );
        }),
      );
    else
      return Container(color: Colors.white);
  }

  Future<void> loadAssets() async {
    setState(() {
      imagePicker = List<Asset>();
      imageController.text = 'Image selected';
    });

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 3,
      );
    } on Exception catch (e) {
      imageController.text = imagePicker == null ? 'image' : '';
      error = e.toString();
    }
    if (!mounted) return;

    setState(() {
      imagePicker = resultList;
      if (error == null) _error = 'No Error Dectected';
    });
  }

  Future save() async {
    setState(() {
      flag = true;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');

    final uri = Uri.parse(url + 'api/secondhandproducts');
    // MultipartFile multipartFile;

    MultipartRequest request = http.MultipartRequest('POST', uri);

    List<int> imageData;
    for (var image in imagePicker) {
      ByteData byteData = await image.getByteData();
      imageData = byteData.buffer.asUint8List();
      MultipartFile multipartFile = MultipartFile.fromBytes(
        'images[]',
        imageData,
        filename: image.name,
      );

      // add file to multipart

      request.files.add(multipartFile);
    }
    // request.files.add(multipartFile);
    request.headers['Accept'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ' + token;
    request.fields['name'] = nameController.text;
    request.fields['price'] = priceController.text;
    request.fields['description'] = descriptionController.text;
    request.fields['warrenty'] = _radioValue1.toString();
    request.fields['expireDate'] = _selectedDate.toString();
    request.fields['showDetail'] = _showDetail.toString();

    http.Response response =
        await http.Response.fromStream(await request.send());
    var result = json.decode(response.body);
    setState(() {
      flag = false;
    });
    if (result['code'] == 200) {
      showSimpleSnackBar(
          context: context,
          title: 'Your request has been sent',
          message: 'You will be notified soon');
      clear();
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text('Request Fail'),
              content: Container(
                  height: MediaQuery.of(context).size.height / 5,
                  child: Text(
                      "Something went wrong!!\nTry again.") // result['message']['name'][0].toString()

                  ),
              actions: [
                RaisedButton(
                  onPressed: () {
                    // error = '';
                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          });
    }
  }

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultappbar(titleText: 'Product Sell', context: context),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 2.0,
                ),
                // color: Color(0XFFF8F8F8),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidgetAutoValidateFalse(
                      labelText: 'Product Name',
                      name: 'Name',
                      controller: nameController,
                      validators: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context,
                            errorText: kNameNullError),
                      ]),
                      inputType: TextInputType.emailAddress,
                    ),
                    TextFieldWidgetAutoValidateFalse(
                      controller: priceController,
                      labelText: 'Price',
                      name: 'Price',
                      validators: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context,
                            errorText: kPriceNullError),
                      ]),
                      inputType: TextInputType.number,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 7.0, bottom: 5.0),
                      child: FormBuilderTextField(
                        name: 'Description',
                        decoration: InputDecoration(
                          labelText: 'Description',
                          focusColor: appColor,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.2, color: appColor),
                            borderRadius: new BorderRadius.circular(12.0),
                          ),
                          fillColor: appColor,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(12.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context,
                              errorText: kDescriptionNullError),
                        ]),
                        autovalidateMode: AutovalidateMode.disabled,
                        maxLines: 5,
                        maxLength: 1000,
                        keyboardType: TextInputType.multiline,
                        controller: descriptionController,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Warrenty:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 25,
                          child: Radio(
                            value: 0,
                            groupValue: _radioValue1,
                            onChanged: _handleRadioValueChange1,
                            activeColor: appColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _radioValue1 = 1;
                            });
                          },
                          child: Text("Not Available"),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 25,
                          child: Radio(
                            value: 1,
                            groupValue: _radioValue1,
                            onChanged: _handleRadioValueChange1,
                            activeColor: appColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _radioValue1 = 0;
                            });
                          },
                          child: Text("Available"),
                        ),
                      ],
                    ),
                    ListTile(
                        leading: Icon(
                          Icons.calendar_today,
                          size: 21,
                          color: appColor,
                        ),
                        title: DateTimeField(
                          decoration:
                              InputDecoration(hintText: 'Select Expire Date'),
                          autovalidate: false,
                          format: DateFormat('yyyy-MM-dd'),
                          onShowPicker: (context, currentValue) {
                            return showDatePicker(
                                firstDate: DateTime.now(),
                                initialDate: DateTime.now(),
                                lastDate: DateTime(DateTime.now().year + 2),
                                context: context);
                          },
                          validator: (value) {
                            if ((value.toString().isEmpty) ||
                                (DateTime.tryParse(value.toString()) == null)) {
                              return 'Please enter a date';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() => _selectedDate = value);
                          },
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.purple),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IntrinsicHeight(
                        child: InkWell(
                          onTap: () {
                            loadAssets();
                          },
                          child: Row(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: appColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        bottomLeft: Radius.circular(12))),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7.0),
                                    child: Text("BROWSE"),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7.0),
                                  child: FormBuilderTextField(
                                    readOnly: true,
                                    name: 'image',
                                    controller: imageController,

                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Choose your pic",
                                        hintStyle: TextStyle()),

                                    // onChanged: (){},
                                    // valueTransformer: (text) => num.tryParse(text),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context,
                                          errorText: 'Please select image'),
                                    ]),
                                    autovalidateMode: AutovalidateMode.disabled,

                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    (imagePicker == null || imagePicker.length == 0)
                        ? Container()
                        : Container(
                            height: 100,
                            child: buildGridView(),
                          ),
                    Row(
                      children: [
                        Text("Show Your Full Details"),
                        Switch(
                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              _showDetail == 1
                                  ? _showDetail = 0
                                  : _showDetail = 1;
                              isSwitched = value;
                              print(_showDetail);
                              // _handleShowDetailValueChange1(value);

                              print(isSwitched);
                            });
                          },
                          activeTrackColor: appColor,
                          activeColor: appColor,
                        ),
                      ],
                    ),
                    ButtonWidget(
                      buttonColor: appColor,
                      borderColor: appColor,
                      buttonName: flag == false ? 'Send Request' : 'Loading',
                      borderRadius: 12.0,
                      textColor: Colors.white,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          save();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
