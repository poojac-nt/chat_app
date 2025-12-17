import 'package:flutter/cupertino.dart';

extension PaddingExtenstion on Widget {
  Widget withPadding(EdgeInsets padding) {
    return Padding(padding: padding, child: this);
  }
}
