import 'package:equatable/equatable.dart';

// Labels.
import '/main.dart';

/// This class can be used to hold failure messages.
/// It can also be thrown like an exception.
class Failure extends Equatable {
  final String code;
  final String message;

  const Failure({
    this.code = '',
    this.message = '',
  });

  /// Initialize a new [Failure] object.
  /// ```dart
  ///  final String code = '',
  ///  final String message = '',
  /// ```
  factory Failure.initial() {
    return const Failure(
      code: '',
      message: '',
    );
  }

  @override
  List<Object> get props => [code, message];

  // #############################
  // Languaged Failures
  // #############################

  /// * ISAR_DATABASE_NULL
  /// * Database is null.
  static Failure databaseIsNull() {
    return Failure(
      code: 'ISAR_DATABASE_NULL',
      message: labels.isarDatabaseIsNull(),
    );
  }

  /// * TIMEZONE_REQUIRED
  /// * A timezone is required but cannot be accessed.
  static Failure timezoneRequired() {
    return Failure(
      code: 'TIMEZONE_REQUIRED',
      message: labels.timezoneRequired(),
    );
  }

  /// * DATE_REQUIRED
  /// * Database is null.
  static Failure dateIsRequired() {
    return Failure(
      code: 'DATE_REQUIRED',
      message: labels.dateIsRequired(),
    );
  }

  /// * TO_CURRENCY_CODE_REQUIRED
  /// * Database is null.
  static Failure toCurrencyRequired() {
    return Failure(
      code: 'TO_CURRENCY_CODE_REQUIRED',
      message: labels.toCurrencyRequired(),
    );
  }

  /// * FROM_CURRENCY_CODE_REQUIRED
  /// * Database is null.
  static Failure fromCurrencyRequired() {
    return Failure(
      code: 'FROM_CURRENCY_CODE_REQUIRED',
      message: labels.fromCurrencyRequired(),
    );
  }

  /// * CURRENCIES_MUST_DIFFER
  /// * Database is null.
  static Failure currenciesMustDiffer() {
    return Failure(
      code: 'CURRENCIES_MUST_DIFFER',
      message: labels.currenciesMustDiffer(),
    );
  }

  /// * EXCHANGE_RATE_EXISTS
  /// * Database is null.
  static Failure exchangeRateAlreadyExists() {
    return Failure(
      code: 'EXCHANGE_RATE_EXISTS',
      message: labels.exchangeRateAlreadyExists(),
    );
  }

  /// * FAILED_TO_LOAD_ENTRIES
  /// * Database is null.
  static Failure failedToLoadEntries() {
    return Failure(
      code: 'FAILED_TO_LOAD_ENTRIES',
      message: labels.failedToLoadEntries(),
    );
  }

  /// * INVALID_FILE
  /// * Database is null.
  static Failure invalidFile() {
    return Failure(
      code: 'INVALID_FILE',
      message: labels.invalidFile(),
    );
  }

  /// * INVALID_IMAGE
  /// * Database is null.
  static Failure invalidImage() {
    return Failure(
      code: 'INVALID_IMAGE',
      message: labels.invalidImage(),
    );
  }

  /// * TERMS_AND_CONDITIONS_NOT_ACCEPTED
  /// * Database is null.
  static Failure termsAndConditionsNotAccepted() {
    return Failure(
      code: 'TERMS_AND_CONDITIONS_NOT_ACCEPTED',
      message: labels.termsAndConditionsNotAccepted(),
    );
  }

  /// * UNKNOWN_QUICK_NUMBER_ACTION
  /// * Chosen quick number action is unknown, please try again.
  static Failure unknownQuickNumberAction() {
    return Failure(
      code: 'UNKNOWN_QUICK_NUMBER_ACTION',
      message: labels.unknonwQuickNumberAction(),
    );
  }

  /// * GENERIC_ERROR
  /// * An error occurred, please try again.
  static Failure genericError() {
    return Failure(
      code: 'GENERIC_ERROR',
      message: labels.failureGenericError(),
    );
  }

  /// * EMPTY_MODEL_ENTRY_NAME
  /// * Model name cannot be empty.
  static Failure emptyModelName() {
    return Failure(
      code: 'EMPTY_MODEL_ENTRY_NAME',
      message: labels.failureEmptyModelName(),
    );
  }

  /// * EMPTY_MODEL_ENTRY_FIELDS
  /// * At least one field is required.
  static Failure noEntryModelFieldsCreated() {
    return Failure(
      code: 'EMPTY_MODEL_ENTRY_FIELDS',
      message: labels.failureNoEmptyModelFieldsCreated(),
    );
  }

  /// * E0003
  /// * Please provide labels for all fields.
  static Failure emptyLabel() {
    return Failure(
      code: 'E0003',
      message: labels.failureEmptyLabels(),
    );
  }

  /// * E0009
  /// * The field $fieldName is missing a required value.
  static Failure requiredValueMissing({required String fieldName}) {
    return Failure(
      code: 'E0009',
      message: labels.failureRequiredValueMissing(fieldName: fieldName),
    );
  }

  /// * E0010
  /// * No edits made.
  static Failure nothingWasEdited() {
    return Failure(
      code: 'E0010',
      message: labels.failureNothingWasEdited(),
    );
  }

  /// * E0011
  /// * No entry data provided.
  static Failure noEntryDataProvided() {
    return Failure(
      code: 'E0011',
      message: labels.failureNoEntryDataProvided(),
    );
  }

  /// * E0013
  /// * Entry must be tagged with another group in order to delete it from this group.
  static Failure currentGroupIsRequired() {
    return Failure(
      code: 'E0013',
      message: labels.failureCurrentGroupIsRequired(),
    );
  }

  /// * E0016
  /// * No copy field selected yet.
  static Failure copyFieldNotSet() {
    return Failure(
      code: 'E0016',
      message: labels.failureCopyFieldNotSet(),
    );
  }

  /// * E0017
  /// * This group already exists.
  static Failure groupAlreadyExists() {
    return Failure(
      code: 'E0017',
      message: labels.failureGroupAlreadyExists(),
    );
  }

  /// * E0018
  /// * Failed to create group, please try again.
  static Failure failedToCreateGroup() {
    return Failure(
      code: 'E0018',
      message: labels.failureFailedToCreateGroup(),
    );
  }

  /// * E0019
  /// * Failed to update entry, please try again.
  static Failure failedToUpdateEntry() {
    return Failure(
      code: 'E0019',
      message: labels.failureFailedToUpdateEntry(),
    );
  }

  /// * E0020
  /// * Failed to create entry, please try again.
  static Failure failedToCreateEntry() {
    return Failure(
      code: 'E0020',
      message: labels.failureFailedToCreateEntry(),
    );
  }

  /// * E0021
  /// * Failed to delete group, please try again.
  static Failure failedToDeleteGroup() {
    return Failure(
      code: 'E0021',
      message: labels.failureFailedToDeleteGroup(),
    );
  }

  /// * E0022
  /// * Failed to delete entry, please try again.
  static Failure failedToDeleteEntry() {
    return Failure(
      code: 'E0022',
      message: labels.failureFailedToDeleteEntry(),
    );
  }

  /// * E0023
  /// * Failed to create entry model, please try again.
  static Failure failedToCreateModelEntry() {
    return Failure(
      code: 'E0023',
      message: labels.failureFailedToCreateEntryModel(),
    );
  }

  /// * E0024
  /// * Failed to update entry model, please try again.
  static Failure failedToUpdateModelEntry() {
    return Failure(
      code: 'E0024',
      message: labels.failureFailedToUpdateEntryModel(),
    );
  }

  /// * E0025
  /// * Please provide entry model data.
  static Failure noEntryModelDataProvided() {
    return Failure(
      code: 'E0025',
      message: labels.failureNoEntryModelDataProvided(),
    );
  }

