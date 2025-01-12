part of 'export_data_sheet_cubit.dart';

enum ExportDataSheetStatus { pageIsLoading, pageHasError, waiting, shareFile, loading, failure, close }

enum LoadFilesStatus { loading, waiting, failure }

class ExportDataSheetState extends Equatable {
  final bool isShared;

  final String loadingMessage;

  final Groups topLevelGroups;
  final Groups subgroups;

  final PickerItems topLevelGroupsAsPickerItems;
  final PickerItems subgroupsAsPickerItems;

  final int sharedExportsLeft;

  final Group topLevelGroup;
  final Group subgroup;

  final Group selectedGroup;

  final Failure failure;
  final ExportDataSheetStatus status;

  final List<String> filePaths;

  final String sharedFilePath;

  final Failure loadFileFailure;
  final LoadFilesStatus loadFilesStatus;

  final Failure pageFailure;

  const ExportDataSheetState({
    required this.isShared,
    required this.loadingMessage,
    required this.topLevelGroups,
    required this.subgroups,
    required this.subgroupsAsPickerItems,
    required this.topLevelGroupsAsPickerItems,
    required this.sharedExportsLeft,
    required this.topLevelGroup,
    required this.subgroup,
    required this.selectedGroup,
    required this.failure,
    required this.status,
    required this.loadFileFailure,
    required this.loadFilesStatus,
    required this.filePaths,
    required this.pageFailure,
    required this.sharedFilePath,
  });

  @override
  List<Object> get props => [
        isShared,
        loadingMessage,
        topLevelGroup,
        sharedExportsLeft,
        topLevelGroups,
        selectedGroup,
        subgroup,
        subgroups,
        topLevelGroupsAsPickerItems,
        subgroupsAsPickerItems,
        loadFileFailure,
        loadFilesStatus,
        failure,
        status,
        filePaths,
        pageFailure,
        sharedFilePath,
      ];

  /// Initialize a new ```ExportDataSheetState``` object.
  factory ExportDataSheetState.initial() {
    return ExportDataSheetState(
      isShared: false,
      loadingMessage: '',
      topLevelGroups: Groups.initial(),
      subgroups: Groups.initial(),
      subgroupsAsPickerItems: PickerItems.initial(),
      topLevelGroupsAsPickerItems: PickerItems.initial(),
      topLevelGroup: Group.initial(),
      subgroup: Group.initial(),
      selectedGroup: Group.initial(),
      sharedExportsLeft: 0,
      loadFileFailure: Failure.initial(),
      loadFilesStatus: LoadFilesStatus.waiting,
      failure: Failure.initial(),
      pageFailure: Failure.initial(),
      filePaths: const [],
      status: ExportDataSheetStatus.pageIsLoading,
      sharedFilePath: '',
    );
  }

  ExportDataSheetState copyWith({
    bool? isShared,
    String? loadingMessage,
    Groups? topLevelGroups,
    Groups? subgroups,
    PickerItems? topLevelGroupsAsPickerItems,
    PickerItems? subgroupsAsPickerItems,
    int? sharedExportsLeft,
    Group? topLevelGroup,
    Group? subgroup,
    Group? selectedGroup,
    Failure? failure,
    ExportDataSheetStatus? status,
    List<String>? filePaths,
    String? sharedFilePath,
    Failure? loadFileFailure,
    LoadFilesStatus? loadFilesStatus,
    Failure? pageFailure,
  }) {
    return ExportDataSheetState(
      isShared: isShared ?? this.isShared,
      loadingMessage: loadingMessage ?? this.loadingMessage,
      topLevelGroups: topLevelGroups ?? this.topLevelGroups,
      subgroups: subgroups ?? this.subgroups,
      topLevelGroupsAsPickerItems: topLevelGroupsAsPickerItems ?? this.topLevelGroupsAsPickerItems,
      subgroupsAsPickerItems: subgroupsAsPickerItems ?? this.subgroupsAsPickerItems,
      sharedExportsLeft: sharedExportsLeft ?? this.sharedExportsLeft,
      topLevelGroup: topLevelGroup ?? this.topLevelGroup,
      subgroup: subgroup ?? this.subgroup,
      selectedGroup: selectedGroup ?? this.selectedGroup,
      failure: failure ?? this.failure,
      status: status ?? this.status,
      filePaths: filePaths ?? this.filePaths,
      sharedFilePath: sharedFilePath ?? this.sharedFilePath,
      loadFileFailure: loadFileFailure ?? this.loadFileFailure,
      loadFilesStatus: loadFilesStatus ?? this.loadFilesStatus,
      pageFailure: pageFailure ?? this.pageFailure,
    );
  }
}
