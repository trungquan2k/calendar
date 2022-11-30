import 'package:flutter/material.dart';
import 'package:calendar/responsive/web_view.dart';
import 'package:calendar/responsive/mobile_view.dart';
import 'package:calendar/responsive/responsive_layout.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobileView: MyMobileBody(),
        webView: WebResposiveView(),
      ),
    );
  }
}
