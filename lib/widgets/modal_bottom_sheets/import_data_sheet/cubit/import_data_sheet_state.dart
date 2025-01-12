part of 'import_data_sheet_cubit.dart';

enum ImportDataSheetStatus { pageIsLoading, pageHasError, waiting, loading, failure, close }

class ImportDataSheetState extends Equatable {
  final bool isShared;

  final String loadingMessage;

  final Group group;
  final ModelEntries importModelEntries;

  final PickerItem? pickedDelimiter;
  final File? file;
  final List<List<dynamic>> csvTable;

  final ModelEntry selectedModelEntry;

  final Failure failure;
  final ImportDataSheetStatus status;

  final Failure pageFailure;

  const ImportDataSheetState({
    required this.isShared,
    required this.loadingMessage,
    required this.group,
    required this.importModelEntries,
    required this.file,
    required this.pickedDelimiter,
    required this.csvTable,
    required this.selectedModelEntry,
    required this.failure,
    required this.status,
    required this.pageFailure,
  });

  @override
  List<Object?> get props => [isShared, loadingMessage, group, importModelEntries, selectedModelEntry, pickedDelimiter, file, csvTable, failure, status, pageFailure];

  /// Initialize a new ```ImportDataSheetState``` object.
  factory ImportDataSheetState.initial() {
    return ImportDataSheetState(
      isShared: false,
      loadingMessage: '',
      group: Group.initial(),
      importModelEntries: ModelEntries.initial(),
      file: null,
      pickedDelimiter: null,
      csvTable: const [],
      selectedModelEntry: ModelEntry.initial(),
      failure: Failure.initial(),
      pageFailure: Failure.initial(),
      status: ImportDataSheetStatus.pageIsLoading,
    );
  }

  /// This getter can be used to check for template edit state.
  bool get isTemplateEdit {
    if (selectedModelEntry.importSpecifications == null) return false;
    if (selectedModelEntry.importSpecifications!.fields.items.isEmpty) return false;

    return true;
  }

  /// Delimiter ```PickerItems```.
  PickerItems get delimiters {
    return const PickerItems(
      items: [
        PickerItem(id: 'comma', label: ','),
        PickerItem(id: 'semicolon', label: ';'),
      ],
    );
  }

  ImportDataSheetState copyWith({
    bool? isShared,
    String? loadingMessage,
    Group? group,
    ModelEntries? importModelEntries,
    PickerItem? pickedDelimiter,
    File? file,
    List<List<dynamic>>? csvTable,
    ModelEntry? selectedModelEntry,
    Failure? failure,
    ImportDataSheetStatus? status,
    Failure? pageFailure,
  }) {
    return ImportDataSheetState(
      isShared: isShared ?? this.isShared,
      loadingMessage: loadingMessage ?? this.loadingMessage,
      group: group ?? this.group,
      importModelEntries: importModelEntries ?? this.importModelEntries,
      pickedDelimiter: pickedDelimiter ?? this.pickedDelimiter,
      file: file ?? this.file,
      csvTable: csvTable ?? this.csvTable,
      selectedModelEntry: selectedModelEntry ?? this.selectedModelEntry,
      failure: failure ?? this.failure,
      status: status ?? this.status,
      pageFailure: pageFailure ?? this.pageFailure,
    );
  }
}
