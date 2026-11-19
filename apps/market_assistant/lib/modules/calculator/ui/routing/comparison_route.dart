import 'package:material_ui/material_ui.dart';
import 'package:native_scope/native_scope.dart';

import '../states/comparison_state.dart';

import '../view_models/calculator_view_model.dart';
import '../view_models/comparison_view_model.dart';

import '../views/comparison_view.dart';

final class ComparisonRoute extends StatefulWidget {
  const ComparisonRoute({super.key});

  @override
  State<ComparisonRoute> createState() => _ComparisonRouteState();
}

final class _ComparisonRouteState extends State<ComparisonRoute> {
  late final ComparisonViewModel _comparisonViewModel;

  @override
  void initState() {
    super.initState();
    final calculatorViewModel = ScopeInjector.read<CalculatorViewModel>(
      context,
    );
    _comparisonViewModel = ComparisonViewModel(
      context: context,
      calculatorViewModel: calculatorViewModel,
    );
    _comparisonViewModel.initState();
  }

  @override
  void dispose() {
    _comparisonViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopeInjector<ComparisonViewModel>(
      injectable: _comparisonViewModel,
      child: ScopeProvider<ComparisonState>(
        notifier: _comparisonViewModel.state,
        child: const ComparisonView(),
      ),
    );
  }
}