  /// * E0026
  /// * Failed to delete entry model, please try again.
  static Failure failedToDeleteEntryModel() {
    return Failure(
      code: 'E0026',
      message: labels.failureFailedToDeleteEntryModel(),
    );
  }

  /// * E0027
  /// * The value you have provided is not a number.
  static Failure invalidNumberInput({required String fieldName}) {
    return Failure(
      code: 'E0027',
      message: labels.failureInvalidNumberInput(fieldName: fieldName),
    );
  }

  /// * E0028
  /// * Failed to create settings, please try again.
  static Failure failedToCreateSettings() {
    return Failure(
      code: 'E0028',
      message: labels.failureFailedToCreateSettings(),
    );
  }

  /// * E0029
  /// * Failed to update settings, please try again.
  static Failure failedToUpdateSettings() {
    return Failure(
      code: 'E0029',
      message: labels.failureFailedToUpdateSettings(),
    );
  }

  /// * E0030
  /// * Please create a selection.
  static Failure noSelectionWasMade() {
    return Failure(
      code: 'E0030',
      message: labels.failureNoSelectionWasMade(),
    );
  }

  /// * E0031
  /// * Failed to access data, please try again.
  static Failure failedToInitializeEntrySelectorData() {
    return Failure(
      code: 'E0031',
      message: labels.failureFailedToInitializeEntrySelectorData(),
    );
  }

  /// * E0032
  /// * Please select an Model Entry.
  static Failure noModelEntrySelected() {
    return Failure(
      code: 'E0032',
      message: labels.failureNoModelEntrySelected(),
    );
  }

  /// * E0033
  /// * This entry model cannot be deleted because there are entries connected to it.
  static Failure entryModelIsReferenced() {
    return Failure(
      code: 'E0033',
      message: labels.failureEntryModelIsReferenced(),
    );
  }

  /// * E0034
  /// * Entry Model connected to this entry could not be found.
  static Failure entryModelNotFound() {
    return Failure(
      code: 'E0034',
      message: labels.failureEntryModelNotFound(),
    );
  }

  /// * E0035
  /// * Your location services are disabled.
  static Failure locationServiceDisabled() {
    return Failure(
      code: 'E0035',
      message: labels.failureLocationServiceDisabled(),
    );
  }

  /// * E0036
  /// * Your location services are disabled.
  static Failure locationPermissionGrantedLimited() {
    return Failure(
      code: 'E0036',
      message: labels.failureLocationPermissionGrantedLimited(),
    );
  }

  /// * E0037
  /// * Please grant location permission in your settings.
  static Failure locationPermissionDeniedForever() {
    return Failure(
      code: 'E0037',
      message: labels.failureLocationPermissionDeniedForever(),
    );
  }

  /// * E0038
  /// * Please grant location permission to use this function.
  static Failure locationPermissionDenied() {
    return Failure(
      code: 'E0038',
      message: labels.failureLocationPermissionDenied(),
    );
  }

  /// * E0039
  /// * Unkown location permission error, please try again.
  static Failure locationPermissionError() {
    return Failure(
      code: 'E0039',
      message: labels.failureLocationPermissionError(),
    );
  }

  /// * E0040
  /// * Could not access current location, please try again.
  static Failure locationCoordinatesAreNull() {
    return Failure(
      code: 'E0040',
      message: labels.failureLocationCoordinatesAreNull(),
    );
  }

  /// * E0041
  /// * Provided latitude is invalid.
  static Failure locationInvalidLatitude() {
    return Failure(
      code: 'E0041',
      message: labels.failureLocationInvalidLatitude(),
    );
  }

  /// * E0042
  /// * Provided longitude is invalid.
  static Failure locationInvalidLongitude() {
    return Failure(
      code: 'E0042',
      message: labels.failureLocationInvalidLongitude(),
    );
  }

  /// * E0043
  /// * The location you have provided is invalid.
  static Failure invalidLocationInput() {
    return Failure(
      code: 'E0043',
      message: labels.failureInvalidLocationInput(),
    );
  }

  /// * E0044
  /// * Failed to update group, please try again.
  static Failure failedToUpdateGroup() {
    return Failure(
      code: 'E0044',
      message: labels.failedToUpdateGroup(),
    );
  }

  /// * E0045
  /// * Images can only be edited if they are decrypted.
  static Failure imagesAreDecrypting() {
    return Failure(
      code: 'E0045',
      message: labels.failureImagesAreDecrypting(),
    );
  }

  /// * E0046
  /// * Please selected or create a group for this entry.
  static Failure groupRequired() {
    return Failure(
      code: 'E0046',
      message: labels.failureGroupRequired(),
    );
  }

  /// * E0047
  /// * Copy value is empty for this entry.
  static Failure copyValueEmpty() {
    return Failure(
      code: 'E0047',
      message: labels.failureCopyValueEmpty(),
    );
  }

  /// * E0048
  /// * Notifications are disabled.
  static Failure notificationsDisabled() {
    return Failure(
      code: 'E0048',
      message: labels.failureNotificationsDisabled(),
    );
  }

  /// * E0049
  /// * Scheduleing notification failed.
  static Failure scheduleNotificationFailed() {
    return Failure(
      code: 'E0049',
      message: labels.failureSchedulingNotification(),
    );
  }

  /// * E0050
  /// * Scheduleing notification failed.
  static Failure notificationsNotImplemented() {
    return Failure(
      code: 'E0050',
      message: labels.failureNotificationsNotImplemented(),
    );
  }

  /// * E0051
  /// * Scheduleing notification failed.
  static Failure notificationCannotBeInPast() {
    return Failure(
      code: 'E0051',
      message: labels.failureNotificationCannotBeInPast(),
    );
  }

  /// * E0052
  /// * Scheduleing notification failed.
  static Failure notificationTitleCannotBeEmpty() {
    return Failure(
      code: 'E0052',
      message: labels.failureNotificationTitleCannotBeEmpty(),
    );
  }

  /// * E0053
  /// * Initializeing notification plugin failed.
  static Failure failedToInitNotificationPlugin() {
    return Failure(
      code: 'E0053',
      message: labels.failureNotificationInitError(),
    );
  }

  /// * E0054
  /// * Notification ID is not unique. Please try again to generate another ID.
  static Failure notificationIdIsNotUnique() {
    return Failure(
      code: 'E0054',
      message: labels.failureNotificationIdIsNotUnique(),
    );
  }

  /// * E0055
  /// * Failed to access notification data.
  static Failure notificationPayloadIsInvalid() {
    return Failure(
      code: 'E0055',
      message: labels.failureNotificationPayloadInvalid(),
    );
  }

  /// * E0056
  /// * Please provide a total amount for the field $fieldName.
  static Failure paymentTotalNotSet({required String fieldName}) {
    return Failure(
      code: 'E0056',
      message: labels.failureExpeneseTotalNotSet(fieldName: fieldName),
    );
  }

  /// * E0057
  /// * Please provide a total amount that is greater than zero for field $fieldName.
  static Failure paymentTotalNotGreaterZero({required String fieldName}) {
    return Failure(
      code: 'E0057',
      message: labels.failureExpeneseTotalNotGreaterZero(fieldName: fieldName),
    );
  }

  /// * E0058
  /// * Please provide a currency for field $fieldName.
  static Failure paymentTotalCurrencyNotSet({required String fieldName}) {
    return Failure(
      code: 'E0058',
      message: labels.failureExpeneseTotalCurrencyNotSet(fieldName: fieldName),
    );
  }

  /// * E0059
  /// * Shares do not add up to total for field $fieldName.
  static Failure paymentTotalDiffersFromShares({required String fieldName}) {
    return Failure(
      code: 'E0059',
      message: labels.failureExpeneseTotalDiffersFromShares(fieldName: fieldName),
    );
  }

  /// * E0060
  /// * Please indicate who paid for the expense for field $fieldName.
  static Failure paymentPaidByNotSelected({required String fieldName}) {
    return Failure(
      code: 'E0060',
      message: labels.failureExpenesePaidByNotSelected(fieldName: fieldName),
    );
  }

