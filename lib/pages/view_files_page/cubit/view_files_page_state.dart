part of 'view_files_page_cubit.dart';

enum ViewFilesPageStatus {
  pageIsLoading,
  pageHasError,
  failure,
  loading,
  shareFile,
  waiting,
  close,
}

class ViewFilesPageState extends Equatable {
  final bool overlayVisible;
  final bool isFiles;

  final int currentPage;
  final Files files;
  final FileItem currentFileItem;

  final String loadingMessage;

  final Group fromGroup;
  final Entry fromEntry;

  final Failure failure;
  final Failure pageFailure;

  final ViewFilesPageStatus status;

  const ViewFilesPageState({
    required this.overlayVisible,
    required this.isFiles,
    required this.fromGroup,
    required this.loadingMessage,
    required this.fromEntry,
    required this.currentPage,
    required this.files,
    required this.currentFileItem,
    required this.failure,
    required this.pageFailure,
    required this.status,
  });

  @override
  List<Object> get props => [overlayVisible, fromGroup, isFiles, loadingMessage, currentPage, currentFileItem, fromEntry, files, failure, pageFailure, status];

  /// Initialize a new `ViewFilesPageState` object.
  factory ViewFilesPageState.initial({required ViewFilesPageArguments arguments}) {
    return ViewFilesPageState(
      overlayVisible: true,
      isFiles: false,
      fromGroup: arguments.fromGroup,
      fromEntry: arguments.fromEntry,
      currentPage: arguments.initialPage,
      loadingMessage: '',
      currentFileItem: arguments.files.items[arguments.initialPage],
      files: arguments.files,
      failure: Failure.initial(),
      pageFailure: Failure.initial(),
      status: ViewFilesPageStatus.waiting,
    );
  }

  // ############################################
  // # Copy With
  // ############################################

  ViewFilesPageState copyWith({
    bool? overlayVisible,
    bool? isFiles,
    int? currentPage,
    Files? files,
    String? loadingMessage,
    FileItem? currentFileItem,
    Group? fromGroup,
    Entry? fromEntry,
    Failure? failure,
    Failure? pageFailure,
    ViewFilesPageStatus? status,
  }) {
    return ViewFilesPageState(
      overlayVisible: overlayVisible ?? this.overlayVisible,
      isFiles: isFiles ?? this.isFiles,
      currentPage: currentPage ?? this.currentPage,
      files: files ?? this.files,
      loadingMessage: loadingMessage ?? this.loadingMessage,
      currentFileItem: currentFileItem ?? this.currentFileItem,
      fromGroup: fromGroup ?? this.fromGroup,
      fromEntry: fromEntry ?? this.fromEntry,
      failure: failure ?? this.failure,
      pageFailure: pageFailure ?? this.pageFailure,
      status: status ?? this.status,
    );
  }
}
