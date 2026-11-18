import '../../domain/measurement.dart';
import '../../domain/measurement_repository.dart';

import '../data/measurements.dart';

final class LocalMeasurementRepository implements MeasurementRepository {
  const LocalMeasurementRepository();

  @override
  List<MeasurementCategory> getAllMeasurementCategory() {
    return measurementCategories;
  }
}
