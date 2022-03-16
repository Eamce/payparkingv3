import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:payparkingv3/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'package:gradient_text/gradient_text.dart';
import 'utils/db_helper.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'constants.dart';
import 'syncing.dart';
import 'about.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => new _SignInPageState();
}
class _SignInPageState extends State<SignInPage> {
  final db = PayParkingDatabase();
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoggedIn = false;
  List data;
  var b='!isLoggedIn';
  var user='';

  Future createDatabase() async{
     await db.init();
  }

  void log(){
    setState((){
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return CupertinoAlertDialog(
            content: new SpinKitRing(
              color: Colors.blueAccent,
              size: 80,
            ),
          );
        },
      );
    });
    logInAttempt();
  }

  Future logInAttempt() async{
//    bool result = await DataConnectionChecker().hasConnection;
//    if(result == true){
//      var res = await db.mysqlLogin(_usernameController.text,_passwordController.text);
    //  var timeLogIn=DateTime.now();
    final dateTimeLogin = DateFormat("yyyy-MM-dd : H:mm:ss aaa").format(DateTime.now());
    final dateLogIn= DateFormat("yyyy-MM-dd").format(DateTime.now());
    final timeLogIn= DateFormat("hh:mm:ss aaa").format(DateTime.now());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      var res = await db.ofLogin(_usernameController.text,_passwordController.text);
      setState(() {
        data = res;
      });
      if(data.isNotEmpty){
        print(data[0]['username']);
        prefs?.setString('empidKey',data[0]['empid']);
        prefs?.setString('username', data[0]['username']);
        prefs?.setBool('isLoggedIn', true);
        // print('Date Log In: $dateLogIn');
        // print('Time Log In: $timeLogIn');
        print("Username: "+data[0]['username']);
        print("Fullname: "+data[0]['fullname']);
        Navigator.of(context).pop();
        Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeT(logInData:data[0]['empid'])),
        );
  //      db.saveLogInDataToSqlite(data[0]['empid'], data[0]['fullname'], dateLogIn, timeLogIn);
       db.saveLogInData(data[0]['empid'], data[0]['fullname'], dateTimeLogin,'0000-00-00 00:00:00','0');
//    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomeT(logInData:data[0]['empid'])));
      }
      if(data.isEmpty){
        Navigator.of(context).pop();
        showDialog(
          barrierDismissible: true,
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return CupertinoAlertDialog(
              title: new Text("Wrong credentials"),
              content: new Text("Please check your username or password"),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
//    }
//    else{
//      Navigator.of(context).pop();
//      showDialog(
//        barrierDismissible: true,
//        context: context,
//        builder: (BuildContext context) {
//          // return object of type Dialog
//          return CupertinoAlertDialog(
//            title: new Text("Connection Problem"),
//            content: new Text("Please Connect to the wifi hotspot or turn your wifi on"),
//            actions: <Widget>[
//              // usually buttons at the bottom of the dialog
//              new FlatButton(
//                child: new Text("Close"),
//                onPressed: () {
//                  Navigator.of(context).pop();
//                },
//              ),
//            ],
//          );
//        },
//      );
//    }
  }

  @override
  void initState(){
    initPlatformState();
    super.initState();
    createDatabase();
 //   checkLogIn();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
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
    final username = Padding(
      padding:
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
      child: new TextField(
        autofocus: false,
        controller: _usernameController,
        decoration: InputDecoration(
          labelText: 'Username',
//          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, width/15.0),
//          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
        ),
      ),
    );

    final password = Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
      child: new TextField(
        autofocus: false,
        controller: _passwordController,
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Password',
//          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, width/15.0),
//          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
        ),
      ),
    );
    final loginButton = Padding(
      padding:  EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: new Container(
        height: 90.0,
        child: CupertinoButton(
          child:  Text('Log in',style: TextStyle(fontWeight: FontWeight.bold,fontSize: width/20.0, color: Colors.lightBlue),),
          onPressed:(){
//            Navigator.push(
//              context,
//              MaterialPageRoute(builder: (context) => HomeT()),
//            );
            log();
          },
        ),
      ),
    );
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
//          title: Text(''),
          actions: <Widget>[
            PopupMenuButton<String>(
              icon: Icon(Icons.settings_backup_restore, color: Colors.black),
              onSelected: choiceAction,
              itemBuilder: (BuildContext context){
                return Constants.choices.map((String choice){
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: new Center(
          child: Form(
            key: _formKey,
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
                username,
                SizedBox(height: 20.0),
                password,
                SizedBox(height: 5.0),
                loginButton,
                SizedBox(height: 20.0),
              ],
            ),),
        ),
      ),
    );
  }
  // Future choiceAction(String choice) async {
  //   if(choice == Constants.dbSync){
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => SyncingPage()),
  //     ).then((result) {
  //       SharedPreferences prefs= a
  //     });
  //   }
  //   if(choice == Constants.about){
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => About()),
  //     ).then((result) {
  //
  //     });
  //   }
  // }
   choiceAction(String choice)  {
    String passData='';
    if(choice == Constants.dbSync){
      Navigator.push(
        context,
         MaterialPageRoute(builder: (context) => SyncingPage(passData: 'download',)),
      ).then((result){

      });
    }
    if(choice == Constants.about){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => About()),
      ).then((result) {
      });
    }
  }
}
