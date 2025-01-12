part of 'add_file_details_sheet_cubit.dart';

enum AddFileDetailsSheetStatus { pageIsLoading, pageHasError, loading, waiting, failure, close }

class AddFileDetailsSheetState extends Equatable {
  final bool isAvatarImage;
  final bool isImages;
  final bool isFiles;
  
  final FileItem initialFileItem;
  final FileItem fileItem;

  final Failure pageFailure;

  final Failure failure;
  final AddFileDetailsSheetStatus status;

  const AddFileDetailsSheetState({
    required this.isAvatarImage,
    required this.isImages,
    required this.isFiles,
    required this.initialFileItem,
    required this.fileItem,
    required this.pageFailure,
    required this.failure,
    required this.status,
  });

  @override
  List<Object> get props => [initialFileItem, fileItem, isAvatarImage, isImages, isFiles, pageFailure, failure, status];

  /// Initialize a new `AddFileDetailsSheetState` object.
  factory AddFileDetailsSheetState.initial() {
    // Init FileItem to make initial and item compareable.
    final FileItem initial = FileItem.initial();

    return AddFileDetailsSheetState(
      isAvatarImage: false,
      isImages: false,
      isFiles: false,
      initialFileItem: initial,
      fileItem: initial,
      pageFailure: Failure.initial(),
      failure: Failure.initial(),
      status: AddFileDetailsSheetStatus.pageIsLoading,
    );
  }

  // ############################################
  // Copy With
  // ############################################

  AddFileDetailsSheetState copyWith({
    bool? isAvatarImage,
    bool? isImages,
    bool? isFiles,
    FileItem? initialFileItem,
    FileItem? fileItem,
    Failure? pageFailure,
    Failure? failure,
    AddFileDetailsSheetStatus? status,
  }) {
    return AddFileDetailsSheetState(
      isAvatarImage: isAvatarImage ?? this.isAvatarImage,
      isImages: isImages ?? this.isImages,
      isFiles: isFiles ?? this.isFiles,
      initialFileItem: initialFileItem ?? this.initialFileItem,
      fileItem: fileItem ?? this.fileItem,
      pageFailure: pageFailure ?? this.pageFailure,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }
}
