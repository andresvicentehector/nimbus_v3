import 'Dimensions.dart';

class AppDimensions implements Dimensions {
  @override
  String get fontRegular => 'Regular';
  @override
  String get fontBold => 'Medium';
  @override
  String get fontMedium => 'SemiBold';
  @override
  String get fontSemibold => 'Bold';

  @override
  double get textSizeLarge => 12.0;

  @override
  double get textSizeLargeMedium => 14.0;

  @override
  double get textSizeMedium => 16.0;

  @override
  double get textSizeNormal => 18.0;

  @override
  double get textSizeSMedium => 20.0;

  @override
  double get textSizeSmall => 24.0;

  @override
  double get textSizeXLarge => 28.0;

  @override
  double get textSizeXXLarge => 30.0;
}
