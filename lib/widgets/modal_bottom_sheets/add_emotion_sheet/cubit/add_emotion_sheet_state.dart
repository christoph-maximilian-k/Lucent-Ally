part of 'add_emotion_sheet_cubit.dart';

enum AddEmotionSheetStatus { pageIsLoading, pageHasError, showEmotions, loading, waiting, failure, close }

class AddEmotionSheetState extends Equatable {
  final EmotionItem emotionItem;

  final Failure pageFailure;

  final Failure failure;
  final AddEmotionSheetStatus status;

  const AddEmotionSheetState({
    required this.emotionItem,
    required this.pageFailure,
    required this.failure,
    required this.status,
  });

  @override
  List<Object> get props => [emotionItem, failure, pageFailure, status];

  /// Initialize a new ```AddEmotionSheetState``` object.
  factory AddEmotionSheetState.initial() {
    return AddEmotionSheetState(
      emotionItem: EmotionItem.initial(),
      pageFailure: Failure.initial(),
      failure: Failure.initial(),
      status: AddEmotionSheetStatus.pageIsLoading,
    );
  }

  AddEmotionSheetState copyWith({
    EmotionItem? emotionItem,
    Failure? pageFailure,
    Failure? failure,
    AddEmotionSheetStatus? status,
  }) {
    return AddEmotionSheetState(
      emotionItem: emotionItem ?? this.emotionItem,
      pageFailure: pageFailure ?? this.pageFailure,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }
}
