part of 'add_files_sheet_cubit.dart';

enum AddFilesSheetStatus { pageIsLoading, pageHasError, loading, waiting, failure, close }

class AddFilesSheetState extends Equatable {
  final Files initialFiles;
  final Files files;

  final bool isEdit;

  final bool isAvatarImage;
  final bool isImages;
  final bool isFiles;

  final Group fromGroup;

  final Entry entry;
  final String fieldId;

  final Failure failure;
  final AddFilesSheetStatus status;

  final Failure pageFailure;

  const AddFilesSheetState({
    required this.initialFiles,
    required this.files,
    required this.isEdit,
    required this.fromGroup,
    required this.entry,
    required this.fieldId,
    required this.isAvatarImage,
    required this.isImages,
    required this.isFiles,
    required this.failure,
    required this.pageFailure,
    required this.status,
  });

  /// Initialize a new `AddFilesSheetState` object.
  factory AddFilesSheetState.initial() {
    return AddFilesSheetState(
      initialFiles: Files.initial(),
      files: Files.initial(),
      isEdit: false,
      fromGroup: Group.initial(),
      entry: Entry.initial(),
      fieldId: '',
      isAvatarImage: false,
      isImages: false,
      isFiles: false,
      failure: Failure.initial(),
      pageFailure: Failure.initial(),
      status: AddFilesSheetStatus.pageIsLoading,
    );
  }

  @override
  List<Object> get props => [initialFiles, files, isEdit, fieldId, fromGroup, entry, isAvatarImage, isImages, isFiles, failure, pageFailure, status];

  // ####################################
  // Copy With
  // ####################################

  AddFilesSheetState copyWith({
    Files? initialFiles,
    Files? files,
    bool? isEdit,
    bool? isAvatarImage,
    bool? isImages,
    bool? isFiles,
    Group? fromGroup,
    Entry? entry,
    String? fieldId,
    Failure? failure,
    AddFilesSheetStatus? status,
    Failure? pageFailure,
  }) {
    return AddFilesSheetState(
      initialFiles: initialFiles ?? this.initialFiles,
      files: files ?? this.files,
      isEdit: isEdit ?? this.isEdit,
      isAvatarImage: isAvatarImage ?? this.isAvatarImage,
      isImages: isImages ?? this.isImages,
      isFiles: isFiles ?? this.isFiles,
      fromGroup: fromGroup ?? this.fromGroup,
      entry: entry ?? this.entry,
      fieldId: fieldId ?? this.fieldId,
      failure: failure ?? this.failure,
      status: status ?? this.status,
      pageFailure: pageFailure ?? this.pageFailure,
    );
  }
}
