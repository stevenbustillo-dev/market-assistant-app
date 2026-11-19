import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui/ui.dart';

import '../../domain/product.dart';
import '../../domain/measurement.dart';
import '../../domain/measurement_repository.dart';

import 'calculator_view_model.dart';
import '../views/product_form_view.dart';

final class DefaultProductFormViewModel extends ChangeNotifier
    implements ProductFormViewModel {
  final List<MeasurementCategory> _categories;
  @override
  List<MeasurementCategory> get categories => _categories;

  List<Measurement>? _measurements;
  @override
  List<Measurement>? get measurements => _measurements;
  @override
  bool get hasMeasurements =>
      _measurements != null && _measurements!.isNotEmpty;

  final TextEditingController _descriptionCtrl;
  @override
  TextEditingController get descriptionCtrl => _descriptionCtrl;

  final TextEditingController _packageUnitsCtrl;
  @override
  TextEditingController get packageUnitsCtrl => _packageUnitsCtrl;

  final TextEditingController _amountCtrl;
  @override
  TextEditingController get amountCtrl => _amountCtrl;

  final ListEditingController<MeasurementCategory> _categoryCtrl;
  @override
  ListEditingController<MeasurementCategory> get categoryCtrl => _categoryCtrl;

  final ListEditingController<Measurement> _measureCtrl;
  @override
  ListEditingController<Measurement> get measureCtrl => _measureCtrl;

  final TextEditingController _priceCtrl;
  @override
  TextEditingController get priceCtrl => _priceCtrl;

  final bool _isEditing;
  @override
  bool get isEditing => _isEditing;

  final BuildContext _context;
  final CalculatorViewModel _state;
  final MeasurementRepository _measurementRepository;

  DefaultProductFormViewModel({
    required this._context,
    required this._state,
    required this._measurementRepository,
  }) : _categories = _measurementRepository.getAllMeasurementCategory(),
       _descriptionCtrl = TextEditingController(text: ''),
       _packageUnitsCtrl = TextEditingController(text: '1'),
       _amountCtrl = TextEditingController(text: ''),
       _categoryCtrl = ListEditingController(),
       _measureCtrl = ListEditingController(),
       _priceCtrl = TextEditingController(text: ''),
       _isEditing = false;

  @override
  void handleSelectCategory(List<MeasurementCategory> elements) {
    _measureCtrl.clear();
    if (elements.isEmpty) {
      _measurements = null;
    } else {
      _measurements = elements[0].measurements;
    }
    notifyListeners();
  }

  @override
  void handleAddProduct() {
    final description = _descriptionCtrl.text.trim();
    final unitPerPackage = int.parse(
      _packageUnitsCtrl.text.trim().isEmpty
          ? '0'
          : _packageUnitsCtrl.text.trim(),
    );
    final amountPerUnit = double.parse(
      _amountCtrl.text.trim().isEmpty ? '0' : _amountCtrl.text.trim(),
    );
    final measurement = _measureCtrl.value[0];
    final price = double.parse(
      _priceCtrl.text.trim().isEmpty ? '0' : _priceCtrl.text.trim(),
    );

    final product = Product(
      description: description,
      unitPerPackage: unitPerPackage,
      amountPerUnit: amountPerUnit,
      measurement: measurement,
      price: price,
    );

    print(product);
  }

  @override
  void handleBack() {
    _context.pop();
  }
}
