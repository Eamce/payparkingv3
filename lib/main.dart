import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'login.dart';
import 'delinquent.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PayParking Login',
//      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      home: Splash(),
      //MyApp2(),
//        home:Delinquent(),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String deviceName = '';
  String deviceVersion = '';
  String identifier = '';

  void initState() {
  //  GlobalVariables.bodyContext = context;
    Timer(Duration(seconds: 4), () {
      //gotoLogin();
      checkLogIn();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final logoSmall = GradientText("Basement",
        gradient: LinearGradient(colors: [Colors.deepOrangeAccent, Colors.blueAccent, Colors.pink]),
        style: TextStyle(fontWeight: FontWeight.bold ,fontSize: width/17),
        textAlign: TextAlign.center);

    final logo = GradientText("PayParking",
        gradient: LinearGradient(colors: [Colors.deepOrangeAccent, Colors.blue, Colors.pink]),
        style: TextStyle(fontWeight: FontWeight.bold ,fontSize: width/13),
        textAlign: TextAlign.center);
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Form(
                child: new ListView(
                  physics: new PageScrollPhysics(),
                  shrinkWrap: true,
                  padding: new EdgeInsets.only(left: 30.0, right: 30.0),
                  children: <Widget>[
                    SizedBox(height: 40.0),
                    logoSmall,
                    SizedBox(height: 0.0),
                    logo,
                    SizedBox(height: 40.0),
                    SizedBox(height: 20.0),
                  ],
                ),), // child: Image.asset(
              //   Assets.pc,
              //   width: 300,
              // ),
            ),
          ),
          Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Future gotoLogin() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
    );

    // var res = await checkIfConnectedToNetwork();
    // if (res == 'error') {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => ErrorScreen()),
    //   );
    // } else if (res == 'errornet') {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => NointernetScreen()),
    //   );
    // } else {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => LoginScreen()),
    //   );
    // }
  }
  Future<void> checkLogIn()async{
    var user='';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user=prefs.getString('empidKey') ?? '';
    bool status=prefs.getBool('isLoggedIn') ?? false;
    if(status){
      print('trueeeee');
      print(user);
      print(status);
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeT(logInData:user)),
      );
    }else{
      print('falseeee');
      print(status);
      print(user);
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignInPage()),
      );
    }
  }
  // Future<void> _deviceDetails() async {
  //   final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
  //   try {
  //     if (Platform.isAndroid) {
  //       var build = await deviceInfoPlugin.androidInfo;
  //       deviceName = build.model;
  //       identifier = build.androidId;
  //
  //       GlobalVariables.deviceInfo = "$deviceName $identifier";
  //       GlobalVariables.readdeviceInfo = "${build.brand} ${build.device}";
  //
  //       //UUID for Android
  //     } else if (Platform.isIOS) {
  //       var data = await deviceInfoPlugin.iosInfo;
  //
  //       deviceName = data.name;
  //       identifier = data.identifierForVendor;
  //       GlobalVariables.deviceInfo = "$deviceName $identifier";
  //       GlobalVariables.readdeviceInfo = "${data.utsname.machine}";
  //       //UUID for iOS
  //     }
  //   } on PlatformException {
  //     print('Failed to get platform version');
  //   }
  // }
}
