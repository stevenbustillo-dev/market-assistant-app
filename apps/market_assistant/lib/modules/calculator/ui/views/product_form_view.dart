import 'package:material_ui/material_ui.dart';
import 'package:ui/ui.dart';

import '../../domain/measurement.dart';

abstract interface class ProductFormViewModel extends ChangeNotifier {
  List<MeasurementCategory> get categories;
  List<Measurement>? get measurements;

  bool get hasMeasurements;

  TextEditingController get descriptionCtrl;
  TextEditingController get packageUnitsCtrl;
  TextEditingController get amountCtrl;
  ListEditingController<MeasurementCategory> get categoryCtrl;
  ListEditingController<Measurement> get measureCtrl;
  TextEditingController get priceCtrl;

  bool get isEditing;

  void handleSelectCategory(List<MeasurementCategory> elements);

  void handleBack();
  void handleAddProduct();
}

final class ProductFormView extends StatelessWidget {
  final ProductFormViewModel _viewModel;

  const ProductFormView({super.key, required this._viewModel});

  @override
  Widget build(BuildContext context) {
    final theme = context.uiTheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.getColors(UiPriority.neutral).background,
              theme.getColors(UiPriority.neutral).surface,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              UiHeader(
                priority: _viewModel.isEditing
                    ? UiPriority.danger
                    : UiPriority.secondary,
                title: _viewModel.isEditing
                    ? 'Editando producto'
                    : 'Agregando producto',
                leadingIcon: Icons.arrow_back_ios_new,
                onLeadingIconPressed: _viewModel.handleBack,
                hasOffset: true,
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsetsGeometry.all(
                    theme.getSpacing(UiSpacing.lg),
                  ),
                  child: Column(
                    spacing: theme.getSpacing((UiSpacing.lg)),
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            spacing: theme.getSpacing(UiSpacing.lg),
                            children: [
                              UiFieldLayout(
                                title: 'Descripción del producto',
                                child: UiField(
                                  priority: _viewModel.isEditing
                                      ? UiPriority.danger
                                      : UiPriority.secondary,
                                  placeholder: 'nombre o distintivo',
                                  controller: _viewModel.descriptionCtrl,
                                ),
                              ),
                              UiFieldLayout(
                                title: 'Unidades en el paquete',
                                hint: 'si no cuenta con cantidad por paquete',
                                child: UiField(
                                  priority: _viewModel.isEditing
                                      ? UiPriority.danger
                                      : UiPriority.secondary,
                                  placeholder: 'unidades en el paquete',
                                  type: UiFieldType.number,
                                  controller: _viewModel.packageUnitsCtrl,
                                ),
                              ),
                              UiFieldLayout(
                                title: 'Cantidad por unidad en el paquete',
                                hint: 'o cantidad por paquete si aplica',
                                child: UiField(
                                  priority: _viewModel.isEditing
                                      ? UiPriority.danger
                                      : UiPriority.secondary,
                                  placeholder: 'cantidad por unidad',
                                  type: UiFieldType.decimal,
                                  controller: _viewModel.amountCtrl,
                                ),
                              ),
                              UiFieldLayout(
                                title: 'Categoría (unidad de medida)',
                                child: UiSelect<MeasurementCategory>(
                                  priority: _viewModel.isEditing
                                      ? UiPriority.danger
                                      : UiPriority.secondary,
                                  placeholder: 'seleccione una categoría',
                                  list: _viewModel.categories,
                                  elementToText: (element) =>
                                      element.translations[0].name,
                                  controller: _viewModel.categoryCtrl,
                                  onChange: _viewModel.handleSelectCategory,
                                ),
                              ),
                              ListenableBuilder(
                                listenable: _viewModel,
                                builder: (context, child) => UiFieldLayout(
                                  title: 'Unidad de medida',
                                  child: UiSelect<Measurement>(
                                    priority: _viewModel.isEditing
                                        ? UiPriority.danger
                                        : UiPriority.secondary,
                                    placeholder:
                                        'seleccione la unidad de medida',
                                    list: _viewModel.measurements,
                                    elementToText: (element) =>
                                        element.translations[0].plural,
                                    controller: _viewModel.measureCtrl,
                                    disabled: !_viewModel.hasMeasurements,
                                  ),
                                ),
                              ),
                              UiFieldLayout(
                                title: 'Precio por paquete',
                                child: UiField(
                                  priority: _viewModel.isEditing
                                      ? UiPriority.danger
                                      : UiPriority.secondary,
                                  placeholder: 'en moneda local',
                                  type: UiFieldType.decimal,
                                  controller: _viewModel.priceCtrl,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: UiButton(
                          onPressed: _viewModel.handleAddProduct,
                          priority: _viewModel.isEditing
                              ? UiPriority.danger
                              : UiPriority.secondary,
                          vertical: UiSpacing.md,
                          radius: UiRadius.xl,
                          child: UiLabel(
                            text: _viewModel.isEditing
                                ? 'Finalizar actualización'
                                : 'Agregar producto',
                            priority: _viewModel.isEditing
                                ? UiPriority.danger
                                : UiPriority.secondary,
                            style: UiFontStyle.caption,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
