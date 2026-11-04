import './measurement.dart';

final class Product {
  final String description;
  final double price;
  final int unitPerPackage;
  final double pricePerUnit;
  final Measurement measurement;

  const Product({
    required this.description,
    required this.price,
    required this.unitPerPackage,
    required this.pricePerUnit,
    required this.measurement,
  });
}
