part of 'create_model_cubit.dart';

enum CreateModelStatus { pageIsLoading, pageHasError, loading, waiting, failure, close }

class CreateModelState extends Equatable {
  final bool isEdit;
  final bool isShared;
  final bool isImportMatch;

  final List<List<dynamic>> csvTable;

  final ModelEntry initialEntryModel;
  final ModelEntry entryModel;

  final PickerItems pickerItemsFields;

  /// Set this to -1 in order to disable fields from automatically gaining focus.
  final int focusedField;

  final List<bool> shouldAnimate;
  final int animationDurationInMilliSeconds;

  final Failure failure;
  final CreateModelStatus status;

  final Failure pageFailure;

  const CreateModelState({
    required this.isEdit,
    required this.isShared,
    required this.isImportMatch,
    required this.csvTable,
    required this.initialEntryModel,
    required this.entryModel,
    required this.pickerItemsFields,
    required this.focusedField,
    required this.shouldAnimate,
    required this.animationDurationInMilliSeconds,
    required this.pageFailure,
    required this.failure,
    required this.status,
  });

  /// Initialize a new [CreateModelState] object.
  factory CreateModelState.initial() {
    // Create Initial entry model.
    // * This is needed to be able to make state entry models compareable.
    final ModelEntry entryModel = ModelEntry.initial();

    return CreateModelState(
      isEdit: false,
      isShared: false,
      isImportMatch: false,
      csvTable: const [],
      pickerItemsFields: PickerItems.initial(),
      initialEntryModel: entryModel,
      entryModel: entryModel,
      focusedField: -1,
      shouldAnimate: const [],
      animationDurationInMilliSeconds: 1,
      pageFailure: Failure.initial(),
      failure: Failure.initial(),
      status: CreateModelStatus.pageIsLoading,
    );
  }

  @override
  List<Object> get props => [
        isShared,
        initialEntryModel,
        isImportMatch,
        csvTable,
        pickerItemsFields,
        entryModel,
        isEdit,
        focusedField,
        pageFailure,
        shouldAnimate,
        animationDurationInMilliSeconds,
        failure,
        status,
      ];

  CreateModelState copyWith({
    bool? isEdit,
    bool? isShared,
    bool? isImportMatch,
    List<List<dynamic>>? csvTable,
    ModelEntry? initialEntryModel,
    ModelEntry? entryModel,
    PickerItems? pickerItemsFields,
    int? focusedField,
    List<bool>? shouldAnimate,
    int? animationDurationInMilliSeconds,
    Failure? failure,
    CreateModelStatus? status,
    Failure? pageFailure,
  }) {
    return CreateModelState(
      isEdit: isEdit ?? this.isEdit,
      isShared: isShared ?? this.isShared,
      isImportMatch: isImportMatch ?? this.isImportMatch,
      csvTable: csvTable ?? this.csvTable,
      initialEntryModel: initialEntryModel ?? this.initialEntryModel,
      entryModel: entryModel ?? this.entryModel,
      pickerItemsFields: pickerItemsFields ?? this.pickerItemsFields,
      focusedField: focusedField ?? this.focusedField,
      shouldAnimate: shouldAnimate ?? this.shouldAnimate,
      animationDurationInMilliSeconds: animationDurationInMilliSeconds ?? this.animationDurationInMilliSeconds,
      failure: failure ?? this.failure,
      status: status ?? this.status,
      pageFailure: pageFailure ?? this.pageFailure,
    );
  }
}