  /// * E0061
  /// * Please provide an exchange rate for field $fieldName.
  static Failure expenseExchangeRateToDefaultInvalid({required String fieldName}) {
    return Failure(
      code: 'E0061',
      message: labels.expenseExchangeRateToDefaultInvalid(fieldName: fieldName),
    );
  }

  /// * E0062
  /// * Failed to create participant, please try again.
  static Failure failedToCreateParticipant() {
    return Failure(
      code: 'E0062',
      message: labels.failedToCreateParticipant(),
    );
  }

  /// * E0063
  /// * Failed to update participant, please try again.
  static Failure failedToUpdateParticipant() {
    return Failure(
      code: 'E0063',
      message: labels.failedToUpdateParticipant(),
    );
  }

  /// * E0064
  /// * Failed to delete participant, please try again.
  static Failure failedToDeleteParticipant() {
    return Failure(
      code: 'E0064',
      message: labels.failedToDeleteParticipant(),
    );
  }

  /// * E0067
  /// * This entry is already a member.
  static Failure entryIsAlreadyMember() {
    return Failure(
      code: 'E0067',
      message: labels.failureEntryIsAlreadyMember(),
    );
  }

  /// * E0069
  /// * Please provide group data.
  static Failure noGroupData() {
    return Failure(
      code: 'E0069',
      message: labels.failureNoGroupData(),
    );
  }

  /// * E0070
  /// * Please provide a group name.
  static Failure noGroupName() {
    return Failure(
      code: 'E0070',
      message: labels.failureNoGroupName(),
    );
  }

  /// * E0071
  /// * No edits made.
  static Failure groupWasNotEdited() {
    return Failure(
      code: 'E0071',
      message: labels.failureNothingWasEdited(),
    );
  }

  /// * E0072
  /// * A previously made reference cannot be changed.
  static Failure previouslyMadeReferenceCannotBeChanged() {
    return Failure(
      code: 'E0072',
      message: labels.failureReferenceCannotChange(),
    );
  }

  /// * E0073
  /// * This entry cannot be deleted because it is referenced as a member.
  static Failure entryIsReferencedAsMember() {
    return Failure(
      code: 'E0073',
      message: labels.failureEntryIsReferencedAsMember(),
    );
  }

  /// * E0074
  /// * This entry can only be added to one group because it depends on the members of this group.
  static Failure invalidNumberOfGroups() {
    return Failure(
      code: 'E0074',
      message: labels.failureInvalidNumberOfGroups(),
    );
  }

  /// * E0075
  /// * This group is locked.
  static Failure groupIsLocked() {
    return Failure(
      code: 'E0075',
      message: labels.failureGroupIsLocked(),
    );
  }

  /// * E0076
  /// * Amount cannot be negative.
  static Failure negativeNumber() {
    return Failure(
      code: 'E0076',
      message: labels.failureNegativeNumber(),
    );
  }

  /// * E0077
  /// * Please delete all subgroups first.
  static Failure groupContainsSubgroups() {
    return Failure(
      code: 'E0077',
      message: labels.failureGroupContainsSubgroups(),
    );
  }

  /// * E0078
  /// * Please first add a quick add reference for this group in the edit group section.
  static Failure invalidQuickAddReference() {
    return Failure(
      code: 'E0078',
      message: labels.failureInvalidQuickAddReference(),
    );
  }

  /// * E0079
  /// * Edit denied.
  static Failure editDenied() {
    return Failure(
      code: 'E0079',
      message: labels.failureEditDenied(),
    );
  }

  /// * E0080
  /// * Please provide a valid positive natural number.
  static Failure pinDoesNotMeetRequirements() {
    return Failure(
      code: 'E0080',
      message: labels.failurePinDoesNotMeetRequirements(),
    );
  }

  /// * E0081
  /// * Pin must consist of at least 4 digits.
  static Failure pinLengthInvalid() {
    return Failure(
      code: 'E0081',
      message: labels.failurePinLengthInvalid(),
    );
  }

  /// * E0082
  /// * Cannot reference entry that is currently being edited.
  static Failure cannotReferenceSelf() {
    return Failure(
      code: 'E0082',
      message: labels.failureCannotReferenceSelf(),
    );
  }

  /// * E0083
  /// * Failed to load chart, entry model not found.
  static Failure chartFailureEntryModelNotFound() {
    return Failure(
      code: 'E0083',
      message: labels.failureChartEntryModelNotFound(),
    );
  }

  /// * E0084
  /// * Failed to load chart, field identification not found.
  static Failure chartFailureFieldIdentificationNotFound() {
    return Failure(
      code: 'E0084',
      message: labels.failureChartFieldIdentificationNotFound(),
    );
  }

  /// * E0085
  /// * Error loading bars.
  static Failure chartFailureErrorLoadingBars() {
    return Failure(
      code: 'E0085',
      message: labels.failureChartErrorLoadingBars(),
    );
  }

  /// * E0086
  /// * No chart data available.
  static Failure chartFailureNoChartDataAvailable() {
    return Failure(
      code: 'E0086',
      message: labels.failureChartNoDataAvailable(),
    );
  }

  /// * E0087
  /// * Failed to create chart, please try again.
  static Failure failedToCreateChart() {
    return Failure(
      code: 'E0087',
      message: labels.failureChartCreation(),
    );
  }

  /// * E0088
  /// * Failed to update chart, please try again.
  static Failure failedToUpdateChart() {
    return Failure(
      code: 'E0088',
      message: labels.failureChartUpdate(),
    );
  }

  /// * E0089
  /// * Failed to delete chart, please try again.
  static Failure failedToDeleteChart() {
    return Failure(
      code: 'E0089',
      message: labels.failureChartDelete(),
    );
  }

  /// * E0090
  /// * Failed to add reference, please try again.
  static Failure failedToAddReference() {
    return Failure(
      code: 'E0090',
      message: labels.failureAddingReference(),
    );
  }

  /// * E0091
  /// * Failed to delete reference, please try again.
  static Failure failedToDeleteReference() {
    return Failure(
      code: 'E0091',
      message: labels.failureDeleteReference(),
    );
  }

  /// * E0092
  /// * It seems like selected group is empty. Add some entries to see charts.
  static Failure chartFailureEmptyGroup() {
    return Failure(
      code: 'E0092',
      message: labels.failureChartEmptyGroup(),
    );
  }

  /// * E0093
  /// * Please first select base data.
  static Failure chartFailureSelectBaseData() {
    return Failure(
      code: 'E0093',
      message: labels.failureChartSelectBaseData(),
    );
  }

  /// * E0094
  /// * This field has currently no chart instructions available. Please choose a different base data field.
  static Failure chartFailureNoChartInstructionsAvailable() {
    return Failure(
      code: 'E0094',
      message: labels.failureChartNoChartInstructionsAvailable(),
    );
  }

  /// * E0095
  /// * Please first assign members to selected group.
  static Failure failureNoMembersAssignedToGroup() {
    return Failure(
      code: 'E0095',
      message: labels.failureNoMembersAssignedToGroup(),
    );
  }

  /// * E0096
  /// * No chart bars created.
  static Failure failureNoChartBarsCreated() {
    return Failure(
      code: 'E0096',
      message: labels.failureNoChartBarsCreated(),
    );
  }

  /// * E0097
  /// * Selection data needs to be of same type.
  static Failure failureSelectionDataTypeDiffers() {
    return Failure(
      code: 'E0097',
      message: labels.failureSelectionDataDiffers(),
    );
  }

  /// * E0098
  /// * This item already exists in selection.
  static Failure failureEqualSelectionValue() {
    return Failure(
      code: 'E0098',
      message: labels.failureEqualSelectionValue(),
    );
  }

  /// * E0099
  /// * Please first select base field.
  static Failure failureNoBaseFieldSelected() {
    return Failure(
      code: 'E0099',
      message: labels.failureNoBaseFieldSelected(),
    );
  }

