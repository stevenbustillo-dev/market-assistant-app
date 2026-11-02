import 'package:flutter/widgets.dart';

import '../models/calculator_data.dart';

final class CalculatorState extends ValueNotifier<CalculatorData> {
  CalculatorState() : super(const CalculatorData());
}
