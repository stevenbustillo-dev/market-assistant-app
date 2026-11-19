import '../../domain/product.dart';
import '../../domain/measurement.dart';

final class CalculatorState {
  final MeasurementCategory? category;
  final Measurement? baseMeasurement;
  final List<Product> products;
  final Product? bestProduct;

  const CalculatorState({
    required this.category,
    required this.baseMeasurement,
    required this.products,
    required this.bestProduct,
  });
}
