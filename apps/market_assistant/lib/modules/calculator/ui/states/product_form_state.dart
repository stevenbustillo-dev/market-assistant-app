import '../../domain/measurement.dart';

import '../models/product_form_error_model.dart';

final class ProductFormState {
  final MeasurementCategory? category;
  final List<MeasurementCategory> categories;
  final List<Measurement> measurements;
  final bool hasMeasurements;
  final bool isEditing;
  final ProductFormErrorModel error;

  const ProductFormState({
    required this.category,
    required this.categories,
    required this.measurements,
    required this.hasMeasurements,
    required this.isEditing,
    required this.error,
  });
}
