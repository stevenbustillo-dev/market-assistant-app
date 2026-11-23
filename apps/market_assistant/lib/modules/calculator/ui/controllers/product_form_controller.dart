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

  (bool, String?, String) _validateDescription() {
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
    return (error == null, error, value);
  }

  (bool, String?, int) _validatePackageUnits() {
    final value = int.tryParse(packageUnitsCtrl.text.trim()) ?? 0;
    final error = value == 0
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
    return (error == null, error, value);
  }

  (bool, String?, double) _validateAmount() {
    final value = double.tryParse(amountCtrl.text.trim()) ?? 0.0;
    final error = value == 0.0
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
    return (error == null, error, value);
  }

  (bool, String?, MeasurementCategory) _validateCategory() {
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
    return (error == null, error, value[0]);
  }

  (bool, String?, Measurement) _validateMeasure() {
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
    return (error == null, error, value[0]);
  }

  (bool, String?, double) _validatePrice() {
    final value = double.tryParse(priceCtrl.text.trim()) ?? 0.0;
    final error = value == 0.0 ? 'el precio por paquete es requerido' : null;
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
    return (error == null, error, value);
  }

  (bool, MeasurementCategory?, Measurement?, Product?) validate() {
    final notValid = (false, null, null, null);

    final (isDescriptionValid, _, descriptionValue) = _validateDescription();
    if (!isDescriptionValid) {
      return notValid;
    }
    final (isPackageUnitsValid, _, packageUnitsValue) = _validatePackageUnits();
    if (!isPackageUnitsValid) {
      return notValid;
    }
    final (isAmountValid, _, amountValue) = _validateAmount();
    if (!isAmountValid) {
      return notValid;
    }
    final (isCategoryValid, _, categoryValue) = _validateCategory();
    if (!isCategoryValid) {
      return notValid;
    }
    final (isMeasureValid, _, measureValue) = _validateMeasure();
    if (!isMeasureValid) {
      return notValid;
    }
    final (isPriceValid, _, priceValue) = _validatePrice();
    if (!isPriceValid) {
      return notValid;
    }

    final baseMeasurement = categoryValue.measurements.firstWhere(
      (element) => element.isBase,
    );

    final product = Product(
      description: descriptionValue,
      price: priceValue,
      unitPerPackage: packageUnitsValue,
      amountPerUnit: amountValue,
      measurement: measureValue,
    );

    return (true, categoryValue, baseMeasurement, product);
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
