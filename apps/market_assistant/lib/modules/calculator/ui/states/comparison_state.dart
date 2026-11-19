import '../../domain/product.dart';
import '../../domain/measurement.dart';

enum ComparisonViewState { initial, adding, calculable }

final class ComparisonState {
  final ComparisonViewState viewState;
  final Product? bestProduct;
  final Measurement? baseMeasurement;
  final List<Product> products;

  const ComparisonState({
    required this.viewState,
    required this.bestProduct,
    required this.baseMeasurement,
    required this.products,
  });
}
