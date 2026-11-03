import './measurement_translation.dart';

final class Measurement {
  final String id;
  final String code;
  final List<MeasurementTranslation> translations;
  final double factor;
  final bool isBase;

  const Measurement({
    required this.id,
    required this.code,
    required this.translations,
    required this.factor,
    required this.isBase,
  });
}

final class MeasurementCategory {
  final String id;
  final String code;
  final List<MeasurementCategoryTranslation> translations;
  final List<Measurement> measurements;

  const MeasurementCategory({
    required this.id,
    required this.code,
    required this.translations,
    required this.measurements,
  });
}
