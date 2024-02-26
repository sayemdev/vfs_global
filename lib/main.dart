import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vfs_global/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VFS Global',
      theme: ThemeData(
        fontFamily: "inter.otf", // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const DashboardScreen(),
    );
  }
}

outlinedBorder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(width: 1, color: Colors.black));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoginVisible = false;
  bool isOtoVisible=false;
  bool isLoaderVisible=true;

  late Timer _timer;
  int _secondsPassed = 0;
  int _totalSeconds = 10;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), _incrementTimer);
  }

  void _incrementTimer(Timer timer) {
    setState(() {
      _secondsPassed++;
    });

    if (_secondsPassed == _totalSeconds) {
      _timer.cancel();
      setState(() {
        isLoginVisible=true;
        isLoaderVisible=false;
      });
      print('Timer completed!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 150),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset("assets/logo.png"),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(width: 2, color: Color(0xFFDEE2E6))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 6),
                        child: Row(
                          children: [
                            Text(
                              "English",
                              style: TextStyle(fontSize: 18),
                            ),
                            Icon(Icons.arrow_drop_down_rounded)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  width: double.infinity,
                  color: Color(0xfffdbe53),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(
                            Icons.warning_rounded,
                            size: 35,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Text(
                                style: TextStyle(fontSize: 19),
                                textAlign: TextAlign.justify,
                                "If you experience technical problems while logging in or registering, please send an e-mail to info.polandin@vfshelpline.com address.In your e-mail, be sure to include your first name, last name, phone number, information describing the problem and a screenshot of the page where the technical problem occurred."),
                          ),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                  child: ListView(
                children: [
                  SizedBox(height: 28),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: (MediaQuery.of(context).size.width / 3) + 80,
                      child: Column(
                        children: [
                          Visibility(
                            visible: isLoginVisible,
                            child: Card(
                              elevation: 1,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 40, horizontal: 50.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Sign in",
                                      style: TextStyle(fontSize: 25),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "Enter your email and password to continue",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    RichText(
                                        text: TextSpan(
                                            text: "Email",
                                            style: TextStyle(fontSize: 16),
                                            children: [
                                          TextSpan(
                                              text: "*",
                                              style:
                                                  TextStyle(color: Colors.red[900]))
                                        ])),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    TextFormField(
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 0),
                                            focusedBorder: outlinedBorder(),
                                            enabledBorder: outlinedBorder(),
                                            hintText: "jane.doe@email.com",
                                            border: outlinedBorder())),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    RichText(
                                        text: TextSpan(
                                            text: "Phone",
                                            style: TextStyle(fontSize: 16),
                                            children: [
                                          TextSpan(
                                              text: "*",
                                              style:
                                                  TextStyle(color: Colors.red[900]))
                                        ])),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    TextFormField(
                                        cursorColor: Colors.black,
                                        keyboardType: TextInputType.visiblePassword,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 0),
                                            focusedBorder: outlinedBorder(),
                                            enabledBorder: outlinedBorder(),
                                            hintText: "**********",
                                            border: outlinedBorder())),
                                    SizedBox(
                                      height: 14,
                                    ),
                                    Image.asset("assets/cloudfare.png"),
                                    SizedBox(
                                      height: 14,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              isLoginVisible=false;
                                              isOtoVisible=true;
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor: Color(0xffe86020)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12.0),
                                            child: Text(
                                              "Sign In",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          )),
                                    ),
                                    SizedBox(
                                      height: 14,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Forgot Password",
                                          style: TextStyle(
                                              decoration: TextDecoration.underline,
                                              fontSize: 19),
                                        ),
                                        Text(
                                          "I don't have an account",
                                          style: TextStyle(
                                              decoration: TextDecoration.underline,
                                              fontSize: 19),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 14),
                                    Text(
                                      "Activate my account",
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontSize: 19),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: isOtoVisible,
                            child: Card(
                              elevation: 1,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 40, horizontal: 50.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Sign in",
                                        style: TextStyle(fontSize: 25),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        "One time password(OTP) has been sent to your mobile number .Your One-time Password (OTP) is valid for 5 minutes.",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      RichText(
                                          text: TextSpan(
                                              text:
                                                  "Please enter your one time password(OTP)",
                                              style: TextStyle(fontSize: 16),
                                              children: [
                                            TextSpan(
                                                text: "*",
                                                style: TextStyle(
                                                    color: Colors.red[900]))
                                          ])),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      TextFormField(
                                          obscureText: true,
                                          cursorColor: Colors.black,
                                          decoration: InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 0),
                                              focusedBorder: outlinedBorder(),
                                              enabledBorder: outlinedBorder(),
                                              hintText: "*******",
                                              border: outlinedBorder())),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        DashboardScreen(),
                                                  ));
                                            },
                                            style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                backgroundColor: Color(0xffe86020)),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 12.0),
                                              child: Text(
                                                "Sign In",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            )),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  Container(
                    color: Color(0x24aeb8c4),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 150),
                      child: Text(
                        "AR-6.0.62 © 2024 VFS Global Group. All Rights Reserved. ISO 23026 compliant information. Our websites are created for viewing on modern browsers; Internet Explorer users please upgrade.",
                        style: TextStyle(fontSize: 17.5),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  )
                ],
              )),
            ],
          ),
          Visibility(
            visible: isLoaderVisible,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Color.fromRGBO(158, 158, 158, 50),
              child: Container(
                height: 200,
                width: 200,
                child: Image.asset("assets/loader.gif",height: 200,),
              ),
            ),
          )
        ],
      ),
    );
  }
}
