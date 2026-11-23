import 'package:material_ui/material_ui.dart';
import 'package:native_scope/native_scope.dart';
import 'package:ui/ui.dart';

import '../../domain/measurement.dart';

import '../states/product_form_state.dart';
import '../view_models/product_form_view_model.dart';

final class ProductFormView extends StatelessWidget {
  const ProductFormView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = ScopeInjector.read<ProductFormViewModel>(context);
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
              ScopeBuilder<ProductFormState, bool>(
                selector: (state) => state.isEditing,
                builder: (context, value, child) => UiHeader(
                  priority: value ? UiPriority.danger : UiPriority.secondary,
                  title: value ? 'Editando producto' : 'Agregando producto',
                  leadingIcon: Icons.arrow_back_ios_new,
                  onLeadingIconPressed: viewModel.handleBack,
                  hasOffset: true,
                ),
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
                              ScopeBuilder<
                                ProductFormState,
                                (bool, bool, String?)
                              >(
                                selector: (state) => (
                                  state.isEditing,
                                  state.error.description != null,
                                  state.error.description,
                                ),
                                builder: (context, value, child) =>
                                    UiFieldLayout(
                                      title: 'Descripción del producto',
                                      hasError: value.$2,
                                      hint: value.$3,
                                      child: UiField(
                                        priority: value.$1
                                            ? UiPriority.danger
                                            : UiPriority.secondary,
                                        placeholder: 'nombre o distintivo',
                                        controller: viewModel
                                            .formController
                                            .descriptionCtrl,
                                      ),
                                    ),
                              ),
                              ScopeBuilder<
                                ProductFormState,
                                (bool, bool, String?)
                              >(
                                selector: (state) => (
                                  state.isEditing,
                                  state.error.packageUnits != null,
                                  state.error.packageUnits,
                                ),
                                builder:
                                    (context, value, child) => UiFieldLayout(
                                      title: 'Unidades en el paquete',
                                      hasError: value.$2,
                                      hint: value.$3 ?? 'si no cuenta con cantidad por paquete',
                                      child: UiField(
                                        priority: value.$1
                                            ? UiPriority.danger
                                            : UiPriority.secondary,
                                        placeholder: 'unidades en el paquete',
                                        type: UiFieldType.number,
                                        controller: viewModel
                                            .formController
                                            .packageUnitsCtrl,
                                      ),
                                    ),
                              ),
                              ScopeBuilder<
                                ProductFormState,
                                (bool, bool, String?)
                              >(
                                selector: (state) => (
                                  state.isEditing,
                                  state.error.amount != null,
                                  state.error.amount,
                                ),
                                builder: (context, value, child) =>
                                    UiFieldLayout(
                                      title:
                                          'Cantidad por unidad en el paquete',
                                      hasError: value.$2,
                                      hint:
                                          value.$3 ??
                                          'o cantidad por paquete si aplica',
                                      child: UiField(
                                        priority: value.$1
                                            ? UiPriority.danger
                                            : UiPriority.secondary,
                                        placeholder: 'cantidad por unidad',
                                        type: UiFieldType.decimal,
                                        controller:
                                            viewModel.formController.amountCtrl,
                                      ),
                                    ),
                              ),
                              ScopeBuilder<
                                ProductFormState,
                                (
                                  bool,
                                  List<MeasurementCategory>,
                                  bool,
                                  String?,
                                  bool,
                                )
                              >(
                                selector: (state) => (
                                  state.isEditing,
                                  state.categories,
                                  state.error.category != null,
                                  state.error.category,
                                  state.category != null,
                                ),
                                builder: (context, value, child) =>
                                    UiFieldLayout(
                                      title: 'Categoría (unidad de medida)',
                                      hasError: value.$3,
                                      hint:
                                          value.$4 ??
                                          (value.$5
                                              ? 'preseleccionado para comparar productos'
                                              : null),
                                      child: UiSelect<MeasurementCategory>(
                                        priority: value.$1
                                            ? UiPriority.danger
                                            : UiPriority.secondary,
                                        placeholder: 'seleccione una categoría',
                                        list: value.$2,
                                        elementToText: (element) =>
                                            element.translations[0].name,
                                        controller: viewModel
                                            .formController
                                            .categoryCtrl,
                                        onChange:
                                            viewModel.handleSelectCategory,
                                        readOnly: value.$5,
                                      ),
                                    ),
                              ),
                              ScopeBuilder<
                                ProductFormState,
                                (bool, List<Measurement>, bool, bool, String?)
                              >(
                                selector: (state) => (
                                  state.isEditing,
                                  state.measurements,
                                  state.hasMeasurements,
                                  state.error.measure != null,
                                  state.error.measure,
                                ),
                                builder: (context, value, child) =>
                                    UiFieldLayout(
                                      title: 'Unidad de medida',
                                      hasError: value.$4,
                                      hint: value.$5,
                                      child: UiSelect<Measurement>(
                                        priority: value.$1
                                            ? UiPriority.danger
                                            : UiPriority.secondary,
                                        placeholder:
                                            'seleccione la unidad de medida',
                                        list: value.$2,
                                        elementToText: (element) =>
                                            element.translations[0].plural,
                                        controller: viewModel
                                            .formController
                                            .measureCtrl,
                                        disabled: !value.$3,
                                      ),
                                    ),
                              ),
                              ScopeBuilder<
                                ProductFormState,
                                (bool, bool, String?)
                              >(
                                selector: (state) => (
                                  state.isEditing,
                                  state.error.price != null,
                                  state.error.price,
                                ),
                                builder: (context, value, child) =>
                                    UiFieldLayout(
                                      title: 'Precio por paquete',
                                      hasError: value.$2,
                                      hint: value.$3,
                                      child: UiField(
                                        priority: value.$1
                                            ? UiPriority.danger
                                            : UiPriority.secondary,
                                        placeholder: 'en moneda local',
                                        type: UiFieldType.decimal,
                                        controller:
                                            viewModel.formController.priceCtrl,
                                      ),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ScopeBuilder<ProductFormState, bool>(
                          selector: (state) => state.isEditing,
                          builder: (context, value, child) => UiButton(
                            onPressed: viewModel.handleAddProduct,
                            priority: value
                                ? UiPriority.danger
                                : UiPriority.secondary,
                            vertical: UiSpacing.md,
                            radius: UiRadius.xl,
                            child: UiLabel(
                              text: value
                                  ? 'Finalizar actualización'
                                  : 'Agregar producto',
                              priority: value
                                  ? UiPriority.danger
                                  : UiPriority.secondary,
                              style: UiFontStyle.caption,
                            ),
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
