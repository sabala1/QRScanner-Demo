import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QRScanner Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Code Reader'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _scanResult = '...';
  bool _isYoutube = false;
  bool _isLineLink = false;
  bool _isFaceBook = false;
  bool _isTikTok = false;

  Widget showTT() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2.0, 12.0, 2.0, 12.0),
      child: Image.asset(
        'images/tt.png',
        height: 150.0,
        width: 34,),
    );
  }
  Widget showYT() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 13.0, 0.0, 13.0),
      child: Image.asset(
          'images/yt.png',
          height: 150,
          width: 40,
      ),
    );
  }
  Widget showLL() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(3.7, 12.0, 0.20, 12.0),
      child: Image.asset(
        'images/ll.png',
        height: 190.80,
        width: 40,),
    );
  }
  Widget showFB() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 12.5, 0.0, 10.5),
      child: Image.asset(
        'images/fb.png',
        height: 190,
        width: 50,),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 196, 194, 194),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 51, 50, 50),
          title: Image.asset(
            'images/logo.png',
            height: 100.0,
            width: 150.0,
          ),
          actions:[          
             showTT(),
             showYT(),
             showLL(),
             showFB(),
          ]
      ),

      body: Container(
        padding: const EdgeInsets.all(8), //??????????????????????????????????????????????????????????????????
        //???????????????????????????????????? widget
        child: SizedBox(
          width: double.infinity, //?????????????????????????????????????????????????????????????????????
          height: 280,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '???????????????????????????',
                    style: GoogleFonts.prompt(
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(_scanResult),
                  const Spacer(),
                  _isYoutube
                      ? SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: const Text(
                              '??????????????????????????? Youtube',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red.shade400,
                            ),
                            onPressed: () async {
                              if (await canLaunch(_scanResult)) {
                                if (Platform.isIOS) {
                                  await launch(_scanResult,
                                      forceSafariVC: false);
                                } else {
                                  await launch(_scanResult);
                                }
                              }
                            },
                          ))
                      : Container(),
                  _isLineLink
                      ? SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: const Text(
                              '??????????????????????????? Line',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green.shade600,
                            ),
                            onPressed: () async {
                              if (await canLaunch(_scanResult)) {
                                if (Platform.isIOS) {
                                  await launch(_scanResult,
                                      forceSafariVC: false);
                                } else {
                                  await launch(_scanResult);
                                }
                              }
                            },
                          ))
                      : Container(),
                  _isFaceBook
                      ? SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: const Text(
                              '??????????????????????????? FaceBook',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue.shade900,
                            ),
                            onPressed: () async {
                              if (await canLaunch(_scanResult)) {
                                if (Platform.isIOS) {
                                  await launch(_scanResult,
                                      forceSafariVC: false);
                                } else {
                                  await launch(_scanResult);
                                }
                              }
                            },
                          ))
                      : Container(),
                  _isTikTok
                      ? SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: const Text(
                              '??????????????????????????? TikTok',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.pink[600],
                            ),
                            onPressed: () async {
                              if (await canLaunch(_scanResult)) {
                                if (Platform.isIOS) {
                                  await launch(_scanResult,
                                      forceSafariVC: false);
                                } else {
                                  await launch(_scanResult);
                                }
                              }
                            },
                          ))
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),

      //????????????SCAN
      floatingActionButton: ElevatedButton(
        onPressed: () {
          startScan();
        },
        style: ElevatedButton.styleFrom(
            primary: const Color.fromARGB(255, 51, 50, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        child: SizedBox(
          width: 80,
          height: 40,
          child: Row(
            children: const [
              Icon(
                Icons.qr_code_scanner,
                color: Colors.white,
              ),
              SizedBox(width: 15),
              Text(
                'SCAN',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  
  //???????????????????????? onpressed (barcode)
  //??????????????????
  startScan() async {
    var colorCode = '#EE1021'; //HEX ?????????????????? SCAN
    var cancelButtonText = ''; //???????????? cancel ?????????????????? SCAN
    var isShowFlashIcon = true; // false ????????? true ????????????flash
    var scanMode = ScanMode.DEFAULT;

    var scanResult = await FlutterBarcodeScanner.scanBarcode(
        colorCode, cancelButtonText, isShowFlashIcon, scanMode);

    _isYoutube = false; //??????????????????link youtube ?????????????????????????????????????????????
    _isLineLink = false;
    _isFaceBook = false;
    _isTikTok = false;

    if (scanResult != '-1') {
      //????????????????????? -1 ????????????setState??????????????? (?????????????????????????????????) //??????????????????????????? -1 ??????setState (??????????????????????????????Scan?????????)
      //????????????????????????????????????????????????????????????????????? scan
      if (scanResult.contains('youtube.com')) {
        _isYoutube = true;
      } else if (scanResult.contains('line.me')) {
        _isLineLink = true;
      } else if (scanResult.contains('facebook.com')) {
        _isFaceBook = true;
      } else if (scanResult.contains('tiktok.com')) {
        _isTikTok = true;
      } else if (scanResult.contains('musical.ly')) {
        _isTikTok = true;
      }

      setState(() {
        _scanResult = scanResult;
      });
    }
  }
}
