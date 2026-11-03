import '../../core/domain/language.dart';

final class MeasurementTranslation {
  final Language language;
  final String singular;
  final String plural;
  final String abbreviation;

  const MeasurementTranslation({
    required this.language,
    required this.singular,
    required this.plural,
    required this.abbreviation,
  });
}

final class MeasurementCategoryTranslation {
  final Language language;
  final String name;

  const MeasurementCategoryTranslation({
    required this.language,
    required this.name,
  });
}
