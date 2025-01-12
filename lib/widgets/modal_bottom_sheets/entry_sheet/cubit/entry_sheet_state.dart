part of 'entry_sheet_cubit.dart';

enum EntrySheetStatus { pageIsLoading, pageHasError, loading, waiting, close, failure }

class EntrySheetState extends Equatable {
  final bool isDefault;
  final bool isSelfDefault;
  final bool isShared;
  final bool isEdit;
  final bool isImportMatch;
  final bool isSetExchangeRate;

  final String pageLoadingMessage;
  final String loadingMessage;

  final Entry initialEntry;
  final Entry entry;

  final ModelEntry entryModel;

  final Group fromGroup;

  final Files deletedFiles;

  final int selectedPickerItemIndex;

  final bool isCurrentLocation;

  final Tags tagsSuggestions;
  final List<String> textSuggestions;
  final List<PhoneData> phoneSuggestions;

  final List<List<dynamic>> csvTable;
  final PickerItems pickerItemsCsvHeaders;

  final Failure failure;
  final EntrySheetStatus status;

  final Failure pageFailure;

  const EntrySheetState({
    required this.isDefault,
    required this.isSelfDefault,
    required this.isShared,
    required this.isImportMatch,
    required this.isSetExchangeRate,
    required this.loadingMessage,
    required this.initialEntry,
    required this.entry,
    required this.entryModel,
    required this.isEdit,
    required this.fromGroup,
    required this.deletedFiles,
    required this.selectedPickerItemIndex,
    required this.isCurrentLocation,
    required this.tagsSuggestions,
    required this.pageFailure,
    required this.textSuggestions,
    required this.phoneSuggestions,
    required this.csvTable,
    required this.pickerItemsCsvHeaders,
    required this.failure,
    required this.status,
    required this.pageLoadingMessage,
  });

  @override
  List<Object?> get props => [
        isDefault,
        isSelfDefault,
        isShared,
        isSetExchangeRate,
        isImportMatch,
        loadingMessage,
        initialEntry,
        entry,
        entryModel,
        isEdit,
        fromGroup,
        deletedFiles,
        selectedPickerItemIndex,
        isCurrentLocation,
        tagsSuggestions,
        textSuggestions,
        phoneSuggestions,
        csvTable,
        pickerItemsCsvHeaders,
        pageFailure,
        failure,
        status,
        pageLoadingMessage,
      ];

  /// Initialize a new [EntrySheetState] object.
  factory EntrySheetState.initial() {
    // Init.
    final Entry entry = Entry.initial();
    final ModelEntry modelEntry = ModelEntry.initial();

    return EntrySheetState(
      isDefault: false,
      isSelfDefault: false,
      isShared: false,
      isImportMatch: false,
      isSetExchangeRate: false,
      loadingMessage: '',
      initialEntry: entry,
      entry: entry,
      entryModel: modelEntry,
      isEdit: false,
      fromGroup: Group.initial(),
      deletedFiles: Files.initial(),
      selectedPickerItemIndex: 0,
      isCurrentLocation: false,
      tagsSuggestions: Tags.initial(),
      textSuggestions: const [],
      phoneSuggestions: const [],
      csvTable: const [],
      pickerItemsCsvHeaders: PickerItems.initial(),
      pageFailure: Failure.initial(),
      failure: Failure.initial(),
      status: EntrySheetStatus.pageIsLoading,
      pageLoadingMessage: '',
    );
  }

  /// This getter can be used to access phone suggestions as labels.
  List<String> get phoneSuggestionsLabels {
    // Init helper.
    List<String> helper = [];

    for (final PhoneData item in phoneSuggestions) {
      helper.add(item.getValue);
    }

    return helper;
  }

  /// This getter can be used to determine if entry name field should request focus.
  bool get getEntryNameFieldShouldRequestFocus {
    // Never request focus in import match mode.
    if (isImportMatch) return false;

    // Never request focus in edit mode.
    if (isEdit) return false;

    // Never request focus in default mode.
    if (isDefault) return false;

    return true;
  }

  EntrySheetState copyWith({
    bool? isDefault,
    bool? isSelfDefault,
    bool? isShared,
    bool? isEdit,
    bool? isImportMatch,
    bool? isSetExchangeRate,
    String? pageLoadingMessage,
    String? loadingMessage,
    Entry? initialEntry,
    Entry? entry,
    ModelEntry? entryModel,
    Group? fromGroup,
    Files? deletedFiles,
    int? selectedPickerItemIndex,
    bool? isCurrentLocation,
    Tags? tagsSuggestions,
    List<String>? textSuggestions,
    List<PhoneData>? phoneSuggestions,
    List<List<dynamic>>? csvTable,
    PickerItems? pickerItemsCsvHeaders,
    Failure? failure,
    EntrySheetStatus? status,
    Failure? pageFailure,
  }) {
    return EntrySheetState(
      isDefault: isDefault ?? this.isDefault,
      isSelfDefault: isSelfDefault ?? this.isSelfDefault,
      isShared: isShared ?? this.isShared,
      isEdit: isEdit ?? this.isEdit,
      isImportMatch: isImportMatch ?? this.isImportMatch,
      isSetExchangeRate: isSetExchangeRate ?? this.isSetExchangeRate,
      pageLoadingMessage: pageLoadingMessage ?? this.pageLoadingMessage,
      loadingMessage: loadingMessage ?? this.loadingMessage,
      initialEntry: initialEntry ?? this.initialEntry,
      entry: entry ?? this.entry,
      entryModel: entryModel ?? this.entryModel,
      fromGroup: fromGroup ?? this.fromGroup,
      deletedFiles: deletedFiles ?? this.deletedFiles,
      selectedPickerItemIndex: selectedPickerItemIndex ?? this.selectedPickerItemIndex,
      isCurrentLocation: isCurrentLocation ?? this.isCurrentLocation,
      tagsSuggestions: tagsSuggestions ?? this.tagsSuggestions,
      textSuggestions: textSuggestions ?? this.textSuggestions,
      phoneSuggestions: phoneSuggestions ?? this.phoneSuggestions,
      csvTable: csvTable ?? this.csvTable,
      pickerItemsCsvHeaders: pickerItemsCsvHeaders ?? this.pickerItemsCsvHeaders,
      failure: failure ?? this.failure,
      status: status ?? this.status,
      pageFailure: pageFailure ?? this.pageFailure,
    );
  }
}
