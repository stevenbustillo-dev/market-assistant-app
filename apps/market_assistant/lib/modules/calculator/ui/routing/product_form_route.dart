import 'package:material_ui/material_ui.dart';
import 'package:native_scope/native_scope.dart';

import '../../infrastructure/repositories/measurement_repository.dart';

import '../states/product_form_state.dart';

import '../view_models/calculator_view_model.dart';
import '../view_models/product_form_view_model.dart';

import '../views/product_form_view.dart';

final class ProductFormRoute extends StatefulWidget {
  const ProductFormRoute({super.key});

  @override
  State<ProductFormRoute> createState() => _ProductFormRouteState();
}

final class _ProductFormRouteState extends State<ProductFormRoute> {
  late final ProductFormViewModel _productFormViewModel;

  @override
  void initState() {
    super.initState();
    final calculatorViewModel = ScopeInjector.read<CalculatorViewModel>(
      context,
    );
    final measurementRepository = LocalMeasurementRepository();
    _productFormViewModel = ProductFormViewModel(
      context: context,
      calculatorViewModel: calculatorViewModel,
      measurementRepository: measurementRepository,
    );
    _productFormViewModel.initState();
  }

  @override
  void dispose() {
    _productFormViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopeInjector<ProductFormViewModel>(
      injectable: _productFormViewModel,
      child: ScopeProvider<ProductFormState>(
        notifier: _productFormViewModel.state,
        child: const ProductFormView(),
      ),
    );
  }
}