  /// * E0100
  /// * Unknown combination, please try again.
  static Failure failureUnknownCombination() {
    return Failure(
      code: 'E0100',
      message: labels.failureUnknownCombination(),
    );
  }

  /// * E0101
  /// * This is currently under construction, sorry for the inconvenience.
  static Failure failureCurrentlyUnderConstruction() {
    return Failure(
      code: 'E0101',
      message: labels.failureCurrentlyUnderConstruction(),
    );
  }

  /// * E0102
  /// * Please first select a combine field.
  static Failure failureNoCombineField() {
    return Failure(
      code: 'E0102',
      message: labels.failureNoCombineField(),
    );
  }

  /// * E0103
  /// * Please first select a member.
  static Failure failureNoMemberSelected() {
    return Failure(
      code: 'E0103',
      message: labels.failureNoMemberSelected(),
    );
  }

  /// * E0104
  /// * An entry name is required.
  static Failure failureEntryNameRequired() {
    return Failure(
      code: 'E0104',
      message: labels.failureEntryNameRequired(),
    );
  }

  /// * E0105
  /// * Failed to create user, please try again.
  static Failure failureToCreateUser() {
    return Failure(
      code: 'E0105',
      message: labels.failureToCreateUser(),
    );
  }

  /// * E0106
  /// * Failed to update user, please try again.
  static Failure failureToUpdateUser() {
    return Failure(
      code: 'E0106',
      message: labels.failureToUpdateUser(),
    );
  }

  /// * E0107
  /// * Failed to create tag, please try again.
  static Failure failedToCreateTag() {
    return Failure(
      code: 'E0107',
      message: labels.failureToCreateTag(),
    );
  }

  /// * E0108
  /// * Invalid tag. Here is an example of a valid tag:\n\na_valid_tag
  static Failure invalidTag() {
    return Failure(
      code: 'E0108',
      message: labels.failureInvalidTag(),
    );
  }

  /// * E0109
  /// * Please provide a Tag for field $fieldName.
  static Failure tagsRequired({required String fieldName}) {
    return Failure(
      code: 'E0109',
      message: labels.failureSharedExpenseTagRequired(fieldName: fieldName),
    );
  }

  /// * E0110
  /// * Invalid pin.\n\nThe maximum length is 25 characters.
  static Failure accessPinTooLong() {
    return Failure(
      code: 'E0110',
      message: labels.failureAccessPinTooLong(),
    );
  }

  /// * E0111
  /// * Invalid pin.\n\nOnly lower case letters, upper case letters and numbers are allowed.
  static Failure accessPinInvalidCharacters() {
    return Failure(
      code: 'E0111',
      message: labels.failureAccessInvalidCharacters(),
    );
  }

  /// * E0112
  /// * Please provide an access pin.
  static Failure accessPinRequired() {
    return Failure(
      code: 'E0112',
      message: labels.failureAccessPinRequired(),
    );
  }

  /// * E0113
  /// * Failed to create member, please try again.
  static Failure failedToCreateMember() {
    return Failure(
      code: 'E0113',
      message: labels.failedToCreateMember(),
    );
  }

  /// * E0114
  /// * Failed to update member, please try again.
  static Failure failedToUpdateMember() {
    return Failure(
      code: 'E0114',
      message: labels.failedToUpdateMember(),
    );
  }

  /// * E0115
  /// * This member is already part of this participant.
  static Failure failureMemberAlreadyPartOfParticipant() {
    return Failure(
      code: 'E0115',
      message: labels.failureMemberAlreadyPartOfParticipant(),
    );
  }

  /// * E0116
  /// * No members created yet.
  static Failure failureNoMembersCreated() {
    return Failure(
      code: 'E0116',
      message: labels.failureNoMembersCreated(),
    );
  }

  /// * E0117
  /// * An object with this id already exists.
  static Failure failureStorageObjectExists() {
    return Failure(
      code: 'E0117',
      message: labels.failureStorageObjectExists(),
    );
  }

  /// * E0118
  /// * An object with this id does not exist.
  static Failure failureStorageObjectDoesNotExist() {
    return Failure(
      code: 'E0118',
      message: labels.failureStorageObjectDoesNotExist(),
    );
  }

  /// * E0119
  /// * This collection does not exist.
  static Failure failureStorageUnknownCollection() {
    return Failure(
      code: 'E0119',
      message: labels.failureStorageUnknownCollection(),
    );
  }

  /// * E0120
  /// * Failed to load groups, please try again.
  static Failure failureToLoadGroups() {
    return Failure(
      code: 'E0120',
      message: labels.failureToLoadGroups(),
    );
  }

  /// * E0121
  /// * Failed to load entries, please try again.
  static Failure failureToLoadEntries() {
    return Failure(
      code: 'E0121',
      message: labels.failureToLoadEntries(),
    );
  }

  /// * E0122
  /// * Please assign at least one Member to this Participant.
  static Failure failureEmptyParticipantMembers() {
    return Failure(
      code: 'E0122',
      message: labels.failureEmptyParticipantMembers(),
    );
  }

  /// * E0123
  /// * Unknown group type, please try again.
  static Failure failureUnknownGroupType() {
    return Failure(
      code: 'E0123',
      message: labels.failureUnknownGroupType(),
    );
  }

  /// * E0124
  /// * Failed to load subgroups, please try again.
  static Failure failureToLoadSubgroups() {
    return Failure(
      code: 'E0124',
      message: labels.failureToLoadSubgroups(),
    );
  }

  /// * E0125
  /// * Please assign a name to this Participant.
  static Failure failureEmptyParticipantName() {
    return Failure(
      code: 'E0125',
      message: labels.failureEmptyParticipantName(),
    );
  }

  /// * E0126
  /// * Failed to create exchange rate, please try again.
  static Failure failedToCreateExchangeRate() {
    return Failure(
      code: 'E0126',
      message: labels.failedToCreateExchangeRate(),
    );
  }

  /// * E0127
  /// * A member with this name already exists.
  static Failure memberNameExists() {
    return Failure(
      code: 'E0127',
      message: labels.memberNameExists(),
    );
  }

  /// * E0128
  /// * Failed to create shared group, please try again.
  static Failure failedToCreateSharedGroup() {
    return Failure(
      code: 'E0128',
      message: labels.failedToCreateSharedGroup(),
    );
  }

  /// * E0129
  /// * Requested group was not found, it may have been deleted.
  static Failure sharedGroupNotFound() {
    return Failure(
      code: 'E0129',
      message: labels.sharedGroupNotFound(),
    );
  }

  /// * E0130
  /// * Only the group creator can edit this group.
  static Failure groupEditPermitted() {
    return Failure(
      code: 'E0130',
      message: labels.groupEditPermitted(),
    );
  }

  /// * E0131
  /// * Could not find referenced participant.
  static Failure participantNotFound() {
    return Failure(
      code: 'E0131',
      message: labels.participantNotFound(),
    );
  }

  /// * E0132
  /// * No ModelEntry created yet.
  static Failure noModelEntryCreatedYet() {
    return Failure(
      code: 'E0132',
      message: labels.noModelEntryCreatedYet(),
    );
  }

  /// * E0133
  /// * Update failed, please try again.
  static Failure failedToPutRecentEntry() {
    return Failure(
      code: 'E0133',
      message: labels.failedToPutRecentEntry(),
    );
  }

  /// * E0134
  /// * Delete failed, please try again.
  static Failure failedToDeleteRecentEntry() {
    return Failure(
      code: 'E0134',
      message: labels.failedToDeleteRecentEntry(),
    );
  }

  /// * E0135
  /// * Currently images cannot be stored online.
  static Failure imagesCloudStorageUnavailable() {
    return Failure(
      code: 'E0135',
      message: labels.imagesCloudStorageUnavailable(),
    );
  }

