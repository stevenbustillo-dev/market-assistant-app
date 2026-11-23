import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../domain/measurement.dart';
import '../../domain/measurement_repository.dart';

import '../models/product_form_error_model.dart';

import '../controllers/product_form_controller.dart';

import '../states/product_form_state.dart';

import './calculator_view_model.dart';

final class ProductFormViewModel {
  final ValueNotifier<ProductFormState> _state;

  ValueNotifier<ProductFormState> get state => _state;

  final ProductFormController _formController;

  ProductFormController get formController => _formController;

  final BuildContext _context;
  final CalculatorViewModel _calculatorViewModel;
  final MeasurementRepository _measurementRepository;

  ProductFormViewModel({
    required this._context,
    required this._calculatorViewModel,
    required this._measurementRepository,
  }) : _state = ValueNotifier<ProductFormState>(
         const ProductFormState(
           category: null,
           categories: [],
           measurements: [],
           hasMeasurements: false,
           isEditing: false,
           error: ProductFormErrorModel(
             description: null,
             packageUnits: null,
             amount: null,
             category: null,
             measure: null,
             price: null,
           ),
         ),
       ),
       _formController = ProductFormController();

  void _setError(
    ProductFormErrorModel Function(ProductFormErrorModel error) setError,
  ) {
    _state.value = _state.value = ProductFormState(
      category: _state.value.category,
      categories: _state.value.categories,
      measurements: _state.value.measurements,
      hasMeasurements: _state.value.hasMeasurements,
      isEditing: _state.value.isEditing,
      error: setError(_state.value.error),
    );
  }

  void initState() {
    _formController.initState(_setError);

    final hasSelectedCategory =
        _calculatorViewModel.state.value.category != null;

    _state.value = ProductFormState(
      category: _calculatorViewModel.state.value.category,
      categories: _measurementRepository.getAllMeasurementCategory(),
      measurements: hasSelectedCategory
          ? _calculatorViewModel.state.value.category!.measurements
          : _state.value.measurements,
      hasMeasurements: hasSelectedCategory,
      isEditing: _state.value.isEditing,
      error: _state.value.error,
    );
    if (_calculatorViewModel.state.value.category != null) {
      formController.categoryCtrl.add(
        _calculatorViewModel.state.value.category!,
      );
    }
  }

  void handleSelectCategory(List<MeasurementCategory> elements) {
    formController.measureCtrl.clear();
    final List<Measurement> measurements = elements.isEmpty
        ? []
        : elements[0].measurements;

    _state.value = ProductFormState(
      category: _state.value.category,
      categories: _state.value.categories,
      measurements: measurements,
      hasMeasurements: measurements.isNotEmpty,
      isEditing: _state.value.isEditing,
      error: _state.value.error,
    );
  }

  void handleAddProduct() {
    final (valid, category, baseMeasurement, product) = _formController
        .validate();
    if (!valid) {
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    _calculatorViewModel.addProduct(category!, baseMeasurement!, product!);
    handleBack();
  }

  void handleBack() {
    _context.pop();
  }

  void dispose() {
    _formController.dispose();
  }
}
