part of 'view_entries_sheet_cubit.dart';

enum ViewEntriesSheetStatus { pageHasError, pageIsLoading, loading, loadMoreEntries, failure, waiting, closeBelow, close }

class ViewEntriesSheetState extends Equatable {
  final bool isShared;

  final String title;

  final String referenceType;
  final String referenceId;
  final String filter;

  final Secrets? secrets;
  final Group fromGroup;

  final int offset;
  final bool isFinished;

  final Tag? tag;

  final Entries entries;
  final ModelEntries modelEntries;

  final bool groupContentChanged;

  final Failure failure;

  final Failure pageFailure;
  final ViewEntriesSheetStatus status;

  const ViewEntriesSheetState({
    required this.isShared,
    required this.title,
    required this.offset,
    required this.isFinished,
    required this.referenceType,
    required this.referenceId,
    required this.filter,
    required this.entries,
    required this.groupContentChanged,
    required this.modelEntries,
    required this.tag,
    required this.secrets,
    required this.fromGroup,
    required this.failure,
    required this.pageFailure,
    required this.status,
  });

  @override
  List<Object?> get props => [isShared, groupContentChanged, referenceType, referenceId, filter, title, secrets, offset, tag, isFinished, entries, modelEntries, fromGroup, failure, pageFailure, status];

  /// Initialize a new ```ViewEntriesSheetState``` object.
  factory ViewEntriesSheetState.initial() {
    return ViewEntriesSheetState(
      isShared: false,
      title: '',
      secrets: null,
      offset: 0,
      isFinished: false,
      tag: null,
      referenceType: '',
      referenceId: '',
      filter: '',
      groupContentChanged: false,
      fromGroup: Group.initial(),
      modelEntries: ModelEntries.initial(),
      entries: Entries.initial(),
      failure: Failure.initial(),
      pageFailure: Failure.initial(),
      status: ViewEntriesSheetStatus.pageIsLoading,
    );
  }

  // #############################
  // Copy With
  // #############################

  ViewEntriesSheetState copyWith({
    bool? isShared,
    String? title,
    Secrets? secrets,
    Group? fromGroup,
    int? offset,
    bool? isFinished,
    bool? groupContentChanged,
    String? referenceType,
    String? referenceId,
    String? filter,
    Tag? tag,
    Entries? entries,
    ModelEntries? modelEntries,
    Failure? failure,
    Failure? pageFailure,
    ViewEntriesSheetStatus? status,
  }) {
    return ViewEntriesSheetState(
      isShared: isShared ?? this.isShared,
      title: title ?? this.title,
      secrets: secrets ?? this.secrets,
      groupContentChanged: groupContentChanged ?? this.groupContentChanged,
      fromGroup: fromGroup ?? this.fromGroup,
      offset: offset ?? this.offset,
      referenceType: referenceType ?? this.referenceType,
      referenceId: referenceId ?? this.referenceId,
      filter: filter ?? this.filter,
      isFinished: isFinished ?? this.isFinished,
      tag: tag ?? this.tag,
      entries: entries ?? this.entries,
      modelEntries: modelEntries ?? this.modelEntries,
      failure: failure ?? this.failure,
      pageFailure: pageFailure ?? this.pageFailure,
      status: status ?? this.status,
    );
  }
}
