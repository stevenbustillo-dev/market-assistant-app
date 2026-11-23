import 'package:material_ui/material_ui.dart';
import 'package:native_scope/native_scope.dart';

import '../view_models/calculator_view_model.dart';

final class CalculatorRoute extends StatefulWidget {
  final Widget child;

  const CalculatorRoute({super.key, required this.child});

  @override
  State<CalculatorRoute> createState() => _CalculatorRouteState();
}

final class _CalculatorRouteState extends State<CalculatorRoute> {
  late final CalculatorViewModel _calculatorViewModel;

  @override
  void initState() {
    super.initState();
    _calculatorViewModel = CalculatorViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return ScopeInjector<CalculatorViewModel>(
      injectable: _calculatorViewModel,
      child: widget.child,
    );
  }
}
