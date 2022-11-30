import 'package:calendar/utils/dimensions.dart';
import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileView;
  final Widget webView;

  ResponsiveLayout({required this.mobileView, required this.webView});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < mobileWidth) {
          return mobileView;
        } else {
          return webView;
        }
      },
    );
  }
}
