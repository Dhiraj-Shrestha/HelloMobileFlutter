import 'package:flutter/material.dart';
import 'package:hello_mobiles/Views/HomeScreen/components/categoriesCard.dart';

import 'package:hello_mobiles/Views/HomeScreen/components/products/recentProduct/productcard.dart';
import 'package:hello_mobiles/Views/HomeScreen/components/showMore.dart';

import 'package:hello_mobiles/Views/mainscreen/AppBarWidget.dart';
import 'package:hello_mobiles/Views/mainscreen/DrawerWidget.dart';
import 'package:hello_mobiles/Views/HomeScreen/components/toppromoslider.dart';
import 'package:hello_mobiles/Views/search/productSearch.dart';
import 'package:hello_mobiles/Widgets/ContainerWithCount.dart';
import 'package:hello_mobiles/provider/product.dart';
import 'package:hello_mobiles/routes/router_constants.dart';
import 'package:hello_mobiles/size/size_config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello_mobiles/utils/constant.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_recognition/speech_recognition.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SpeechRecognition _speech;
  bool _speechRecognitionAvailable = false;
  bool _isListening = false;

  String transcription = '';

  @override
  void initState() {
    super.initState();
    activateSpeechRecognizer();
  }

  void requestPermission() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.microphone);

    if (permission != PermissionStatus.granted) {
      await PermissionHandler()
          .requestPermissions([PermissionGroup.microphone]);
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  void activateSpeechRecognizer() {
    _speech = new SpeechRecognition();
    _speech.setAvailabilityHandler(onSpeechAvailability);
    _speech.setCurrentLocaleHandler(onCurrentLocale);
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    _speech
        .activate()
        .then((res) => setState(() => _speechRecognitionAvailable = res));
  }

  void start() => _speech
      .listen(locale: 'en_US')
      .then((result) => print('Started listening => result $result'));

  void cancel() =>
      _speech.cancel().then((result) => setState(() => _isListening = result));

  void stop() => _speech.stop().then((result) {
        setState(() => _isListening = result);
      });

  void onSpeechAvailability(bool result) =>
      setState(() => _speechRecognitionAvailable = result);

  void onCurrentLocale(String locale) =>
      setState(() => print("current locale: $locale"));

  void onRecognitionStarted() => setState(() => _isListening = true);

  void onRecognitionResult(String text) {
    setState(() {
      showSearch(context: context, delegate: DataSearch(q: text));
    });
  }

  void onRecognitionComplete() => setState(() => _isListening = false);

  Widget _buildVoiceInput({String label, VoidCallback onPressed}) =>
      new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Row(
            children: <Widget>[
              InkWell(
                onTap: () {
                  setState(() => _isListening = false);
                  start();
                },
                child: Text(
                  label,
                  style: const TextStyle(color: appColor),
                ),
              ),
              IconButton(
                icon: Icon(Icons.mic),
                onPressed: onPressed,
              ),
            ],
          ));

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        // title: Image.asset(
        //   "assets/images/ic_app_icon.png",
        //   width: 80,
        //   height: 40,
        // ),
        title: Text(
          'Hello Mobiles',
          style: TextStyle(color: appColor),
        ),
        actions: <Widget>[
          _buildVoiceInput(
            onPressed: () {
              requestPermission();
              _speechRecognitionAvailable && !_isListening ? start() : stop();
            },
            label: _isListening ? 'Listening...' : '',
          ),
          //Adding the search widget in AppBar
          IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search),
            //Don't block the main thread
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              CarouselPage(),
              showMore(
                  icon: FontAwesomeIcons.solidPlusSquare,
                  suffixText: 'Recently Added',
                  prefixText: '',
                  onTap: () {}),
              Container(
                  height: getProportionateScreenHeight(200),
                  child: ProductCard()),
              showMore(
                  icon: FontAwesomeIcons.tasks,
                  suffixText: 'Categories',
                  prefixText: '',
                  onTap: () {}),
              Container(
                  height: getProportionateScreenHeight(120),
                  child: Categories()),
            ],
          ),
        ),
      ),
    );
  }
}
