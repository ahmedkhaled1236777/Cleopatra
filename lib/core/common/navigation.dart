import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

navigateto({required BuildContext context, required Widget page}) {
  return Navigator.of(context).push(MaterialPageRoute(builder: (_) {
    return page;
  }));
}

navigateandfinish({required BuildContext context, required Widget page}) {
  return Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
    return page;
  }));
}
