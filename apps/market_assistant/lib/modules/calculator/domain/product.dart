import './measurement.dart';

final class Product {
  final String description;
  final double price;
  final int unitPerPackage;
  final double amountPerUnit;
  final Measurement measurement;

  const Product({
    required this.description,
    required this.price,
    required this.unitPerPackage,
    required this.amountPerUnit,
    required this.measurement,
  });

  double calculatePricePerAmount() {
    final baseAmount = unitPerPackage * amountPerUnit * measurement.factor;

    return price / baseAmount;
  }
}
