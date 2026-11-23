import 'package:flutter/widgets.dart';
import 'package:ui/ui.dart';

import '../../domain/measurement.dart';
import '../../domain/product.dart';

import '../models/product_form_error_model.dart';

final class ProductFormController {
  final TextEditingController descriptionCtrl;
  final TextEditingController packageUnitsCtrl;
  final TextEditingController amountCtrl;
  final ListEditingController<MeasurementCategory> categoryCtrl;
  final ListEditingController<Measurement> measureCtrl;
  final TextEditingController priceCtrl;

  late final void Function(
    ProductFormErrorModel Function(ProductFormErrorModel currentError),
  )
  _setError;

  ProductFormController()
    : descriptionCtrl = TextEditingController(text: ''),
      packageUnitsCtrl = TextEditingController(text: '1'),
      amountCtrl = TextEditingController(text: ''),
      categoryCtrl = ListEditingController(),
      measureCtrl = ListEditingController(),
      priceCtrl = TextEditingController(text: '');

  void initState(
    void Function(
      ProductFormErrorModel Function(ProductFormErrorModel currentError),
    )
    setError,
  ) {
    _setError = setError;

    descriptionCtrl.addListener(_validateDescription);
    packageUnitsCtrl.addListener(_validatePackageUnits);
    amountCtrl.addListener(_validateAmount);
    categoryCtrl.addListener(_validateCategory);
    measureCtrl.addListener(_validateMeasure);
    priceCtrl.addListener(_validatePrice);
  }

  (bool, String) _validateDescription() {
    final value = descriptionCtrl.text.trim();
    final error = value.isEmpty ? 'la descripción es requerida' : null;
    _setError(
      (currentError) => ProductFormErrorModel(
        description: error,
        packageUnits: currentError.packageUnits,
        amount: currentError.amount,
        category: currentError.category,
        measure: currentError.measure,
        price: currentError.price,
      ),
    );
    return (error == null, (error ?? value));
  }

  (bool, String) _validatePackageUnits() {
    final value = packageUnitsCtrl.text.trim();
    final error = value.isEmpty
        ? 'las unudades en el paquete son requeridas'
        : null;
    _setError(
      (currentError) => ProductFormErrorModel(
        description: currentError.description,
        packageUnits: error,
        amount: currentError.amount,
        category: currentError.category,
        measure: currentError.measure,
        price: currentError.price,
      ),
    );
    return (error == null, (error ?? value));
  }

  (bool, String) _validateAmount() {
    final value = amountCtrl.text.trim();
    final error = value.isEmpty
        ? 'la cantidad por unidad o por paquete es requerida'
        : null;
    _setError(
      (currentError) => ProductFormErrorModel(
        description: currentError.description,
        packageUnits: currentError.packageUnits,
        amount: error,
        category: currentError.category,
        measure: currentError.measure,
        price: currentError.price,
      ),
    );
    return (error == null, (error ?? value));
  }

  (bool, String, MeasurementCategory) _validateCategory() {
    final value = categoryCtrl.value;
    final error = value.isEmpty ? 'la categoría es requerida' : null;
    _setError(
      (currentError) => ProductFormErrorModel(
        description: currentError.description,
        packageUnits: currentError.packageUnits,
        amount: currentError.amount,
        category: error,
        measure: currentError.measure,
        price: currentError.price,
      ),
    );
    return (error == null, error ?? '', value[0]);
  }

  (bool, String, Measurement) _validateMeasure() {
    final value = measureCtrl.value;
    final error = value.isEmpty ? 'la unidad de medida es requerida' : null;
    _setError(
      (currentError) => ProductFormErrorModel(
        description: currentError.description,
        packageUnits: currentError.packageUnits,
        amount: currentError.amount,
        category: currentError.category,
        measure: error,
        price: currentError.price,
      ),
    );
    return (error == null, error ?? '', value[0]);
  }

  (bool, String) _validatePrice() {
    final value = priceCtrl.text.trim();
    final error = value.isEmpty ? 'el precio por paquete es requerido' : null;
    _setError(
      (currentError) => ProductFormErrorModel(
        description: currentError.description,
        packageUnits: currentError.packageUnits,
        amount: currentError.amount,
        category: currentError.category,
        measure: currentError.measure,
        price: error,
      ),
    );
    return (error == null, (error ?? value));
  }

  (bool, Product?) validate() {
    return (false, null);
  }

  void dispose() {
    descriptionCtrl.removeListener(_validateDescription);
    packageUnitsCtrl.removeListener(_validatePackageUnits);
    amountCtrl.removeListener(_validateAmount);
    categoryCtrl.removeListener(_validateCategory);
    measureCtrl.removeListener(_validateMeasure);
    priceCtrl.removeListener(_validatePrice);
  }
}