  /// * E0136
  /// * Currently files cannot be stored online.
  static Failure filesCloudStorageUnavailable() {
    return Failure(
      code: 'E0136',
      message: labels.filesCloudStorageUnavailable(),
    );
  }

  /// * E0137
  /// * Currently references to other entries cannot be stored online.
  static Failure entryReferenceStorageUnavailable() {
    return Failure(
      code: 'E0137',
      message: labels.entryReferenceStorageUnavailable(),
    );
  }

  /// * E0138
  /// * Failed to load model entries, please try again.
  static Failure failureToLoadModelEntries() {
    return Failure(
      code: 'E0138',
      message: labels.failedToLoadModelEntries(),
    );
  }

  /// * E0139
  /// * You do not have edit permissions for this entry.
  static Failure noEditPermission() {
    return Failure(
      code: 'E0139',
      message: labels.entryEditProhibited(),
    );
  }

  /// * E0140
  /// * You do not have the permission to add an entry to this group.
  static Failure entryAddProhibited() {
    return Failure(
      code: 'E0140',
      message: labels.entryAddProhibited(),
    );
  }

  /// * E0141
  /// * Only the group creator can delete this group.
  static Failure groupDeletePermitted() {
    return Failure(
      code: 'E0141',
      message: labels.groupDeletePermitted(),
    );
  }

  /// * E0142
  /// * You do not have permission to delete this subgroup.
  static Failure subgroupDeletePermitted() {
    return Failure(
      code: 'E0142',
      message: labels.subgroupDeleteProhibited(),
    );
  }

  /// * E0143
  /// * You do not have permission to delete this entry.
  static Failure entryDeleteNotAllowed() {
    return Failure(
      code: 'E0143',
      message: labels.entryDeleteProhibited(),
    );
  }

  /// * E0144
  /// * Invalid group type for this action.
  static Failure failureInvalidGroupType() {
    return Failure(
      code: 'E0144',
      message: labels.failureInvalidGroupType(),
    );
  }

  /// * E0145
  /// * Failed to fetch suggestions.
  static Failure failureToFetchSuggestions() {
    return Failure(
      code: 'E0145',
      message: labels.failureToFetchSuggestions(),
    );
  }

  /// * E0146
  /// * You cannot add a subgroup to this group.
  static Failure noSubgroupAddPermission() {
    return Failure(
      code: 'E0146',
      message: labels.subgroupAddProhibited(),
    );
  }

  /// * E0147
  /// * You do not have permissions to edit this subgroup.
  static Failure noSubgroupEditPermission() {
    return Failure(
      code: 'E0147',
      message: labels.subgroupEditProhibited(),
    );
  }

  /// * E0148
  /// * A root group reference is required.
  static Failure rootGroupRequired() {
    return Failure(
      code: 'E0148',
      message: labels.rootGroupRequired(),
    );
  }

  /// * E0149
  /// * Failed to delete preferences, please try again.
  static Failure failedToDeleteModelEntryPrefs() {
    return Failure(
      code: 'E0149',
      message: labels.failedToDeleteModelEntryPrefs(),
    );
  }

  /// * E0149
  /// * Failed to create preferences, please try again.
  static Failure failedToCreateModelEntryPrefs() {
    return Failure(
      code: 'E0149',
      message: labels.failedToCreateModelEntryPrefs(),
    );
  }

  /// * E0150
  /// * Failed to update model entry preferences, please try again.
  static Failure failedToUpdateModelEntryPrefs() {
    return Failure(
      code: 'E0150',
      message: labels.failedToUpdateModelEntryPrefs(),
    );
  }

  /// * E0151
  /// * This feature is not yet implemented, please try again later.
  static Failure unimplemented() {
    return Failure(
      code: 'E0151',
      message: labels.unimplemented(),
    );
  }

  /// * E0152
  /// * Failed to save preferences, please try again.
  static Failure failedToPutModelEntryPrefs() {
    return Failure(
      code: 'E0152',
      message: labels.failedToPutModelEntryPrefs(),
    );
  }

  /// * E0153
  /// * Failed to save preferences, please try again.
  static Failure failedToCreateGroupPrefs() {
    return Failure(
      code: 'E0153',
      message: labels.failedToCreateGroupPrefs(),
    );
  }

  /// * E0154
  /// * Failed to update group preferences, please try again.
  static Failure failedToUpdateGroupPrefs() {
    return Failure(
      code: 'E0154',
      message: labels.failedToUpdateGroupPrefs(),
    );
  }

  /// * E0155
  /// * Failed to delete preferences, please try again.
  static Failure failedToDeleteGroupPrefs() {
    return Failure(
      code: 'E0155',
      message: labels.failedToDeleteGroupPrefs(),
    );
  }

  /// * E0156
  /// * Failed to save preferences, please try again.
  static Failure failedToPutGroupPrefs() {
    return Failure(
      code: 'E0156',
      message: labels.failedToPutGroupPrefs(),
    );
  }

  /// * E0157
  /// * Selected quick add model entry was deleted.
  static Failure quickAddReferenceDeleted() {
    return Failure(
      code: 'E0157',
      message: labels.quickAddReferenceDeleted(),
    );
  }

  /// * E0158
  /// * Cannot add this entry to this group because this group does not allow ModelEntry of this type.
  static Failure modelEntryNotInRestrictions() {
    return Failure(
      code: 'E0158',
      message: labels.modelEntryNotInRestrictions(),
    );
  }

  /// * E0159
  /// * Please authenticate before trying to join a group.
  static Failure loginRequiredBeforeDeepLink() {
    return Failure(
      code: 'E0159',
      message: labels.loginRequiredBeforeDeepLink(),
    );
  }

  /// * E0160
  /// * Selected copy field does not exist in this entry.
  static Failure failureCopyFieldDoesNotExist() {
    return Failure(
      code: 'E0160',
      message: labels.failureCopyFieldDoesNotExist(),
    );
  }

  /// * E0161
  /// * This measure category was not found.
  static Failure unknownMeasureCategory() {
    return Failure(
      code: 'E0161',
      message: labels.unknownMeasureCategory(),
    );
  }

  /// * E0162
  /// * This measure category was not found.
  static Failure measurementUnitIsRequired({required String fieldName}) {
    return Failure(
      code: 'E0162',
      message: labels.measurementUnitIsRequired(fieldName: fieldName),
    );
  }

  /// * MEASUREMENT_DATA_DATE_IS_REQUIRED
  /// * This measure category was not found.
  static Failure measurementDateIsRequired({required String fieldName}) {
    return Failure(
      code: 'MEASUREMENT_DATA_DATE_IS_REQUIRED',
      message: labels.measurementDateIsRequired(fieldName: fieldName),
    );
  }

  /// * MONEY_DATA_DATE_IS_REQUIRED
  /// * This measure category was not found.
  static Failure moneyDateIsRequired({required String fieldName}) {
    return Failure(
      code: 'MONEY_DATA_DATE_IS_REQUIRED',
      message: labels.moneyDateIsRequired(fieldName: fieldName),
    );
  }

  /// * E0163
  /// * Made selection is invalid.
  static Failure invalidEmotionItem() {
    return Failure(
      code: 'E0163',
      message: labels.invalidEmotionItem(),
    );
  }

  /// * E0164
  /// * Currently avatar images cannot be stored online.
  static Failure avatarImageStorageUnavailable() {
    return Failure(
      code: 'E0164',
      message: labels.avatarImageStorageUnavailable(),
    );
  }

  /// * E0165
  /// * No participants created yet.
  static Failure noParticipantsCreated() {
    return Failure(
      code: 'E0165',
      message: labels.noParticipantsCreated(),
    );
  }

  /// * E0166
  /// * Exchange rate not found, calculation not accurately possible.
  static Failure exchangeRateNotFound({required String from, required String to}) {
    return Failure(
      code: 'E0166',
      message: labels.exchangeRateNotFound(from: from, to: to),
    );
  }

