import 'package:Nimbus/template/Resources.dart';
import 'package:flutter/cupertino.dart';

extension AppContext on BuildContext {
  Resources get resources => Resources.of(this);
}
