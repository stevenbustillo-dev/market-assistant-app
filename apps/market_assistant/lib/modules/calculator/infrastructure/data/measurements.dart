import '../../domain/measurement.dart';
import '../../domain/measurement_translation.dart';

import '../../../core/infrastructure/data/languages.dart';

const measurementCategories = [
  MeasurementCategory(
    code: 'mass',
    translations: [
      MeasurementCategoryTranslation(language: esLanguage, name: 'Masa'),
    ],
    measurements: [
      Measurement(
        code: 'mg',
        translations: [
          MeasurementTranslation(
            language: esLanguage,
            singular: 'Miligramo',
            plural: 'Miligramos',
          ),
        ],
        factor: 0.001,
        isBase: false,
      ),
      Measurement(
        code: 'g',
        translations: [
          MeasurementTranslation(
            language: esLanguage,
            singular: 'Gramo',
            plural: 'Gramos',
          ),
        ],
        factor: 1.0,
        isBase: true,
      ),
      Measurement(
        code: 'kg',
        translations: [
          MeasurementTranslation(
            language: esLanguage,
            singular: 'Kilogramo',
            plural: 'Kilogramos',
          ),
        ],
        factor: 1000.0,
        isBase: false,
      ),
      Measurement(
        code: 'oz',
        translations: [
          MeasurementTranslation(
            language: esLanguage,
            singular: 'Onza',
            plural: 'Onzas',
          ),
        ],
        factor: 28.349523125,
        isBase: false,
      ),
      Measurement(
        code: 'lb',
        translations: [
          MeasurementTranslation(
            language: esLanguage,
            singular: 'Libra',
            plural: 'Libras',
          ),
        ],
        factor: 453.59237,
        isBase: false,
      ),
    ],
  ),
  MeasurementCategory(
    code: 'volume',
    translations: [
      MeasurementCategoryTranslation(language: esLanguage, name: 'Volumen'),
    ],
    measurements: [
      Measurement(
        code: 'ml',
        translations: [
          MeasurementTranslation(
            language: esLanguage,
            singular: 'Mililitro',
            plural: 'Mililitros',
          ),
        ],
        factor: 1.0,
        isBase: true,
      ),
      Measurement(
        code: 'l',
        translations: [
          MeasurementTranslation(
            language: esLanguage,
            singular: 'Litro',
            plural: 'Litros',
          ),
        ],
        factor: 1000.0,
        isBase: false,
      ),
      Measurement(
        code: 'gal',
        translations: [
          MeasurementTranslation(
            language: esLanguage,
            singular: 'Galón',
            plural: 'Galones',
          ),
        ],
        factor: 3785.411784,
        isBase: false,
      ),
    ],
  ),
  MeasurementCategory(
    code: 'count',
    translations: [
      MeasurementCategoryTranslation(language: esLanguage, name: 'Conteo'),
    ],
    measurements: [
      Measurement(
        code: 'unit',
        translations: [
          MeasurementTranslation(
            language: esLanguage,
            singular: 'Unidad',
            plural: 'Unidades',
          ),
        ],
        factor: 1.0,
        isBase: true,
      ),
      Measurement(
        code: 'dozen',
        translations: [
          MeasurementTranslation(
            language: esLanguage,
            singular: 'Docena',
            plural: 'Docenas',
          ),
        ],
        factor: 12.0,
        isBase: false,
      ),
    ],
  ),
  MeasurementCategory(
    code: 'length',
    translations: [
      MeasurementCategoryTranslation(language: esLanguage, name: 'Longitud'),
    ],
    measurements: [
      Measurement(
        code: 'mm',
        translations: [
          MeasurementTranslation(
            language: esLanguage,
            singular: 'Milímetro',
            plural: 'Milímetros',
          ),
        ],
        factor: 0.1,
        isBase: false,
      ),
      Measurement(
        code: 'cm',
        translations: [
          MeasurementTranslation(
            language: esLanguage,
            singular: 'Centímetro',
            plural: 'Centímetros',
          ),
        ],
        factor: 1.0,
        isBase: true,
      ),
      Measurement(
        code: 'm',
        translations: [
          MeasurementTranslation(
            language: esLanguage,
            singular: 'Metro',
            plural: 'Metros',
          ),
        ],
        factor: 100.0,
        isBase: false,
      ),
      Measurement(
        code: 'km',
        translations: [
          MeasurementTranslation(
            language: esLanguage,
            singular: 'Kilómetro',
            plural: 'Kilómetros',
          ),
        ],
        factor: 100000.0,
        isBase: false,
      ),
      Measurement(
        code: 'inch',
        translations: [
          MeasurementTranslation(
            language: esLanguage,
            singular: 'Pulgada',
            plural: 'Pulgadas',
          ),
        ],
        factor: 2.54,
        isBase: false,
      ),
      Measurement(
        code: 'ft',
        translations: [
          MeasurementTranslation(
            language: esLanguage,
            singular: 'Pie',
            plural: 'Pies',
          ),
        ],
        factor: 30.48,
        isBase: false,
      ),
      Measurement(
        code: 'yd',
        translations: [
          MeasurementTranslation(
            language: esLanguage,
            singular: 'Yarda',
            plural: 'Yardas',
          ),
        ],
        factor: 91.44,
        isBase: false,
      ),
    ],
  ),
  MeasurementCategory(
    code: 'area',
    translations: [
      MeasurementCategoryTranslation(language: esLanguage, name: 'Área'),
    ],
    measurements: [
      Measurement(
        code: 'cm2',
        translations: [
          MeasurementTranslation(
            language: esLanguage,
            singular: 'Centímetro cuadrado',
            plural: 'Centímetros cuadrados',
          ),
        ],
        factor: 1.0,
        isBase: true,
      ),
      Measurement(
        code: 'm2',
        translations: [
          MeasurementTranslation(
            language: esLanguage,
            singular: 'Metro cuadrado',
            plural: 'Metros cuadrados',
          ),
        ],
        factor: 10000.0,
        isBase: false,
      ),
      Measurement(
        code: 'ft2',
        translations: [
          MeasurementTranslation(
            language: esLanguage,
            singular: 'Pie cuadrado',
            plural: 'Pies cuadrados',
          ),
        ],
        factor: 929.0304,
        isBase: false,
      ),
    ],
  ),
];
