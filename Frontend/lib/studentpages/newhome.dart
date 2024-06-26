import "package:flutter/material.dart";
import 'package:mess/studentpages/campus.dart';
import 'package:mess/studentpages/messoff.dart';
import 'package:mess/studentpages/pdf_viewer_screen.dart';
import 'Newmenu.dart';
import 'global_vari.dart';
import 'options.dart';
import 'qr.dart';
import 'northform.dart';

class Newhome extends StatefulWidget {
  const Newhome({super.key});

  @override
  State<Newhome> createState() => _NewhomeState();
}

class _NewhomeState extends State<Newhome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: ListView.builder(
        itemCount: options.length,
        itemBuilder: (BuildContext context, int index) {
          final opt = options[index];
          return GestureDetector(
            onTap: () {
              if (opt['title'] == 'MESS MENU') {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return PdfViewerScreen();
                }));
              } else if (opt['title'] == 'MESS PREFERENCE FORM') {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return campus();
                }));
              } else if (opt['title'] == 'MESS OFF') {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return MessOff();
                }));
              } else {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ScanQrPage();
                }));
              }
            },
            child: Maker(
                title: opt['title'] as String, image: opt['image'] as String),
          );
        },
      ),
    );
  }
}
