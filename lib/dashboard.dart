import 'dart:async';
import 'dart:math' as math;

import 'package:custom_check_box/custom_check_box.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

import 'Appointment.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isLoaderVisible = true;
  bool isApListVisible = false;

  late Timer _timer;
  int _secondsPassed = 0;
  int _totalSeconds = 5;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < appointments.length; i++) {
      appointments[i].location = _randomizeLocation();
    }
    _timer = Timer.periodic(Duration(seconds: 1), _incrementTimer);
  }

  void _incrementTimer(Timer timer) {
    setState(() {
      _secondsPassed++;
    });

    if (_secondsPassed == _totalSeconds) {
      _timer.cancel();
      setState(() {
        isLoaderVisible = false;
        isApListVisible = true;
      });
      print('Timer completed!');
    }
  }

  bool detailsLoader = false;

  void _hideWidgetAfterDelay() {
    Future.delayed(Duration(seconds: 10), () {
      if (mounted) {
        print("end");
        setState(() {
          detailsLoader = false; // Hide the widget after 10 seconds
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );

    return Scaffold(
      body: !isDetails
          ? Stack(
              children: [
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 150),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset("assets/logo.png"),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 6),
                            child: Row(
                              children: [
                                Text(
                                  "Sign Out",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 40,
                  ),
                  Expanded(
                      child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 250),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Active application(s)",
                                      style: TextStyle(
                                          color: Color(0xffe86020),
                                          fontSize: 16),
                                    ),
                                    Container(
                                      height: 4,
                                      color: Colors.transparent,
                                      width: 200,
                                    )
                                  ],
                                ),
                                ElevatedButton(
                                    onPressed: null,
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: Color(0xffe86020)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0),
                                      child: Text(
                                        "Start New Booking",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  height: 4,
                                  color: Color(0xffe86020),
                                  width: 200,
                                ),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: Divider(
                                    height: 1,
                                  ),
                                ))
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Visibility(
                              visible: isApListVisible,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListView.builder(
                                    itemBuilder: (context, index) {
                                      return Card(
                                        margin: EdgeInsets.only(bottom: 20),
                                        color: Colors.grey[100],
                                        child: Padding(
                                          padding: const EdgeInsets.all(25.0),
                                          child: Container(
                                              width: double.infinity,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    "Appointment details",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16.5),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    appointments[index]
                                                        .category,
                                                    style:
                                                        TextStyle(fontSize: 22),
                                                  ),
                                                  SizedBox(
                                                    height: 14,
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Group Reference Number - ${appointments[index].referenceNumber}",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors
                                                                .grey[600]),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () async {
                                                          print("object");
                                                          setState(() {
                                                            isDetails = true;
                                                            detailsLoader =
                                                                true;
                                                            _hideWidgetAfterDelay();
                                                          });
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      8.0),
                                                          child: Text(
                                                              "Manage Appointment",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xffe86020),
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                  fontSize:
                                                                      18)),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 14,
                                                  ),
                                                  Divider(),
                                                  SizedBox(
                                                    height: 14,
                                                  ),
                                                  Text(
                                                    "Applicants:",
                                                    style: TextStyle(
                                                        fontSize: 16.5),
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    appointments[index].name,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        color:
                                                            Colors.grey[600]),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      );
                                    },
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: appointments.length,
                                  ),
                                  Text(
                                    "IMPORTANT",
                                    style: TextStyle(fontSize: 19),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                      "Once you press the button 'Start New Booking', please carefully read the information provided on the next page to ensure your appointment to be scheduled properly.",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.grey),
                                      textAlign: TextAlign.justify),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      CustomCheckBox(
                                        value: check1,
                                        shouldShowBorder: true,
                                        borderColor: Colors.black,
                                        checkedFillColor: Colors.black,
                                        borderRadius: 6,
                                        borderWidth: 1,
                                        checkBoxSize: 24,
                                        onChanged: (val) {
                                          //do your stuff here
                                          setState(() {
                                            check1 = val;
                                          });
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                            "I confirm that I will read this information before scheduling an appointment.",
                                            style: TextStyle(fontSize: 17),
                                            textAlign: TextAlign.justify),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Text(
                                    "WARNING",
                                    style: TextStyle(fontSize: 19),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                      "In case an appointment will be scheduled for the incorrect Visa category, Visa sub-category and/or Visa application centre, your application will not be accepted at a Visa application center, and you will not get the prepaid service tee back.",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.grey),
                                      textAlign: TextAlign.justify),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomCheckBox(
                                        value: check1,
                                        shouldShowBorder: true,
                                        borderColor: Colors.black,
                                        checkedFillColor: Colors.black,
                                        borderRadius: 6,
                                        borderWidth: 1,
                                        checkBoxSize: 24,
                                        onChanged: (val) {
                                          //do your stuff here
                                          setState(() {
                                            check1 = val;
                                          });
                                        },
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 12.0),
                                          child: Text(
                                            "I confirm that I am responsible to choose the correct Visa category, Visa sub-category and Visa application center while scheduling an appointment.",
                                            style: TextStyle(fontSize: 17),
                                            textAlign: TextAlign.justify,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 300,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
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
                ]),
                Visibility(
                  visible: isLoaderVisible,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Color.fromRGBO(158, 158, 158, 50),
                    child: Container(
                      height: 200,
                      width: 200,
                      child: Image.asset(
                        "assets/loader.gif",
                        height: 200,
                      ),
                    ),
                  ),
                )
              ],
            )
          : Stack(
              children: [
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 150),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset("assets/logo.png"),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 6),
                            child: Row(
                              children: [
                                Text(
                                  "Sign Out",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 40,
                  ),
                  Expanded(
                      child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 250),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                    height: 25,
                                    width: 25,
                                    child: Image.asset(
                                      "assets/backimg.png",
                                      height: 25,
                                      color: Color(0xffe86020),
                                      width: 25,
                                    )),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  "Back",
                                  style: TextStyle(
                                      fontSize: 17, color: Color(0xffe86020)),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "National Employment",
                              style: TextStyle(fontSize: 23),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Group Reference Number - ${appointments[0].referenceNumber}",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.grey[600]),
                            ),
                            SizedBox(height: 30,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: ExpansionTileCard(
                                key: cardA,
                                leading: const CircleAvatar(child: Text('A')),
                                title: const Text('Tap me!'),
                                subtitle: const Text('I expand!'),
                                children: <Widget>[
                                  const Divider(
                                    thickness: 1.0,
                                    height: 1.0,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 8.0,
                                      ),
                                      child: Text(
                                        """Hi there, I'm a drop-in replacement for Flutter's ExpansionTile.

Use me any time you think your app could benefit from being just a bit more Material.

These buttons control the next card down!""",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  ButtonBar(
                                    alignment: MainAxisAlignment.spaceAround,
                                    buttonHeight: 52.0,
                                    buttonMinWidth: 90.0,
                                    children: <Widget>[
                                      TextButton(
                                        style: flatButtonStyle,
                                        onPressed: () {
                                          cardB.currentState?.expand();
                                        },
                                        child:  Column(
                                          children: <Widget>[
                                            Icon(Icons.arrow_downward),
                                            Padding(
                                              padding: EdgeInsets.symmetric(vertical: 2.0),
                                            ),
                                            Text('Open'),
                                          ],
                                        ),
                                      ),
                                      TextButton(
                                        style: flatButtonStyle,
                                        onPressed: () {
                                          cardB.currentState?.collapse();
                                        },
                                        child:  Column(
                                          children: <Widget>[
                                            Icon(Icons.arrow_upward),
                                            Padding(
                                              padding: EdgeInsets.symmetric(vertical: 2.0),
                                            ),
                                            Text('Close'),
                                          ],
                                        ),
                                      ),
                                      TextButton(
                                        style: flatButtonStyle,
                                        onPressed: () {
                                          cardB.currentState?.toggleExpansion();
                                        },
                                        child:  Column(
                                          children: <Widget>[
                                            Icon(Icons.swap_vert),
                                            Padding(
                                              padding: EdgeInsets.symmetric(vertical: 2.0),
                                            ),
                                            Text('Toggle'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: ExpansionTileCard(
                                key: cardB,
                                expandedTextColor: Colors.red,
                                leading: const CircleAvatar(child: Text('B')),
                                title: const Text('Tap me!'),
                                subtitle: const Text('I expand, too!'),
                                children: <Widget>[
                                  const Divider(
                                    thickness: 1.0,
                                    height: 1.0,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 8.0,
                                      ),
                                      child: Text(
                                        """Hi there, I'm a drop-in replacement for Flutter's ExpansionTile.

Use me any time you think your app could benefit from being just a bit more Material.

These buttons control the card above!""",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  ButtonBar(
                                    alignment: MainAxisAlignment.spaceAround,
                                    buttonHeight: 52.0,
                                    buttonMinWidth: 90.0,
                                    children: <Widget>[
                                      TextButton(
                                        style: flatButtonStyle,
                                        onPressed: () {
                                          cardA.currentState?.expand();
                                        },
                                        child:  Column(
                                          children: <Widget>[
                                            Icon(Icons.arrow_downward),
                                            Padding(
                                              padding: EdgeInsets.symmetric(vertical: 2.0),
                                            ),
                                            Text('Open'),
                                          ],
                                        ),
                                      ),
                                      TextButton(
                                        style: flatButtonStyle,
                                        onPressed: () {
                                          cardA.currentState?.collapse();
                                        },
                                        child:  Column(
                                          children: <Widget>[
                                            Icon(Icons.arrow_upward),
                                            Padding(
                                              padding: EdgeInsets.symmetric(vertical: 2.0),
                                            ),
                                            Text('Close'),
                                          ],
                                        ),
                                      ),
                                      TextButton(
                                        style: flatButtonStyle,
                                        onPressed: () {
                                          cardA.currentState?.toggleExpansion();
                                        },
                                        child:  Column(
                                          children: <Widget>[
                                            Icon(Icons.swap_vert),
                                            Padding(
                                              padding: EdgeInsets.symmetric(vertical: 2.0),
                                            ),
                                            Text('Toggle'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
                ]),
                Visibility(
                  visible: detailsLoader,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Color.fromRGBO(158, 158, 158, 50),
                    child: Container(
                      height: 200,
                      width: 200,
                      child: Image.asset(
                        "assets/loader.gif",
                        height: 200,
                      ),
                    ),
                  ),
                )
              ],
            ),
    );

  }
  final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = GlobalKey();


  bool check1 = false;

  List<Appointment> appointments = [
    Appointment(
      name: 'MD ZIHAD ALI',
      referenceNumber: 'XYZ82079856306',
      category: 'National Employment',
      dateTime: DateTime(2024, 3, 5, 9, 0),
      location:
          'Shivaji Stadium Metro Station, Mezzanine Level, Baba Kharak Singh Marg, Connaught Place',
      email: 'zihad.vfs24@gmail.com',
      phone: '880 1739478332',
      nationality: 'Bangladeshi',
      passportNumber: 'A00868689',
    ),
    Appointment(
      name: 'Farid Ahmed',
      referenceNumber: 'XYZ82074794893',
      category: 'National Employment',
      dateTime: DateTime(2024, 3, 17, 12, 0),
      location: "_randomizeLocation()",
      email: 'farid.ahmed@gmail.com',
      phone: '+880123456789',
      nationality: 'Bangladeshi',
      passportNumber: 'AH08290455',
    ),
    Appointment(
      name: 'Farid Ahmed',
      referenceNumber: 'XYZ82074794893',
      category: 'National Employment',
      dateTime: DateTime(2024, 3, 1, 9, 0),
      location: 'VFS Office, Dhaka',
      email: 'farid.ahmed@gmail.com',
      phone: '+880123456789',
      nationality: 'Bangladeshi',
      passportNumber: 'EJ56432938',
    ),
    Appointment(
      name: 'Nadia Rahman',
      referenceNumber: 'XYZ82075468754',
      category: 'National Study',
      dateTime: DateTime(2024, 3, 2, 10, 30),
      location: 'VFS Office, Chittagong',
      email: 'nadia.rahman@gmail.com',
      phone: '+880987654321',
      nationality: 'Bangladeshi',
      passportNumber: 'BD987654',
    ),
    Appointment(
      name: 'Ayesha Khan',
      referenceNumber: 'XYZ82072157678',
      category: 'National Employment',
      dateTime: DateTime(2024, 3, 3, 13, 45),
      location: 'VFS Office, Sylhet',
      email: 'ayesha.khan@gmail.com',
      phone: '+880123456789',
      nationality: 'Bangladeshi',
      passportNumber: 'BD654321',
    ),
    Appointment(
      name: 'Imran Hussain',
      referenceNumber: 'XYZ82078776876',
      category: 'National Employment',
      dateTime: DateTime(2024, 3, 4, 11, 15),
      location: 'VFS Office, Rajshahi',
      email: 'imran.hussain@gmail.com',
      phone: '+880987654321',
      nationality: 'Bangladeshi',
      passportNumber: 'BD210987',
    ),
    Appointment(
      name: 'Tasnim Islam',
      referenceNumber: 'XYZ09876557675',
      category: 'National Employment',
      dateTime: DateTime(2024, 3, 5, 14, 0),
      location: 'VFS Office, Khulna',
      email: 'tasnim.islam@gmail.com',
      phone: '+880123456789',
      nationality: 'Bangladeshi',
      passportNumber: 'BD098765',
    ),
    Appointment(
      name: 'Sadia Chowdhury',
      referenceNumber: 'XYZ76543276543',
      category: 'National Study',
      dateTime: DateTime(2024, 3, 6, 9, 30),
      location: 'VFS Office, Barisal',
      email: 'sadia.chowdhury@gmail.com',
      phone: '+880987654321',
      nationality: 'Bangladeshi',
      passportNumber: 'BD765432',
    ),
    Appointment(
      name: 'Faisal Rahman',
      referenceNumber: 'XYZ23456779875',
      category: 'National Employment',
      dateTime: DateTime(2024, 3, 7, 11, 0),
      location: 'VFS Office, Rangpur',
      email: 'faisal.rahman@gmail.com',
      phone: '+880123456789',
      nationality: 'Bangladeshi',
      passportNumber: 'BD234567',
    ),
    Appointment(
      name: 'Tahmina Akhtar',
      referenceNumber: 'XYZ87654365648',
      category: 'National Employment',
      dateTime: DateTime(2024, 3, 8, 13, 30),
      location: 'VFS Office, Mymensingh',
      email: 'tahmina.akhtar@gmail.com',
      phone: '+880987654321',
      nationality: 'Bangladeshi',
      passportNumber: 'BD876543',
    ),
    Appointment(
      name: 'Arif Islam',
      referenceNumber: 'XYZ34567835454',
      category: 'National Employment',
      dateTime: DateTime(2024, 3, 9, 15, 0),
      location: 'VFS Office, Sylhet',
      email: 'arif.islam@gmail.com',
      phone: '+880123456789',
      nationality: 'Bangladeshi',
      passportNumber: 'BD345678',
    ),
    Appointment(
      name: 'Nusrat Jahan',
      referenceNumber: 'XYZ90123489783',
      category: 'National Study',
      dateTime: DateTime(2024, 3, 10, 10, 0),
      location: 'VFS Office, Rajshahi',
      email: 'nusrat.jahan@gmail.com',
      phone: '+880987654321',
      nationality: 'Bangladeshi',
      passportNumber: 'BD901234',
    ),
    Appointment(
      name: 'Rahim Ahmed',
      referenceNumber: 'XYZ45678935455',
      category: 'National Employment',
      dateTime: DateTime(2024, 3, 11, 12, 30),
      location: 'VFS Office, Chittagong',
      email: 'rahim.ahmed@gmail.com',
      phone: '+880123456789',
      nationality: 'Bangladeshi',
      passportNumber: 'BD456789',
    ),
    Appointment(
      name: 'Samiha Khan',
      referenceNumber: 'XYZ89012393765',
      category: 'National Employment',
      dateTime: DateTime(2024, 3, 12, 14, 0),
      location: 'VFS Office, Dhaka',
      email: 'samiha.khan@gmail.com',
      phone: '+880987654321',
      nationality: 'Bangladeshi',
      passportNumber: 'BD890123',
    ),
    Appointment(
      name: 'Abdul Rahman',
      referenceNumber: 'XYZ56789087845',
      category: 'National Employment',
      dateTime: DateTime(2024, 3, 13, 16, 0),
      location: 'VFS Office, Khulna',
      email: 'abdul.rahman@gmail.com',
      phone: '+880123456789',
      nationality: 'Bangladeshi',
      passportNumber: 'BD567890',
    ),
    Appointment(
      name: 'Shabnam Ahmed',
      referenceNumber: 'XYZ23456767556',
      category: 'National Study',
      dateTime: DateTime(2024, 3, 14, 9, 0),
      location: 'VFS Office, Sylhet',
      email: 'shabnam.ahmed@gmail.com',
      phone: '+880987654321',
      nationality: 'Bangladeshi',
      passportNumber: 'BD234567',
    ),
    Appointment(
      name: 'Rafi Khan',
      referenceNumber: 'XYZ78901276543',
      category: 'National Employment',
      dateTime: DateTime(2024, 3, 15, 11, 0),
      location: 'VFS Office, Dhaka',
      email: 'rafi.khan@gmail.com',
      phone: '+880123456789',
      nationality: 'Bangladeshi',
      passportNumber: 'BD789012',
    ),
    Appointment(
      name: 'Nazia Rahman',
      referenceNumber: 'XYZ34567845766',
      category: 'National Employment',
      dateTime: DateTime(2024, 3, 16, 13, 0),
      location: 'VFS Office, Rajshahi',
      email: 'nazia.rahman@gmail.com',
      phone: '+880987654321',
      nationality: 'Bangladeshi',
      passportNumber: 'BD345678',
    ),
    Appointment(
      name: 'Kamal Ahmed',
      referenceNumber: 'XYZ90123496394',
      category: 'National Employment',
      dateTime: DateTime(2024, 3, 17, 15, 0),
      location: 'VFS Office, Chittagong',
      email: 'kamal.ahmed@gmail.com',
      phone: '+880123456789',
      nationality: 'Bangladeshi',
      passportNumber: 'BD901234',
    ),
    Appointment(
      name: 'Sabina Khan',
      referenceNumber: 'XYZ56789095425',
      category: 'National Study',
      dateTime: DateTime(2024, 3, 18, 10, 0),
      location: 'VFS Office, Dhaka',
      email: 'sabina.khan@gmail.com',
      phone: '+880987654321',
      nationality: 'Bangladeshi',
      passportNumber: 'BD567890',
    ),
    Appointment(
      name: 'Fahim Rahman',
      referenceNumber: 'XYZ12345645020',
      category: 'National Employment',
      dateTime: DateTime(2024, 3, 19, 12, 0),
      location: 'VFS Office, Sylhet',
      email: 'fahim.rahman@gmail.com',
      phone: '+880123456789',
      nationality: 'Bangladeshi',
      passportNumber: 'BD123456',
    ),
    Appointment(
      name: 'Rina Islam',
      referenceNumber: 'XYZ78901297473',
      category: 'National Employment',
      dateTime: DateTime(2024, 3, 20, 14, 0),
      location: 'VFS Office, Dhaka',
      email: 'rina.islam@gmail.com',
      phone: '+880987654321',
      nationality: 'Bangladeshi',
      passportNumber: 'BD789012',
    ),
    Appointment(
      name: 'Taher Khan',
      referenceNumber: 'XYZ234567',
      category: 'National Employment',
      dateTime: DateTime(2024, 3, 21, 16, 0),
      location: 'VFS Office, Chittagong',
      email: 'taher.khan@gmail.com',
      phone: '+880123456789',
      nationality: 'Bangladeshi',
      passportNumber: 'BD234567',
    ),
    Appointment(
      name: 'Sabrina Ahmed',
      referenceNumber: 'XYZ89012378583',
      category: 'National Study',
      dateTime: DateTime(2024, 3, 22, 9, 0),
      location: 'VFS Office, Rajshahi',
      email: 'sabrina.ahmed@gmail.com',
      phone: '+880987654321',
      nationality: 'Bangladeshi',
      passportNumber: 'BD890123',
    ),
    Appointment(
      name: 'Imtiaz Khan',
      referenceNumber: 'XYZ45678907294',
      category: 'National Employment',
      dateTime: DateTime(2024, 3, 23, 11, 0),
      location: 'VFS Office, Sylhet',
      email: 'imtiaz.khan@gmail.com',
      phone: '+880123456789',
      nationality: 'Bangladeshi',
      passportNumber: 'BD456789',
    ),
    Appointment(
      name: 'Anika Rahman',
      referenceNumber: 'XYZ901234354246',
      category: 'National Employment',
      dateTime: DateTime(2024, 3, 24, 13, 0),
      location: 'VFS Office, Dhaka',
      email: 'anika.rahman@gmail.com',
      phone: '+880987654321',
      nationality: 'Bangladeshi',
      passportNumber: 'BD901234',
    ),
    Appointment(
      name: 'Rezaul Karim',
      referenceNumber: 'XYZ92758345678',
      category: 'National Employment',
      dateTime: DateTime(2024, 3, 25, 15, 0),
      location: 'VFS Office, Chittagong',
      email: 'rezaul.karim@gmail.com',
      phone: '+880123456789',
      nationality: 'Bangladeshi',
      passportNumber: 'BD567890',
    ),
  ];

  String _randomizeLocation() {
    final locations = [
      "Shivaji Stadium Metro Station, Mezzanine Level, Baba Kharak Singh Marg, Connaught Place",
      "5th Floor, Rene Tower, Plot No AA-I, 1842, Rajdanga Main Road, Kasba"
    ];
    return locations[math.Random().nextInt(locations.length)];
  }

  bool isDetails = false;
}