  /// * E0167
  /// * Unknown chart instruction.
  static Failure unknownChartInstruction() {
    return Failure(
      code: 'E0167',
      message: labels.unknownChartInstruction(),
    );
  }

  /// * E0169
  /// * A currency is required.
  static Failure moneyFieldCurrencyRequired({required String fieldName}) {
    return Failure(
      code: 'E0169',
      message: labels.moneyFieldCurrencyRequired(fieldName: fieldName),
    );
  }

  /// * E0170
  /// * Only the value of this field can be changed, not the parameters.
  static Failure cannotChangeParameters() {
    return Failure(
      code: 'E0170',
      message: labels.basicLabelsCannotChangeParamters(),
    );
  }

  /// * E0171
  /// * Please first select a measurement category.
  static Failure measurementCategoryIsRequired() {
    return Failure(
      code: 'E0171',
      message: labels.basicLabelsMeasurementCategoryIsRequired(),
    );
  }

  /// * E0172
  /// * Unknown unit conversion.
  static Failure unknownConversion() {
    return Failure(
      code: 'E0172',
      message: labels.basicLabelsUnknownUnitConversion(),
    );
  }

  /// * E0173
  /// * Please wait until current running fetch is finished.
  static Failure isAlreadyLoading() {
    return Failure(
      code: 'E0173',
      message: labels.basicLabelsisAlreadyLoading(),
    );
  }

  /// * E0174
  /// * Failed to find referenced cached chart items.
  static Failure cachedChartItemsNotFound() {
    return Failure(
      code: 'E0174',
      message: labels.cachedChartItemsNotFound(),
    );
  }

  /// * E0175
  /// * Please provide a valid total amount for the field $fieldName.
  static Failure paymentInvalidNumber({required String fieldName}) {
    return Failure(
      code: 'E0175',
      message: labels.failurePaymentInvalidNumber(fieldName: fieldName),
    );
  }

  /// * E0176
  /// * A participant ID is required.
  static Failure participantIdRequired() {
    return Failure(
      code: 'E0176',
      message: labels.participantIdRequired(),
    );
  }

  /// * E0177
  /// * Only 60 local notifications are allowed.
  static Failure tooManyNotifications() {
    return Failure(
      code: 'E0177',
      message: labels.tooManyNotifications(),
    );
  }

  /// * E0178
  /// * Please provide a password.
  static Failure passwordCannotBeEmpty() {
    return Failure(
      code: 'E0178',
      message: labels.passwordCannotBeEmpty(),
    );
  }

  /// * E0179
  /// * Password cannot exceed 50 characters.
  static Failure passwordIsTooLong() {
    return Failure(
      code: 'E0179',
      message: labels.passwordIsTooLong(),
    );
  }

  /// * E0180
  /// * Provided password is incorrect.
  static Failure incorrectPassword() {
    return Failure(
      code: 'E0180',
      message: labels.incorrectPassword(),
    );
  }

  /// * E0181
  /// * An app password is required to enable this function.\n\nPlease first set a password in the main menu.
  static Failure appPasswordrequired() {
    return Failure(
      code: 'E0181',
      message: labels.appPasswordRequired(),
    );
  }

  /// * E0182
  /// * No group created yet. Please create a group and try again.
  static Failure noGroupCreatedYet() {
    return Failure(
      code: 'E0182',
      message: labels.noGroupCreatedYet(),
    );
  }

  /// * E0183
  /// * Please first choose a file to import.
  static Failure noFileChosen() {
    return Failure(
      code: 'E0183',
      message: labels.noFileChosen(),
    );
  }

  /// * E0184
  /// * Please provide a default value for the entry name.
  static Failure failureEntryNameDefaultRequired() {
    return Failure(
      code: 'E0184',
      message: labels.failureEntryNameDefaultRequired(),
    );
  }

  /// * E0185
  /// * Please first provide a sample entry.
  static Failure sampleEntryRequired() {
    return Failure(
      code: 'E0185',
      message: labels.failureSampleEntryRequired(),
    );
  }

  /// * E0186
  /// * 'A invalid value was discovered in row $row for $rowKey.\n\nImport failed as specified.';
  static Failure importInvalidValueShouldFail({required String? rowKey, required int row, required bool tooManyChars}) {
    return Failure(
      code: 'E0186',
      message: labels.importInvalidValueShouldFail(rowKey: rowKey, row: row, tooManyChars: tooManyChars),
    );
  }

  /// * E0187
  /// * A missing value was discovered in row $row for $rowKey.\n\nImport failed as specified.
  static Failure importMissingValueShouldFail({required String? rowKey, required int row}) {
    return Failure(
      code: 'E0187',
      message: labels.importMissingValueShouldFail(rowKey: rowKey, row: row),
    );
  }

  /// * E0188
  /// * Specified import rule is unknown.
  static Failure unknownImportRule() {
    return Failure(
      code: 'E0188',
      message: labels.unknownImportRule(),
    );
  }

  /// * E0189
  /// * A missing default was discovered in row $row for $rowKey.\n\nImport failed as specified.
  static Failure importMissingDefaultShouldFail({required String rowKey, required int row}) {
    return Failure(
      code: 'E0189',
      message: labels.importMissingDefaultShouldFail(rowKey: rowKey, row: row),
    );
  }

  /// * E0190
  /// * Please set a rule for invalid values.
  static Failure invalidValueRuleRequired() {
    return Failure(
      code: 'E0190',
      message: labels.invalidValueRuleRequired(),
    );
  }

  /// * E0191
  /// * Please set a rule for missing values.
  static Failure missingValueRuleRequired() {
    return Failure(
      code: 'E0190',
      message: labels.missingValueRuleRequired(),
    );
  }

  /// * E0192
  /// * Payment data import references are incomplete.
  static Failure invalidPaymentImportReferences() {
    return Failure(
      code: 'E0192',
      message: labels.invalidPaymentImportReferences(),
    );
  }

  /// * E0193
  /// * Please link members with datapoints to import payment data.
  static Failure importInvalidMemberReferences() {
    return Failure(
      code: 'E0193',
      message: labels.importInvalidMemberReferences(),
    );
  }

  /// * E0194
  /// * Member with the name "$providedMemberName" could not be found.
  static Failure importCouldNotFindMemberName({required String providedMemberName, required String rowKey, required int row}) {
    return Failure(
      code: 'E0194',
      message: labels.importCouldNotFindMemberName(providedMemberName: providedMemberName, rowKey: rowKey, row: row),
    );
  }

  /// * E0194
  /// * Group lacks a participant.
  static Failure groupDoesNotHaveAParticipant() {
    return Failure(
      code: 'E0194',
      message: labels.groupDoesNotHaveAParticipant(),
    );
  }

  /// * E0195
  /// * 'A invalid measurement pair was discovered in row $row for category $rowKey.\n\nImport failed as specified.';
  static Failure importInvalidMeasurementPair({required String? category, required String? unit, required int row}) {
    return Failure(
      code: 'E0195',
      message: labels.importInvalidMeasurementPair(category: category, unit: unit, row: row),
    );
  }

  /// * E0196
  /// * 'Emotion data import failed because lists which indicate the emotion type, emotion intensity and emotion occurrence have a different number of items.';
  static Failure importEmotionsListLengthsDiffer({required int row}) {
    return Failure(
      code: 'E0196',
      message: labels.importEmotionsListLengthsDiffer(row: row),
    );
  }

  /// * E0197
  /// * 'No shared exports left this month.';
  static Failure noSharedExportsLeft() {
    return Failure(
      code: 'E0197',
      message: labels.noSharedExportsLeft(),
    );
  }

  /// * E0198
  /// * 'No group selected.';
  static Failure noGroupSelected() {
    return Failure(
      code: 'E0198',
      message: labels.noGroupSelected(),
    );
  }

  /// * E0199
  /// * 'Only the group creator can export groups.';
  static Failure onlyGroupCreatorCanExport() {
    return Failure(
      code: 'E0199',
      message: labels.onlyGroupCreatorCanExport(),
    );
  }

  /// * E0200
  /// * 'This group is empty.';
  static Failure groupIsEmpty() {
    return Failure(
      code: 'E0200',
      message: labels.groupIsEmpty(),
    );
  }

  /// * E0201
  /// * 'Failed to load files.';
  static Failure failedToLoadFiles() {
    return Failure(
      code: 'E0201',
      message: labels.failedToLoadFiles(),
    );
  }

  /// * E0202
  /// * 'Could not find model entry.';
  static Failure modelEntryNotFound() {
    return Failure(
      code: 'E0202',
      message: labels.modelEntryNotFound(),
    );
  }

  /// * E0203
  /// * 'Failed to access secrets needed for encryption, please try again.';
  static Failure failedToAccessSecrets() {
    return Failure(
      code: 'E0203',
      message: labels.failedToAccessSecrets(),
    );
  }

  /// * E0204
  /// * 'Unknown field type discovered.';
  static Failure unknownFieldType() {
    return Failure(
      code: 'E0204',
      message: labels.unknownFieldType(),
    );
  }

  /// * E0205
  /// * 'Unknown time format.';
  static Failure unknownTimeFormat() {
    return Failure(
      code: 'E0205',
      message: labels.unknownTimeFormat(),
    );
  }

  /// * E0206
  /// * 'Account is locked because to many invalid password attempts have been made.\n\nPlease try again later.';
  static Failure lockoutError() {
    return Failure(
      code: 'E0206',
      message: labels.lockoutError(),
    );
  }

  /// * E0207
  /// * 'No common model entries selected.';
  static Failure noCommonModelEntriesSelected() {
    return Failure(
      code: 'E0207',
      message: labels.noCommonModelEntriesSelected(),
    );
  }

  /// * E0208
  /// * 'Exchange rate must be greater than zero.';
  static Failure customExchangeRateMustBeGreaterZero() {
    return Failure(
      code: 'E0208',
      message: labels.customExchangeRateMustBeGreaterZero(),
    );
  }

  /// * E0209
  /// * 'For the field $fieldName a exchange rate from $fromCurrencyCode to $toCurrencyCode could not be found.\n\nPlease provide a custom exchange rate or change the currency of this field.';
  static Failure customExchangeRateRequiredForField({required String fromCurrencyCode, required String toCurrencyCode, required String fieldName}) {
    return Failure(
      code: 'E0209',
      message: labels.customExchangeRateRequiredForField(fieldName: fieldName, fromCurrencyCode: fromCurrencyCode, toCurrencyCode: toCurrencyCode),
    );
  }

  /// * E0210
  /// * 'The field "$fieldName" tries to access a exchange rate of the future.';
  static Failure exchangeRateInFuture({required String fieldName}) {
    return Failure(
      code: 'E0210',
      message: labels.exchangeRateInFuture(fieldName: fieldName),
    );
  }

  /// * E0211
  /// * 'The default currency of a shared group cannot be changed if entries exist.';
  static Failure cannotChangeDefaultCurrencyOfSharedGroup() {
    return Failure(
      code: 'E0211',
      message: labels.cannotChangeDefaultCurrencyOfSharedGroup(),
    );
  }

  /// * TOO_MANY_NUMBER_CHARACTERS
  /// * 'Numbers in this app are limited to a maximum of 14 characters.';
  static Failure numberHasTooManyCharacters() {
    return Failure(
      code: 'TOO_MANY_NUMBER_CHARACTERS',
      message: labels.numberHasTooManyCharacters(),
    );
  }

  // #############################
  // Failures API
  // #############################

  /// This method can be used to access translated API Failures by their code.
  static Failure getApiFailureByCode({required String code}) {
    // * Internal Server Error.
    if (code == 'EAPI0001') return Failure.apiInternalServerError();

    // * Empty response.
    if (code == 'EAPI0002') return Failure.apiEmptyResponseBody();

    // * Unknown response code.
    if (code == 'EAPI0003') return Failure.apiUnknownResponseCode();

    // * API Timeout.
    if (code == 'EAPI0004') return Failure.apiHttpTimeout();

    // * API generic error.
    if (code == 'EAPI0005') return Failure.apiGenericError();

    // * Failure unauthorized request.
    if (code == 'EAPI0006') return Failure.apiUnauthorizedRequest();

    // * Failure invalid endpoint.
    if (code == 'EAPI0007') return Failure.apiInvalidEndpoint();

    // * No IP address provided.
    if (code == 'EAPI0008') return Failure.apiNoIPAddressProvided();

    // * Endpoint access prohibited.
    if (code == 'EAPI0009') return Failure.apiEndpointAccessProhibited();

    // * Request limit exceeded.
    if (code == 'EAPI0010') return Failure.apiRequestLimitExceeded();

    // * Cannot delete referenced model entry.
    if (code == 'EAPI0011') return Failure.apiCannotDeleteReferencedModelEntry();

    // * Invalid entry edit permission.
    if (code == 'EAPI0012') return Failure.apiInvalidEntryEditPermission();

    // * Invalid entry add permission.
    if (code == 'EAPI0013') return Failure.apiInvalidEntryAddPermission();

    // * Invalid entry delete permission.
    if (code == 'EAPI0014') return Failure.apiInvalidEntryDeletePermission();

    // * Invalid subgroup add permission.
    if (code == 'EAPI0015') return Failure.apiInvalidSubgroupAddPermission();

    // * Invalid subgroup edit permission.
    if (code == 'EAPI0016') return Failure.apiInvalidSubgroupEditPermission();

    // * Invalid subgroup delete permission.
    if (code == 'EAPI0017') return Failure.apiInvalidSubgroupDeletePermission();

    // * This group is locked.
    if (code == 'EAPI0018') return Failure.apiGroupIsLocked();

    // * This username is not available.
    if (code == 'EAPI0019') return Failure.apiUsernameNotAvailable();

    // * This object was deleted.
    if (code == 'EAPI0020') return Failure.apiObjectWasDeleted();

    // * Object delete failed.
    if (code == 'EAPI0021') return Failure.apiObjectDeleteFailed();

    // * Group update failed.
    if (code == 'EAPI0022') return Failure.apiGroupUpdateFailed();

    // * Generic transaction failure.
    if (code == 'EAPI0023') return Failure.apiDatabaseTransactionFailed();

    // * Referenced object not found.
    if (code == 'EAPI0024') return Failure.apiReferencedObjectNotFound();

    // * No chart type supplied.
    if (code == 'EAPI0026') return Failure.unknownChartInstruction();

    // * Referenced cache object not found.
    if (code == 'EAPI0027') return Failure.cachedChartItemsNotFound();

    // * An app update is required to contiune.
    if (code == 'APP_UPDATE_REQUIRED') return Failure.appUpdateRequired();

    // * API experiences technical difficulties.
    if (code == 'API_TECHNICAL_DIFFICULTIES') return Failure.apiTechnicalDifficulties();

    // * API maintenance.
    if (code == 'API_MAINTENANCE') return Failure.apiMaintenance();

    // * API deprecated.
    if (code == 'API_DEPRECATED') return Failure.apiDeprecated();

    // * API access revoked indefinitely.
    if (code == 'API_ACCESS_REVOKED_INDEFINITELY') return Failure.apiAccessRevokedIndefinitely();

    // * API access revoked temporarily.
    if (code == 'API_ACCESS_REVOKED_TEMPORARILY') return Failure.apiAccessRevokedTemporarily();

    // * API suspended.
    if (code == 'API_SUSPENDED') return Failure.apiSuspended();

    // No code was supplied or code was not found.
    return apiGenericError();
  }

  /// * EAPI0001
  /// * Internal server error. Something went wrong on our side, please try again.
  static Failure apiInternalServerError() {
    return Failure(
      code: 'EAPI0001',
      message: labels.failureApiInternalServerError(),
    );
  }

  /// * EAPI0002
  /// * No data was returned, please try again.
  static Failure apiEmptyResponseBody() {
    return Failure(
      code: 'EAPI0002',
      message: labels.failureApiEmptyResponseBody(),
    );
  }

  /// * EAPI0003
  /// * Received response code is unknown, please try again.
  static Failure apiUnknownResponseCode() {
    return Failure(
      code: 'EAPI0003',
      message: labels.failureApiUnknownResponseCode(),
    );
  }

  /// * EAPI0004
  /// * This took to long, please try again.
  static Failure apiHttpTimeout() {
    return Failure(
      code: 'EAPI0004',
      message: labels.failureApiHttpTimeout(),
    );
  }

  /// * EAPI0005
  /// * An error occurred, please try again.
  static Failure apiGenericError() {
    return Failure(
      code: 'EAPI0005',
      message: labels.failureApiGenericError(),
    );
  }

  /// * EAPI0006
  /// * Valid authorization is missing, request denied.
  static Failure apiUnauthorizedRequest() {
    return Failure(
      code: 'EAPI0006',
      message: labels.failureApiUnauthorizedRequest(),
    );
  }

  /// * EAPI0007
  /// * Invalid endpoint accessed, request denied.
  static Failure apiInvalidEndpoint() {
    return Failure(
      code: 'EAPI0007',
      message: labels.apiInvalidEndpoint(),
    );
  }

  /// * EAPI0008
  /// * No IP address provided, request denied.
  static Failure apiNoIPAddressProvided() {
    return Failure(
      code: 'EAPI0008',
      message: labels.apiNoIPAddressProvided(),
    );
  }

  /// * EAPI0009
  /// * Invalid permission to access this endpoint, request denied.
  static Failure apiEndpointAccessProhibited() {
    return Failure(
      code: 'EAPI0008',
      message: labels.apiEndpointAccessProhibited(),
    );
  }

  /// * EAPI0010
  /// * Request limit was exceeded, please try again later.
  static Failure apiRequestLimitExceeded() {
    return Failure(
      code: 'EAPI0010',
      message: labels.apiRequestLimitExceeded(),
    );
  }

  /// * EAPI0011
  /// * This model entry is referenced by entries and cannot be deleted.
  static Failure apiCannotDeleteReferencedModelEntry() {
    return Failure(
      code: 'EAPI0011',
      message: labels.failureEntryModelIsReferenced(),
    );
  }

  /// * EAPI0012
  /// * Invalid permission to edit entry.
  static Failure apiInvalidEntryEditPermission() {
    return Failure(
      code: 'EAPI0012',
      message: labels.entryEditProhibited(),
    );
  }

  /// * EAPI0013
  /// * Invalid permission to add entry.
  static Failure apiInvalidEntryAddPermission() {
    return Failure(
      code: 'EAPI0013',
      message: labels.entryAddProhibited(),
    );
  }

  /// * EAPI0014
  /// * Invalid permission to delete entry.
  static Failure apiInvalidEntryDeletePermission() {
    return Failure(
      code: 'EAPI0014',
      message: labels.entryDeleteProhibited(),
    );
  }

  /// * EAPI0015
  /// * Invalid permission to add subgroup.
  static Failure apiInvalidSubgroupAddPermission() {
    return Failure(
      code: 'EAPI0015',
      message: labels.subgroupAddProhibited(),
    );
  }

  /// * EAPI0016
  /// * Invalid permission to edit subgroup.
  static Failure apiInvalidSubgroupEditPermission() {
    return Failure(
      code: 'EAPI0016',
      message: labels.subgroupEditProhibited(),
    );
  }

  /// * EAPI0017
  /// * Invalid permission to delete subgroup.
  static Failure apiInvalidSubgroupDeletePermission() {
    return Failure(
      code: 'EAPI0017',
      message: labels.subgroupDeleteProhibited(),
    );
  }

  /// * EAPI0018
  /// * This group is locked.
  static Failure apiGroupIsLocked() {
    return Failure(
      code: 'EAPI0018',
      message: labels.failureGroupIsLocked(),
    );
  }

  /// * EAPI0019
  /// * This username is not available.
  static Failure apiUsernameNotAvailable() {
    return Failure(
      code: 'EAPI0019',
      message: labels.apiUsernameNotAvailable(),
    );
  }

  /// * EAPI0020
  /// * This object was deleted.
  static Failure apiObjectWasDeleted() {
    return Failure(
      code: 'EAPI0020',
      message: labels.apiObjectWasDeleted(),
    );
  }

  /// * EAPI0021
  /// * Failed to delete object.
  static Failure apiObjectDeleteFailed() {
    return Failure(
      code: 'EAPI0021',
      message: labels.apiObjectDeleteFailed(),
    );
  }

  /// * EAPI0022
  /// * Failed to update group.
  static Failure apiGroupUpdateFailed() {
    return Failure(
      code: 'EAPI0022',
      message: labels.failedToUpdateGroup(),
    );
  }

  /// * EAPI0023
  /// * Database transaction failed, please try again.
  static Failure apiDatabaseTransactionFailed() {
    return Failure(
      code: 'EAPI0023',
      message: labels.apiDatabaseTransactionFailed(),
    );
  }

  /// * EAPI0024
  /// * Referenced object was not found.
  static Failure apiReferencedObjectNotFound() {
    return Failure(
      code: 'EAPI0024',
      message: labels.apiReferencedObjectNotFound(),
    );
  }

  /// * APP_UPDATE_REQUIRED
  /// * 'A newer version of the app is required to continue.\n\nPlease update to the latest version to ensure compatibility and access to all features.';
  static Failure appUpdateRequired() {
    return Failure(
      code: 'APP_UPDATE_REQUIRED',
      message: labels.appUpdateRequired(),
    );
  }

  /// * API_TECHNICAL_DIFFICULTIES
  /// * 'Our servers are experiencing technical difficulties.\n\nPlease try again later.';
  static Failure apiTechnicalDifficulties() {
    return Failure(
      code: 'API_TECHNICAL_DIFFICULTIES',
      message: labels.apiTechnicalDifficulties(),
    );
  }

  /// * API_MAINTENANCE
  /// * 'We're making some improvements behind the scenes.\n\nPlease try again later.';
  static Failure apiMaintenance() {
    return Failure(
      code: 'API_MAINTENANCE',
      message: labels.apiMaintenance(),
    );
  }

  /// * API_DEPRECATED
  /// * 'We're sorry but this cannot be used anymore.\n\nPlease update your app to get access to the latest improvements.';
  static Failure apiDeprecated() {
    return Failure(
      code: 'API_DEPRECATED',
      message: labels.apiDeprecated(),
    );
  }

  /// * API_ACCESS_REVOKED_INDEFINITELY
  /// * 'You have exceeded the request limit to often and your access to the api has been revoked indefinitely.\n\nPlease contact our support if you think this is a misstake.';
  static Failure apiAccessRevokedIndefinitely() {
    return Failure(
      code: 'API_ACCESS_REVOKED_INDEFINITELY',
      message: labels.apiAccessRevokedIndefinitely(),
    );
  }

  /// * API_ACCESS_REVOKED_TEMPORARILY
  /// * 'You have exceeded the request limit. Please try again later.';
  static Failure apiAccessRevokedTemporarily() {
    return Failure(
      code: 'API_ACCESS_REVOKED_TEMPORARILY',
      message: labels.apiAccessRevokedTemporarily(),
    );
  }

  /// * API_SUSPENDED
  /// * 'API has been suspended until further notice.\n\nWe apologize for any inconveniences.';
  static Failure apiSuspended() {
    return Failure(
      code: 'API_SUSPENDED',
      message: labels.apiSuspended(),
    );
  }

  // #############################
  // Copy With
  // #############################

  Failure copyWith({
    String? code,
    String? message,
  }) {
    return Failure(
      code: code ?? this.code,
      message: message ?? this.message,
    );
  }
}
