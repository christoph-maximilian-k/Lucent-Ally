// Models.
import '/data/models/invite_specs/invite_specs.dart';
import '/data/models/picker_items/picker_item.dart';
import '/data/models/field_identifications/field_identification.dart';
import '/data/models/field_identifications/field_identifications.dart';
import '/data/models/import_specifications/import_specifications.dart';

class Labels {
  final String languageLocale;

  const Labels({
    required this.languageLocale,
  });

  //----------------------------------------------
  //----------------- App Name -------------------
  //----------------------------------------------

  /// App name
  /// ```dart
  /// 'Lucent Ally'
  /// ```
  /// * does not change
  String appName() {
    return 'Lucent Ally';
  }

  //-----------------------------------------------
  //---------- Basic Labels -----------------------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Tags';
  /// ```
  /// * default is english (en)
  String basicLabelsTags() {
    if (languageLocale == 'de') return 'Tags';
    return 'Tags';
  }

  /// Localizes the label
  /// ```dart
  /// 'Time';
  /// ```
  /// * default is english (en)
  String basicLabelsTime() {
    if (languageLocale == 'de') return 'Uhrzeit';
    return 'Time';
  }

  /// Localizes the label
  /// ```dart
  /// 'Expiration date';
  /// ```
  /// * default is english (en)
  String basicLabelsExpirationDate() {
    if (languageLocale == 'de') return 'Ablaufdatum';
    return 'Expiration date';
  }

  /// Localizes the label
  /// ```dart
  /// 'Usage limits';
  /// ```
  /// * default is english (en)
  String basicLabelsUsageLimits() {
    if (languageLocale == 'de') return 'Nutzungslimits';
    return 'Usage limits';
  }

  /// Localizes the label
  /// ```dart
  /// 'Delete this member?';
  /// ```
  /// * default is english (en)
  String confirmDeleteMember() {
    if (languageLocale == 'de') return 'Dieses Mitglied wirklich löschen?';
    return 'Delete this member?';
  }

  /// Localizes the label
  /// ```dart
  /// 'You';
  /// ```
  /// * default is english (en)
  String basicLabelsYou() {
    if (languageLocale == 'de') return 'Du';
    return 'You';
  }

  /// Localizes the label
  /// ```dart
  /// 'Decrypting file...';
  /// ```
  /// * default is english (en)
  String decryptingFile() {
    if (languageLocale == 'de') return 'Datei entschlüsseln..';
    return 'Decrypting file...';
  }

  /// Localizes the label
  /// ```dart
  /// 'Decrypting image...';
  /// ```
  /// * default is english (en)
  String decryptingImage() {
    if (languageLocale == 'de') return 'Bild entschlüsseln..';
    return 'Decrypting image...';
  }

  /// Localizes the label
  /// ```dart
  /// 'Image';
  /// ```
  /// * default is english (en)
  String basicLabelsImage() {
    if (languageLocale == 'de') return 'Bild';
    return 'Image';
  }

  /// Localizes the label
  /// ```dart
  /// 'File';
  /// ```
  /// * default is english (en)
  String basicLabelsFile() {
    if (languageLocale == 'de') return 'Datei';
    return 'File';
  }

  /// Localizes the label
  /// ```dart
  /// 'Share';
  /// ```
  /// * default is english (en)
  String basicLabelsShare() {
    if (languageLocale == 'de') return 'Teilen';
    return 'Share';
  }

  /// Localizes the label
  /// ```dart
  /// 'No caption available.';
  /// ```
  /// * default is english (en)
  String basicLabelsNoCaption() {
    if (languageLocale == 'de') return 'Kein Dateitext vorhanden.';
    return 'No caption available.';
  }

  /// Localizes the label
  /// ```dart
  /// 'No member selected.';
  /// ```
  /// * default is english (en)
  String basicLabelsNoMemberSelected() {
    if (languageLocale == 'de') return 'Kein Mitglied ausgewählt.';
    return 'No member selected.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Attention!';
  /// ```
  /// * default is english (en)
  String basicLabelsAttention() {
    if (languageLocale == 'de') return 'Achtung!';
    return 'Attention!';
  }

  /// Localizes the label
  /// ```dart
  /// 'Invalid entries';
  /// ```
  /// * default is english (en)
  String basicLabelsInvalidEntries() {
    if (languageLocale == 'de') return 'Ungültige Einträge';
    return 'Invalid entries';
  }

  /// Localizes the label
  /// ```dart
  /// 'Provide exchange rates';
  /// ```
  /// * default is english (en)
  String basicLabelsProvideExchangeRates() {
    if (languageLocale == 'de') return 'Wechselkurse angeben';
    return 'Provide exchange rates';
  }

  /// Localizes the label
  /// ```dart
  /// 'Exchange rate from $fromCurrencyCode to $toCurrencyCode was not found.\n\nPlease provide a custom exchange rate.';
  /// ```
  /// * default is english (en)
  String customExchangeRateRequired({required bool inFuture, required String fromCurrencyCode, required String toCurrencyCode}) {
    if (languageLocale == 'de') {
      if (inFuture) return 'Benötigter Wechselkurs von $fromCurrencyCode zu $toCurrencyCode liegt in der Zukunft.\n\nBitte ändere das Datum, lege einen benutzerdefinierten Wechselkurs fest oder warte bis der Wechselkurs verfügbar ist.';
      return 'Wechselkurs von $fromCurrencyCode zu $toCurrencyCode konnte nicht gefunden werden.\n\nBitte lege einen benutzerdefinierten Wechselkurs fest.';
    }

    if (inFuture) return 'Requested exchange rate from $fromCurrencyCode to $toCurrencyCode lies in the future.\n\nPlease change the date, provide a custom exchange rate or wait until the exchange rate is available.';
    return 'Exchange rate from $fromCurrencyCode to $toCurrencyCode was not found.\n\nPlease provide a custom exchange rate.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For the field $fieldName a exchange rate from $fromCurrencyCode to $toCurrencyCode could not be found.\n\nPlease provide a custom exchange rate or change the currency of this field.';
  /// ```
  /// * default is english (en)
  String customExchangeRateRequiredForField({required String fromCurrencyCode, required String toCurrencyCode, required String fieldName}) {
    if (languageLocale == 'de') return 'Für das Feld "$fieldName" konnte der Wechselkurs von $fromCurrencyCode zu $toCurrencyCode nicht gefunden werden.\n\nBitte lege einen benutzerdefinierten Wechselkurs fest oder ändere die Währung für dieses Feld.';
    return 'For the field "$fieldName" a exchange rate from $fromCurrencyCode to $toCurrencyCode could not be found.\n\nPlease provide a custom exchange rate or change the currency of this field.';
  }

  /// Localizes the label
  /// ```dart
  /// 'The field "$fieldName" tries to access a exchange rate of the future.';
  /// ```
  /// * default is english (en)
  String exchangeRateInFuture({required String fieldName}) {
    if (languageLocale == 'de') return 'Im Feld "$fieldName" wird ein zukünftiger Wechselkurs angefragt.';
    return 'The field "$fieldName" tries to access a exchange rate of the future.';
  }

  /// Localizes the label
  /// ```dart
  /// 'No images selected.';
  /// ```
  /// * default is english (en)
  String basicLabelsNoFilesSelected() {
    if (languageLocale == 'de') return 'Keine Dateien ausgewählt.';
    return 'No files selected.';
  }

  /// Localizes the label
  /// ```dart
  /// 'No images selected.';
  /// ```
  /// * default is english (en)
  String basicLabelsNoImagesSelected() {
    if (languageLocale == 'de') return 'Keine Bilder ausgewählt.';
    return 'No images selected.';
  }

  /// Localizes the label
  /// ```dart
  /// 'No image selected.';
  /// ```
  /// * default is english (en)
  String basicLabelsNoImageSelected() {
    if (languageLocale == 'de') return 'Kein Bild ausgewählt.';
    return 'No image selected.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Numbers in this app are limited to a maximum of 14 characters.';
  /// ```
  /// * default is english (en)
  String numberHasTooManyCharacters() {
    if (languageLocale == 'de') return 'Zahlen in dieser App sind auf maximal 14 Zeichen begrenzt.';
    return 'Numbers in this app are limited to a maximum of 14 characters.';
  }

  /// Localizes the label
  /// ```dart
  /// 'The default currency of a shared group cannot be changed if entries exist.';
  /// ```
  /// * default is english (en)
  String cannotChangeDefaultCurrencyOfSharedGroup() {
    if (languageLocale == 'de') return 'Die Standardwährung einer geteilten Gruppe kann nur geändert werden, wenn keine Einträge vorhanden sind.';
    return 'The default currency of a shared group cannot be changed if entries exist.';
  }

  /// Localizes the label
  /// ```dart
  /// return value != null ? 'Exchange rate: $value' :'Set custom exchange rate';
  /// ```
  /// * default is english (en)
  String basicLabelsSetCustomExchangeRate({required String? value, required String defaultCurrency}) {
    if (languageLocale == 'de') return value != null ? 'Wechselkurs:   $value   ' : 'Wechselkurs zu $defaultCurrency festlegen';
    return value != null ? 'Exchange rate:   $value   ' : 'Set custom exchange rate to $defaultCurrency';
  }

  /// Localizes the label.
  /// * Returns info line depending on chart filter settings.
  /// * default is english (en)
  String basicLabelsFieldIndication({required FieldIdentifications fieldIdentifications, required String filterByFieldId}) {
    // Access the relevant field identification. This should be null if no filterByFieldId was supplied.
    final FieldIdentification? fieldIdentification = fieldIdentifications.getById(fieldId: filterByFieldId);
    final String fieldName = fieldIdentification?.label ?? '';

    if (languageLocale == 'de') {
      return fieldName.isEmpty ? 'Für alle Felder des ausgewählten Typs' : 'Für das Feld "$fieldName"';
    }

    return fieldName.isEmpty ? 'For all Fields of chosen type' : 'For field "$fieldName"';
  }

  /// Localizes the label
  /// ```dart
  /// 'Maximum'
  /// ```
  /// * default is english (en)
  String basicLabelsMaximum() {
    if (languageLocale == 'de') return 'Maximum';
    return 'Maximum';
  }

  /// Localizes the label
  /// ```dart
  /// 'Default Currency';
  /// ```
  /// * default is english (en)
  String basicLabelsDefaultCurrency() {
    if (languageLocale == 'de') return 'Standardwährung';
    return 'Default Currency';
  }

  /// Localizes the label
  /// ```dart
  /// 'Exchange rate';
  /// ```
  /// * default is english (en)
  String basicLabelsExchangeRate() {
    if (languageLocale == 'de') return 'Wechselkurs';
    return 'Exchange rate';
  }

  /// Localizes the label
  /// ```dart
  /// 'Restrict to common'
  /// ```
  /// * default is english (en)
  String basicLabelsRestrictToCommon() {
    if (languageLocale == 'de') return 'Beschränken';
    return 'Restrict to common';
  }

  /// Localizes the label
  /// ```dart
  /// return groupName.isEmpty? 'Choose group' : groupName;
  /// ```
  /// * default is english (en)
  String basicLabelsChooseGroup({required String groupName}) {
    if (languageLocale == 'de') return groupName.isEmpty ? 'Gruppe auswählen' : groupName;
    return groupName.isEmpty ? 'Choose group' : groupName;
  }

  /// Localizes the label
  /// ```dart
  /// return groupName.isEmpty? 'Choose subgroup' : groupName;
  /// ```
  /// * default is english (en)
  String basicLabelsChooseSubgroup({required String groupName}) {
    if (languageLocale == 'de') return groupName.isEmpty ? 'Untergruppe auswählen' : groupName;
    return groupName.isEmpty ? 'Choose subgroup' : groupName;
  }

  /// Localizes the label
  /// ```dart
  /// 'Fail'
  /// ```
  /// * default is english (en)
  String basicLabelsImportShouldFail() {
    if (languageLocale == 'de') return 'Fehlschlagen';
    return 'Fail';
  }

  /// Localizes the label
  /// ```dart
  /// 'Fail or use default'
  /// ```
  /// * default is english (en)
  String basicLabelsImportShouldFailOrDefault() {
    if (languageLocale == 'de') return 'Standardwert sonst fehlschlagen';
    return 'Use default or fail';
  }

  /// Localizes the label
  /// ```dart
  /// 'Skip'
  /// ```
  /// * default is english (en)
  String basicLabelsImportShouldSkip() {
    if (languageLocale == 'de') return 'Überspringen';
    return 'Skip';
  }

  /// Localizes the label
  /// ```dart
  /// 'Add participant'
  /// ```
  /// * default is english (en)
  String basicLabelsAddParticipant() {
    if (languageLocale == 'de') return 'Mitwirkende erstellen';
    return 'Add participant';
  }

  /// Localizes the label
  /// ```dart
  /// 'Delete file?'
  /// ```
  /// * default is english (en)
  String basicLabelsConfirmDeleteFile() {
    if (languageLocale == 'de') return 'Datei löschen?';
    return 'Delete file?';
  }

  /// Localizes the label
  /// ```dart
  /// 'Add participant'
  /// ```
  /// * default is english (en)
  String basicLabelsInfoMessageParticipantImportMode() {
    if (languageLocale == 'de') return 'Mitwirkende sind notwendig um Zahlungen darzustellen aber die Gruppe in die importiert werden soll hat keine Mitwirkende definiert.';
    return 'A participant is required to display payments and the group that you want to import to does not have a participant set.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Use default or skip'
  /// ```
  /// * default is english (en)
  String basicLabelsImportShouldSkipOrDefault() {
    if (languageLocale == 'de') return 'Standardwert sonst überspringen';
    return 'Use default or skip';
  }

  /// Localizes the label
  /// ```dart
  /// 'Replace missing values'
  /// ```
  /// * default is english (en)
  String basicLabelsReplaceMissingValues() {
    if (languageLocale == 'de') return 'Fehlende Werte ersetzen';
    return 'Replace missing values';
  }

  /// Localizes the label
  /// ```dart
  /// 'Replace missing values'
  /// ```
  /// * default is english (en)
  String basicLabelsInfoMessageForceMemberValueImport() {
    if (languageLocale == 'de') return 'Wenn aktiviert werden fehlende Werte mit "0,00" ersetzt.';
    return 'This will replace any missing values with "0.00" if set to true.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Create example'
  /// ```
  /// * default is english (en)
  String basicLabelsCreateExample() {
    if (languageLocale == 'de') return 'Beispiel erstellen';
    return 'Create example';
  }

  /// Localizes the label
  /// ```dart
  /// return isEdit ? 'Edit sample entry' : 'Create sample entry';
  /// ```
  /// * default is english (en)
  String basicLabelsCreateTemplate({required bool isEdit}) {
    if (languageLocale == 'de') return isEdit ? 'Beispiel-Eintrag bearbeiten' : 'Beispiel-Eintrag erstellen';
    return isEdit ? 'Edit sample entry' : 'Create sample entry';
  }

  /// Localizes the label
  /// ```dart
  /// 'Choose existing'
  /// ```
  /// * default is english (en)
  String basicLabelsChooseExisting() {
    if (languageLocale == 'de') return 'Aus Existierenden auswählen';
    return 'Choose existing';
  }

  /// Localizes the label
  /// ```dart
  /// 'Create new'
  /// ```
  /// * default is english (en)
  String basicLabelsCreateNew() {
    if (languageLocale == 'de') return 'Neu erstellen';
    return 'Create new';
  }

  /// Localizes the label
  /// ```dart
  /// 'Choose file'
  /// ```
  /// * default is english (en)
  String basicLabelsChooseFile() {
    if (languageLocale == 'de') return 'Datei auswählen';
    return 'Choose file';
  }

  /// Localizes the label
  /// ```dart
  /// return '$days days left';
  /// ```
  /// * default is english (en)
  String basicLabelsDaysLeft({required int days}) {
    if (languageLocale == 'de') return 'Noch $days Tage';
    return '$days days left';
  }

  /// Localizes the label
  /// ```dart
  /// return datapoint == null || datapoint.isEmpty ? 'Match value with datapoint' : datapoint;
  /// ```
  /// * default is english (en)
  String basicLabelsConnectValueWithDatapoint({required String? datapoint}) {
    if (languageLocale == 'de') return datapoint == null || datapoint.isEmpty ? 'Wert mit Datenpunkt verknüpfen' : datapoint;
    return datapoint == null || datapoint.isEmpty ? 'Match value with datapoint' : datapoint;
  }

  /// Localizes the label
  /// ```dart
  /// return datapoint == null || datapoint.isEmpty ? 'Match exchange rate with datapoint' : datapoint;
  /// ```
  /// * default is english (en)
  String basicLabelsMatchCustomExchangeRateWithDatapoint({required String? datapoint}) {
    if (languageLocale == 'de') return datapoint == null || datapoint.isEmpty ? 'Wechselkurs mit Datenpunkt verknüpfen' : datapoint;
    return datapoint == null || datapoint.isEmpty ? 'Match exchange rate with datapoint' : datapoint;
  }

  /// Localizes the label
  /// ```dart
  /// return datapoint == null || datapoint.isEmpty ? 'Match currency with datapoint' : datapoint;
  /// ```
  /// * default is english (en)
  String basicLabelsConnectCurrencyWithDatapoint({required String? datapoint}) {
    if (languageLocale == 'de') return datapoint == null || datapoint.isEmpty ? 'Währung mit Datenpunkt verknüpfen' : datapoint;
    return datapoint == null || datapoint.isEmpty ? 'Match currency with datapoint' : datapoint;
  }

  /// Localizes the label
  /// ```dart
  /// 'Delimiters'
  /// ```
  /// * default is english (en)
  String basicLabelsDelimiters() {
    if (languageLocale == 'de') return 'Trennzeichen';
    return 'Delimiters';
  }

  /// Localizes the label
  /// ```dart
  /// 'Invite to group'
  /// ```
  /// * default is english (en)
  String basicLabelsInviteToGroup() {
    if (languageLocale == 'de') return 'Zur Gruppe einladen';
    return 'Invite to group';
  }

  /// Localizes the label
  /// ```dart
  /// 'Entry name copied'
  /// ```
  /// * default is english (en)
  String basicLabelsEntryNameCopied() {
    if (languageLocale == 'de') return 'Eintragsname kopiert';
    return 'Entry name copied';
  }

  /// Localizes the label
  /// ```dart
  /// 'Password'
  /// ```
  /// * default is english (en)
  String basicLabelsPasswordHint() {
    if (languageLocale == 'de') return 'Passwort';
    return 'Password';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please authenticate'
  /// ```
  /// * default is english (en)
  String basicLabelsAuthenticate() {
    if (languageLocale == 'de') return 'Authentifizierung notwendig';
    return 'Please authenticate';
  }

  /// Localizes the label
  /// ```dart
  /// 'Show protected entries'
  /// ```
  /// * default is english (en)
  String basicLabelsShowProtectedRecentEntries() {
    if (languageLocale == 'de') return 'Geschützte Einträge anzeigen';
    return 'Show protected entries';
  }

  /// Localizes the label
  /// ```dart
  /// 'Hide protected entries'
  /// ```
  /// * default is english (en)
  String basicLabelsHideProtectedRecentEntries() {
    if (languageLocale == 'de') return 'Geschützte Einträge verstecken';
    return 'Hide protected entries';
  }

  /// Localizes the label
  /// ```dart
  /// return value ? 'enabled' : 'disabled';
  /// ```
  /// * default is english (en)
  String basicLabelsEnabledDisabled({required bool value}) {
    if (languageLocale == 'de') return value ? 'an' : 'aus';
    return value ? 'enabled' : 'disabled';
  }

  /// Localizes the label
  /// ```dart
  /// 'Password created'
  /// ```
  /// * default is english (en)
  String basicLabelsPasswordCreated() {
    if (languageLocale == 'de') return 'Passwort erstellt';
    return 'Password created';
  }

  /// Localizes the label
  /// ```dart
  /// 'Password updated'
  /// ```
  /// * default is english (en)
  String basicLabelsPasswordUpdated() {
    if (languageLocale == 'de') return 'Passwort aktualisiert';
    return 'Password updated';
  }

  /// Localizes the label
  /// ```dart
  /// return isShared ? 'Shared entry' : 'Entry';
  /// ```
  /// * default is english (en)
  String basicLabelsGenericEntry({required bool isShared}) {
    if (languageLocale == 'de') return isShared ? 'Geteilter Eintrag' : 'Eintrag';
    return isShared ? 'Shared entry' : 'Entry';
  }

  /// Localizes the label
  /// ```dart
  /// 'Cancle'
  /// ```
  /// * default is english (en)
  String basicLabelsCancle() {
    if (languageLocale == 'de') return 'Abbrechen';
    return 'Cancle';
  }

  /// Localizes the label
  /// ```dart
  /// 'No entries found.';
  /// ```
  /// * default is english (en)
  String basicLabelsNoEntriesMessage() {
    if (languageLocale == 'de') return 'Keine Einträge gefunden.';
    return 'No entries found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Notify'
  /// ```
  /// * default is english (en)
  String basicLabelsAutomaticNotification() {
    if (languageLocale == 'de') return 'Benachrichtigen';
    return 'Notify';
  }

  /// Localizes the label
  /// ```dart
  /// 'Are you sure you do not want to save made edits?'
  /// ```
  /// * default is english (en)
  String basicLabelsUnsavedChanges() {
    if (languageLocale == 'de') return 'Gemachte Änderungen verwerfen?';
    return 'Are you sure you do not want to save made edits?';
  }

  /// Localizes the label
  /// ```dart
  /// 'Settings saved'
  /// ```
  /// * default is english (en)
  String basicLabelsSettingsSaved() {
    if (languageLocale == 'de') return 'Einstellungen gespeichert';
    return 'Settings saved';
  }

  /// Localizes the label
  /// ```dart
  /// 'Minimum'
  /// ```
  /// * default is english (en)
  String basicLabelsMinimum() {
    if (languageLocale == 'de') return 'Minimum';
    return 'Minimum';
  }

  /// Localizes the label
  /// ```dart
  /// 'Average'
  /// ```
  /// * default is english (en)
  String basicLabelsAverage() {
    if (languageLocale == 'de') return 'Durchschnitt';
    return 'Average';
  }

  /// Localizes the label
  /// ```dart
  /// 'No value found'
  /// ```
  /// * default is english (en)
  String basicLabelsNoValueFound() {
    if (languageLocale == 'de') return 'Kein Wert gefunden';
    return 'No value found';
  }

  /// Localizes the label
  /// ```dart
  /// 'Sum'
  /// ```
  /// * default is english (en)
  String basicLabelsSum() {
    if (languageLocale == 'de') return 'Summe';
    return 'Sum';
  }

  /// Localizes the label
  /// ```dart
  /// 'Unnamed'
  /// ```
  /// * default is english (en)
  String basicLabelsUnnamed() {
    if (languageLocale == 'de') return 'Unbenannt';
    return 'Unnamed';
  }

  /// Localizes the label
  /// ```dart
  /// 'Only the value of this field can be changed, not the parameters.'
  /// ```
  /// * default is english (en)
  String basicLabelsCannotChangeParamters() {
    if (languageLocale == 'de') return 'Für dieses Feld kann nur der Wert geändert werden, nicht die Parameter.';
    return 'Only the value of this field can be changed, not the parameters.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Descriptive values'
  /// ```
  /// * default is english (en)
  String basicLabelsDescriptiveValues() {
    if (languageLocale == 'de') return 'Beschreibende Werte';
    return 'Descriptive values';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please first select a measurement category.'
  /// ```
  /// * default is english (en)
  String basicLabelsMeasurementCategoryIsRequired() {
    if (languageLocale == 'de') return 'Bitte wähle zunächst eine Messkategorie aus.';
    return 'Please first select a measurement category.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Unknown unit conversion.'
  /// ```
  /// * default is english (en)
  String basicLabelsUnknownUnitConversion() {
    if (languageLocale == 'de') return 'Unbekannte Einheiten Umwandlung';
    return 'Unknown unit conversion.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please wait until current running fetch is finished.'
  /// ```
  /// * default is english (en)
  String basicLabelsisAlreadyLoading() {
    if (languageLocale == 'de') return 'Bitte warte bis der aktuell laufende Abruf abgeschlossen ist.';
    return 'Please wait until current running fetch is finished.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Repayments'
  /// ```
  /// * default is english (en)
  String basicLabelsRepayments() {
    if (languageLocale == 'de') return 'Rückzahlungen';
    return 'Repayments';
  }

  /// Localizes the label
  /// ```dart
  /// return category.isEmpty ? 'Category' : category;
  /// ```
  /// * default is english (en)
  String basicLabelsCategory({required String category}) {
    if (languageLocale == 'de') return category.isEmpty ? 'Kategorie' : category;
    return category.isEmpty ? 'Category' : category;
  }

  /// Localizes the label
  /// ```dart
  /// return unit.isEmpty ? 'Unit' : unit;
  /// ```
  /// * default is english (en)
  String basicLabelsUnit({required String unit}) {
    if (languageLocale == 'de') return unit.isEmpty ? 'Einheit' : unit;
    return unit.isEmpty ? 'Unit' : unit;
  }

  /// Localizes the label
  /// ```dart
  /// 'Positive emotion'
  /// ```
  /// * default is english (en)
  String basicLabelsPositiveEmotion() {
    if (languageLocale == 'de') return 'Positive Emotionen';
    return 'Positive emotions';
  }

  /// Localizes the label
  /// ```dart
  /// 'Parameters can change'
  /// ```
  /// * default is english (en)
  String basicLabelsCanChangeParameters() {
    if (languageLocale == 'de') return 'Parameter änderbar';
    return 'Parameters can change';
  }

  /// Localizes the label
  /// ```dart
  /// 'Negative emotion'
  /// ```
  /// * default is english (en)
  String basicLabelsNegativeEmotion() {
    if (languageLocale == 'de') return 'Negative Emotionen';
    return 'Negative emotions';
  }

  /// Localizes the label
  /// ```dart
  /// 'Image exists'
  /// ```
  /// * default is english (en)
  String basicLabelsImageExists() {
    if (languageLocale == 'de') return 'Bild vorhanden';
    return 'Image exists';
  }

  /// Localizes the label
  /// ```dart
  /// 'Converting data...'
  /// ```
  /// * default is english (en)
  String basicLabelsConvertingData() {
    if (languageLocale == 'de') return 'Daten konvertieren...';
    return 'Converting data...';
  }

  /// Localizes the label
  /// ```dart
  /// 'A currency is required.'
  /// ```
  /// * default is english (en)
  String moneyFieldCurrencyRequired({required String fieldName}) {
    if (languageLocale == 'de') return 'Bitte gib für das Feld "$fieldName" eine Währung an.';
    return 'A currency is required for the field "$fieldName".';
  }

  /// Localizes the label
  /// ```dart
  /// 'Field'
  /// ```
  /// * default is english (en)
  String basicLabelsField() {
    if (languageLocale == 'de') return 'Feld';
    return 'Field';
  }

  /// Localizes the label
  /// ```dart
  /// 'Date'
  /// ```
  /// * default is english (en)
  String basicLabelsDate() {
    if (languageLocale == 'de') return 'Datum';
    return 'Date';
  }

  /// Localizes the label
  /// ```dart
  /// return date == null || date.isEmpty ? 'Date' : date;
  /// ```
  /// * default is english (en)
  String basicLabelsDateDefault({required String? date}) {
    if (languageLocale == 'de') return date == null || date.isEmpty ? 'Datum' : date;
    return date == null || date.isEmpty ? 'Date' : date;
  }

  /// Localizes the label
  /// ```dart
  /// return time == null || time.isEmpty ? 'Time' : time;
  /// ```
  /// * default is english (en)
  String basicLabelsTimeDefault({required String? time}) {
    if (languageLocale == 'de') return time == null || time.isEmpty ? 'Uhrzeit' : time;
    return time == null || time.isEmpty ? 'Time' : time;
  }

  /// Localizes the label
  /// ```dart
  /// return timezone == null || timezone.isEmpty ? 'Timezone' : timezone;
  /// ```
  /// * default is english (en)
  String basicLabelsTimezoneDefault({required String? timezone}) {
    if (languageLocale == 'de') return timezone == null || timezone.isEmpty ? 'Zeitzone' : timezone;
    return timezone == null || timezone.isEmpty ? 'Timezone' : timezone;
  }

  /// Localizes the label
  /// ```dart
  /// 'Days until'
  /// ```
  /// * default is english (en)
  String basicLabelsDaysUntil() {
    if (languageLocale == 'de') return 'Tage bis';
    return 'Days until';
  }

  /// Localizes the label
  /// ```dart
  /// 'Current age'
  /// ```
  /// * default is english (en)
  String basicLabelsCurrentAge() {
    if (languageLocale == 'de') return 'Aktuelles Alter';
    return 'Current age';
  }

  /// Localizes the label
  /// ```dart
  /// 'No date found.'
  /// ```
  /// * default is english (en)
  String basicLabelsNoDateFound() {
    if (languageLocale == 'de') return 'Kein Datum gefunden.';
    return 'No date found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Unknown field'
  /// ```
  /// * default is english (en)
  String basicLabelsUnknownField() {
    if (languageLocale == 'de') return 'Unbekanntes Feld';
    return 'Unknown field';
  }

  /// Localizes the label
  /// ```dart
  /// 'Entry'
  /// ```
  /// * default is english (en)
  String basicLabelsEntry() {
    if (languageLocale == 'de') return 'Eintrag';
    return 'Entry';
  }

  /// Localizes the label
  /// ```dart
  /// 'Spring'
  /// ```
  /// * default is english (en)
  String basicLabelsSpring() {
    if (languageLocale == 'de') return 'Frühling';
    return 'Spring';
  }

  /// Localizes the label
  /// ```dart
  /// 'Summer'
  /// ```
  /// * default is english (en)
  String basicLabelsSummer() {
    if (languageLocale == 'de') return 'Sommer';
    return 'Summer';
  }

  /// Localizes the label
  /// ```dart
  /// 'Autumn'
  /// ```
  /// * default is english (en)
  String basicLabelsAutumn() {
    if (languageLocale == 'de') return 'Herbst';
    return 'Autumn';
  }

  /// Localizes the label
  /// ```dart
  /// 'Winter'
  /// ```
  /// * default is english (en)
  String basicLabelsWinter() {
    if (languageLocale == 'de') return 'Winter';
    return 'Winter';
  }

  /// Localizes the label
  /// ```dart
  /// 'Image missing'
  /// ```
  /// * default is english (en)
  String basicLabelsImageMissing() {
    if (languageLocale == 'de') return 'Bild fehlt';
    return 'Image missing';
  }

  /// Localizes the label
  /// ```dart
  /// 'Title exists'
  /// ```
  /// * default is english (en)
  String basicLabelsTitleExists() {
    if (languageLocale == 'de') return 'Titel vorhanden';
    return 'Title exists';
  }

  /// Localizes the label
  /// ```dart
  /// 'Title missing'
  /// ```
  /// * default is english (en)
  String basicLabelsTitleMissing() {
    if (languageLocale == 'de') return 'Titel fehlt';
    return 'Title missing';
  }

  /// Localizes the label
  /// ```dart
  /// 'Text exists'
  /// ```
  /// * default is english (en)
  String basicLabelsTextExists() {
    if (languageLocale == 'de') return 'Text vorhanden';
    return 'Text exists';
  }

  /// Localizes the label
  /// ```dart
  /// 'Text missing'
  /// ```
  /// * default is english (en)
  String basicLabelsTextMissing() {
    if (languageLocale == 'de') return 'Text fehlt';
    return 'Text missing';
  }

  /// Localizes the label
  /// ```dart
  /// 'Service (optional)'
  /// ```
  /// * default is english (en)
  String basicLabelsServiceOptional() {
    if (languageLocale == 'de') return 'Dienst (optional)';
    return 'Service (optional)';
  }

  /// Localizes the label
  /// ```dart
  /// 'Fields'
  /// ```
  /// * default is english (en)
  String basicLabelsFields() {
    if (languageLocale == 'de') return 'Felder';
    return 'Fields';
  }

  /// Localizes the label
  /// ```dart
  /// 'Datapoints'
  /// ```
  /// * default is english (en)
  String basicLabelsDatapoints() {
    if (languageLocale == 'de') return 'Datenpunkte';
    return 'Datapoints';
  }

  /// Localizes the label
  /// ```dart
  /// 'Match with Field'
  /// ```
  /// * default is english (en)
  String basicLabelsMatchWithField() {
    if (languageLocale == 'de') return 'Mit Feld verknüpfen';
    return 'Match with Field';
  }

  /// Localizes the label
  /// ```dart
  /// return datapoint == null || datapoint.isEmpty ? 'Match with datapoint' : datapoint;
  /// ```
  /// * default is english (en)
  String basicLabelsMatchWithDatapoint({required String? datapoint}) {
    if (languageLocale == 'de') return datapoint == null || datapoint.isEmpty ? 'Mit Datenpunkt verknüpfen' : datapoint;
    return datapoint == null || datapoint.isEmpty ? 'Match with datapoint' : datapoint;
  }

  /// Localizes the label
  /// ```dart
  /// return datapoint == null || datapoint.isEmpty ? 'Match latitude with datapoint' : 'Latitude • $datapoint';
  /// ```
  /// * default is english (en)
  String basicLabelsMatchLatitudeWithDatapoint({required String? datapoint}) {
    if (languageLocale == 'de') return datapoint == null || datapoint.isEmpty ? 'Breitengrad mit Datenpunkt verknüpfen' : 'Breitengrad • $datapoint';
    return datapoint == null || datapoint.isEmpty ? 'Match latitude with datapoint' : 'Latitude • $datapoint';
  }

  /// Localizes the label
  /// ```dart
  /// return datapoint == null || datapoint.isEmpty ? 'Match category with datapoint' : 'Category • $datapoint';
  /// ```
  /// * default is english (en)
  String basicLabelsMatchCategoryWithDatapoint({required String? datapoint}) {
    if (languageLocale == 'de') return datapoint == null || datapoint.isEmpty ? 'Kategorie mit Datenpunkt verknüpfen' : 'Kategorie • $datapoint';
    return datapoint == null || datapoint.isEmpty ? 'Match category with datapoint' : 'Category • $datapoint';
  }

  /// Localizes the label
  /// ```dart
  /// return datapoint == null || datapoint.isEmpty ? 'Match unit with datapoint' : 'Unit • $datapoint';
  /// ```
  /// * default is english (en)
  String basicLabelsMatchUnitWithDatapoint({required String? datapoint}) {
    if (languageLocale == 'de') return datapoint == null || datapoint.isEmpty ? 'Einheit mit Datenpunkt verknüpfen' : 'Einheit • $datapoint';
    return datapoint == null || datapoint.isEmpty ? 'Match unit with datapoint' : 'Unit • $datapoint';
  }

  /// Localizes the label
  /// ```dart
  /// return datapoint == null || datapoint.isEmpty ? 'Match value with datapoint' : 'Value • $datapoint';
  /// ```
  /// * default is english (en)
  String basicLabelsMatchValueWithDatapoint({required String? datapoint}) {
    if (languageLocale == 'de') return datapoint == null || datapoint.isEmpty ? 'Wert mit Datenpunkt verknüpfen' : 'Wert • $datapoint';
    return datapoint == null || datapoint.isEmpty ? 'Match value with datapoint' : 'Value • $datapoint';
  }

  /// Localizes the label
  /// ```dart
  /// return datapoint == null || datapoint.isEmpty ? 'Match emotion with datapoint' : 'Emotion • $datapoint';
  /// ```
  /// * default is english (en)
  String basicLabelsMatchEmotionWithDatapoint({required String? datapoint}) {
    if (languageLocale == 'de') return datapoint == null || datapoint.isEmpty ? 'Emotion mit Datenpunkt verknüpfen' : 'Emotion • $datapoint';
    return datapoint == null || datapoint.isEmpty ? 'Match emotion with datapoint' : 'Emotion • $datapoint';
  }

  /// Localizes the label
  /// ```dart
  /// return datapoint == null || datapoint.isEmpty ? 'Match intensity with datapoint' : 'Intensity • $datapoint';
  /// ```
  /// * default is english (en)
  String basicLabelsMatchIntensityWithDatapoint({required String? datapoint}) {
    if (languageLocale == 'de') return datapoint == null || datapoint.isEmpty ? 'Intensität mit Datenpunkt verknüpfen' : 'Intensität • $datapoint';
    return datapoint == null || datapoint.isEmpty ? 'Match intensity with datapoint' : 'Intensity • $datapoint';
  }

  /// Localizes the label
  /// ```dart
  /// return datapoint == null || datapoint.isEmpty ? 'Match occurrence with datapoint' : 'Occurrence • $datapoint';
  /// ```
  /// * default is english (en)
  String basicLabelsMatchOccurrenceWithDatapoint({required String? datapoint}) {
    if (languageLocale == 'de') return datapoint == null || datapoint.isEmpty ? 'Zeitpunkt mit Datenpunkt verknüpfen' : 'Zeitpunkt • $datapoint';
    return datapoint == null || datapoint.isEmpty ? 'Match occurrence with datapoint' : 'Occurrence • $datapoint';
  }

  /// Localizes the label
  /// ```dart
  /// return datapoint == null || datapoint.isEmpty ? 'Match latitude with datapoint' : 'Longitude • $datapoint';
  /// ```
  /// * default is english (en)
  String basicLabelsMatchLongitudeWithDatapoint({required String? datapoint}) {
    if (languageLocale == 'de') return datapoint == null || datapoint.isEmpty ? 'Längengrad mit Datenpunkt verknüpfen' : 'Längengrad • $datapoint';
    return datapoint == null || datapoint.isEmpty ? 'Match latitude with datapoint' : 'Longitude • $datapoint';
  }

  /// Localizes the label
  /// ```dart
  /// return datapoint == null || datapoint.isEmpty ? 'Match username with datapoint' : datapoint;
  /// ```
  /// * default is english (en)
  String basicLabelsMatchUsernameWithDatapoint({required String? datapoint}) {
    if (languageLocale == 'de') return datapoint == null || datapoint.isEmpty ? 'Username mit Datenpunkt verknüpfen' : datapoint;
    return datapoint == null || datapoint.isEmpty ? 'Match username with datapoint' : datapoint;
  }

  /// Localizes the label
  /// ```dart
  /// return datapoint == null || datapoint.isEmpty ? 'Match international prefix with datapoint' : datapoint;
  /// ```
  /// * default is english (en)
  String basicLabelsMatchInternationalPrefixWithDatapoint({required String? datapoint}) {
    if (languageLocale == 'de') return datapoint == null || datapoint.isEmpty ? 'Vorwahl mit Datenpunkt verknüpfen' : datapoint;
    return datapoint == null || datapoint.isEmpty ? 'Match international prefix with datapoint' : datapoint;
  }

  /// Localizes the label
  /// ```dart
  /// return datapoint == null || datapoint.isEmpty ? 'Match phone number with datapoint' : datapoint;
  /// ```
  /// * default is english (en)
  String basicLabelsMatchPhoneWithDatapoint({required String? datapoint}) {
    if (languageLocale == 'de') return datapoint == null || datapoint.isEmpty ? 'Telefonnummer mit Datenpunkt verknüpfen' : datapoint;
    return datapoint == null || datapoint.isEmpty ? 'Match phone number with datapoint' : datapoint;
  }

  /// Localizes the label
  /// ```dart
  /// return datapoint == null || datapoint.isEmpty ? 'Match service with datapoint' : datapoint;
  /// ```
  /// * default is english (en)
  String basicLabelsMatchUsernameServiceWithDatapoint({required String? datapoint}) {
    if (languageLocale == 'de') return datapoint == null || datapoint.isEmpty ? 'Dienst mit Datenpunkt verknüpfen' : datapoint;
    return datapoint == null || datapoint.isEmpty ? 'Match service with datapoint' : datapoint;
  }

  /// Localizes the label
  /// ```dart
  /// 'Not specified'
  /// ```
  /// * default is english (en)
  String basicLabelsNotSpecified() {
    if (languageLocale == 'de') return 'Nicht angegeben';
    return 'Not specified';
  }

  /// Localizes the label
  /// ```dart
  /// 'True'
  /// ```
  /// * default is english (en)
  String basicLabelsTrue() {
    if (languageLocale == 'de') return 'Wahr';
    return 'True';
  }

  /// Localizes the label
  /// ```dart
  /// 'False'
  /// ```
  /// * default is english (en)
  String basicLabelsFalse() {
    if (languageLocale == 'de') return 'Falsch';
    return 'False';
  }

  /// Localizes the label
  /// ```dart
  /// 'Accumulated'
  /// ```
  /// * default is english (en)
  String basicLabelsAccumulated() {
    if (languageLocale == 'de') return 'Akkumuliert';
    return 'Accumulated';
  }

  /// Localizes the label
  /// ```dart
  /// 'Individual values'
  /// ```
  /// * default is english (en)
  String basicLabelsIndividualValues() {
    if (languageLocale == 'de') return 'Einzelwerte';
    return 'Individual values';
  }

  /// Localizes the label
  /// ```dart
  /// 'Limit to specific field';
  /// ```
  /// * default is english (en)
  String basicLabelsLimitToField() {
    if (languageLocale == 'de') return 'Auf Feld beschränken';
    return 'Limit to specific field';
  }

  /// Localizes the label
  /// ```dart
  /// 'Others';
  /// ```
  /// * default is english (en)
  String basicLabelsOthers() {
    if (languageLocale == 'de') return 'Andere';
    return 'Others';
  }

  /// Localizes the label
  /// ```dart
  /// 'Uncategorized';
  /// ```
  /// * default is english (en)
  String basicLabelsNotTagged() {
    if (languageLocale == 'de') return 'Unkategorisiert';
    return 'Uncategorized';
  }

  /// Localizes the label
  /// ```dart
  /// 'Unknown chart type.';
  /// ```
  /// * default is english (en)
  String basicLabelsUnknownChartType() {
    if (languageLocale == 'de') return 'Unbekannte Diagrammart.';
    return 'Unknown chart type.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Optimized transactions';
  /// ```
  /// * default is english (en)
  String basicLabelsShowOptimized() {
    if (languageLocale == 'de') return 'Optimierte Transaktionen';
    return 'Optimized transactions';
  }

  /// Localizes the label
  /// ```dart
  /// 'All transactions';
  /// ```
  /// * default is english (en)
  String basicLabelsShowAll() {
    if (languageLocale == 'de') return 'Alle Transaktionen';
    return 'All transactions';
  }

  /// Localizes the label
  /// ```dart
  /// 'Overall';
  /// ```
  /// * default is english (en)
  String basicLabelsOverall() {
    if (languageLocale == 'de') return 'Gesamt';
    return 'Overall';
  }

  /// Localizes the label
  /// ```dart
  /// 'No data available for these filter settings.';
  /// ```
  /// * default is english (en)
  String basicLabelNoDataAvailable() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen sind keine Daten verfügbar.';
    return 'No data available for these filter settings.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Fullscreen';
  /// ```
  /// * default is english (en)
  String basicLabelFullscreen() {
    if (languageLocale == 'de') return 'Vollbild';
    return 'Fullscreen';
  }

  /// Localizes the label
  /// ```dart
  /// 'Choose time interval';
  /// ```
  /// * default is english (en)
  String basicLabelChooseTimeInterval() {
    if (languageLocale == 'de') return 'Zeitinterval wählen';
    return 'Choose time interval';
  }

  /// Localizes the label
  /// ```dart
  /// 'Considers all expense fields.';
  /// ```
  /// * default is english (en)
  String basicLabelsConsidersAllExpenseFields() {
    if (languageLocale == 'de') return 'Berücksichtigt alle Felder des Typs Ausgabe.';
    return 'Considers all expense fields.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Choose member';
  /// ```
  /// * default is english (en)
  String basicLabelChooseMember() {
    if (languageLocale == 'de') return 'Mitglied auswählen';
    return 'Choose member';
  }

  /// Localizes the label
  /// ```dart
  /// 'Settlements and total costs';
  /// ```
  /// * default is english (en)
  String basicLabelsShowSettlementAndCosts() {
    if (languageLocale == 'de') return 'Abrechnung und Gesamtkosten';
    return 'Settlements and total costs';
  }

  /// Localizes the label
  /// ```dart
  /// 'Show preview';
  /// ```
  /// * default is english (en)
  String basicLabelsShowPreview() {
    if (languageLocale == 'de') return 'Vorschau anzeigen';
    return 'Show preview';
  }

  /// Localizes the label
  /// ```dart
  /// 'at';
  /// ```
  /// * default is english (en)
  String basicLabelsAt() {
    if (languageLocale == 'de') return 'um';
    return 'at';
  }

  /// Localizes the label
  /// ```dart
  /// 'failed';
  /// ```
  /// * default is english (en)
  String basicLabelsFailed() {
    if (languageLocale == 'de') return 'fehlgeschlagen';
    return 'failed';
  }

  /// Localizes the label
  /// ```dart
  /// 'Choose a chart type';
  /// ```
  /// * default is english (en)
  String basicLabelsChartDecisionTitle() {
    if (languageLocale == 'de') return 'Wähle eine Diagrammart';
    return 'Choose a chart type';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to load chart.';
  /// ```
  /// * default is english (en)
  String basicLabelsFailedToLoadChart() {
    if (languageLocale == 'de') return 'Fehler beim laden.';
    return 'Failed to load chart.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Entry defaults';
  /// ```
  /// * default is english (en)
  String basicLabelsEntryDefaults() {
    if (languageLocale == 'de') return 'Standardwerte';
    return 'Entry defaults';
  }

  /// Localizes the label
  /// ```dart
  /// 'Default created';
  /// ```
  /// * default is english (en)
  String basicLabelsDefaultCreated() {
    if (languageLocale == 'de') return 'Standard erstellt';
    return 'Default created';
  }

  /// Localizes the label
  /// ```dart
  /// 'A default cannot be set for this field.';
  /// ```
  /// * default is english (en)
  String basicLabelsDefaultNotAvailable() {
    if (languageLocale == 'de') return 'Für dieses Feld kann kein Standard gesetzt werden.';
    return 'A default cannot be set for this field.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Is editable'
  /// ```
  /// * default is english (en)
  String basicLabelsIsEditable() {
    if (languageLocale == 'de') return 'Ist editierbar';
    return 'Is editable';
  }

  /// Localizes the label
  /// ```dart
  /// 'Group info'
  /// ```
  /// * default is english (en)
  String basicLabelsGroupInfo() {
    if (languageLocale == 'de') return 'Gruppeninfo';
    return 'Group info';
  }

  /// Localizes the label
  /// ```dart
  /// 'Statistics'
  /// ```
  /// * default is english (en)
  String basicLabelsCharts() {
    if (languageLocale == 'de') return 'Diagramme';
    return 'Statistics';
  }

  /// Localizes the label
  /// ```dart
  /// 'Join group'
  /// ```
  /// * default is english (en)
  String joinGroup() {
    if (languageLocale == 'de') return 'Gruppe beitreten';
    return 'Join group';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please provide the id of the group that you want to join.\n\nIt might look like this:\n\nfhsU27fjS'
  /// ```
  /// * default is english (en)
  String groupInviteLinkExample() {
    if (languageLocale == 'de') return 'Bitte gib die Alias der Gruppe an der du beitreten möchtest.\n\nHier ist eine Beispiel Alias:\n\nfhsU273';
    return 'Please provide the alias of the group that you want to join.\n\nIt might look like this:\n\nfhsU273';
  }

  /// Localizes the label
  /// ```dart
  /// 'Model entries'
  /// ```
  /// * default is english (en)
  String basicLabelsModelEntries() {
    if (languageLocale == 'de') return 'Eintragsvorlagen';
    return 'Model entries';
  }

  /// Localizes the label
  /// ```dart
  /// 'Entries'
  /// ```
  /// * default is english (en)
  String basicLabelsEntries() {
    if (languageLocale == 'de') return 'Einträge';
    return 'Entries';
  }

  /// Localizes the label
  /// ```dart
  /// 'Entries'
  /// ```
  /// * default is english (en)
  String basicLabelsEntriesTaggedWith({required String tagLabel}) {
    if (languageLocale == 'de') return 'Einträge mit dem Tag "$tagLabel"';
    return 'Entries tagged with "$tagLabel"';
  }

  /// Localizes the label
  /// ```dart
  /// 'Created at'
  /// ```
  /// * default is english (en)
  String basicLabelsCreatedAt() {
    if (languageLocale == 'de') return 'Erstellt am';
    return 'Created at';
  }

  /// Localizes the label
  /// ```dart
  /// 'Edited at'
  /// ```
  /// * default is english (en)
  String basicLabelsEditedAt() {
    if (languageLocale == 'de') return 'Zuletzt bearbeitet';
    return 'Edited at';
  }

  /// Localizes the label
  /// ```dart
  /// return isShared ? 'Common model entries' : 'Restrictions';
  /// ```
  /// * default is english (en)
  String basicLabelsCommonModelEntries({required bool isShared}) {
    if (languageLocale == 'de') return isShared ? 'Gemeinsame Eintragsvorlagen' : 'Beschränkungen';
    return isShared ? 'Common model entries' : 'Restrictions';
  }

  /// Localizes the label
  /// ```dart
  /// 'Success'
  /// ```
  /// * default is english (en)
  String basicLabelsSuccess() {
    if (languageLocale == 'de') return 'Aktion erfolgreich';
    return 'Success';
  }

  /// Localizes the label
  /// ```dart
  /// 'Local groups'
  /// ```
  /// * default is english (en)
  String basicLabelsLocalGroups() {
    if (languageLocale == 'de') return 'Lokale Gruppen';
    return 'Local groups';
  }

  /// Localizes the label
  /// ```dart
  /// 'Shared groups'
  /// ```
  /// * default is english (en)
  String basicLabelsSharedGroups() {
    if (languageLocale == 'de') return 'Geteilte Gruppen';
    return 'Shared groups';
  }

  /// Localizes the label
  /// ```dart
  /// 'close'
  /// ```
  /// * default is english (en)
  String basicLabelsClose() {
    if (languageLocale == 'de') return 'Schließen';
    return 'Close';
  }

  /// Localizes the label
  /// ```dart
  /// 'Accept'
  /// ```
  /// * default is english (en)
  String basicLabelsAccept() {
    if (languageLocale == 'de') return 'Akzeptieren';
    return 'Accept';
  }

  /// Localizes the label
  /// ```dart
  /// 'Import'
  /// ```
  /// * default is english (en)
  String basicLabelsImport() {
    if (languageLocale == 'de') return 'Importieren';
    return 'Import';
  }

  /// Localizes the label
  /// ```dart
  /// 'Export'
  /// ```
  /// * default is english (en)
  String basicLabelsExport() {
    if (languageLocale == 'de') return 'Exportieren';
    return 'Export';
  }

  /// Localizes the label
  /// ```dart
  /// 'add'
  /// ```
  /// * default is english (en)
  String basicLabelsAdd() {
    if (languageLocale == 'de') return 'Hinzufügen';
    return 'Add';
  }

  /// Localizes the label
  /// ```dart
  /// 'This group is empty.'
  /// ```
  /// * default is english (en)
  String basicLabelsEmptyGroup() {
    if (languageLocale == 'de') return 'Diese Gruppe ist leer.';
    return 'This group is empty.';
  }

  /// Localizes the label
  /// ```dart
  /// 'edit'
  /// ```
  /// * default is english (en)
  String basicLabelsEdit() {
    if (languageLocale == 'de') return 'Bearbeiten';
    return 'Edit';
  }

  /// Localizes the label
  /// ```dart
  /// 'delete'
  /// ```
  /// * default is english (en)
  String basicLabelsDelete() {
    if (languageLocale == 'de') return 'Löschen';
    return 'Delete';
  }

  /// Localizes the label
  /// ```dart
  /// 'Ready'
  /// ```
  /// * default is english (en)
  String basicLabelsReady() {
    if (languageLocale == 'de') return 'Fertig';
    return 'Ready';
  }

  /// Localizes the label
  /// ```dart
  /// 'choose'
  /// ```
  /// * default is english (en)
  String basicLabelsChoose() {
    if (languageLocale == 'de') return 'Auswählen';
    return 'Choose';
  }

  /// Localizes the label
  /// ```dart
  /// 'Try again'
  /// ```
  /// * default is english (en)
  String basicLabelsTryAgain() {
    if (languageLocale == 'de') return 'Noch einmal versuchen';
    return 'Try again';
  }

  /// Localizes the label
  /// ```dart
  /// 'Available files'
  /// ```
  /// * default is english (en)
  String basicLabelsAvailableFiles() {
    if (languageLocale == 'de') return 'Verfügbare Dateien';
    return 'Available files';
  }

  /// Localizes the label
  /// ```dart
  /// 'Participant'
  /// ```
  /// * default is english (en)
  String basicLabelsParticipant() {
    if (languageLocale == 'de') return 'Mitwirkende';
    return 'Participant';
  }

  /// Localizes the label
  /// ```dart
  /// 'No previously exported files found.'
  /// ```
  /// * default is english (en)
  String basicLabelsNoExportedFilesFound() {
    if (languageLocale == 'de') return 'Keine bereits exportierten Dateien gefunden.';
    return 'No previously exported files found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'This value will only be used if the default currency of the group where the import is conducted differs from the import currency.\n\nIf an invalid or missing custom exchange rate is detected, the import will proceed without applying the custom exchange rate.'
  /// ```
  /// * default is english (en)
  String basicLabelsImportCustomExchangeRate() {
    if (languageLocale == 'de') return 'Dieser Wert wird nur verwendet, wenn sich die Standardwährung der Gruppe, in der der Import durchgeführt wird, von der Importwährung unterscheidet.\n\nWenn ein ungültiger oder fehlender benutzerdefinierter Wechselkurs festgestellt wird, wird der Import ohne Anwendung des benutzerdefinierten Wechselkurses fortgesetzt.';
    return 'This value will only be used if the default currency of the group where the import is conducted differs from the import currency.\n\nIf an invalid or missing custom exchange rate is detected, the import will proceed without applying the custom exchange rate.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Participant'
  /// ```
  /// * default is english (en)
  String basicLabelsMembers() {
    if (languageLocale == 'de') return 'Mitglieder';
    return 'Members';
  }

  /// Localizes the label
  /// ```dart
  /// 'Something went wrong, please try again.'
  /// ```
  /// * default is english (en)
  String basicLabelsGenericError() {
    if (languageLocale == 'de') return 'Etwas ist schief gelaufen, bitte versuche es noch einmal.';
    return 'Something went wrong, please try again.';
  }

  //-----------------------------------------------
  //---------- Expense Report Sheet State ---------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'calculateing expense report...'
  /// ```
  /// * default is english (en)
  String expenseReportSheetStateLoadingMessage() {
    if (languageLocale == 'de') return 'abrechnung berechnen...';
    return 'calculateing expense report...';
  }

  //-----------------------------------------------
  //---------- Expense Report Sheet ---------------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Account are leveled out.'
  /// ```
  /// * default is english (en)
  String expenseReportSheetAccountIsLeveledOut() {
    if (languageLocale == 'de') return 'Konten sind ausgeglichen.';
    return 'Accounts are leveled out.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Expense report'
  /// ```
  /// * default is english (en)
  String expenseReportSheetExpenseReport() {
    if (languageLocale == 'de') return 'Ausgabenbericht';
    return 'Expense report';
  }

  /// Localizes the label
  /// ```dart
  /// 'owns'
  /// ```
  /// * default is english (en)
  String expenseReportSheetOwns() {
    if (languageLocale == 'de') return 'schuldet';
    return 'owns';
  }

  //-----------------------------------------------
  //---------- Statistic Decision Sheet -----------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Bar chart'
  /// ```
  /// * default is english (en)
  String statisticDecisionSheetBarChart() {
    if (languageLocale == 'de') return 'Balkendiagramm';
    return 'Bar chart';
  }

  /// Localizes the label
  /// ```dart
  /// 'Pie chart'
  /// ```
  /// * default is english (en)
  String statisticDecisionSheetPieChart() {
    if (languageLocale == 'de') return 'Kreisdiagramm';
    return 'Pie chart';
  }

  /// Localizes the label
  /// ```dart
  /// 'Addition'
  /// ```
  /// * default is english (en)
  String statisticCombineActionAddition() {
    if (languageLocale == 'de') return 'Addition';
    return 'Addition';
  }

  /// Localizes the label for Subtraction
  /// ```dart
  /// 'Subtraction'
  /// ```
  /// * default is english (en)
  String statisticCombineActionSubtraction() {
    if (languageLocale == 'de') return 'Subtraktion';
    return 'Subtraction';
  }

  /// Localizes the label for Multiplication
  /// ```dart
  /// 'Multiplication'
  /// ```
  /// * default is english (en)
  String statisticCombineActionMultiplication() {
    if (languageLocale == 'de') return 'Multiplikation';
    return 'Multiplication';
  }

  /// Localizes the label for Division
  /// ```dart
  /// 'Division'
  /// ```
  /// * default is english (en)
  String statisticCombineActionDivision() {
    if (languageLocale == 'de') return 'Division';
    return 'Division';
  }

  //-----------------------------------------------
  //---------- Custom Notifications Tile ----------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Notifications'
  /// ```
  /// * default is english (en)
  String customNotificationsTileTitle() {
    if (languageLocale == 'de') return 'Benachrichtigungen';
    return 'Notifications';
  }

  /// Localizes the label
  /// ```dart
  /// return title ?? 'untitled notification';
  /// ```
  /// * default is english (en)
  String customNotificationsTileNotificationTitle({required String? title}) {
    if (languageLocale == 'de') return title ?? 'kein Titel';
    return title ?? 'untitled notification';
  }

  //-----------------------------------------------
  //---------- Custom Notifications Tile ----------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'title'
  /// ```
  /// * default is english (en)
  String localNotificationsDetailsSheetTitle() {
    if (languageLocale == 'de') return 'Titel';
    return 'Title';
  }

  /// Localizes the label
  /// ```dart
  /// return title ?? 'untitled notification';
  /// ```
  /// * default is english (en)
  String localNotificationsDetailsSheetSubtitle({required String? title}) {
    if (languageLocale == 'de') return title ?? 'kein Titel';
    return title ?? 'untitled notification';
  }

  /// Localizes the label
  /// ```dart
  /// 'Message'
  /// ```
  /// * default is english (en)
  String localNotificationsDetailsSheetMessage() {
    if (languageLocale == 'de') return 'Nachricht';
    return 'Message';
  }

  /// Localizes the label
  /// ```dart
  /// return message ?? 'no message set';
  /// ```
  /// * default is english (en)
  String localNotificationsDetailsSheetMessageSubtitle({required String? message}) {
    if (languageLocale == 'de') return message ?? 'keine Nachricht';
    return message ?? 'no message set';
  }

  /// Localizes the label
  /// ```dart
  /// 'Next notification'
  /// ```
  /// * default is english (en)
  String localNotificationsDetailsSheetNextNotification() {
    if (languageLocale == 'de') return 'Nächste Benachrichtigung';
    return 'Next notification';
  }

  /// Localizes the label
  /// ```dart
  /// 'Notification repeats'
  /// ```
  /// * default is english (en)
  String localNotificationsDetailsSheetNotificationRepeats() {
    if (languageLocale == 'de') return 'Wird wiederholt';
    return 'Notification repeats';
  }

  //-----------------------------------------------
  //---------- Notification Payload ---------------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'This notification has already been shown.'
  /// ```
  /// * default is english (en)
  String notificationPayloadNotificationInPast() {
    if (languageLocale == 'de') return 'Diese Benachrichtigung wurde bereits angezeigt.';
    return 'This notification has already been shown.';
  }

  /// Localizes the label
  /// ```dart
  /// return '$date at $time';
  /// ```
  /// * default is english (en)
  String notificationPayloadNotificationDateTime({required String date, required String time}) {
    if (languageLocale == 'de') return '$date um $time';
    return '$date at $time';
  }

  /// Localizes the label
  /// ```dart
  ///  return 'every year';
  /// ```
  /// * default is english (en)
  String notificationPayloadRepeatLabelEveryYear() {
    if (languageLocale == 'de') return 'jedes Jahr';
    return 'every year';
  }

  /// Localizes the label
  /// ```dart
  /// return 'every month';
  /// ```
  /// * default is english (en)
  String notificationPayloadRepeatLabelEveryMonth() {
    if (languageLocale == 'de') return 'jeden Monat';
    return 'every month';
  }

  /// Localizes the label
  /// ```dart
  /// return 'every week';
  /// ```
  /// * default is english (en)
  String notificationPayloadRepeatLabelEveryWeek() {
    if (languageLocale == 'de') return 'jede Woche';
    return 'every week';
  }

  /// Localizes the label
  /// ```dart
  /// return 'every day';
  /// ```
  /// * default is english (en)
  String notificationPayloadRepeatLabelEveryDay() {
    if (languageLocale == 'de') return 'jeden Tag';
    return 'every day';
  }

  /// Localizes the label
  /// ```dart
  /// return 'never';
  /// ```
  /// * default is english (en)
  String notificationPayloadRepeatLabelNever() {
    if (languageLocale == 'de') return 'nie';
    return 'never';
  }

  //-----------------------------------------------
  //---------- Splash Screen Labels ---------------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'back'
  /// ```
  /// * default is english (en)
  String splashScreenGoBack() {
    if (languageLocale == 'de') return 'zurück';
    return 'back';
  }

  //----------------------------------------------
  //----------------- Location Repository --------
  //----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Your location services are disabled.'
  /// ```
  /// * default is english (en)
  String failureLocationServiceDisabled() {
    if (languageLocale == 'de') return 'Standort ist ausgeschaltet.';
    return 'Your location services are disabled.';
  }

  /// Localizes the label
  /// ```dart
  /// 'This option is currently not supported.'
  /// ```
  /// * default is english (en)
  String failureLocationPermissionGrantedLimited() {
    if (languageLocale == 'de') return 'Diese option ist im Moment nicht verfügbar.';
    return 'This option is currently not supported.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please grant location permission in your settings.'
  /// ```
  /// * default is english (en)
  String failureLocationPermissionDeniedForever() {
    if (languageLocale == 'de') return 'Bitte erlaube den Zugriff auf den Standort in deinen Einstellungen.';
    return 'Please grant location permission in your settings.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please grant location permission to use this function.'
  /// ```
  /// * default is english (en)
  String failureLocationPermissionDenied() {
    if (languageLocale == 'de') return 'Bitte erlaube den Zugriff auf den Standort um diese Funktion nutzen zu können.';
    return 'Please grant location permission to use this function.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Unkown location permission error, please try again.'
  /// ```
  /// * default is english (en)
  String failureLocationPermissionError() {
    if (languageLocale == 'de') return 'Unbekannter Standort Berechtigungs Status, bitte versuche es noch einmal.';
    return 'Unkown location permission error, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Could not access current location, please try again.'
  /// ```
  /// * default is english (en)
  String failureLocationCoordinatesAreNull() {
    if (languageLocale == 'de') return 'Fehler beim Standortzugriff, bitte versuche es noch einmal.';
    return 'Could not access current location, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Provided latitude is invalid.'
  /// ```
  /// * default is english (en)
  String failureLocationInvalidLatitude() {
    if (languageLocale == 'de') return 'Angegebener Breitengrad is ungültig.';
    return 'Provided latitude is invalid.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Provided longitude is invalid.'
  /// ```
  /// * default is english (en)
  String failureLocationInvalidLongitude() {
    if (languageLocale == 'de') return 'Angegebener Längengrad is ungültig.';
    return 'Provided longitude is invalid.';
  }

  /// Localizes the label
  /// ```dart
  /// 'The location you have provided is invalid.'
  /// ```
  /// * default is english (en)
  String failureInvalidLocationInput() {
    if (languageLocale == 'de') return 'Angegebener Standort ist ungültig.';
    return 'The location you have provided is invalid.';
  }

  //----------------------------------------------
  //------------ Add Images Sheet Labels ---------
  //----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// return isEdit ? 'Are you sure you do not want to save made edits?' : 'Are you sure you do not want to use selection?';
  /// ```
  /// * default is english (en)
  String addImagesSheetConfirmCloseSheet({required bool isEdit}) {
    if (languageLocale == 'de') return isEdit ? 'Gemachte Änderungen sicher nicht speichern?' : 'Ausgewählte Dateien sicher nicht verwenden?';
    return isEdit ? 'Are you sure you do not want to save made edits?' : 'Are you sure you do not want to use selection?';
  }

  /// Localizes the label
  /// ```dart
  /// 'done'
  /// ```
  /// * default is english (en)
  String addImagesFloatingActionBarLabel() {
    if (languageLocale == 'de') return 'fertig';
    return 'done';
  }

  /// Localizes the label
  /// ```dart
  /// return isAvatar ? 'No image selected yet.' : 'No images selected yet.';
  /// ```
  /// * default is english (en)
  String addImagesSheetNoImagesSelected({required bool isAvatar}) {
    if (languageLocale == 'de') return isAvatar ? 'Noch kein Bild ausgewählt.' : 'Noch keine Bilder ausgewählt.';
    return isAvatar ? 'No image selected yet.' : 'No images selected yet.';
  }

  /// Localizes the label
  /// ```dart
  /// return isAvatarImage ? 'Select image' : isImages ? 'Select images' : 'Select files';
  /// ```
  /// * default is english (en)
  String addFilesSheetTitle({required bool isAvatarImage, required bool isImages, required bool isFiles}) {
    if (languageLocale == 'de') {
      if (isAvatarImage) return 'Bild auswählen';
      if (isImages) return 'Bilder auswählen';
      return 'Dateien auswählen';
    }

    // Return english as default.
    if (isAvatarImage) return 'Select image';
    if (isImages) return 'Select images';
    return 'Select files';
  }

  //----------------------------------------------
  //------------ Add Image Details Sheet Labels --
  //----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// isImage ? 'Image title' : 'File title';
  /// ```
  /// * default is english (en)
  String addImageDetailsImageTitle({required bool isImage}) {
    if (languageLocale == 'de') return isImage ? 'Bildtitel' : 'Dateititel';
    return isImage ? 'Image title' : 'File title';
  }

  /// Localizes the label
  /// ```dart
  /// 'encrypt image'
  /// ```
  /// * default is english (en)
  String addImageDetailsEncryptImage() {
    if (languageLocale == 'de') return 'Bild verschlüsseln';
    return 'encrypt image';
  }

  /// Localizes the label
  /// ```dart
  /// return wantEncryption ? 'Image data will be encrypted.\n\nThis option slows down image saving and loading process.\n\nImages are stored securely in your file system.' : 'Image data will not be encrypted.\n\nThis option saves and loads images more quickly.\n\nAnyone with access to your file system can view your images.';
  /// ```
  /// * default is english (en)
  String addImageDetailsEncryptImageInfoMessage({required bool wantEncryption}) {
    if (languageLocale == 'de') return wantEncryption ? 'Bilddaten werden verschlüsselt.\n\nDiese Option verringert die Geschwindigkeit mit der Bilder gespeichert und geladet werden können.\n\nBilder werden dafür sicher im Dateiensystem gespeichert.' : 'Bilddaten werden nicht verschlüsselt.\n\nDiese Option speichert und lädt Bilder schneller.\n\nJedoch kann jeder mit Zugang zum Dateiensystem deine Bilder sehen.';
    return wantEncryption ? 'Image data will be encrypted.\n\nThis option slows down image saving and loading process.\n\nImages are stored securely in your file system.' : 'Image data will not be encrypted.\n\nThis option saves and loads images more quickly.\n\nAnyone with access to your file system can view your images.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Caption'
  /// ```
  /// * default is english (en)
  String caption({required bool isImage}) {
    if (languageLocale == 'de') return isImage ? 'Bildtext' : 'Dateitext';
    return isImage ? 'Caption' : 'Caption';
  }

  /// Localizes the label
  /// ```dart
  /// 'done'
  /// ```
  /// * default is english (en)
  String addImageDetailsSaveDetails() {
    if (languageLocale == 'de') return 'fertig';
    return 'done';
  }

  //----------------------------------------------
  //------------ Initial Screen Labels -----------
  //----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'try again'
  /// ```
  /// * default is english (en)
  String initialScreenTryAgain() {
    if (languageLocale == 'de') return 'Noch einmal versuchen';
    return 'Try again';
  }

  /// Localizes the label
  /// ```dart
  /// 'create access password'
  /// ```
  /// * default is english (en)
  String initialScreenAnonTitle() {
    if (languageLocale == 'de') return 'Zugangspasswort erstellen';
    return 'create access password';
  }

  /// Localizes the label
  /// ```dart
  /// 'Choose this password?'
  /// ```
  /// * default is english (en)
  String initialScreenAnonConfirmMessage() {
    if (languageLocale == 'de') return 'Dieses Passwort verwenden?';
    return 'Choose this password?';
  }

  /// Localizes the label
  /// ```dart
  /// 'We cannot help you, if you forget your access password.\nAll your data will be lost.'
  /// ```
  /// * default is english (en)
  String initialScreenAnonInfoMessage() {
    if (languageLocale == 'de') return 'Wir können nicht helfen wenn dieses Passwort vergessen wird.\n\nDieses Passwort zu vergessen bedeutet den Verlust aller Daten.';
    return 'We cannot help you, if you forget your access password.\n\nAll your data will be lost.';
  }

  /// Localizes the label
  /// ```dart
  /// 'ready'
  /// ```
  /// * default is english (en)
  String initialScreenAnonButtonLabel() {
    if (languageLocale == 'de') return 'fertig';
    return 'ready';
  }

  /// Localizes the label
  /// ```dart
  /// 'access password'
  /// ```
  /// * default is english (en)
  String initialScreenUserTitle() {
    if (languageLocale == 'de') return 'Zugangspasswort';
    return 'access password';
  }

  //----------------------------------------------
  //------------ Main Screen Labels --------------
  //----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'entries: $numberOfEntries'
  /// ```
  /// * default is english (en)
  String mainScreenGridViewSubtitle({required int numberOfEntries}) {
    if (languageLocale == 'de') return 'Einträge: $numberOfEntries';
    return 'entries: $numberOfEntries';
  }

  /// Localizes the label
  /// ```dart
  /// 'create group'
  /// ```
  /// * default is english (en)
  String mainScreenGridViewAction() {
    if (languageLocale == 'de') return 'Gruppe erstellen';
    return 'create group';
  }

  /// Localizes the label
  /// ```dart
  /// 'add';
  /// ```
  /// * default is english (en)
  String mainScreenFloatingActionBarLabel() {
    if (languageLocale == 'de') return 'erstellen';
    return 'add';
  }

  /// Localizes the label
  /// ```dart
  /// return  localGroups ? 'Local groups' : 'Shared groups';
  /// ```
  /// * default is english (en)
  String mainScreenGroupsDropDownButtonLabel({required bool isShared}) {
    if (languageLocale == 'de') return isShared ? 'Geteilte Gruppen' : 'Lokale Gruppen';
    return isShared ? 'Shared groups' : 'Local groups';
  }

  /// Localizes the label
  /// ```dart
  /// 'no groups created yet';
  /// ```
  /// * default is english (en)
  String mainScreenEmptyGridViewMessage() {
    if (languageLocale == 'de') return 'Noch keine Gruppen erstellt';
    return 'no groups created yet';
  }

  /// Localizes the label
  /// ```dart
  /// 'Recent entries';
  /// ```
  /// * default is english (en)
  String mainScreenRecentItems() {
    if (languageLocale == 'de') return 'Kürzliche Einträge';
    return 'Recent entries';
  }

  //----------------------------------------------
  //------------ Main Screen Cubit Labels --------
  //----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// '$label copied'
  /// ```
  /// * default is english (en)
  String mainScreenCubitCopyToClipboardNotification({required String label}) {
    if (languageLocale == 'de') return '$label kopiert';
    return '$label copied';
  }

  /// Localizes the label
  /// ```dart
  /// 'ungrouped items';
  /// ```
  /// * default is english (en)
  String mainScreenCubitUngroupedItems() {
    if (languageLocale == 'de') return 'Nicht gruppierte Einträge';
    return 'ungrouped items';
  }

  //-----------------------------------------------
  //----------Card display expense ----------------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'loading exchange rate from $fromCurrencyCode to $toCurrencyCode'
  /// ```
  /// * default is english (en)
  String loadingMessageExchangeRate({required String fromCurrencyCode, required String toCurrencyCode}) {
    if (languageLocale == 'de') return 'Lade Wechselkurs von $fromCurrencyCode zu $toCurrencyCode.';
    return 'Loading exchange rate from $fromCurrencyCode to $toCurrencyCode.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to access exchange rate from $fromCurrencyCode to $toCurrencyCode.'
  /// ```
  /// * default is english (en)
  String failedToAccessExchangeRate({required String fromCurrencyCode, required String toCurrencyCode}) {
    if (languageLocale == 'de') return 'Laden des Wechselkurses von $fromCurrencyCode zu $toCurrencyCode fehlgeschlagen.';
    return 'Failed to access exchange rate from $fromCurrencyCode to $toCurrencyCode.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to access members, please try again.'
  /// ```
  /// * default is english (en)
  String failedToAccessMembers() {
    if (languageLocale == 'de') return 'Fehler beim abrufen der Mitglieder, bitte versuche es noch einmal.';
    return 'Failed to access members, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to access tags, please try again.'
  /// ```
  /// * default is english (en)
  String failedToAccessTags() {
    if (languageLocale == 'de') return 'Fehler beim abrufen der Tags, bitte versuche es noch einmal.';
    return 'Failed to access tags, please try again.';
  }

  //-----------------------------------------------
  //----------Create Model Sheet Labels -----------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// return 'Create ${isShared ? 'shared' : 'local'} ModelEntry';
  /// ```
  /// * default is english (en)
  String createModelSheetTitle({required bool isShared, required bool isEdit}) {
    if (languageLocale == 'de') return '${isShared ? 'Geteilte' : 'Lokale'} Eintragsvorlage ${isEdit ? 'bearbeiten' : 'erstellen'}';
    return '${isEdit ? 'Edit' : 'Create'} ${isShared ? 'shared' : 'local'} ModelEntry';
  }

  /// Localizes the label
  /// ```dart
  /// 'Name'
  /// ```
  /// * default is english (en)
  String createModelSheetName() {
    if (languageLocale == 'de') return 'Name der Eintragsvorlage';
    return 'Model Name';
  }

  /// Localizes the label
  /// ```dart
  /// 'This field is required.'
  /// ```
  /// * default is english (en)
  String createModelSheetFieldRequired() {
    if (languageLocale == 'de') return 'Dieses Feld ist erforderlich.';
    return 'This field is required.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Entry name'
  /// ```
  /// * default is english (en)
  String createModelSheetEntryName() {
    if (languageLocale == 'de') return 'Name des Eintrags';
    return 'Entry name';
  }

  /// Localizes the label
  /// ```dart
  /// 'Created at'
  /// ```
  /// * default is english (en)
  String createModelSheetCreatedAt() {
    if (languageLocale == 'de') return 'Erstellt am';
    return 'Created at';
  }

  /// Localizes the label
  /// ```dart
  /// 'A text field which lets you indicate the name of your entry is automatically included in every entry model'
  /// ```
  /// * default is english (en)
  String createModelSheetEntryNameInfoMessage() {
    if (languageLocale == 'de') return 'Ein Eingabefeld für den Eintragsnamen ist automatisch in jeder Eintragsvorlage vorhanden.';
    return 'A text field which lets you indicate the name of your entry is automatically included in every entry model.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please select a data point that should be matched as the entry name.'
  /// ```
  /// * default is english (en)
  String createModelSheetImportEntryNameInfo() {
    if (languageLocale == 'de') return 'Bitte wähle aus welcher Datenpunkt als Eintragsname verwendet werden soll.';
    return 'Please select a data point that should be matched as the entry name.';
  }

  /// Localizes the label
  /// ```dart
  /// return entryNameInstruction.isEmpty ? 'Choose' : entryNameInstruction;
  /// ```
  /// * default is english (en)
  String importEntryNameDropDownButton({required String entryNameInstruction}) {
    if (languageLocale == 'de') return entryNameInstruction.isEmpty ? 'Auswählen' : entryNameInstruction;
    return entryNameInstruction.isEmpty ? 'Choose' : entryNameInstruction;
  }

  /// Localizes the label
  /// ```dart
  /// return createdAtInstruction.isEmpty ? 'Choose' : createdAtInstruction;
  /// ```
  /// * default is english (en)
  String importCreatedAtDropDownButton({required String createdAtInstruction}) {
    if (languageLocale == 'de') return createdAtInstruction.isEmpty ? 'Auswählen' : createdAtInstruction;
    return createdAtInstruction.isEmpty ? 'Choose' : createdAtInstruction;
  }

  /// Localizes the label
  /// ```dart
  /// 'A created at field is automatically included in every model entry.\n\nYou can choose if this is editable or not.\n\nEntries can be created for the past and the future if it is editbale.'
  /// ```
  /// * default is english (en)
  String createModelSheetCreatedAtInfoMessage({required bool isImportMatch}) {
    if (languageLocale == 'de') return isImportMatch ? 'Falls dieses Feld editierbar ist kann der Zeitpunkt der Eintragserstellung auch nach der Erstellung verändert werden. Einträge können also für die Vergangenheit oder die Zukunft erstellt werden.' : 'Ein Feld für den Zeitpunkt der Eintragerstellung ist automatisch in jeder Eintragsvorlage vorhanden.\n\nFalls dieses Feld editierbar ist kann der Zeitpunkt der Eintragserstellung auch nach der Erstellung verändert werden. Einträge können also für die Vergangenheit oder die Zukunft erstellt werden.';
    return isImportMatch ? 'If this field is editable the created at point of time can also be changed after the entry creation. This means that entries can be created for the past and the future.' : 'A created at field is automatically included in every model entry.\n\nIf this field is editable the created at point of time can also be changed after the entry creation. This means that entries can be created for the past and the future.';
  }

  /// Localizes the label
  /// ```dart
  /// 'No fields added yet.\n\nAdd fields by tapping the  +  icon in the bottom right.'
  /// ```
  /// * default is english (en)
  String createModelSheetEmptyLabelsInfoMessage() {
    if (languageLocale == 'de') return 'Noch keine Felder hinzugefügt.\n\nTippe auf das  +  Symbol um Felder hinzuzufügen.';
    return 'No fields added yet.\n\nAdd fields by tapping the  +  icon in the bottom right.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Error, widget is null...'
  /// ```
  /// * default is english (en)
  String createModelSheetNullWidget() {
    if (languageLocale == 'de') return 'Fehler, Widget ist null...';
    return 'Error, widget is null...';
  }

  /// Localizes the label
  /// ```dart
  /// isEditSelection ? 'edit selection' : 'create selection'
  /// ```
  /// * default is english (en)
  String createModelSheetSelectionButtonLabel({required bool isEditSelection}) {
    if (languageLocale == 'de') return isEditSelection ? 'Auswahl bearbeiten' : 'Auswahl erstellen';
    return isEditSelection ? 'edit selection' : 'create selection';
  }

  /// Localizes the label
  /// ```dart
  /// isEditEntryModel ? '$entryModelName' : 'select entry model'
  /// ```
  /// * default is english (en)
  String createModelSheetEntryModelButtonLabel({required bool isEditEntryModel, required String? entryModelName}) {
    if (languageLocale == 'de') return isEditEntryModel ? '$entryModelName' : 'Eintragsvorlage auswählen';
    return isEditEntryModel ? '$entryModelName' : 'select entry model';
  }

  /// Localizes the label
  /// ```dart
  /// '$fieldType name'
  /// ```
  /// * default is english (en)
  String createModelSheetFieldName({required String fieldType}) {
    if (languageLocale == 'de') return '$fieldType Feld';
    return '$fieldType field';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please note, that a chosen entry model cannot be changed to a different one later.'
  /// ```
  /// * default is english (en)
  String createModelSheetReferenceInfoMessage() {
    if (languageLocale == 'de') return 'Bitte beachte, dass die ausgewählte Eintragsvorlage später nicht mehr geändert werden kann.';
    return 'Please note, that a chosen entry model cannot be changed to a different one later.';
  }

  /// Localizes the label
  /// ```dart
  /// 'remove field'
  /// ```
  /// * default is english (en)
  String createModelSheetRemoveField() {
    if (languageLocale == 'de') return 'Feld entfernen';
    return 'remove field';
  }

  /// Localizes the label
  /// ```dart
  /// 'required'
  /// ```
  /// * default is english (en)
  String createModelSheetRequired() {
    if (languageLocale == 'de') return 'erforderlich';
    return 'required';
  }

  /// Localizes the label
  /// ```dart
  /// isEdit ? 'save changes' : 'create model'
  /// ```
  /// * default is english (en)
  String createModelSheetActionbarLabel({required bool isEdit}) {
    if (languageLocale == 'de') return isEdit ? 'speichern' : 'erstellen';
    return isEdit ? 'save changes' : 'create model';
  }

  //-----------------------------------------------
  //----------Create Model Sheet Cubit Labels -----
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Are you sure that you do not want to save made edits?'
  /// ```
  /// * default is english (en)
  String createModelSheetCubitEditConfirmClose() {
    if (languageLocale == 'de') return 'Bist du sicher das du die gemachten Änderungen nicht speichern willst?';
    return 'Are you sure that you do not want to save made edits?';
  }

  /// Localizes the label
  /// ```dart
  /// 'Are you sure that you want to discard this entry model?'
  /// ```
  /// * default is english (en)
  String createModelSheetCubitCreateConfirmClose() {
    if (languageLocale == 'de') return 'Bist du sicher das du diese Eintragsvorlage nicht speichern willst?';
    return 'Are you sure that you want to discard this entry model?';
  }

  //-----------------------------------------------
  //---------------- Reorder Sheet ----------------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Ready'
  /// ```
  /// * default is english (en)
  String reorderSheetReady() {
    if (languageLocale == 'de') return 'Fertig';
    return 'Ready';
  }

  //------------------------------------------------------
  //---------------- Chart Instruction Combinator Sheet --
  //------------------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Create bars'
  /// ```
  /// * default is english (en)
  String chartInstructionCombinatorSheetTitle() {
    if (languageLocale == 'de') return 'Säulen erstellen';
    return 'Create bars';
  }

  /// Localizes the label
  /// ```dart
  /// 'Change action interpretation'
  /// ```
  /// * default is english (en)
  String chartInstructionCombinatorSheetChangeActionInterpretation() {
    if (languageLocale == 'de') return 'Interpretation ändern';
    return 'Change action interpretation';
  }

  /// Localizes the label
  /// ```dart
  /// 'In percent'
  /// ```
  /// * default is english (en)
  String chartInstructionCombinatorSheetInPercent() {
    if (languageLocale == 'de') return 'In Prozent';
    return 'In percent';
  }

  /// Localizes the label
  /// ```dart
  /// 'Ready'
  /// ```
  /// * default is english (en)
  String chartInstructionCombinatorSheetReady() {
    if (languageLocale == 'de') return 'Fertig';
    return 'Ready';
  }

  //------------------------------------------------------
  //---------------- Chart Instruction Combinator Cubit --
  //------------------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Select base instruction'
  /// ```
  /// * default is english (en)
  String chartInstructionCombinatorCubitSelectBaseInstruction() {
    if (languageLocale == 'de') return 'Basisinstruktion auswählen';
    return 'Select base instruction';
  }

  /// Localizes the label
  /// ```dart
  /// 'Select combine instruction'
  /// ```
  /// * default is english (en)
  String chartInstructionCombinatorCubitSelectCombineInstruction() {
    if (languageLocale == 'de') return 'Kombinieren mit';
    return 'Select combine instruction';
  }

  /// Localizes the label
  /// ```dart
  /// 'Select action'
  /// ```
  /// * default is english (en)
  String chartInstructionCombinatorCubitSelectAction() {
    if (languageLocale == 'de') return 'Aktion auswählen';
    return 'Select action';
  }

  //-----------------------------------------------
  //---------------- Bar Items Instructions -------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Custom bar'
  /// ```
  /// * default is english (en)
  String barItemsInstructionsCustomBar() {
    if (languageLocale == 'de') return 'Individuelle Säule';
    return 'Custom bar';
  }

  //-----------------------------------------------
  //---------------- Create Bar Chart Sheet State -
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'preparing data...'
  /// ```
  /// * default is english (en)
  String createBarChartSheetStateLoadingMessage() {
    if (languageLocale == 'de') return 'Daten vorbereiten...';
    return 'preparing data...';
  }

  //-----------------------------------------------
  //---------------- Create Bar Chart Sheet -------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Create bar chart'
  /// ```
  /// * default is english (en)
  String createBarChartSheetTitle() {
    if (languageLocale == 'de') return 'Balkendiagramm erstellen';
    return 'Create bar chart';
  }

  /// Localizes the label
  /// ```dart
  /// 'No bar data available.'
  /// ```
  /// * default is english (en)
  String createBarChartSheetNoBarDataAvailable() {
    if (languageLocale == 'de') return 'Keine Balkendaten vorhanden.';
    return 'No bar data available.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Base data'
  /// ```
  /// * default is english (en)
  String createBarChartSheetBaseData() {
    if (languageLocale == 'de') return 'Stammdaten';
    return 'Base data';
  }

  /// Localizes the label
  /// ```dart
  /// if (isEntriesBaseData) return 'Entries';
  /// if (isFieldsBaseData) return 'Fields';
  /// return 'Select base data';
  /// ```
  /// * default is english (en)
  String createBarChartSheetSelectBaseData({required bool isEntriesBaseData, required bool isFieldsBaseData}) {
    if (languageLocale == 'de') {
      if (isEntriesBaseData) return 'Einträge';
      if (isFieldsBaseData) return 'Felder';
      return 'Stammdaten auswählen';
    }

    if (isEntriesBaseData) return 'Entries';
    if (isFieldsBaseData) return 'Fields';
    return 'Select base data';
  }

  /// Localizes the label
  /// ```dart
  /// 'Combine with (optional)'
  /// ```
  /// * default is english (en)
  String createBarChartSheetCombineWith() {
    if (languageLocale == 'de') return 'Kombinieren mit (optional)';
    return 'Combine with (optional)';
  }

  /// Localizes the label
  /// ```dart
  /// if (combineWithEntries) return 'Entries';
  /// if (combineWithFields) return 'Fields';
  /// return 'Select data';
  /// ```
  /// * default is english (en)
  String createBarChartSheetSelectCombineWithData({required bool combineWithFields, required bool combineWithMember}) {
    if (languageLocale == 'de') {
      if (combineWithFields) return 'Felder';
      if (combineWithMember) return 'Mitglied';
      return 'Daten auswählen';
    }

    if (combineWithFields) return 'Fields';
    if (combineWithMember) return 'Member';
    return 'Select data';
  }

  /// Localizes the label
  /// ```dart
  /// 'Select base field'
  /// ```
  /// * default is english (en)
  String createBarChartSheetSelectBaseField() {
    if (languageLocale == 'de') return 'Datenfeld auswählen';
    return 'Select base field';
  }

  /// Localizes the label
  /// ```dart
  /// 'Select field'
  /// ```
  /// * default is english (en)
  String createBarChartSheetSelectCombineField() {
    if (languageLocale == 'de') return 'Datenfeld auswählen';
    return 'Select field';
  }

  /// Localizes the label
  /// ```dart
  /// 'Chart title'
  /// ```
  /// * default is english (en)
  String createBarChartSheetChartTitle() {
    if (languageLocale == 'de') return 'Diagramm Titel';
    return 'Chart title';
  }

  /// Localizes the label
  /// ```dart
  /// 'Axis names'
  /// ```
  /// * default is english (en)
  String createBarChartSheetAxisNames() {
    if (languageLocale == 'de') return 'Achsnamen';
    return 'Axis names';
  }

  /// Localizes the label
  /// ```dart
  /// 'Chart settings'
  /// ```
  /// * default is english (en)
  String createBarChartSheetChartSettings() {
    if (languageLocale == 'de') return 'Diagramm Einstellungen';
    return 'Chart settings';
  }

  /// Localizes the label
  /// ```dart
  /// 'Add bars'
  /// ```
  /// * default is english (en)
  String createBarChartSheetAddBars() {
    if (languageLocale == 'de') return 'Balken hinzufügen';
    return 'Add bars';
  }

  /// Localizes the label
  /// ```dart
  /// 'Change a bar'
  /// ```
  /// * default is english (en)
  String createBarChartSheetChangeBar() {
    if (languageLocale == 'de') return 'Balken ändern';
    return 'Change a bar';
  }

  /// Localizes the label
  /// ```dart
  /// 'Delete bars'
  /// ```
  /// * default is english (en)
  String createBarChartSheetDeleteBars() {
    if (languageLocale == 'de') return 'Balken löschen';
    return 'Delete bars';
  }

  /// Localizes the label
  /// ```dart
  /// 'Reorder bars'
  /// ```
  /// * default is english (en)
  String createBarChartSheetReorderBars() {
    if (languageLocale == 'de') return 'Balken verschieben';
    return 'Reorder bars';
  }

  /// Localizes the label
  /// ```dart
  /// 'Select member'
  /// ```
  /// * default is english (en)
  String createBarChartSheetSelectMember() {
    if (languageLocale == 'de') return 'Mitglied auswählen';
    return 'Select member';
  }

  /// Localizes the label
  /// ```dart
  /// 'Ready'
  /// ```
  /// * default is english (en)
  String createBarChartSheetReady() {
    if (languageLocale == 'de') return 'Fertig';
    return 'Ready';
  }

  //-----------------------------------------------
  //---------------- Group Selected Sheet ---------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Invitelink copied'
  /// ```
  /// * default is english (en)
  String groupSelectedSheetInviteCopiedNotification() {
    if (languageLocale == 'de') return 'Einladungslink kopiert';
    return 'Invitelink copied';
  }

  //-----------------------------------------------
  //---------------- Group ------------------------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Group owner'
  /// ```
  /// * default is english (en)
  String basicLabelsRootGroupOwner() {
    if (languageLocale == 'de') return 'Gruppenbesitzer';
    return 'Group owner';
  }

  /// Localizes the label
  /// ```dart
  /// 'Only you'
  /// ```
  /// * default is english (en)
  String basicLabelsGroupCreator() {
    if (languageLocale == 'de') return 'Nur du';
    return 'Only you';
  }

  /// Localizes the label
  /// ```dart
  /// 'Entry creator'
  /// ```
  /// * default is english (en)
  String basicLabelsEntryCreator() {
    if (languageLocale == 'de') return 'Eintragsersteller';
    return 'Entry creator';
  }

  /// Localizes the label
  /// ```dart
  /// 'Everyone'
  /// ```
  /// * default is english (en)
  String basicLabelsEveryone() {
    if (languageLocale == 'de') return 'Jeder';
    return 'Everyone';
  }

  /// Localizes the label
  /// ```dart
  /// 'None'
  /// ```
  /// * default is english (en)
  String basicLabelsNone() {
    if (languageLocale == 'de') return 'Keiner';
    return 'None';
  }

  /// Localizes the label
  /// ```dart
  /// 'Only group creator'
  /// ```
  /// * default is english (en)
  String groupAddEditOnlyByGroupOwner() {
    if (languageLocale == 'de') return 'Grupppenersteller';
    return 'Group creator';
  }

  /// Localizes the label
  /// ```dart
  /// 'Add by everyone / Edit by group creator'
  /// ```
  /// * default is english (en)
  String groupAddByEveryoneEditByGroupOwner() {
    if (languageLocale == 'de') return 'Alle können erstellen\n\nGrupppenersteller kann bearbeiten';
    return 'Add by everyone\n\nEdit by group creator';
  }

  /// Localizes the label
  /// ```dart
  /// 'Add by everyone / Edit by self'
  /// ```
  /// * default is english (en)
  String groupAddByEveryoneEditBySelf() {
    if (languageLocale == 'de') return 'Alle können erstellen\n\nErsteller können bearbeiten';
    return 'Add by everyone\n\nEdit by self';
  }

  /// Localizes the label
  /// ```dart
  /// 'Add and edit by everyone'
  /// ```
  /// * default is english (en)
  String groupAddEditByEveryone() {
    if (languageLocale == 'de') return 'Alle können erstellen und bearbeiten';
    return 'Add and edit by everyone';
  }

  /// Localizes the label
  /// ```dart
  /// 'Local Group'
  /// ```
  /// * default is english (en)
  String groupTypeLocalGroup() {
    if (languageLocale == 'de') return 'Lokale Gruppe';
    return 'Local group';
  }

  /// Localizes the label
  /// ```dart
  /// 'Shared subgroup'
  /// ```
  /// * default is english (en)
  String groupTypeSharedSubgroup() {
    if (languageLocale == 'de') return 'Geteilte Untergruppe';
    return 'Shared subgroup';
  }

  /// Localizes the label
  /// ```dart
  /// 'Local subgroup'
  /// ```
  /// * default is english (en)
  String groupTypeLocalSubgroup() {
    if (languageLocale == 'de') return 'Lokale Untergruppe';
    return 'Local subgroup';
  }

  /// Localizes the label
  /// ```dart
  /// 'Local groups only exists on your device.\n\nThis mode is ideal for private data like passwords or other sensitive information.'
  /// ```
  /// * default is english (en)
  String groupTypeLocalGroupInfoMessage() {
    if (languageLocale == 'de') return 'Lokale Gruppen existieren nur auf diesem Gerät und können verschlüsselt werden.\n\nDieser Modus ist ideal um private Daten wie Passwörter oder andere sensitive Informationen aufzubewahren.';
    return 'Local groups only exists on your device and can be encrypted.\n\nThis mode is ideal for private data like passwords or other sensitive information.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Shared Group'
  /// ```
  /// * default is english (en)
  String groupTypeSharedGroup() {
    if (languageLocale == 'de') return 'Geteilte Gruppe';
    return 'Shared group';
  }

  /// Localizes the label
  /// ```dart
  /// 'Shared groups will be saved on our servers.\n\nChoose this mode if you want others to participate in this group.'
  /// ```
  /// * default is english (en)
  String groupTypeSharedGroupInfoMessage() {
    if (languageLocale == 'de') return 'Geteilte Gruppen werden sicher auf unseren Servern gespeichert.\n\nWähle diesen Modus falls du möchtest das andere an dieser Gruppe teilnehmen können.';
    return 'Shared groups will be saved securely on our servers.\n\nChoose this mode if you want others to participate in this group.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Only the root group creator can delete entries, regardless of who created the entry.'
  /// ```
  /// * default is english (en)
  String rootGroupCreatorDeletePolicyInfoMessage() {
    if (languageLocale == 'de') return 'Nur der Stammgruppenersteller kann Einträge löschen, egal wer den Eintrag erstellt hat.';
    return 'Only the root group creator can delete entries, regardless of who created the entry.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Only you can delete entries, regardless of who created the entry.'
  /// ```
  /// * default is english (en)
  String groupCreaterDeletePolicyInfoMessage() {
    if (languageLocale == 'de') return 'Nur der Gruppenersteller kann Einträge löschen, egal wer den Eintrag erstellt hat.';
    return 'Only you can delete entries, regardless of who created the entry.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Entries can only be deleted by their creator.'
  /// ```
  /// * default is english (en)
  String entryCreatorDeletePolicyInfoMessage() {
    if (languageLocale == 'de') return 'Nur die Person welche den Eintrag erstellt kann diesen auch löschen.';
    return 'Entries can only be deleted by their creator.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Everyone can delete entries, regardless of who created the entry.'
  /// ```
  /// * default is english (en)
  String groupEveryoneDeletePolicyInfoMessage() {
    if (languageLocale == 'de') return 'Jeder kann Einträge löschen, egal wer den Eintrag erstellt hat.';
    return 'Everyone can delete entries, regardless of who created the entry.';
  }

  /// Localizes the label
  /// ```dart
  /// 'No one can delete entries.'
  /// ```
  /// * default is english (en)
  String groupNoneDeletePolicyInfoMessage() {
    if (languageLocale == 'de') return 'Keiner kann Einträge löschen.';
    return 'No one can delete entries.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Only selected users can delete entries, regardless of who created the entry.'
  /// ```
  /// * default is english (en)
  String groupPermittedUserDeletePolicyInfoMessage() {
    if (languageLocale == 'de') return 'Nur der ausgewählte Personen können Einträge löschen, egal wer den Eintrag erstellt hat.';
    return 'Only selected users can delete entries, regardless of who created the entry.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Only the root group creator can add subgroups.'
  /// ```
  /// * default is english (en)
  String rootGroupCreatorAddSubgroupPolicyInfoMessage() {
    if (languageLocale == 'de') return 'Nur der Stammgruppenersteller kann Untergruppen erstellen.';
    return 'Only the root group creator can add subgroups.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Only you can can add subgroups.'
  /// ```
  /// * default is english (en)
  String groupCreaterAddSubgroupPolicyInfoMessage() {
    if (languageLocale == 'de') return 'Nur du kannst Untergruppen erstellen.';
    return 'Only you can can add subgroups.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Everyone can add subgroups.'
  /// ```
  /// * default is english (en)
  String groupEveryoneAddSubgroupPolicyInfoMessage() {
    if (languageLocale == 'de') return 'Jeder kann Untergruppen erstellen.';
    return 'Everyone can add subgroups.';
  }

  /// Localizes the label
  /// ```dart
  /// 'No one can add subgroups.'
  /// ```
  /// * default is english (en)
  String groupNoneAddSubgroupPolicyInfoMessage() {
    if (languageLocale == 'de') return 'Keiner kann Untergruppen erstellen.';
    return 'No one can add subgroups.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Only selected users can add subgroups.'
  /// ```
  /// * default is english (en)
  String groupPermittedUserAddSubgroupPolicyInfoMessage() {
    if (languageLocale == 'de') return 'Nur der ausgewählte Personen können Untergruppen erstellen.';
    return 'Only selected users can add subgroups.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Only the root group creator can edit subgroups.'
  /// ```
  /// * default is english (en)
  String rootGroupCreatorEditSubgroupPolicyInfoMessage() {
    if (languageLocale == 'de') return 'Nur der Stammgruppenersteller kann Untergruppen bearbeiten.';
    return 'Only the root group creator can edit subgroups.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Only you can edit subgroups.'
  /// ```
  /// * default is english (en)
  String groupCreaterEditSubgroupPolicyInfoMessage() {
    if (languageLocale == 'de') return 'Nur du kannst Untergruppen bearbeiten.';
    return 'Only you can edit subgroups.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Everyone can edit subgroups.'
  /// ```
  /// * default is english (en)
  String groupEveryoneEditSubgroupPolicyInfoMessage() {
    if (languageLocale == 'de') return 'Jeder kann Untergruppen bearbeiten.';
    return 'Everyone can edit subgroups.';
  }

  /// Localizes the label
  /// ```dart
  /// 'No one can edit subgroups.'
  /// ```
  /// * default is english (en)
  String groupNoneEditSubgroupPolicyInfoMessage() {
    if (languageLocale == 'de') return 'Keiner kann Untergruppen bearbeiten.';
    return 'No one can edit subgroups.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Only selected users can edit subgroups.'
  /// ```
  /// * default is english (en)
  String groupPermittedUserEditSubgroupPolicyInfoMessage() {
    if (languageLocale == 'de') return 'Nur der ausgewählte Personen können Untergruppen bearbeiten.';
    return 'Only selected users can edit subgroups.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Only the root group creator can delete subgroups.'
  /// ```
  /// * default is english (en)
  String rootGroupCreatorDeleteSubgroupPolicyInfoMessage() {
    if (languageLocale == 'de') return 'Nur der Stammgruppenersteller kann Untergruppen löschen.';
    return 'Only the root group creator can delete subgroups.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Only you can delete subgroups.'
  /// ```
  /// * default is english (en)
  String groupCreaterDeleteSubgroupPolicyInfoMessage() {
    if (languageLocale == 'de') return 'Nur du kannst Untergruppen löschen.';
    return 'Only you can delete subgroups.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Everyone can delete subgroups.'
  /// ```
  /// * default is english (en)
  String groupEveryoneDeleteSubgroupPolicyInfoMessage() {
    if (languageLocale == 'de') return 'Jeder kann Untergruppen löschen.';
    return 'Everyone can delete subgroups.';
  }

  /// Localizes the label
  /// ```dart
  /// 'No one can delete subgroups.'
  /// ```
  /// * default is english (en)
  String groupNoneDeleteSubgroupPolicyInfoMessage() {
    if (languageLocale == 'de') return 'Keiner kann Untergruppen löschen.';
    return 'No one can delete subgroups.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Only selected users can delete subgroups.'
  /// ```
  /// * default is english (en)
  String groupPermittedUserDeleteSubgroupPolicyInfoMessage() {
    if (languageLocale == 'de') return 'Nur der ausgewählte Personen können Untergruppen löschen.';
    return 'Only selected users can delete subgroups.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Only the root group creator can add entries.'
  /// ```
  /// * default is english (en)
  String rootGroupCreatorAddEntryPolicyInfoMessage() {
    if (languageLocale == 'de') return 'Nur der Stammgruppenersteller kann Einträge erstellen.';
    return 'Only the root group creator can add entries.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Only you can add entries.'
  /// ```
  /// * default is english (en)
  String groupCreaterAddEntryPolicyInfoMessage() {
    if (languageLocale == 'de') return 'Nur du kannst Einträge erstellen.';
    return 'Only you can add entries.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Everyone can add entries.'
  /// ```
  /// * default is english (en)
  String groupEveryoneAddEntryPolicyInfoMessage() {
    if (languageLocale == 'de') return 'Jeder kann Einträge erstellen.';
    return 'Everyone can add entries.';
  }

  /// Localizes the label
  /// ```dart
  /// 'No one can add entries.'
  /// ```
  /// * default is english (en)
  String groupNoneAddEntryPolicyInfoMessage() {
    if (languageLocale == 'de') return 'Keiner kann Einträge erstellen.';
    return 'No one can add entries.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Only selected users can add entries.'
  /// ```
  /// * default is english (en)
  String groupPermittedUserAddEntryPolicyInfoMessage() {
    if (languageLocale == 'de') return 'Nur der ausgewählte Personen können Einträge erstellen.';
    return 'Only selected users can add entries.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Only the root group creator can edit entries, regardless of who created the entry.'
  /// ```
  /// * default is english (en)
  String rootGroupCreatorEditPolicyInfoMessage() {
    if (languageLocale == 'de') return 'Nur der Stammgruppenersteller kann Einträge bearbeiten, egal wer den Eintrag erstellt hat.';
    return 'Only the root group creator can edit entries, regardless of who created the entry.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Only the group creator can edit entries, regardless of who created the entry.'
  /// ```
  /// * default is english (en)
  String groupCreaterEditPolicyInfoMessage() {
    if (languageLocale == 'de') return 'Nur du kannst Einträge bearbeiten, egal wer den Eintrag erstellt hat.';
    return 'Only you can edit entries, regardless of who created the entry.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Entries can only be edit by their creator.'
  /// ```
  /// * default is english (en)
  String entryCreatorEditPolicyInfoMessage() {
    if (languageLocale == 'de') return 'Nur die Person welche den Eintrag erstellt kann diesen auch bearbeiten.';
    return 'Entries can only be edited by their creator.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Everyone can edit entries, regardless of who created the entry.'
  /// ```
  /// * default is english (en)
  String groupEveryoneEditPolicyInfoMessage() {
    if (languageLocale == 'de') return 'Jeder kann Einträge bearbeiten, egal wer den Eintrag erstellt hat.';
    return 'Everyone can edit entries, regardless of who created the entry.';
  }

  /// Localizes the label
  /// ```dart
  /// 'No one can edit entries.'
  /// ```
  /// * default is english (en)
  String groupNoneEditPolicyInfoMessage() {
    if (languageLocale == 'de') return 'Keiner kann Einträge bearbeiten.';
    return 'No one can edit entries.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Only selected users can edit entries, regardless of who created the entry.'
  /// ```
  /// * default is english (en)
  String groupPermittedUserEditPolicyInfoMessage() {
    if (languageLocale == 'de') return 'Nur der ausgewählte Personen können Einträge bearbeiten, egal wer den Eintrag erstellt hat.';
    return 'Only selected users can edit entries, regardless of who created the entry.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Only the group creator can add and edit entries.'
  /// ```
  /// * default is english (en)
  String groupGroupOwnerWritePolicyInfoMessage() {
    if (languageLocale == 'de') return 'Nur der Gruppenersteller kann Einträge erstellen und bearbeiten.';
    return 'Only the group creator can add and edit entries.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Everyone can add entries but only the group creator can edit them.'
  /// ```
  /// * default is english (en)
  String groupAddEveryoneEditGroupOwnerPolicyInfoMessage() {
    if (languageLocale == 'de') return 'Jeder kann Einträge erstellen aber nur der Gruppenersteller kann diese bearbeiten.';
    return 'Everyone can add entries but only the group creator can edit them.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Entries can be created by everyone. Entries can only be edited by their creator.'
  /// ```
  /// * default is english (en)
  String groupAddEveryoneEditSelfPolicyInfoMessage() {
    if (languageLocale == 'de') return 'Jeder kann Einträge erstellen. Einträge können nur von deren Erstellern bearbeiten werden.';
    return 'Entries can be created by everyone. Entries can only be edited by their creator.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Entries can be created by everyone. Entries can be edited by everyone regardless of who created the entry.'
  /// ```
  /// * default is english (en)
  String groupAddEditEveryonePolicyInfoMessage() {
    if (languageLocale == 'de') return 'Jeder kann Einträge erstellen. Einträge können von allen bearbeitet werden, egal wer den Eintrag erstellt hat.';
    return 'Entries can be created by everyone. Entries can be edited by everyone regardless of who created the entry.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Only selected users can add and edit entries.'
  /// ```
  /// * default is english (en)
  String groupAddEditOnlyPermittedPolicyInfoMessage() {
    if (languageLocale == 'de') return 'Nur ausgewählte Personen können Einträge erstellen und bearbeiten.';
    return 'Only selected users can add and edit entries.';
  }

  //-----------------------------------------------
  //---------------- Group Selected Sheet Cubit ---
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Edit'
  /// ```
  /// * default is english (en)
  String groupSelectedSheetCubitEdit() {
    if (languageLocale == 'de') return 'Bearbeiten';
    return 'Edit';
  }

  /// Localizes the label
  /// ```dart
  /// 'Delete'
  /// ```
  /// * default is english (en)
  String groupSelectedSheetCubitDelete() {
    if (languageLocale == 'de') return 'Löschen';
    return 'Delete';
  }

  /// Localizes the label
  /// ```dart
  /// 'chart deleted'
  /// ```
  /// * default is english (en)
  String groupSelectedSheetCubitDeleteChartNotification() {
    if (languageLocale == 'de') return 'Diagramm gelöscht';
    return 'chart deleted';
  }

  /// Localizes the label
  /// ```dart
  /// 'Delete this chart?'
  /// ```
  /// * default is english (en)
  String groupSelectedSheetCubitDeleteChartConfrimMessage() {
    if (languageLocale == 'de') return 'Diese Statistik wirklich löschen?';
    return 'Delete this chart?';
  }

  //-----------------------------------------------
  //---------------- Statistics Bar ---------------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'accessing group charts...'
  /// ```
  /// * default is english (en)
  String statisticsBarLoadingMessage() {
    if (languageLocale == 'de') return 'lade Diagramme...';
    return 'accessing group charts...';
  }

  //-----------------------------------------------
  //---------------- Create Bar Chart Sheet Cubit -
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Entries'
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitBaseDataEntries() {
    if (languageLocale == 'de') return 'Einträge';
    return 'Entries';
  }

  /// Localizes the label
  /// ```dart
  /// 'Fields'
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitBaseDataFields() {
    if (languageLocale == 'de') return 'Felder';
    return 'Fields';
  }

  /// Localizes the label
  /// ```dart
  /// 'Member'
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitBaseDataMember() {
    if (languageLocale == 'de') return 'Mitglied';
    return 'Member';
  }

  /// Localizes the label
  /// ```dart
  /// 'Discard this chart?'
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitConfirmMessage() {
    if (languageLocale == 'de') return 'Diagramm verwerfen?';
    return 'Discard this chart?';
  }

  /// Localizes the label
  /// ```dart
  /// 'Chart title'
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitChangeChartTitle() {
    if (languageLocale == 'de') return 'Diagramm Titel';
    return 'Chart title';
  }

  /// Localizes the label
  /// ```dart
  /// show ? 'Hide horizontal lines' : 'Show horizontal lines';
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitChangeChartHorizontalGridLines({required bool show}) {
    if (languageLocale == 'de') return show ? 'Horizontale Linien verbergen' : 'Horizontale Linien anzeigen';
    return show ? 'Hide horizontal lines' : 'Show horizontal lines';
  }

  /// Localizes the label
  /// ```dart
  /// show ? 'Hide vertical lines' : 'Show vertical lines';
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitChangeChartVerticalGridLines({required bool show}) {
    if (languageLocale == 'de') return show ? 'Vertikale Linien verbergen' : 'Vertikale Linien anzeigen';
    return show ? 'Hide vertical lines' : 'Show vertical lines';
  }

  /// Localizes the label
  /// ```dart
  /// 'Change border visibility';
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitChangeChartBorderVisibility() {
    if (languageLocale == 'de') return 'Rahmen Sichtbarkeit ändern';
    return 'Change border visibility';
  }

  /// Localizes the label
  /// ```dart
  /// 'Change title visibility';
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitChangeTitleVisibility() {
    if (languageLocale == 'de') return 'Titel Sichtbarkeit ändern';
    return 'Change title visibility';
  }

  /// Localizes the label
  /// ```dart
  /// show ? 'Hide top border' : 'Show top border';
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitTopBorderVisibility({required bool show}) {
    if (languageLocale == 'de') return show ? 'Oberen Rahmen verbergen' : 'Oberen Rahmen anzeigen';
    return show ? 'Hide top border' : 'Show top border';
  }

  /// Localizes the label
  /// ```dart
  /// show ? 'Hide bottom border' : 'Show bottom border';
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitBottomBorderVisibility({required bool show}) {
    if (languageLocale == 'de') return show ? 'Unteren Rahmen verbergen' : 'Unteren Rahmen anzeigen';
    return show ? 'Hide bottom border' : 'Show bottom border';
  }

  /// Localizes the label
  /// ```dart
  /// show ? 'Hide left border' : 'Show left border';
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitLeftBorderVisibility({required bool show}) {
    if (languageLocale == 'de') return show ? 'Linken Rahmen verbergen' : 'Linken Rahmen anzeigen';
    return show ? 'Hide left border' : 'Show left border';
  }

  /// Localizes the label
  /// ```dart
  /// show ? 'Hide right border' : 'Show right border';
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitRightBorderVisibility({required bool show}) {
    if (languageLocale == 'de') return show ? 'Rechten Rahmen verbergen' : 'Rechten Rahmen anzeigen';
    return show ? 'Hide right border' : 'Show right border';
  }

  /// Localizes the label
  /// ```dart
  /// show ? 'Hide top labels' : 'Show right labels';
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitTopLabelsVisibility({required bool show}) {
    if (languageLocale == 'de') return show ? 'Obere Titel verbergen' : 'Obere Titel anzeigen';
    return show ? 'Hide top labels' : 'Show top labels';
  }

  /// Localizes the label
  /// ```dart
  /// show ? 'Hide bottom labels' : 'Show bottom labels';
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitBottomLabelsVisibility({required bool show}) {
    if (languageLocale == 'de') return show ? 'Untere Titel verbergen' : 'Untere Titel anzeigen';
    return show ? 'Hide bottom labels' : 'Show bottom labels';
  }

  /// Localizes the label
  /// ```dart
  /// show ? 'Hide left labels' : 'Show left labels';
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitLeftLabelsVisibility({required bool show}) {
    if (languageLocale == 'de') return show ? 'Linke Titel verbergen' : 'Linke Titel anzeigen';
    return show ? 'Hide left labels' : 'Show left labels';
  }

  /// Localizes the label
  /// ```dart
  /// 'Top'
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitTop() {
    if (languageLocale == 'de') return 'Oben';
    return 'Top';
  }

  /// Localizes the label
  /// ```dart
  /// 'Bottom'
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitBottom() {
    if (languageLocale == 'de') return 'Unten';
    return 'Bottom';
  }

  /// Localizes the label
  /// ```dart
  /// 'Left'
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitLeft() {
    if (languageLocale == 'de') return 'Links';
    return 'Left';
  }

  /// Localizes the label
  /// ```dart
  /// 'Right'
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitRight() {
    if (languageLocale == 'de') return 'Rechts';
    return 'Right';
  }

  /// Localizes the label
  /// ```dart
  /// 'Top axis name'
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitTopAxisNameHint() {
    if (languageLocale == 'de') return 'Oberer Achsname';
    return 'Top axis name';
  }

  /// Localizes the label
  /// ```dart
  /// 'Bottom axis name'
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitBottomAxisNameHint() {
    if (languageLocale == 'de') return 'Unterer Achsname';
    return 'Bottom axis name';
  }

  /// Localizes the label
  /// ```dart
  /// 'Left axis name'
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitLeftAxisNameHint() {
    if (languageLocale == 'de') return 'Linker Achsname';
    return 'Left axis name';
  }

  /// Localizes the label
  /// ```dart
  /// 'Right axis name'
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitRightAxisNameHint() {
    if (languageLocale == 'de') return 'Rechter Achsname';
    return 'Right axis name';
  }

  /// Localizes the label
  /// ```dart
  /// 'Fields'
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitSelectBaseDataField() {
    if (languageLocale == 'de') return 'Datenfelder';
    return 'Fields';
  }

  /// Localizes the label
  /// ```dart
  /// 'Select member'
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitSelectMember() {
    if (languageLocale == 'de') return 'Mitglied auswählen';
    return 'Select member';
  }

  /// Localizes the label
  /// ```dart
  /// 'Change top label'
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitChangeTopLabel() {
    if (languageLocale == 'de') return 'Oberen Titel ändern';
    return 'Change top label';
  }

  /// Localizes the label
  /// ```dart
  /// 'Change bottom label'
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitChangeBottomLabel() {
    if (languageLocale == 'de') return 'Unteren Titel ändern';
    return 'Change bottom label';
  }

  /// Localizes the label
  /// ```dart
  /// 'Change color'
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitChangeColor() {
    if (languageLocale == 'de') return 'Farbe ändern';
    return 'Change color';
  }

  /// Localizes the label
  /// ```dart
  /// 'creating chart...'
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitLoadingMessageCreatingChart() {
    if (languageLocale == 'de') return 'Diagramm erstellen...';
    return 'creating chart...';
  }

  /// Localizes the label
  /// ```dart
  /// 'updateing chart...'
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitLoadingMessageUpdateingChart() {
    if (languageLocale == 'de') return 'Diagramm aktualisieren...';
    return 'updateing chart...';
  }

  /// Localizes the label
  /// ```dart
  /// 'chart created'
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitChartCreatedNotification() {
    if (languageLocale == 'de') return 'Diagramm erstellt';
    return 'chart created';
  }

  /// Localizes the label
  /// ```dart
  /// 'chart updated'
  /// ```
  /// * default is english (en)
  String createBarChartSheetCubitChartUpdatedNotification() {
    if (languageLocale == 'de') return 'Diagramm aktualisiert';
    return 'chart updated';
  }

  //-----------------------------------------------
  //---------------- Custom Bar Chart -------------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'calculating chart data...'
  /// ```
  /// * default is english (en)
  String loadingMessageCalculatingChartData() {
    if (languageLocale == 'de') return 'Diagrammdaten laden...';
    return 'calculating chart data...';
  }

  //-----------------------------------------------
  //---------------- Alphabet ---------------------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'A'
  /// ```
  /// * default is english (en)
  String alphabetA() {
    if (languageLocale == 'de') return 'A';
    return 'A';
  }

  /// Localizes the label
  /// ```dart
  /// 'B'
  /// ```
  /// * default is english (en)
  String alphabetB() {
    if (languageLocale == 'de') return 'B';
    return 'B';
  }

  /// Localizes the label
  /// ```dart
  /// 'C'
  /// ```
  /// * default is english (en)
  String alphabetC() {
    if (languageLocale == 'de') return 'C';
    return 'C';
  }

  /// Localizes the label
  /// ```dart
  /// 'D'
  /// ```
  /// * default is english (en)
  String alphabetD() {
    if (languageLocale == 'de') return 'D';
    return 'D';
  }

  //-----------------------------------------------
  //---------------- Bar Items --------------------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Bar at position $position'
  /// ```
  /// * default is english (en)
  String barItemsBarAtPosition({required int position}) {
    if (languageLocale == 'de') return 'Balken an $position';
    return 'Bar at position $position';
  }

  //-----------------------------------------------
  //---------------- Entry-------------------------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Number of entries'
  /// ```
  /// * default is english (en)
  String entryChartInstructionNumberOfEntries() {
    if (languageLocale == 'de') return 'Anzahl der Einträge';
    return 'Number of entries';
  }

  /// Localizes the label
  /// ```dart
  /// 'Entries'
  /// ```
  /// * default is english (en)
  String entryEntries() {
    if (languageLocale == 'de') return 'Einträge';
    return 'Entries';
  }

  //-----------------------------------------------
  //---------------- Number Data ------------------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Total'
  /// ```
  /// * default is english (en)
  String numberDataChartInstructionTotal() {
    if (languageLocale == 'de') return 'Gesamt';
    return 'Total';
  }

  /// Localizes the label
  /// ```dart
  /// 'Total'
  /// ```
  /// * default is english (en)
  String numberDataBarItemTotal() {
    if (languageLocale == 'de') return 'Gesamt';
    return 'Total';
  }

  /// Localizes the label
  /// ```dart
  /// 'Average'
  /// ```
  /// * default is english (en)
  String numberDataChartInstructionAverage() {
    if (languageLocale == 'de') return 'Mittelwert';
    return 'Average';
  }

  /// Localizes the label
  /// ```dart
  /// 'Average'
  /// ```
  /// * default is english (en)
  String numberDataBarItemAverage() {
    if (languageLocale == 'de') return 'Mittel';
    return 'Average';
  }

  /// Localizes the label
  /// ```dart
  /// 'Maximum'
  /// ```
  /// * default is english (en)
  String numberDataChartInstructionMaximum() {
    if (languageLocale == 'de') return 'Maximum';
    return 'Maximum';
  }

  /// Localizes the label
  /// ```dart
  /// 'Maximum'
  /// ```
  /// * default is english (en)
  String numberDataBarItemMaximum() {
    if (languageLocale == 'de') return 'Maximum';
    return 'Maximum';
  }

  /// Localizes the label
  /// ```dart
  /// 'Maximum'
  /// ```
  /// * default is english (en)
  String numberDataChartInstructionMinimum() {
    if (languageLocale == 'de') return 'Minimum';
    return 'Minimum';
  }

  /// Localizes the label
  /// ```dart
  /// 'Minimum'
  /// ```
  /// * default is english (en)
  String numberDataBarItemMinimum() {
    if (languageLocale == 'de') return 'Minimum';
    return 'Minimum';
  }

  //-----------------------------------------------
  //---------------- Selector Data ----------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Selection Distribution'
  /// ```
  /// * default is english (en)
  String selectorDataChartInstructionSelectionDistribution() {
    if (languageLocale == 'de') return 'Verteilung';
    return 'Selection Distribution';
  }

  /// Localizes the label
  /// ```dart
  /// 'Most selected item'
  /// ```
  /// * default is english (en)
  String selectorDataChartInstructionMostSelectedItem() {
    if (languageLocale == 'de') return 'Am meisten ausgewählt';
    return 'Most selected item';
  }

  /// Localizes the label
  /// ```dart
  /// 'Least selected item'
  /// ```
  /// * default is english (en)
  String selectorDataChartInstructionLeastSelectedItem() {
    if (languageLocale == 'de') return 'Am wenigsten ausgewählt';
    return 'Least selected item';
  }

  //-----------------------------------------------
  //---------------- Text Data ----------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Average text length'
  /// ```
  /// * default is english (en)
  String textDataChartInstructionTextLengthMean() {
    if (languageLocale == 'de') return 'Durchschnittliche Textlänge';
    return 'Average text length';
  }

  /// Localizes the label
  /// ```dart
  /// 'Average text length'
  /// ```
  /// * default is english (en)
  String textDataBarItemTextLengthMean() {
    if (languageLocale == 'de') return 'Textlänge Mittel';
    return 'Average text length';
  }

  /// Localizes the label
  /// ```dart
  /// 'Number of Words'
  /// ```
  /// * default is english (en)
  String textDataChartInstructionNumberOfWords() {
    if (languageLocale == 'de') return 'Anzahl der Wörter';
    return 'Number of Words';
  }

  /// Localizes the label
  /// ```dart
  /// 'Number of Words'
  /// ```
  /// * default is english (en)
  String textDataBarItemNumberOfWords() {
    if (languageLocale == 'de') return 'Anzahl der Wörter';
    return 'Number of Words';
  }

  //-----------------------------------------------
  //---------------- Expense Data -----------------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Total amount spent'
  /// ```
  /// * default is english (en)
  String expenseDataChartInstructionTotalSpent() {
    if (languageLocale == 'de') return 'Gesamtausgaben';
    return 'Total amount spent';
  }

  /// Localizes the label
  /// ```dart
  /// 'Total spent'
  /// ```
  /// * default is english (en)
  String paymentDataBarItemTotalSpent() {
    if (languageLocale == 'de') return 'Gesamtausgaben';
    return 'Total spent';
  }

  /// Localizes the label
  /// ```dart
  /// 'Total amount spent by member'
  /// ```
  /// * default is english (en)
  String expenseDataChartInstructionMemberTotal() {
    if (languageLocale == 'de') return 'Mitglied Gesamtausgaben';
    return 'Total amount spent by member';
  }

  /// Localizes the label
  /// ```dart
  /// 'Total amount spent of all members'
  /// ```
  /// * default is english (en)
  String expenseDataChartInstructionAllMembersTotal() {
    if (languageLocale == 'de') return 'Gesamtausgaben aller Mitglieder';
    return 'Total amount spent of all members';
  }

  /// Localizes the label
  /// ```dart
  /// 'Percentage of total amount spent by member'
  /// ```
  /// * default is english (en)
  String expenseDataChartInstructionMemberPercentageOfTotal() {
    if (languageLocale == 'de') return 'Prozentuale Gesamtausgaben eines Mitglieds';
    return 'Percentage of total amount spent by member';
  }

  /// Localizes the label
  /// ```dart
  /// 'Account balance by member'
  /// ```
  /// * default is english (en)
  String expenseDataChartInstructionMemberAccountBalance() {
    if (languageLocale == 'de') return 'Mitglied Kontostand';
    return 'Account balance by member';
  }

  /// Localizes the label
  /// ```dart
  /// 'Account balance of all members'
  /// ```
  /// * default is english (en)
  String expenseDataChartInstructionAllMembersAccountBalances() {
    if (languageLocale == 'de') return 'Kontostand aller Mitglieder';
    return 'Account balance of all members';
  }

  /// Localizes the label
  /// ```dart
  /// 'Member total spent over time'
  /// ```
  /// * default is english (en)
  String expenseDataChartInstructionMemberTotalSpentOverTime() {
    if (languageLocale == 'de') return 'Ausgaben eines Mitglieds im Zeitverlauf';
    return 'Member total spent over time';
  }

  /// Localizes the label
  /// ```dart
  /// 'Member total income over time'
  /// ```
  /// * default is english (en)
  String expenseDataChartInstructionMemberTotalIncomeOverTime() {
    if (languageLocale == 'de') return 'Einnahmen eines Mitglieds im Zeitverlauf';
    return 'Member total income over time';
  }

  /// Localizes the label
  /// ```dart
  /// 'Member profits or losses over time'
  /// ```
  /// * default is english (en)
  String expenseDataChartInstructionMemberProfitsAndLossesOverTime() {
    if (languageLocale == 'de') return 'Gewinn oder Verlust eines Mitglieds im Zeitverlauf';
    return 'Member profits or losses over time';
  }

  //-----------------------------------------------
  //---------------- ModelEntry -------------------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Subtitle field not set'
  /// ```
  /// * default is english (en)
  String entryModelSubtitleFieldNotSet() {
    if (languageLocale == 'de') return 'Kein Untertitel ausgewählt';
    return 'Subtitle not set';
  }

  /// Localizes the label
  /// ```dart
  /// 'Chosen subtitle field is empty'
  /// ```
  /// * default is english (en)
  String entryModelSubtitleFieldIsEmpty() {
    if (languageLocale == 'de') return 'Untertitelfeld ist leer';
    return 'Chosen subtitle field is empty';
  }

  /// Localizes the label
  /// ```dart
  /// 'Chosen thirdline field is empty'
  /// ```
  /// * default is english (en)
  String entryModelThirdlineFieldIsEmpty() {
    if (languageLocale == 'de') return 'Drittzeilenfeld ist leer';
    return 'Chosen thirdline field is empty';
  }

  /// Localizes the label
  /// ```dart
  /// 'Subtitle not available'
  /// ```
  /// * default is english (en)
  String entryModelSubtitleNotAvailable() {
    if (languageLocale == 'de') return 'Untertitel nicht verfügbar';
    return 'Subtitle not available';
  }

  /// Localizes the label
  /// ```dart
  /// 'Thirdline not available'
  /// ```
  /// * default is english (en)
  String entryModelThirdlineNotAvailable() {
    if (languageLocale == 'de') return 'Drittzeile nicht verfügbar';
    return 'Thirdline not available';
  }

  /// Localizes the label
  /// ```dart
  /// 'Login'
  /// ```
  /// * default is english (en)
  String modelEntryLogin() {
    if (languageLocale == 'de') return 'Login';
    return 'Login';
  }

  /// Localizes the label
  /// ```dart
  /// 'E-mail'
  /// ```
  /// * default is english (en)
  String modelEntryEmail() {
    if (languageLocale == 'de') return 'E-mail';
    return 'E-mail';
  }

  /// Localizes the label
  /// ```dart
  /// 'Username'
  /// ```
  /// * default is english (en)
  String modelEntryUsername() {
    if (languageLocale == 'de') return 'Username';
    return 'Username';
  }

  /// Localizes the label
  /// ```dart
  /// 'Password'
  /// ```
  /// * default is english (en)
  String modelEntryPassword() {
    if (languageLocale == 'de') return 'Passwort';
    return 'Password';
  }

  /// Localizes the label
  /// ```dart
  /// 'Connected phone number'
  /// ```
  /// * default is english (en)
  String modelEntryConnectedPhone() {
    if (languageLocale == 'de') return 'Verbundene Telefonnummer';
    return 'Connected phone number';
  }

  /// Localizes the label
  /// ```dart
  /// 'Website'
  /// ```
  /// * default is english (en)
  String modelEntryWebsite() {
    if (languageLocale == 'de') return 'Website';
    return 'Website';
  }

  /// Localizes the label
  /// ```dart
  /// 'Notes'
  /// ```
  /// * default is english (en)
  String modelEntryNotes() {
    if (languageLocale == 'de') return 'Notizen';
    return 'Notes';
  }

  /// Localizes the label
  /// ```dart
  /// 'Mood'
  /// ```
  /// * default is english (en)
  String modelEntryMood() {
    if (languageLocale == 'de') return 'Gemütslage';
    return 'Mood';
  }

  /// Localizes the label
  /// ```dart
  /// 'Current mood'
  /// ```
  /// * default is english (en)
  String modelEntryCurrentMood() {
    if (languageLocale == 'de') return 'Derzeitige Gemütslage';
    return 'Current mood';
  }

  /// Localizes the label
  /// ```dart
  /// 'Sleep duration'
  /// ```
  /// * default is english (en)
  String modelEntryMoodSleepDuration() {
    if (languageLocale == 'de') return 'Schlafdauer in Stunden';
    return 'Sleep duration in hours';
  }

  /// Localizes the label
  /// ```dart
  /// 'Slept well'
  /// ```
  /// * default is english (en)
  String modelEntryMoodSleptWell() {
    if (languageLocale == 'de') return 'Gut geschlafen?';
    return 'Slept well';
  }

  /// Localizes the label
  /// ```dart
  /// 'Current stress level'
  /// ```
  /// * default is english (en)
  String modelEntryMoodCurrentStressLevel() {
    if (languageLocale == 'de') return 'Derzeitiges Stresslevel';
    return 'Current stress level';
  }

  /// Localizes the label
  /// ```dart
  /// 'Current energy level'
  /// ```
  /// * default is english (en)
  String modelEntryMoodCurrentEnergyLevel() {
    if (languageLocale == 'de') return 'Derzeitiges Energielevel';
    return 'Current energy level';
  }

  /// Localizes the label
  /// ```dart
  /// 'Daily goals'
  /// ```
  /// * default is english (en)
  String modelEntryMoodGoals() {
    if (languageLocale == 'de') return 'Tagesziele';
    return 'Daily goals';
  }

  /// Localizes the label
  /// ```dart
  /// 'Activities'
  /// ```
  /// * default is english (en)
  String modelEntryMoodActivities() {
    if (languageLocale == 'de') return 'Aktivitäten';
    return 'Activities';
  }

  /// Localizes the label
  /// ```dart
  /// 'Income/Expense'
  /// ```
  /// * default is english (en)
  String modelEntryIncomeExpense() {
    if (languageLocale == 'de') return 'Einnahme/Ausgabe';
    return 'Income/Expense';
  }

  /// Localizes the label
  /// ```dart
  /// 'Value date'
  /// ```
  /// * default is english (en)
  String modelEntryIncomeExpenseValueDate() {
    if (languageLocale == 'de') return 'Valutadatum';
    return 'Value date';
  }

  /// Localizes the label
  /// ```dart
  /// 'IBAN ordering account'
  /// ```
  /// * default is english (en)
  String modelEntryIncomeExpenseIBANOrderingAccount() {
    if (languageLocale == 'de') return 'IBAN Auftragskonto';
    return 'IBAN ordering account';
  }

  /// Localizes the label
  /// ```dart
  /// 'Additional references'
  /// ```
  /// * default is english (en)
  String modelEntryIncomeExpenseAdditionalReference() {
    if (languageLocale == 'de') return 'Zusatzreferenzen';
    return 'Additional references';
  }

  /// Localizes the label
  /// ```dart
  /// 'Bank name participant'
  /// ```
  /// * default is english (en)
  String modelEntryIncomeExpenseBanknameParticipant() {
    if (languageLocale == 'de') return 'Bankname Zahlungsbeteiligter';
    return 'Bank name participant';
  }

  /// Localizes the label
  /// ```dart
  /// 'IBAN participant'
  /// ```
  /// * default is english (en)
  String modelEntryIncomeExpenseIBANParticipant() {
    if (languageLocale == 'de') return 'IBAN Zahlungsbeteiligter';
    return 'IBAN participant';
  }

  /// Localizes the label
  /// ```dart
  /// 'BIC (SWIFT) participant'
  /// ```
  /// * default is english (en)
  String modelEntryIncomeExpenseBICParticipant() {
    if (languageLocale == 'de') return 'BIC (SWIFT) Zahlungsbeteiligter';
    return 'BIC (SWIFT) participant';
  }

  /// Localizes the label
  /// ```dart
  /// 'Booking text'
  /// ```
  /// * default is english (en)
  String modelEntryIncomeBookingText() {
    if (languageLocale == 'de') return 'Buchungstext';
    return 'Booking text';
  }

  /// Localizes the label
  /// ```dart
  /// 'Designated Purpose'
  /// ```
  /// * default is english (en)
  String modelEntryIncomeBookingVerwendungszweck() {
    if (languageLocale == 'de') return 'Verwendungszweck';
    return 'Designated Purpose';
  }

  /// Localizes the label
  /// ```dart
  /// 'Person'
  /// ```
  /// * default is english (en)
  String modelEntryPerson() {
    if (languageLocale == 'de') return 'Person';
    return 'Person';
  }

  /// Localizes the label
  /// ```dart
  /// 'Phone'
  /// ```
  /// * default is english (en)
  String modelEntryPhone() {
    if (languageLocale == 'de') return 'Telefon';
    return 'Phone';
  }

  /// Localizes the label
  /// ```dart
  /// 'Date of birth'
  /// ```
  /// * default is english (en)
  String modelEntryDateOfBirth() {
    if (languageLocale == 'de') return 'Geburtstag';
    return 'Date of birth';
  }

  /// Localizes the label
  /// ```dart
  /// 'Gender'
  /// ```
  /// * default is english (en)
  String modelEntryGender() {
    if (languageLocale == 'de') return 'Geschlecht';
    return 'Gender';
  }

  //-----------------------------------------------
  //---------------- Create Group Sheet -----------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// if (sharedGroup) return isEdit ? 'Edit shared group' : 'Create shared group';
  /// return isEdit ? 'Edit local group' : 'Create local group';
  /// ```
  /// * default is english (en)
  String createGroupSheetTitle({required bool isShared, required bool isEdit}) {
    if (languageLocale == 'de') {
      if (isShared) return isEdit ? 'Geteilte Gruppe bearbeiten' : 'Geteilte Gruppe erstellen';
      return isEdit ? 'Lokale Gruppe bearbeiten' : 'Lokale Gruppe erstellen';
    }

    if (isShared) return isEdit ? 'Edit shared group' : 'Create shared group';
    return isEdit ? 'Edit local group' : 'Create local group';
  }

  /// Localizes the label
  /// ```dart
  /// return isEdit ? 'edit $participantName' : 'create';
  /// ```
  /// * default is english (en)
  String createGroupSheetParticipantButtonLabel({required bool isEdit, required String participantName}) {
    if (languageLocale == 'de') return isEdit ? '$participantName bearbeiten' : 'hinzufügen';
    return isEdit ? 'edit $participantName' : 'add';
  }

  /// Localizes the label
  /// ```dart
  /// 'Who can add entries?'
  /// ```
  /// * default is english (en)
  String createGroupSheetEntryAddPolicy() {
    if (languageLocale == 'de') return 'Wer kann Einträge erstellen?';
    return 'Who can add entries?';
  }

  /// Localizes the label
  /// ```dart
  /// 'Who can edit entries?'
  /// ```
  /// * default is english (en)
  String createGroupSheetEntryEditPolicy() {
    if (languageLocale == 'de') return 'Wer kann Einträge bearbeiten?';
    return 'Who can edit entries?';
  }

  /// Localizes the label
  /// ```dart
  /// 'Who can delete entries?'
  /// ```
  /// * default is english (en)
  String createGroupSheetEntryDeletePolicy() {
    if (languageLocale == 'de') return 'Wer kann Einträge löschen?';
    return 'Who can delete entries?';
  }

  /// Localizes the label
  /// ```dart
  /// 'Who can add subgroups?'
  /// ```
  /// * default is english (en)
  String createGroupSheetSubgroupAddPolicy() {
    if (languageLocale == 'de') return 'Wer kann Untergruppen erstellen?';
    return 'Who can add subgroups?';
  }

  /// Localizes the label
  /// ```dart
  /// 'Who can edit this group?'
  /// ```
  /// * default is english (en)
  String createGroupSheetGroupEditPolicy() {
    if (languageLocale == 'de') return 'Wer kann diese Gruppe bearbeiten?';
    return 'Who can edit this group?';
  }

  /// Localizes the label
  /// ```dart
  /// 'Who can delete this group?'
  /// ```
  /// * default is english (en)
  String createGroupSheetGroupDeletePolicy() {
    if (languageLocale == 'de') return 'Wer kann diese Gruppe löschen?';
    return 'Who can delete this group?';
  }

  //-----------------------------------------------
  //---------------- Entry Sheet Labels -----------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'back'
  /// ```
  /// * default is english (en)
  String entrySheetErrorButtonLabel() {
    if (languageLocale == 'de') return 'zurück';
    return 'back';
  }

  /// Localizes the label
  /// ```dart
  /// isEdit ? 'edit $entryModelName entry' : 'create $entryModelName entry'
  /// ```
  /// * default is english (en)
  String entrySheetTitle({required bool isDefault, required bool isEdit, required String entryModelName}) {
    if (languageLocale == 'de') {
      if (isDefault) {
        return isEdit ? 'Standard bearbeiten' : 'Standard erstellen';
      }

      return isEdit ? '$entryModelName bearbeiten' : '$entryModelName erstellen';
    }

    if (isDefault) return isEdit ? 'Edit default' : 'Create default';
    return isEdit ? 'Edit $entryModelName' : 'Create $entryModelName';
  }

  /// Localizes the label
  /// ```dart
  /// 'entry name'
  /// ```
  /// * default is english (en)
  String entrySheetEntryName() {
    if (languageLocale == 'de') return 'Eintragsname';
    return 'Entry name';
  }

  /// Localizes the label
  /// ```dart
  /// 'groups'
  /// ```
  /// * default is english (en)
  String entrySheetGroups() {
    if (languageLocale == 'de') return 'Gruppen';
    return 'Groups';
  }

  /// Localizes the label
  /// ```dart
  /// 'create group'
  /// ```
  /// * default is english (en)
  String entrySheetCreateNewGroup() {
    if (languageLocale == 'de') return 'Gruppe erstellen';
    return 'Create group';
  }

  /// Localizes the label
  /// ```dart
  /// 'group name'
  /// ```
  /// * default is english (en)
  String entrySheetGroupNameHint() {
    if (languageLocale == 'de') return 'Gruppenname';
    return 'Group name';
  }

  /// Localizes the label
  /// ```dart
  /// 'choose from existing groups'
  /// ```
  /// * default is english (en)
  String entrySheetChooseFromExistingGroups() {
    if (languageLocale == 'de') return 'existierende Gruppe auswählen';
    return 'choose from existing groups';
  }

  /// Localizes the label
  /// ```dart
  /// isImage ? 'Tab an image to add a title and a caption.': 'Tab a file to add a title and a caption.';
  /// ```
  /// * default is english (en)
  String entrySheetLabelFilesTitleAndCaptionInfoMessage({required bool isImage}) {
    if (languageLocale == 'de') return isImage ? 'Tippe auf ein Bild für Titel und Bildtext.' : 'Tippe auf eine Datei für Titel und Dateitext.';
    return isImage ? 'Tab an image for title and caption.' : 'Tab a file for title and caption.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Decrypt files...'
  /// ```
  /// * default is english (en)
  String entrySheetLabelFilesLoadingMessage() {
    if (languageLocale == 'de') return 'Dateien entschlüsseln...';
    return 'Decrypt files...';
  }

  /// Localizes the label
  /// ```dart
  /// return isEdit ? 'Change selection' : isImage ? 'Select images' : 'Select files';
  /// ```
  /// * default is english (en)
  String entrySheetLabelChooseFilesButtonLabel({required bool isEdit, required bool isImage}) {
    if (languageLocale == 'de') {
      return isEdit
          ? 'Auswahl ändern'
          : isImage
              ? 'Bilder auswählen'
              : 'Dateien auswählen';
    }

    // English default.
    return isEdit
        ? 'Change selection'
        : isImage
            ? 'Select images'
            : 'Select files';
  }

  /// Localizes the label
  /// ```dart
  /// return isEdit ? 'Change selection' : 'Select image';
  /// ```
  /// * default is english (en)
  String entrySheetLabelChooseAvatarImageButtonLabel({required bool isEdit}) {
    if (languageLocale == 'de') return isEdit ? 'Auswahl ändern' : 'Bild auswählen';
    return isEdit ? 'Change selection' : 'Select image';
  }

  /// Localizes the label
  /// ```dart
  /// 'A value is required.'
  /// ```
  /// * default is english (en)
  String basicLabelsAValueIsRequired() {
    if (languageLocale == 'de') return 'Ein Wert ist erforderlich.';
    return 'A value is required.';
  }

  /// Localizes the label
  /// ```dart
  /// 'choose date'
  /// ```
  /// * default is english (en)
  String entrySheetChooseDateButtonLabel() {
    if (languageLocale == 'de') return 'Datum auswählen';
    return 'Choose date';
  }

  /// Localizes the label
  /// ```dart
  /// 'choose'
  /// ```
  /// * default is english (en)
  String entrySheetChooseDateAndTimeButtonLabel() {
    if (languageLocale == 'de') return 'Zeitpunkt auswählen';
    return 'Choose date and time';
  }

  /// Localizes the label
  /// ```dart
  /// 'choose'
  /// ```
  /// * default is english (en)
  String entrySheetChooseTimeButtonLabel() {
    if (languageLocale == 'de') return 'Uhrzeit auswählen';
    return 'Choose time';
  }

  /// Localizes the label
  /// ```dart
  /// 'try again'
  /// ```
  /// * default is english (en)
  String entrySheetOnRetryLabel() {
    if (languageLocale == 'de') return 'Noch einmal versuchen';
    return 'Try again';
  }

  /// Localizes the label
  /// ```dart
  /// 'no selection made'
  /// ```
  /// * default is english (en)
  String entrySheetNoSelectionMade() {
    if (languageLocale == 'de') return 'keine Auswahl getroffen';
    return 'no selection made';
  }

  /// Localizes the label
  /// ```dart
  /// 'no selection'
  /// ```
  /// * default is english (en)
  String entrySheetNoSelection() {
    if (languageLocale == 'de') return 'keine Auswahl';
    return 'no selection';
  }

  /// Localizes the label
  /// ```dart
  /// 'entries loading...'
  /// ```
  /// * default is english (en)
  String entrySheetLoadingMessageEntriesLoading() {
    if (languageLocale == 'de') return 'lade Einträge...';
    return 'entries loading...';
  }

  /// Localizes the label
  /// ```dart
  /// 'no $name entries created yet'
  /// ```
  /// * default is english (en)
  String entrySheetNoEntriesCreatedYet({required String name}) {
    if (languageLocale == 'de') return 'noch keine $name Einträge erstellt';
    return 'no $name entries created yet';
  }

  /// Localizes the label
  /// ```dart
  /// isEdit ? 'save changes' : 'create entry'
  /// ```
  /// * default is english (en)
  String entrySheetFloatingActionBarLabel({required bool isEdit}) {
    if (languageLocale == 'de') return isEdit ? 'Speichern' : 'Erstellen';
    return isEdit ? 'Save changes' : 'Create entry';
  }

  /// Localizes the label
  /// ```dart
  /// 'password generated'
  /// ```
  /// * default is english (en)
  String entrySheetPasswordGeneratedNotification() {
    if (languageLocale == 'de') return 'Passwort erstellt';
    return 'password generated';
  }

  /// Localizes the label
  /// ```dart
  /// '$entryModelName entry created'
  /// ```
  /// * default is english (en)
  String entrySheetEntryCreatedNotification({required String entryModelName}) {
    if (languageLocale == 'de') return '$entryModelName Eintrag erstellt';
    return '$entryModelName entry created';
  }

  /// Localizes the label
  /// ```dart
  /// 'Latitude'
  /// ```
  /// * default is english (en)
  String entrySheetLabelLatitude() {
    if (languageLocale == 'de') return 'Breitengrad';
    return 'Latitude';
  }

  /// Localizes the label
  /// ```dart
  /// 'Longitude'
  /// ```
  /// * default is english (en)
  String entrySheetLabelLongitude() {
    if (languageLocale == 'de') return 'Längengrad';
    return 'Longitude';
  }

  /// Localizes the label
  /// ```dart
  /// 'use current location'
  /// ```
  /// * default is english (en)
  String entrySheetLabelCurrentLocation() {
    if (languageLocale == 'de') return 'Meinen Standort verwenden';
    return 'Use current location';
  }

  /// Localizes the label
  /// ```dart
  /// isInit ? 'currency' : 'currency: $currencyCode';
  /// ```
  /// * default is english (en)
  String entrySheetMoneyDataCurrencyButtonLabel({required bool isInit, required String currencyCode}) {
    if (languageLocale == 'de') return isInit ? 'Währung' : currencyCode;
    return isInit ? 'currency' : currencyCode;
  }

  /// Localizes the label
  /// ```dart
  /// entryName.isEmpty ? 'select entry' : entryName;
  /// ```
  /// * default is english (en)
  String entrySheetEntryReferenceButtonLabel({required String entryName}) {
    if (languageLocale == 'de') return entryName.isEmpty ? 'Eintrag auswählen' : entryName;
    return entryName.isEmpty ? 'select entry' : entryName;
  }

  //-----------------------------------------------
  //---------------- Custom Text Field ------------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'No suggestions found.'
  /// ```
  /// * default is english (en)
  String customTextFieldNoSuggestionsFound() {
    if (languageLocale == 'de') return 'Keine Vorschläge gefunden.';
    return 'No suggestions found.';
  }

  //-----------------------------------------------
  //---------------- Entry Sheet Cubit ------------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Are you sure that you do not want to save made edits?'
  /// ```
  /// * default is english (en)
  String entrySheetCubitConfirmCloseEdit() {
    if (languageLocale == 'de') return 'Bist du sicher das du die gemachten Änderungen nicht speichern willst?';
    return 'Are you sure that you do not want to save made edits?';
  }

  /// Localizes the label
  /// ```dart
  /// 'Are you sure that you want to discard this entry?'
  /// ```
  /// * default is english (en)
  String entrySheetCubitConfirmClose() {
    if (languageLocale == 'de') return 'Bist du sicher das du diesen Eintrag nicht speichern willst?';
    return 'Are you sure that you want to discard this entry?';
  }

  /// Localizes the label
  /// ```dart
  /// 'Validateing entry...'
  /// ```
  /// * default is english (en)
  String entrySheetCubitValidateEntry() {
    if (languageLocale == 'de') return 'Validiere Eintrag...';
    return 'Validateing entry...';
  }

  /// Localizes the label
  /// ```dart
  /// wantEncryption ? 'encrypting image ${currentImage + 1} of $totalImages' : 'saving image ${currentImage + 1} of $totalImages';
  /// ```
  /// * default is english (en)
  String entrySheetCubitSaveImages({required int currentImage, required int totalImages, required bool wantEncryption}) {
    if (languageLocale == 'de') return wantEncryption ? 'verschlüssle Bild ${currentImage + 1} von $totalImages' : 'speichere Bild ${currentImage + 1} von $totalImages';
    return wantEncryption ? 'encrypting image ${currentImage + 1} of $totalImages' : 'saving image ${currentImage + 1} of $totalImages';
  }

  /// Localizes the label
  /// ```dart
  /// 'update image ${currentImage + 1} of $totalImages'
  /// ```
  /// * default is english (en)
  String entrySheetCubitUpdateImages({required int currentImage, required int totalImages, required bool wantEncryption}) {
    if (languageLocale == 'de') return 'aktualisiere Bild ${currentImage + 1} von $totalImages';
    return 'update image ${currentImage + 1} of $totalImages';
  }

  /// Localizes the label
  /// ```dart
  /// 'A newer version of the app is required to continue.\n\nPlease update to the latest version to ensure compatibility and access to all features.'
  /// ```
  /// * default is english (en)
  String appUpdateRequired() {
    if (languageLocale == 'de') return 'Eine neuere Version der App ist erforderlich um fortzufahren.\n\nBitte aktualisiere auf die neueste Version, um Kompatibilität und Zugriff auf alle Funktionen sicherzustellen.';
    return 'A newer version of the app is required to continue.\n\nPlease update to the latest version to ensure compatibility and access to all features.';
  }

  /// Localizes the label
  /// ```dart
  /// 'ISAR database is null.'
  /// ```
  /// * default is english (en)
  String isarDatabaseIsNull() {
    if (languageLocale == 'de') return 'ISAR Datenbank ist null.';
    return 'ISAR database is null.';
  }

  /// Localizes the label
  /// ```dart
  /// 'ISAR database is null.'
  /// ```
  /// * default is english (en)
  String timezoneRequired() {
    if (languageLocale == 'de') return 'Eine Zeitzone ist erforderlich, kann jedoch nicht abgerufen werden.';
    return 'A timezone is required but cannot be accessed.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please first provide a date.'
  /// ```
  /// * default is english (en)
  String dateIsRequired() {
    if (languageLocale == 'de') return 'Bitte gib zunächst ein Datum an.';
    return 'Please first provide a date.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Picked file is invalid.'
  /// ```
  /// * default is english (en)
  String invalidFile() {
    if (languageLocale == 'de') return 'Ausgewählte Datei ist ungültig.';
    return 'Picked file is invalid.';
  }

  /// Localizes the label
  /// ```dart
  /// 'A to currency code is required.'
  /// ```
  /// * default is english (en)
  String toCurrencyRequired() {
    if (languageLocale == 'de') return 'Ein Zielwährungscode ist erforderlich.';
    return 'A "to" currency code is required.';
  }

  /// Localizes the label
  /// ```dart
  /// 'A from currency code is required.'
  /// ```
  /// * default is english (en)
  String fromCurrencyRequired() {
    if (languageLocale == 'de') return 'Ein Ausgangswährungscode ist erforderlich.';
    return 'A "from" currency code is required.';
  }

  /// Localizes the label
  /// ```dart
  /// '"From" and "To" cannot be equal.'
  /// ```
  /// * default is english (en)
  String currenciesMustDiffer() {
    if (languageLocale == 'de') return 'Ausgangswährung und Zielwährung müssen sich unterscheiden.';
    return '"From" and "To" cannot be equal.';
  }

  /// Localizes the label
  /// ```dart
  /// 'A exchange rate with equal "From" and "To" pair already exists.'
  /// ```
  /// * default is english (en)
  String exchangeRateAlreadyExists() {
    if (languageLocale == 'de') return 'Ein Wechselkurs mit gleicher Ausgangswährung und Zielwährung existiert bereits.';
    return 'A exchange rate with equal "From" and "To" pair already exists.';
  }

  /// Localizes the label
  /// ```dart
  /// return isDefault ? 'Default exchange rates' : 'Custom exchange rates';
  /// ```
  /// * default is english (en)
  String customExchangeRates({required bool isDefault}) {
    if (languageLocale == 'de') return isDefault ? 'Standardwechselkurse' : 'Benutzerdefinierte Wechselkurse';
    return isDefault ? 'Default exchange rates' : 'Custom exchange rates';
  }

  /// Localizes the label
  /// ```dart
  /// 'Picked image is invalid.'
  /// ```
  /// * default is english (en)
  String invalidImage() {
    if (languageLocale == 'de') return 'Ausgewähltes Bild ist ungültig.';
    return 'Picked image is invalid.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Chosen quick number action is unknown, please try again.'
  /// ```
  /// * default is english (en)
  String unknonwQuickNumberAction() {
    if (languageLocale == 'de') return 'Diese Aktion kann nicht verarbeitet werden, bitte versuche es noch einmal.';
    return 'Chosen quick number action is unknown, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please accept our terms and conditions to participate in shared groups.'
  /// ```
  /// * default is english (en)
  String termsAndConditionsNotAccepted() {
    if (languageLocale == 'de') return 'Bitte akzeptiere unsere Allgemeinen Geschäftsbedingungen, um an geteilten Gruppen teilzunehmen.';
    return 'Please accept our terms and conditions to participate in shared groups.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Our servers are experiencing technical difficulties. Please try again later.'
  /// ```
  /// * default is english (en)
  String apiTechnicalDifficulties() {
    if (languageLocale == 'de') return 'Unsere Server haben derzeit technische Probleme.\n\nBitte versuche es später erneut.';
    return 'Our servers are experiencing technical difficulties.\n\nPlease try again later.';
  }

  /// Localizes the label
  /// ```dart
  /// 'We're making some improvements behind the scenes.\n\nPlease try again later.'
  /// ```
  /// * default is english (en)
  String apiMaintenance() {
    if (languageLocale == 'de') return 'Wir nehmen einige Verbesserungen im Hintergrund vor.\n\nBitte versuche es später erneut.';
    return "We're making some improvements behind the scenes.\n\nPlease try again later.";
  }

  /// Localizes the label
  /// ```dart
  /// 'We're making some improvements behind the scenes.\n\nPlease try again later.'
  /// ```
  /// * default is english (en)
  String apiDeprecated() {
    if (languageLocale == 'de') return 'Es tut uns leid aber dies kann nicht mehr verwendet werden.\n\nBitte aktualisiere die App um Zugriff auf die neuesten Verbesserungen zu erhalten.';
    return "We're sorry but this cannot be used anymore.\n\nPlease update your app to get access to the latest improvements.";
  }

  /// Localizes the label
  /// ```dart
  /// 'You have exceeded the request limit to often and your access has been revoked indefinitely.\n\nPlease contact our support if you think this is a misstake.'
  /// ```
  /// * default is english (en)
  String apiAccessRevokedIndefinitely() {
    if (languageLocale == 'de') return 'Ihr Zugriffsrecht wurde dauerhaft widerrufen weil das Anfrage-Limit zu oft überschritten wurde.\n\nBitte kontaktieren Sie unseren Support, wenn Sie denken, dass dies ein Fehler ist.';
    return 'You have exceeded the request limit to often and your access has been revoked indefinitely.\n\nPlease contact our support if you think this is a misstake.';
  }

  /// Localizes the label
  /// ```dart
  /// 'You have exceeded the request limit. Please try again later.'
  /// ```
  /// * default is english (en)
  String apiAccessRevokedTemporarily() {
    if (languageLocale == 'de') return 'Das Anfrage-Limit wurde überschritten. Bitte versuche es später wieder.';
    return 'You have exceeded the request limit. Please try again later.';
  }

  /// Localizes the label
  /// ```dart
  /// 'API has been suspended until further notice.\n\nWe apologize for any inconveniences.'
  /// ```
  /// * default is english (en)
  String apiSuspended() {
    if (languageLocale == 'de') return 'Die API wurde bis auf Weiteres ausgesetzt.\n\nWir entschuldigen uns für etwaige Unannehmlichkeiten.';
    return 'API has been suspended until further notice.\n\nWe apologize for any inconveniences.';
  }

  /// Localizes the label
  /// ```dart
  /// 'create group: $groupName'
  /// ```
  /// * default is english (en)
  String entrySheetCubitCreateGroup({required String groupName}) {
    if (languageLocale == 'de') return 'erstelle Gruppe: $groupName';
    return 'create group: $groupName';
  }

  /// Localizes the label
  /// ```dart
  /// 'update group'
  /// ```
  /// * default is english (en)
  String entrySheetCubitUpdateGroup() {
    if (languageLocale == 'de') return 'aktualisiere Gruppe';
    return 'update group';
  }

  //-----------------------------------------------
  //---------------- Create Selection Sheet Labels
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'custom selection'
  /// ```
  /// * default is english (en)
  String createSelectionSheetTitle() {
    if (languageLocale == 'de') return 'individuelle Auswahl';
    return 'custom selection';
  }

  /// Localizes the label
  /// ```dart
  /// 'add '
  /// ```
  /// * default is english (en)
  String createSelectionSelectorButtonLabel() {
    if (languageLocale == 'de') return 'hinzufügen';
    return 'add';
  }

  /// Localizes the label
  /// ```dart
  /// 'done'
  /// ```
  /// * default is english (en)
  String createSelectionFloatingActionBarLabel() {
    if (languageLocale == 'de') return 'fertig';
    return 'done';
  }

  /// Localizes the label
  /// ```dart
  /// 'Are you sure that you want to discard made selection? '
  /// ```
  /// * default is english (en)
  String createSelectionConfirmCloseSheet() {
    if (languageLocale == 'de') return 'Gemachte Auswahl wirklich verwerfen?';
    return 'Are you sure that you want to discard made selection?';
  }

  //-----------------------------------------------
  //---------------- Date Of Birth Data -----------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'years old'
  /// ```
  /// * default is english (en)
  String dateOfBirthDataYearsOld() {
    if (languageLocale == 'de') return 'Jahre alt';
    return 'years old';
  }

  /// Localizes the label
  /// ```dart
  /// return '$date at $time';
  /// ```
  /// * default is english (en)
  String dateOfBirthDataDateAndTime({required String date, required String time}) {
    if (languageLocale == 'de') return '$date um $time';
    return '$date at $time';
  }

  //-----------------------------------------------
  //---------------- Date Selector Labels ---------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'done'
  /// ```
  /// * default is english (en)
  String dateSelectorButtonLabel() {
    if (languageLocale == 'de') return 'fertig';
    return 'done';
  }

  //-----------------------------------------------
  //---------------- List Selector Sheet Labels ---
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'no items found'
  /// ```
  /// * default is english (en)
  String listSelectorNoItemsFound() {
    if (languageLocale == 'de') return 'keine Elemente gefunden';
    return 'no items found';
  }

  //-----------------------------------------------
  //---------------- Group Selected Sheet Labels --
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'this group is currently empty'
  /// ```
  /// * default is english (en)
  String groupSelectedSheetEmptyEntriesMessage() {
    if (languageLocale == 'de') return 'derzeit keine Einträge in dieser Gruppe';
    return 'this group is currently empty';
  }

  /// Localizes the label
  /// ```dart
  /// 'Remove from group'
  /// ```
  /// * default is english (en)
  String entrySelectedSheetRemoveFromGroup() {
    if (languageLocale == 'de') return 'Aus Gruppe entfernen';
    return 'Remove from group';
  }

  /// Localizes the label
  /// ```dart
  /// 'add'
  /// ```
  /// * default is english (en)
  String groupSelectedSheetAddEntries() {
    if (languageLocale == 'de') return 'hinzufügen';
    return 'add';
  }

  /// Localizes the label
  /// ```dart
  /// 'no subgroups created yet'
  /// ```
  /// * default is english (en)
  String groupSelectedSheetEmptySubgroupsMessage() {
    if (languageLocale == 'de') return 'noch keine Untergruppen';
    return 'no subgroups created yet';
  }

  /// Localizes the label
  /// ```dart
  /// 'Entries: $numberOfEntries'
  /// ```
  /// * default is english (en)
  String groupSelectedSheetNumberOfEntries({required int numberOfEntries}) {
    if (languageLocale == 'de') return 'Einträge: $numberOfEntries';
    return 'Entries: $numberOfEntries';
  }

  //-----------------------------------------------
  //---------------- Group Selected Sheet Cubit Labels
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// '$fieldLabel copied'
  /// ```
  /// * default is english (en)
  String groupSelectedSheetCubitCopyField({required String label}) {
    if (languageLocale == 'de') return '$label kopiert';
    return '$label copied';
  }

  /// Localizes the label
  /// ```dart
  /// 'Remove this entry from this group?'
  /// ```
  /// * default is english (en)
  String entrySelectedSheetCubitConfirmRemoveFromGroup() {
    if (languageLocale == 'de') return 'Eintrag wirklich aus dieser Gruppe entfernen?';
    return 'Remove this entry from this group?';
  }

  /// Localizes the label
  /// ```dart
  /// 'Removed from group'
  /// ```
  /// * default is english (en)
  String entrySelectedSheetCubitRemovedFromGroup() {
    if (languageLocale == 'de') return 'Aus Gruppe entfernt';
    return 'Removed from group';
  }

  /// Localizes the label
  /// ```dart
  /// 'Are you sure you want to delete this group?'
  /// ```
  /// * default is english (en)
  String groupSelectedSheetCubitConfirmDeleteGroupTitle() {
    if (languageLocale == 'de') return 'Diese Gruppe wirklich löschen?';
    return 'Are you sure you want to delete this group?';
  }

  /// Localizes the label
  /// ```dart
  /// '· This will delete all subgroups.\n\n· This will delete all entries of this group and its subgroups unless they are also in another group.'
  /// ```
  /// * default is english (en)
  String groupSelectedSheetCubitConfirmDeleteGroupSubtitle() {
    if (languageLocale == 'de') return '· Dies wird alle Einträge dieser Gruppe löschen.\n\n· Einträge werden nicht gelöscht wenn diese noch in einer anderen Gruppe sind.';
    return '· This will delete all entries of this group.\n\n· Entries will not be deleted if they also are in another group.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Edit group'
  /// ```
  /// * default is english (en)
  String groupSelectedSheetCubitOptionEditGroup() {
    if (languageLocale == 'de') return 'Gruppe bearbeiten';
    return 'Edit group';
  }

  /// Localizes the label
  /// ```dart
  /// 'Search in group'
  /// ```
  /// * default is english (en)
  String groupSelectedSheetCubitOptionSearchGroup() {
    if (languageLocale == 'de') return 'Gruppe durchsuchen';
    return 'Search in group';
  }

  /// Localizes the label
  /// ```dart
  /// 'Delete group'
  /// ```
  /// * default is english (en)
  String groupSelectedSheetCubitOptionDeleteGroup() {
    if (languageLocale == 'de') return 'Gruppe löschen';
    return 'Delete group';
  }

  /// Localizes the label
  /// ```dart
  /// 'Quick add reference'
  /// ```
  /// * default is english (en)
  String groupSelectedSheetCubitOptionPickQuickAddReference() {
    if (languageLocale == 'de') return 'Schnelles hinzufügen';
    return 'Quick add reference';
  }

  /// Localizes the label
  /// ```dart
  /// 'Group notifications'
  /// ```
  /// * default is english (en)
  String groupNotifications() {
    if (languageLocale == 'de') return 'Gruppen Benachrichtigungen';
    return 'Group notifications';
  }

  /// Localizes the label
  /// ```dart
  /// 'Select an model entry to quickly add a new entry of this kind to this group if you long press the add button.';
  /// ```
  /// * default is english (en)
  String groupSelectedSheetQuickAddReferenceInfoMessage() {
    if (languageLocale == 'de') return 'Wähle eine Eintragsvorlage aus um schnell einen Eintrag dieser Art, durch langes pressen der hinzufügen Taste, zu dieser Gruppe hinzuzufügen.';
    return 'Select an model entry to quickly add a new entry of this kind to this group if you long press the add button.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Share group'
  /// ```
  /// * default is english (en)
  String groupSelectedSheetCubitOptionShareGroup() {
    if (languageLocale == 'de') return 'Gruppe teilen';
    return 'Share group';
  }

  /// Localizes the label
  /// ```dart
  /// 'View expense report'
  /// ```
  /// * default is english (en)
  String groupSelectedSheetCubitOptionExpenseReport() {
    if (languageLocale == 'de') return 'Ausgabenabrechnung anzeigen';
    return 'View expense report';
  }

  /// Localizes the label
  /// ```dart
  /// 'Leave group'
  /// ```
  /// * default is english (en)
  String groupSelectedSheetCubitOptionLeaveGroup() {
    if (languageLocale == 'de') return 'Gruppe verlassen';
    return 'Leave group';
  }

  /// Localizes the label
  /// ```dart
  /// 'group deleted'
  /// ```
  /// * default is english (en)
  String groupSelectedSheetCubitGroupDeletedNotification() {
    if (languageLocale == 'de') return 'Gruppe gelöscht';
    return 'group deleted';
  }

  /// Localizes the label
  /// ```dart
  /// 'entry deleted'
  /// ```
  /// * default is english (en)
  String groupSelectedSheetCubitEntryDeletedNotification() {
    if (languageLocale == 'de') return 'Eintrag gelöscht';
    return 'entry deleted';
  }

  /// Localizes the label
  /// ```dart
  /// 'New entry'
  /// ```
  /// * default is english (en)
  String groupSelectedSheetCubitOptionNewEntry() {
    if (languageLocale == 'de') return 'Neuer Eintrag';
    return 'New entry';
  }

  /// Localizes the label
  /// ```dart
  /// 'Existing entry'
  /// ```
  /// * default is english (en)
  String groupSelectedSheetCubitOptionExistingEntry() {
    if (languageLocale == 'de') return 'Existierender Eintrag';
    return 'Existing entry';
  }

  /// Localizes the label
  /// ```dart
  /// 'Subgroup'
  /// ```
  /// * default is english (en)
  String groupSelectedSheetCubitOptionSubgroup() {
    if (languageLocale == 'de') return 'Untergruppe';
    return 'Subgroup';
  }

  /// Localizes the label
  /// ```dart
  /// 'Chart'
  /// ```
  /// * default is english (en)
  String groupSelectedSheetCubitOptionChart() {
    if (languageLocale == 'de') return 'Statistik';
    return 'Chart';
  }

  //-----------------------------------------------
  //---------------- Create Shared Group Sheet ----
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Create shared group'
  /// ```
  /// * default is english (en)
  String createSharedGroupSheetTitle() {
    if (languageLocale == 'de') return 'Geteilte Gruppe erstellen';
    return 'Create shared group';
  }

  /// Localizes the label
  /// ```dart
  /// 'open writes'
  /// ```
  /// * default is english (en)
  String createSharedGroupSheetOpenWrites() {
    if (languageLocale == 'de') return 'Freies hinzufügen';
    return 'open writes';
  }

  /// Localizes the label
  /// ```dart
  /// return openWrites ? 'everyone can add and change entries' : 'only you can add and change entries';
  /// ```
  /// * default is english (en)
  String createSharedGroupSheetOpenWritesInfo({required bool openWrites}) {
    if (languageLocale == 'de') return openWrites ? 'Jeder kann Einträge hinzufügen und bearbeiten.' : 'Nur du kannst Einträge hinzufügen und bearbeiten.';
    return openWrites ? 'everyone can add and change entries' : 'only you can add and change entries';
  }

  /// Localizes the label
  /// ```dart
  /// 'Access pin (optional)'
  /// ```
  /// * default is english (en)
  String createSharedGroupSheetAccessPin() {
    if (languageLocale == 'de') return 'Zugangspin';
    return 'Access pin';
  }

  /// Localizes the label
  /// ```dart
  /// 'Set this to restrict access to this shared group.'
  /// ```
  /// * default is english (en)
  String createSharedGroupSheetAccessPinInfo() {
    if (languageLocale == 'de') return 'Verwende dies um den Zugang zu dieser geteilten Gruppe einzuschränken.';
    return 'Set this to restrict access to this shared group.';
  }

  /// Localizes the label
  /// ```dart
  /// 'share group'
  /// ```
  /// * default is english (en)
  String createSharedGroupSheetShareGroup() {
    if (languageLocale == 'de') return 'Gruppe teilen';
    return 'share group';
  }

  //-----------------------------------------------
  //---------------- Shared Group -------------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Delete group?'
  /// ```
  /// * default is english (en)
  String sharedGroupDeleteGroupTitle() {
    if (languageLocale == 'de') return 'Gruppe wirklich löschen?';
    return 'Delete group?';
  }

  /// Localizes the label
  /// ```dart
  /// 'Group and contents will be deleted for everyone.'
  /// ```
  /// * default is english (en)
  String sharedGroupDeleteGroupSubtitle() {
    if (languageLocale == 'de') return 'Gruppe und deren Inhalt wird für alle gelöscht.\n\nDies kann nicht rückgängig gemacht werden.';
    return 'Group and contents will be deleted for everyone.\n\nThis cannot be undone.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Leave group?'
  /// ```
  /// * default is english (en)
  String sharedGroupLeaveGroup() {
    if (languageLocale == 'de') return 'Gruppe verlassen?';
    return 'Leave group?';
  }

  /// Localizes the label
  /// ```dart
  /// 'This will store all Entries of this Group on our servers'
  /// ```
  /// * default is english (en)
  String shareInfoSheetEntriesInfo() {
    if (languageLocale == 'de') return 'Dies wird alle Einträge dieser Gruppe auf unseren Servern speichern';
    return 'This will store all Entries of this Group on our servers';
  }

  /// Localizes the label
  /// ```dart
  /// 'This will store all Entries of this Group on our servers'
  /// ```
  /// * default is english (en)
  String shareInfoSheetEntryModelInfo() {
    if (languageLocale == 'de') return 'Dies wird alle Eintragsvorlagen dieser Einträge auf unseren Servern speichern';
    return 'This will store all Entry Models of these Entries on our servers';
  }

  /// Localizes the label
  /// ```dart
  /// 'You can choose who can add or delete Entries before shareing'
  /// ```
  /// * default is english (en)
  String shareInfoSheetAddAndDeleteChoice() {
    if (languageLocale == 'de') return 'Vor dem Teilen kannst du festlegen wer Einträge hinzufügen und löschen kann';
    return 'You can choose who can add and delete Entries before shareing';
  }

  /// Localizes the label
  /// ```dart
  /// 'You can set an optional access pin before shareing'
  /// ```
  /// * default is english (en)
  String shareInfoSheetAccessPin() {
    if (languageLocale == 'de') return 'Vor dem Teilen kann optional eine Zugangspin festgelegt werden';
    return 'You can set an optional access pin before shareing';
  }

  /// Localizes the label
  /// ```dart
  /// 'don't show again'
  /// ```
  /// * default is english (en)
  String shareInfoSheetDontShowAgain() {
    if (languageLocale == 'de') return 'nicht mehr anzeigen';
    return 'don\'t show again';
  }

  /// Localizes the label
  /// ```dart
  /// 'Got it, next step'
  /// ```
  /// * default is english (en)
  String shareInfoSheetPositiveButtonLabel() {
    if (languageLocale == 'de') return 'Alles klar, nächster Schritt';
    return 'Got it, next step';
  }

  /// Localizes the label
  /// ```dart
  /// 'cancle'
  /// ```
  /// * default is english (en)
  String shareInfoSheetCancle() {
    if (languageLocale == 'de') return 'abbrechen';
    return 'cancle';
  }

  //-----------------------------------------------
  //---------------- Add Entries to Group Sheet Labels
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'add entries to $groupName'
  /// ```
  /// * default is english (en)
  String addEntriesToGroupSheetTitle({required String groupName}) {
    if (languageLocale == 'de') return 'Einträge zu $groupName hinzufügen';
    return 'add entries to $groupName';
  }

  /// Localizes the label
  /// ```dart
  /// 'all your entries are already in this group'
  /// ```
  /// * default is english (en)
  String addEntriesToGroupSheetEmptyEntriesMessage() {
    if (languageLocale == 'de') return 'Alle Einträge sind bereits in dieser Gruppe';
    return 'all your entries are already in this group';
  }

  /// Localizes the label
  /// ```dart
  /// 'add to group'
  /// ```
  /// * default is english (en)
  String addEntriesToGroupSheetAddToGroup() {
    if (languageLocale == 'de') return 'zu Gruppe hinzufügen';
    return 'add to group';
  }

  //-----------------------------------------------
  //---------------- Add Entries to Group Sheet Cubit Labels
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'entry deleted'
  /// ```
  /// * default is english (en)
  String addEntriesToGroupSheetCubitEntryDeleted() {
    if (languageLocale == 'de') return 'Eintrag gelöscht';
    return 'entry deleted';
  }

  /// Localizes the label
  /// ```dart
  /// 'added to $groupName'
  /// ```
  /// * default is english (en)
  String addEntriesToGroupSheetCubitEntryAddedNotification({required String groupName}) {
    if (languageLocale == 'de') return 'zu $groupName hinzugefügt';
    return 'added to $groupName';
  }

  //-----------------------------------------------
  //--------------- Settings Sheet Cubit ----------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'pin set';
  /// ```
  /// * default is english (en)
  String settingsSheetCubitPinSetNotification() {
    if (languageLocale == 'de') return 'Pin erstellt';
    return 'pin set';
  }

  //-----------------------------------------------
  //--------------- Settings Sheet ----------------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'appearance'
  /// ```
  /// * default is english (en)
  String settingsSheetAppearance() {
    if (languageLocale == 'de') return 'Erscheinungsbild';
    return 'appearance';
  }

  /// Localizes the label
  /// ```dart
  /// 'settings'
  /// ```
  /// * default is english (en)
  String settingsSheetSettings() {
    if (languageLocale == 'de') return 'Einstellungen';
    return 'settings';
  }

  /// Localizes the label
  /// ```dart
  /// 'Language: $language'
  /// ```
  /// * default is english (en)
  String settingsSheetLanguage({required String language}) {
    if (languageLocale == 'de') return 'Sprache: $language';
    return 'Language: $language';
  }

  /// Localizes the label
  /// ```dart
  /// 'use this to change the language of this app'
  /// ```
  /// * default is english (en)
  String settingsSheetLanguageInfoMessage() {
    if (languageLocale == 'de') return 'Verändere die Anzeigesprache der App';
    return 'Use this to change the language of this app';
  }

  /// Localizes the label
  /// ```dart
  /// 'max $numberOfLines lines'
  /// ```
  /// * default is english (en)
  String settingsSheetMaxTextFieldLines({required int numberOfLines}) {
    if (languageLocale == 'de') return 'Maximal $numberOfLines Zeilen';
    return 'Max $numberOfLines lines';
  }

  /// Localizes the label
  /// ```dart
  /// 'this is the number of lines which will be visible if a text field is not one lined while creating or editing an entry'
  /// ```
  /// * default is english (en)
  String settingsSheetMaxTextFieldLinesInfoMessage() {
    if (languageLocale == 'de') return 'Verändert die Anzahl der sichtbaren Zeilen für Textfelder, beim erstellen oder bearbeiten eines Eintrags, sofern diese nicht als Einzeiler deklariert sind';
    return 'This is the number of lines which will be visible if a text field is not one lined while creating or editing an entry';
  }

  /// Localizes the label
  /// ```dart
  /// '$numberOfLines lines'
  /// ```
  /// * default is english (en)
  String settingsSheetMaxTextFieldPickerLabel({required int numberOfLines}) {
    if (languageLocale == 'de') return '$numberOfLines Zeilen';
    return '$numberOfLines Lines';
  }

  /// Localizes the language depending on ```locale``` input.
  /// ```dart
  /// if (locale == 'de') return 'Deutsch';
  /// return 'English';
  /// ```
  /// * default is english
  String settingsSheetLanguagePickerLabel({required String locale}) {
    if (locale == 'de') return 'Deutsch';
    return 'English';
  }

  /// Localizes the label
  /// ```dart
  /// 'notifications are visible for $durationInSeconds seconds'
  /// ```
  /// * default is english (en)
  String settingsSheetNotificationDuration({required int durationInSeconds}) {
    if (languageLocale == 'de') return 'Sichtbar für $durationInSeconds Sekunden';
    return 'Visible for $durationInSeconds seconds';
  }

  /// Localizes the label
  /// ```dart
  /// 'this indicates the amount of time for which notifications about app specific events (for example entry deletion or entry updates) are displayed'
  /// ```
  /// * default is english (en)
  String settingsSheetNotificationDurationInfoMessage() {
    if (languageLocale == 'de') return 'Gibt die Zeit in Sekunden an, für die App spezifische Benachrichtigungen angezeigt werden';
    return 'This indicates the amount of time for which notifications about app specific events (for example entry deletion or entry updates) are displayed';
  }

  /// Localizes the label
  /// ```dart
  /// '$durationInSeconds seconds'
  /// ```
  /// * default is english (en)
  String settingsSheetNotificationDurationPickerLabel({required int durationInSeconds}) {
    if (languageLocale == 'de') return '$durationInSeconds Sekunden';
    return '$durationInSeconds seconds';
  }

  /// Localizes the label
  /// ```dart
  /// 'security'
  /// ```
  /// * default is english (en)
  String settingsSheetSecurity() {
    if (languageLocale == 'de') return 'Sicherheit';
    return 'Security';
  }

  /// Localizes the label
  /// ```dart
  /// 'after $autoLogoutInMinutes minutes'
  /// ```
  /// * default is english (en)
  String settingsSheetAutoLogoutAfter({required int autoLogoutInMinutes}) {
    if (languageLocale == 'de') return 'Nach $autoLogoutInMinutes Minuten';
    return 'After $autoLogoutInMinutes minutes';
  }

  /// Localizes the label
  /// ```dart
  /// 'this indicates the duration after which access password is required again'
  /// ```
  /// * default is english (en)
  String settingsSheetAutoLogoutAfterInfoMessage() {
    if (languageLocale == 'de') return 'Legt fest nach wie vielen Minuten das Zugangspasswort für geschützte Gruppen erneut eingegeben werden muss.\n\nDie Zeit beginnt von neuem, wenn mit der App interagiert wird.';
    return 'This indicates the duration after which access password for protected groups is required again.\n\nThe duration will be resetted whenever an interaction with the app occurs.';
  }

  /// Localizes the label
  /// ```dart
  /// '$autoLogoutInMinutes minutes'
  /// ```
  /// * default is english (en)
  String settingsSheetAutoLogoutPickerLabel({required int autoLogoutInMinutes}) {
    if (languageLocale == 'de') return '$autoLogoutInMinutes Minuten';
    return '$autoLogoutInMinutes minutes';
  }

  //-----------------------------------------------
  //--------------- Select Option Sheet -----------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'close'
  /// ```
  /// * default is english (en)
  String selectOptionSheetClose() {
    if (languageLocale == 'de') return 'Schließen';
    return 'Close';
  }

  //-----------------------------------------------
  //--------------- Picker Items ------------------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Amber'
  /// ```
  /// * default is english (en)
  String pickerItemsColorAmber() {
    if (languageLocale == 'de') return 'Bernstein';
    return 'Amber';
  }

  /// Localizes the label
  /// ```dart
  /// 'Green'
  /// ```
  /// * default is english (en)
  String pickerItemsColorGreen() {
    if (languageLocale == 'de') return 'Grün';
    return 'Green';
  }

  /// Localizes the label
  /// ```dart
  /// 'Blue-grey'
  /// ```
  /// * default is english (en)
  String pickerItemsColorBlueGrey() {
    if (languageLocale == 'de') return 'Blaugrau';
    return 'Blue-grey';
  }

  /// Localizes the label
  /// ```dart
  /// 'Red'
  /// ```
  /// * default is english (en)
  String pickerItemsColorRed() {
    if (languageLocale == 'de') return 'Rot';
    return 'Red';
  }

  /// Localizes the label
  /// ```dart
  /// 'Purple'
  /// ```
  /// * default is english (en)
  String pickerItemsColorPurple() {
    if (languageLocale == 'de') return 'Lila';
    return 'Purple';
  }

  /// Localizes the label
  /// ```dart
  /// 'Deep purple'
  /// ```
  /// * default is english (en)
  String pickerItemsColorDeepPurple() {
    if (languageLocale == 'de') return 'Dunkellila';
    return 'Deep purple';
  }

  /// Localizes the label
  /// ```dart
  /// 'Orange'
  /// ```
  /// * default is english (en)
  String pickerItemsColorOrange() {
    if (languageLocale == 'de') return 'Orange';
    return 'Orange';
  }

  /// Localizes the label
  /// ```dart
  /// 'Deep orange'
  /// ```
  /// * default is english (en)
  String pickerItemsColorDeepOrange() {
    if (languageLocale == 'de') return 'Dunkelorange';
    return 'Deep orange';
  }

  /// Localizes the label
  /// ```dart
  /// 'Black'
  /// ```
  /// * default is english (en)
  String pickerItemsColorBlack() {
    if (languageLocale == 'de') return 'Schwarz';
    return 'Black';
  }

  /// Localizes the label
  /// ```dart
  /// 'Brown'
  /// ```
  /// * default is english (en)
  String pickerItemsColorBrown() {
    if (languageLocale == 'de') return 'Braun';
    return 'Brown';
  }

  /// Localizes the label
  /// ```dart
  /// 'White'
  /// ```
  /// * default is english (en)
  String pickerItemsColorWhite() {
    if (languageLocale == 'de') return 'Weiss';
    return 'White';
  }

  /// Localizes the label
  /// ```dart
  /// 'Teal'
  /// ```
  /// * default is english (en)
  String pickerItemsColorTeal() {
    if (languageLocale == 'de') return 'Aquamarin';
    return 'Teal';
  }

  /// Localizes the label
  /// ```dart
  /// 'Blue'
  /// ```
  /// * default is english (en)
  String pickerItemsColorBlue() {
    if (languageLocale == 'de') return 'Blau';
    return 'Blue';
  }

  /// Localizes the label
  /// ```dart
  /// 'Pink'
  /// ```
  /// * default is english (en)
  String pickerItemsColorPink() {
    if (languageLocale == 'de') return 'Rosa';
    return 'Pink';
  }

  /// Localizes the label
  /// ```dart
  /// 'Cyan'
  /// ```
  /// * default is english (en)
  String pickerItemsColorCyan() {
    if (languageLocale == 'de') return 'Zyan';
    return 'Cyan';
  }

  /// Localizes the label
  /// ```dart
  /// 'Lime'
  /// ```
  /// * default is english (en)
  String pickerItemsColorLime() {
    if (languageLocale == 'de') return 'Neongrün';
    return 'Lime';
  }

  /// Localizes the label
  /// ```dart
  /// 'Indigo'
  /// ```
  /// * default is english (en)
  String pickerItemsColorIndigo() {
    if (languageLocale == 'de') return 'Indigo';
    return 'Indigo';
  }

  /// Localizes the label
  /// ```dart
  /// 'Light blue'
  /// ```
  /// * default is english (en)
  String pickerItemsColorLightBlue() {
    if (languageLocale == 'de') return 'Hellblau';
    return 'Light blue';
  }

  /// Localizes the label
  /// ```dart
  /// 'Light Green'
  /// ```
  /// * default is english (en)
  String pickerItemsColorLightGreen() {
    if (languageLocale == 'de') return 'Hellgrün';
    return 'Light green';
  }

  /// Localizes the label
  /// ```dart
  /// 'Yellow'
  /// ```
  /// * default is english (en)
  String pickerItemsColorYellow() {
    if (languageLocale == 'de') return 'Gelb';
    return 'Yellow';
  }

  /// Localizes the label
  /// ```dart
  /// 'Light Pink'
  /// ```
  /// * default is english (en)
  String pickerItemsColorLightPink() {
    if (languageLocale == 'de') return 'Hellrosa';
    return 'Light Pink';
  }

  /// Localizes the label
  /// ```dart
  /// 'Light purple'
  /// ```
  /// * default is english (en)
  String pickerItemsColorLightPurple() {
    if (languageLocale == 'de') return 'Hellpurpur';
    return 'Light purple';
  }

  /// Localizes the label
  /// ```dart
  /// 'Light red'
  /// ```
  /// * default is english (en)
  String pickerItemsColorLightRed() {
    if (languageLocale == 'de') return 'Hellrot';
    return 'Light red';
  }

  /// Localizes the label
  /// ```dart
  /// 'Light orange'
  /// ```
  /// * default is english (en)
  String pickerItemsColorLightOrange() {
    if (languageLocale == 'de') return 'Hellorange';
    return 'Light orange';
  }

  /// Localizes the label
  /// ```dart
  /// 'Light teal'
  /// ```
  /// * default is english (en)
  String pickerItemsColorLightTeal() {
    if (languageLocale == 'de') return 'Hell Aquamarin';
    return 'Light teal';
  }

  /// Localizes the label
  /// ```dart
  /// 'Light brown'
  /// ```
  /// * default is english (en)
  String pickerItemsColorLightBrown() {
    if (languageLocale == 'de') return 'Hellbraun';
    return 'Light brown';
  }

  /// Localizes the label
  /// ```dart
  /// 'Magenta'
  /// ```
  /// * default is english (en)
  String pickerItemsColorMagenta() {
    if (languageLocale == 'de') return 'Magenta';
    return 'Magenta';
  }

  /// Localizes the label
  /// ```dart
  /// 'Chartreuse'
  /// ```
  /// * default is english (en)
  String pickerItemsColorChartreuse() {
    if (languageLocale == 'de') return 'Gelbgrün';
    return 'Chartreuse';
  }

  /// Localizes the label
  /// ```dart
  /// 'Navy'
  /// ```
  /// * default is english (en)
  String pickerItemsColorNavy() {
    if (languageLocale == 'de') return 'Marineblau';
    return 'Navy';
  }

  /// Localizes the label
  /// ```dart
  /// 'Olive'
  /// ```
  /// * default is english (en)
  String pickerItemsColorOlive() {
    if (languageLocale == 'de') return 'Olivegrün';
    return 'Olive';
  }

  //-----------------------------------------------
  //--------------- Picker Sheet ------------------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'ready'
  /// ```
  /// * default is english (en)
  String pickerSheetConfirm() {
    if (languageLocale == 'de') return 'Fertig';
    return 'Ready';
  }

  //-----------------------------------------------
  //--------------- Set Notification State Labels -
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'never'
  /// ```
  /// * default is english (en)
  String setNotificationStatePickerRepeatNeverLabel() {
    if (languageLocale == 'de') return 'Nie';
    return 'Never';
  }

  /// Localizes the label
  /// ```dart
  /// 'every year'
  /// ```
  /// * default is english (en)
  String setNotificationStatePickerRepeatEveryYearLabel() {
    if (languageLocale == 'de') return 'Jedes Jahr';
    return 'Every year';
  }

  /// Localizes the label
  /// ```dart
  /// 'every month'
  /// ```
  /// * default is english (en)
  String setNotificationStatePickerRepeatEveryMonthLabel() {
    if (languageLocale == 'de') return 'Jeden Monat';
    return 'Every month';
  }

  /// Localizes the label
  /// ```dart
  /// 'every week'
  /// ```
  /// * default is english (en)
  String setNotificationStatePickerRepeatEveryWeekLabel() {
    if (languageLocale == 'de') return 'Jede Woche';
    return 'Every week';
  }

  /// Localizes the label
  /// ```dart
  /// 'every day'
  /// ```
  /// * default is english (en)
  String setNotificationStatePickerRepeatEveryDayLabel() {
    if (languageLocale == 'de') return 'Jeden Tag';
    return 'Every day';
  }

  //-----------------------------------------------
  //--------------- Set Notification Sheet --------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'close'
  /// ```
  /// * default is english (en)
  String setNotificationPageFailureButtonLabel() {
    if (languageLocale == 'de') return 'Schließen';
    return 'Close';
  }

  /// Localizes the label
  /// ```dart
  /// 'notify on'
  /// ```
  /// * default is english (en)
  String setNotificationSheetOnLabel() {
    if (languageLocale == 'de') return 'Benachrichtigen am';
    return 'Notify on';
  }

  /// Localizes the label
  /// ```dart
  /// 'repeat'
  /// ```
  /// * default is english (en)
  String setNotificationSheetRepeatLabel() {
    if (languageLocale == 'de') return 'Wiederholen';
    return 'Repeat';
  }

  /// Localizes the label
  /// ```dart
  /// 'Notification title'
  /// ```
  /// * default is english (en)
  String setNotificationSheetNotificationTitle() {
    if (languageLocale == 'de') return 'Titel';
    return 'Notification title';
  }

  /// Localizes the label
  /// ```dart
  /// 'notification message'
  /// ```
  /// * default is english (en)
  String setNotificationSheetNotificationBody() {
    if (languageLocale == 'de') return 'Nachricht';
    return 'Notification message';
  }

  /// Localizes the label
  /// ```dart
  /// 'next notification'
  /// ```
  /// * default is english (en)
  String setNotificationSheetNextNotificationLabel() {
    if (languageLocale == 'de') return 'Nächste Benachrichtigung';
    return 'Next notification';
  }

  /// Localizes the label
  /// ```dart
  /// '(YYYY-MM-DD)'
  /// ```
  /// * default is english (en)
  String setNotificationSheetNextNotificationDateFormatLabel() {
    if (languageLocale == 'de') return '(JJJJ-MM-TT)';
    return '(YYYY-MM-DD)';
  }

  /// Localizes the label
  /// ```dart
  /// ' at $time'
  /// ```
  /// * default is english (en)
  String setNotificationSheetNextNotificationAtLabel({required String time}) {
    if (languageLocale == 'de') return ' um $time';
    return ' at $time';
  }

  /// Localizes the label
  /// ```dart
  /// 'on the'
  /// ```
  /// * default is english (en)
  String setNotificationSheetNextNotificationOnTheLabel() {
    if (languageLocale == 'de') return 'am ';
    return 'on the ';
  }

  /// Localizes the label
  /// ```dart
  /// 'Save'
  /// ```
  /// * default is english (en)
  String setNotificationSheetSaveNotificationLabel() {
    if (languageLocale == 'de') return 'Speichern';
    return 'Save';
  }

  //-----------------------------------------------
  //--------------- Set Notification Cubit Labels -
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'otification scheduled'
  /// ```
  /// * default is english (en)
  String setNotificationSheetNotificationScheduled() {
    if (languageLocale == 'de') return 'Benachrichtigung aktiviert';
    return 'Notification scheduled';
  }

  //-----------------------------------------------
  //--------------- Search Sheet ------------------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Cancel'
  /// ```
  /// * default is english (en)
  String searchSheetCancel() {
    if (languageLocale == 'de') return 'Abbrechen';
    return 'Cancel';
  }

  /// Localizes the label
  /// ```dart
  /// 'Type to search.'
  /// ```
  /// * default is english (en)
  String searchSheetTypeToSearch() {
    if (languageLocale == 'de') return 'Zum suchen tippen.';
    return 'Type to search.';
  }

  /// Localizes the label
  /// ```dart
  /// 'No matching results.'
  /// ```
  /// * default is english (en)
  String searchSheetNoMatchingResults() {
    if (languageLocale == 'de') return 'Keine passende Einträge gefunden.';
    return 'No matching results.';
  }

  //-----------------------------------------------
  //--------------- Group Decision Sheet ----------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Group created'
  /// ```
  /// * default is english (en)
  String groupDecisionSheetGroupCreatedNotification() {
    if (languageLocale == 'de') return 'Gruppe erstellt';
    return 'Group created';
  }

  /// Localizes the label
  /// ```dart
  /// 'Choose group type'
  /// ```
  /// * default is english (en)
  String groupDecisionSheetChooseGroupType() {
    if (languageLocale == 'de') return 'Gruppenmodus auswählen';
    return 'Choose group mode';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Select group';
  /// ```
  /// * default is english (en)
  String groupDecisionSheetTitle() {
    if (languageLocale == 'de') return 'Gruppe auswählen';
    return 'Select group';
  }

  /// Localizes the label
  /// ```dart
  /// return 'No ${isShared ? 'shared' : 'local'} group created yet.\n\nPlease create a ${isShared ? 'shared' : 'local'} group before creating an entry.';
  /// ```
  /// * default is english (en)
  String groupDecisionSheetEmptyGroupsMessage({required bool isShared}) {
    if (languageLocale == 'de') return 'Noch keine ${isShared ? 'geteilte' : 'lokale'} Gruppe erstellt.\n\nBitte erstelle eine ${isShared ? 'geteilte' : 'lokale'} Gruppe vor dem erstellen eines Eintrags.';
    return 'No ${isShared ? 'shared' : 'local'} group created yet.\n\nPlease create a ${isShared ? 'shared' : 'local'} group before creating an entry.';
  }

  /// Localizes the label
  /// ```dart
  /// 'select'
  /// ```
  /// * default is english (en)
  String groupDecisionSheetSelect() {
    if (languageLocale == 'de') return 'Auswählen';
    return 'Select';
  }

  /// Localizes the label
  /// ```dart
  /// 'create group'
  /// ```
  /// * default is english (en)
  String groupDecisionSheetCreateNewGroup() {
    if (languageLocale == 'de') return 'Gruppe erstellen';
    return 'Create group';
  }

  //-----------------------------------------------
  //--------------- Search Sheet Cubit ------------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// '$fieldLabel copied'
  /// ```
  /// * default is english (en)
  String searchSheetCubitCopyNotification({required String label}) {
    if (languageLocale == 'de') return '$label kopiert';
    return '$label copied';
  }

  /// Localizes the label
  /// ```dart
  /// 'entry deleted'
  /// ```
  /// * default is english (en)
  String searchSheetCubitEntryDeletedNotification() {
    if (languageLocale == 'de') return 'Eintrag gelöscht';
    return 'Entry deleted';
  }

  //-----------------------------------------------
  //---------------- List Selector Sheet ----------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'cancel'
  /// ```
  /// * default is english (en)
  String listSelectorSheetCancel() {
    if (languageLocale == 'de') return 'Abbrechen';
    return 'Cancel';
  }

  /// Localizes the label
  /// ```dart
  /// 'no matching results'
  /// ```
  /// * default is english (en)
  String listSelectorSheetNoMatchingResults() {
    if (languageLocale == 'de') return 'Keine passenden Einträge gefunden.';
    return 'No matching results.';
  }

  /// Localizes the label
  /// ```dart
  /// 'unknown item'
  /// ```
  /// * default is english (en)
  String listSelectorSheetUnknownItem() {
    if (languageLocale == 'de') return 'Unbekanntes Element';
    return 'Unknown item';
  }

  //-----------------------------------------------
  //---------------- Licences Sheet ---------------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Try again'
  /// ```
  /// * default is english (en)
  String licencesSheetRetry() {
    if (languageLocale == 'de') return 'Noch einmal versuchen';
    return 'Try again';
  }

  /// Localizes the label
  /// ```dart
  /// 'Licenses'
  /// ```
  /// * default is english (en)
  String licencesSheetTitle() {
    if (languageLocale == 'de') return 'Lizenzen';
    return 'Licenses';
  }

  /// Localizes the label
  /// ```dart
  /// 'Powered by Flutter'
  /// ```
  /// * default is english (en)
  String licencesSheetPoweredByFlutter() {
    if (languageLocale == 'de') return 'Erstellt mit Flutter';
    return 'Powered by Flutter';
  }

  /// Localizes the label
  /// ```dart
  /// return numberOfLicenses == 1 ? '$numberOfLicenses License' : '$numberOfLicenses Licenses';
  /// ```
  /// * default is english (en)
  String licencesSheetNumberOfLicenses({required int numberOfLicenses}) {
    if (languageLocale == 'de') return numberOfLicenses == 1 ? '$numberOfLicenses Lizenz' : '$numberOfLicenses Lizenzen';
    return numberOfLicenses == 1 ? '$numberOfLicenses License' : '$numberOfLicenses Licenses';
  }

  //-----------------------------------------------
  //---------------- Licences Sheet ---------------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'License $license';
  /// ```
  /// * default is english (en)
  String displayLicencesSheetCurrentLicense({required int license}) {
    if (languageLocale == 'de') return 'Lizenz $license';
    return 'License $license';
  }

  //-----------------------------------------------
  //---------------- Contact Support Sheet --------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'try again';
  /// ```
  /// * default is english (en)
  String contactSupportSheetTryAgain() {
    if (languageLocale == 'de') return 'Noch einmal versuchen';
    return 'Try again';
  }

  /// Localizes the label
  /// ```dart
  /// 'Contact Support';
  /// ```
  /// * default is english (en)
  String contactSupportSheetTitle() {
    if (languageLocale == 'de') return 'Support kontaktieren';
    return 'Contact support';
  }

  /// Localizes the label
  /// ```dart
  /// 'We strive to answer support tickets within 48 hours and we will get back to you as soon as possible.\n\nThank you for your patience!';
  /// ```
  /// * default is english (en)
  String contactSupportSheetPledge() {
    if (languageLocale == 'de') return 'Wir geben unser Bestes um Anfragen in weniger als 48 Stunden zu bearbeiten und werden uns so schnell wie möglich melden.\n\nDanke für deine Geduld!';
    return 'We strive to answer support tickets within 48 hours and we will get back to you as soon as possible.\n\nThank you for your patience!';
  }

  /// Localizes the label
  /// ```dart
  /// 'You can reach us here';
  /// ```
  /// * default is english (en)
  String contactSupportSheetEmailTitle() {
    if (languageLocale == 'de') return 'Bitte schreib uns hier';
    return 'You can reach us here';
  }

  /// Localizes the label
  /// ```dart
  /// 'email copied';
  /// ```
  /// * default is english (en)
  String contactSupportSheetEmailNotification() {
    if (languageLocale == 'de') return 'Email kopiert';
    return 'Email copied';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please provide these details';
  /// ```
  /// * default is english (en)
  String contactSupportSheetDetailsTitle() {
    if (languageLocale == 'de') return 'Bitte gib diese Details an';
    return 'Please provide these details';
  }

  /// Localizes the label
  /// ```dart
  /// 'Platform · $platform\nBuild number · $buildNumber\nVersion · $version';
  /// ```
  /// * default is english (en)
  String contactSupportSheetDetails({required String platform, required String buildNumber, required String version}) {
    return 'Platform · $platform\nBuild number · $buildNumber\nVersion · $version';
  }

  /// Localizes the label
  /// ```dart
  /// 'details copied';
  /// ```
  /// * default is english (en)
  String contactSupportSheetDetailsNotification() {
    if (languageLocale == 'de') return 'Details kopiert';
    return 'Details copied';
  }

  //-----------------------------------------------
  //---------------- Menu Sheet -------------------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'entry models'
  /// ```
  /// * default is english (en)
  String menuSheetGridViewTitle() {
    if (languageLocale == 'de') return 'Eintragsvorlagen';
    return 'Model entries';
  }

  /// Localizes the label
  /// ```dart
  /// return 'No ${isShared ? 'shared' : 'local'} ModelEntries created yet.';
  /// ```
  /// * default is english (en)
  String menuSheetEmptyGridViewMessage({required bool isShared}) {
    if (languageLocale == 'de') return 'Noch keine ${isShared ? 'geteilten' : 'lokalen'} Eintragsvorlagen erstellt.';
    return 'No ${isShared ? 'shared' : 'local'} ModelEntries created yet.';
  }

  /// Localizes the label
  /// ```dart
  /// 'entries: $numberOfEntries'
  /// ```
  /// * default is english (en)
  String menuSheetGridViewCardSubtitle({required int numberOfEntries}) {
    if (languageLocale == 'de') return 'Einträge: $numberOfEntries';
    return 'Entries: $numberOfEntries';
  }

  /// Localizes the label
  /// ```dart
  /// 'Create Model entry'
  /// ```
  /// * default is english (en)
  String menuSheetCreateEntryModelButton() {
    if (languageLocale == 'de') return 'Eintragsvorlage erstellen';
    return 'Create model entry';
  }

  /// Localizes the label
  /// ```dart
  /// 'utility'
  /// ```
  /// * default is english (en)
  String menuSheetHeaderUtility() {
    if (languageLocale == 'de') return 'Dienste';
    return 'Utility';
  }

  /// Localizes the label
  /// ```dart
  /// 'Profile'
  /// ```
  /// * default is english (en)
  String menuSheetHeaderProfile() {
    if (languageLocale == 'de') return 'Profil';
    return 'Profile';
  }

  /// Localizes the label
  /// ```dart
  /// 'Change username'
  /// ```
  /// * default is english (en)
  String menuSheetChangeUsername() {
    if (languageLocale == 'de') return 'Benutzername ändern';
    return 'Change username';
  }

  /// Localizes the label
  /// ```dart
  /// return isShared ? 'Welcome $username' : 'Welcome';
  /// ```
  /// * default is english (en)
  String menuSheetWelcomeAppBar({required bool isShared, required String username}) {
    if (languageLocale == 'de') return isShared ? 'Willkommen $username' : 'Willkommen';
    return isShared ? 'Welcome $username' : 'Welcome';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please be aware that you can only change your username once.'
  /// ```
  /// * default is english (en)
  String changeUsernameInfoMessage({required String currentUsername}) {
    if (languageLocale == 'de') return 'Bitte beachte, dass du deinen Benutzernamen nur einmal ändern kannst.\n\nBenutzernamen müssen den Nutzervereinbarungen entsprechen.\n\n\nDerzeitiger Username:\n\n$currentUsername';
    return 'Please be aware that you can only change your username once.\n\nUsernames need to conform to the user agreement.\n\n\nCurrent username:\n\n$currentUsername';
  }

  /// Localizes the label
  /// ```dart
  /// 'Your current username is:\n\n$username';
  /// ```
  /// * default is english (en)
  String menuSheetChangeUsernameInfoMessage({required String username}) {
    if (languageLocale == 'de') return 'Derzeitiger Benutzername:\n\n$username';
    return 'Your current username is:\n\n$username';
  }

  /// Localizes the label
  /// ```dart
  /// 'Settings'
  /// ```
  /// * default is english (en)
  String menuSheetShowSettingsButton() {
    if (languageLocale == 'de') return 'Einstellungen';
    return 'Settings';
  }

  /// Localizes the label
  /// ```dart
  /// 'Group password'
  /// ```
  /// * default is english (en)
  String menuSheetCreateCustomPassword() {
    if (languageLocale == 'de') return 'App Passwort';
    return 'App password';
  }

  /// Localizes the label
  /// ```dart
  /// 'Use this to create a global app password.\n\nThis enables the ability to encrypt local groups.\n\nPlease consider, that we cannot help if you forget this password!\n\nLoosing this password will result in the loss of all data stored in encrypted groups!'
  /// ```
  /// * default is english (en)
  String menuSheetCreateCustomPasswordInfoMessage() {
    if (languageLocale == 'de') return 'Verwende dies um ein globales Passwort zu erstellen.\n\nDies ermöglicht es beispielsweise lokale Gruppen zu verschlüsseln.\n\nBitte beachte, das wir nicht helfen können wenn dieses Passwort vergessen wird!\n\nDas Vergessen dieses Passwortes bedeutet den Verlust der Daten in verschlüsselten Gruppen!';
    return 'Use this to create a global app password.\n\nThis enables the ability to encrypt local groups.\n\nPlease consider, that we cannot help if you forget this password!\n\nLoosing this password will result in the loss of all data stored in encrypted groups!';
  }

  /// Localizes the label
  /// ```dart
  /// 'Export data'
  /// ```
  /// * default is english (en)
  String menuSheetExportDataButton() {
    if (languageLocale == 'de') return 'Daten exportieren';
    return 'Export data';
  }

  /// Localizes the label
  /// ```dart
  /// 'Import data'
  /// ```
  /// * default is english (en)
  String menuSheetImportDataButton() {
    if (languageLocale == 'de') return 'Daten importieren';
    return 'Import data';
  }

  /// Localizes the label
  /// ```dart
  /// 'Currently the only supported format for importing data is ".csv".'
  /// ```
  /// * default is english (en)
  String menuSheetImportInfoMessage() {
    if (languageLocale == 'de') return 'Derzeit wird nur das Dateiformat ".csv" für den Import unterstützt.';
    return 'Currently the only supported format for importing data is ".csv".';
  }

  /// Localizes the label
  /// ```dart
  /// 'app'
  /// ```
  /// * default is english (en)
  String menuSheetHeaderApp() {
    if (languageLocale == 'de') return 'App';
    return 'App';
  }

  /// Localizes the label
  /// ```dart
  /// 'privacy policy'
  /// ```
  /// * default is english (en)
  String menuSheetPrivacyPolicyButton() {
    if (languageLocale == 'de') return 'Datenschutzrichtlinien';
    return 'Privacy policy';
  }

  /// Localizes the label
  /// ```dart
  /// 'user agreement'
  /// ```
  /// * default is english (en)
  String menuSheetUserAgreementButton() {
    if (languageLocale == 'de') return 'Nutzervereinbarung';
    return 'User agreement';
  }

  /// Localizes the label
  /// ```dart
  /// 'Acknowledgements'
  /// ```
  /// * default is english (en)
  String menuSheetAcknowledgementsButton() {
    if (languageLocale == 'de') return 'Lizenzen';
    return 'Acknowledgements';
  }

  /// Localizes the label
  /// ```dart
  /// 'contact support'
  /// ```
  /// * default is english (en)
  String menuSheetContactSupportButton() {
    if (languageLocale == 'de') return 'Kontakt';
    return 'Contact support';
  }

  /// Localizes the label
  /// ```dart
  /// 'logout'
  /// ```
  /// * default is english (en)
  String menuSheetLogoutButton() {
    if (languageLocale == 'de') return 'Abmelden';
    return 'Logout';
  }

  /// Localizes the label
  /// ```dart
  /// 'logout'
  /// ```
  /// * default is english (en)
  String menuSheetLogoutInfoMessage({required int minutes}) {
    if (languageLocale == 'de') return 'Um das wiederholte Eingeben des Passworts beim Zugriff auf geschützte Gruppen zu vermeiden, merkt sich die Anwendung die letzte Authentifizierung.\n\nPeriodisch (derzeit nach $minutes Minuten) "vergisst" die App dies, um eine erneute Authentifizierung zu erzwingen.\n\nMit diesem Button kann manuell ein "Vergessen"-Ereignis ausgelöst werden.\n\nNach diesem Ereignis ist eine erneute Authentifizierung erforderlich, wenn auf eine geschützte Gruppe zugegriffen wird.';
    return 'In order to not have to repeatedly present the password if protected groups are accessed the application remembers last authentification.\n\nPeriodically (currently after $minutes minutes) the app "forgets" this in order to require reauthentification again.\n\nThis button can be used to manually trigger a "forget" event.\n\nAfter that event a reauthentification is required if a protected group is accessed.';
  }

  //-----------------------------------------------
  //---------------- Menu Sheet Cubit -------------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'entry model created'
  /// ```
  /// * default is english (en)
  String menuSheetCubitEntryModelCreatedNotification() {
    if (languageLocale == 'de') return 'Eintragsvorlage erstellt';
    return 'Entry model created';
  }

  /// Localizes the label
  /// ```dart
  /// 'entry model deleted'
  /// ```
  /// * default is english (en)
  String menuSheetCubitEntryModelDeletedNotification() {
    if (languageLocale == 'de') return 'Eintragsvorlage gelöscht';
    return 'Entry model deleted';
  }

  //-----------------------------------------------
  //---------------- Entry Decision Sheet --------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Select a model entry'
  /// ```
  /// * default is english (en)
  String entryDecisionSheetSelectModelEntryTitle() {
    if (languageLocale == 'de') return 'Eintragsvorlage auswählen';
    return 'Select a model entry';
  }

  /// Localizes the label
  /// ```dart
  /// 'no entry models created yet'
  /// ```
  /// * default is english (en)
  String entryDecisionSheetNoModelsCreated() {
    if (languageLocale == 'de') return 'Noch keine Eintragsvorlagen erstellt.';
    return 'No entry models created yet.';
  }

  /// Localizes the label
  /// ```dart
  /// 'add $entryModelName'
  /// ```
  /// * default is english (en)
  String entryDecisionSheetAddEntryModelButtonLabel({required String entryModelName}) {
    if (languageLocale == 'de') return '$entryModelName erstellen';
    return 'Add $entryModelName';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Create new ${isShared ? 'shared' : 'local'} ModelEntry';
  /// ```
  /// * default is english (en)
  String entryDecisionSheetCreateModelButtonLabel() {
    if (languageLocale == 'de') return 'Eintragsvorlage erstellen';
    return 'Create ModelEntry';
  }

  //-----------------------------------------------
  //---------------- Dentry Decision Sheet Cubit --
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'entry model created'
  /// ```
  /// * default is english (en)
  String entryDecisionSheetCubitModelCreatedNotification() {
    if (languageLocale == 'de') return 'Eintragsvorlage erstellt';
    return 'Entry model created';
  }

  //-----------------------------------------------
  //---------------- Display Entries Sheet --------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'entries starting with $searchCriteria'
  /// ```
  /// * default is english (en)
  String displayEntriesSheetListViewTitle({required String searchCriteria}) {
    if (languageLocale == 'de') return 'Einträge beginnend mit $searchCriteria';
    return 'Entries starting with $searchCriteria';
  }

  /// Localizes the label
  /// ```dart
  /// 'no entries that start with $searchCriteria found'
  /// ```
  /// * default is english (en)
  String displayEntriesSheetEmptyEntriesMessage({required String searchCriteria}) {
    if (languageLocale == 'de') return 'Keine Einträge beginnend mit $searchCriteria gefunden.';
    return 'No entries that start with $searchCriteria found.';
  }

  //-----------------------------------------------
  //---------------- Display Entries Sheet Cubit --------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'entry deleted'
  /// ```
  /// * default is english (en)
  String displayEntriesSheetCubitEntryDeletedNotification() {
    if (languageLocale == 'de') return 'Eintrag gelöscht';
    return 'Entry deleted';
  }

  /// Localizes the label
  /// ```dart
  /// '$label copied'
  /// ```
  /// * default is english (en)
  String displayEntriesSheetCubitCopyToClipboardNotification({required String label}) {
    if (languageLocale == 'de') return '$label kopiert';
    return '$label copied';
  }

  //-----------------------------------------------
  //---------------- Entry Model Selected Sheet Cubit
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// '$fieldLabel copied'
  /// ```
  /// * default is english (en)
  String entryModelSelectedSheetCubitCopyToClipboard({required String label}) {
    if (languageLocale == 'de') return '$label kopiert';
    return '$label copied';
  }

  /// Localizes the label
  /// ```dart
  /// 'Are you sure you want to delete this entry model?'
  /// ```
  /// * default is english (en)
  String entryModelSelectedSheetCubitConfirmTitle() {
    if (languageLocale == 'de') return 'Diese Eintragsvorlage wirklich löschen?';
    return 'Are you sure you want to delete this model entry?';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please note that model entries can only be deleted, if they are not used by an entry.'
  /// ```
  /// * default is english (en)
  String entryModelSelectedSheetCubitConfirmSubtitle() {
    if (languageLocale == 'de') return 'Eintragsvorlagen können nur gelöscht werden wenn diese von keinem Eintrag verwendet werden.';
    return 'Please note that model entries can only be deleted, if they are not used by an entry.';
  }

  /// Localizes the label
  /// ```dart
  /// 'entry deleted'
  /// ```
  /// * default is english (en)
  String entryModelSelectedSheetCubitEntryDeletedNotification() {
    if (languageLocale == 'de') return 'Eintrag gelöscht';
    return 'Entry deleted';
  }

  /// Localizes the label
  /// ```dart
  /// 'Model entry edited'
  /// ```
  /// * default is english (en)
  String entryModelSelectedSheetCubitEntryModelEditedNotification() {
    if (languageLocale == 'de') return 'Eintragsvorlage bearbeitet';
    return 'Model entry edited';
  }

  //-----------------------------------------------
  //---------------- Entry Selected Sheet ---------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Delete entry'
  /// ```
  /// * default is english (en)
  String entrySelectedSheetCubitDeleteEntry() {
    if (languageLocale == 'de') return 'Eintrag löschen';
    return 'Delete entry';
  }

  /// Localizes the label
  /// ```dart
  /// 'Ban user'
  /// ```
  /// * default is english (en)
  String entrySelectedSheetCubitBanUser() {
    if (languageLocale == 'de') return 'User verbannen';
    return 'Ban user';
  }

  /// Localizes the label
  /// ```dart
  /// 'Go to group'
  /// ```
  /// * default is english (en)
  String entrySelectedSheetGoToGroup() {
    if (languageLocale == 'de') return 'Gehe zu Gruppe';
    return 'Go to group';
  }

  /// Localizes the label
  /// ```dart
  /// 'Revoke ban'
  /// ```
  /// * default is english (en)
  String entrySelectedSheetCubitRevokeBan() {
    if (languageLocale == 'de') return 'Bann aufheben';
    return 'Revoke ban';
  }

  /// Localizes the label
  /// ```dart
  /// 'Ban this user?'
  /// ```
  /// * default is english (en)
  String entrySelectedSheetConfirmBanUser() {
    if (languageLocale == 'de') return 'Diesen User verbannen?';
    return 'Ban this user?';
  }

  /// Localizes the label
  /// ```dart
  /// 'They wont be able to view this group or contribute content.'
  /// ```
  /// * default is english (en)
  String entrySelectedSheetConfirmBanUserInfo() {
    if (languageLocale == 'de') return 'Dadurch kann dieser die Gruppe nicht mehr sehen und keine Inhalte erstellen.';
    return 'They wont be able to view this group or contribute content.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Revoke ban?'
  /// ```
  /// * default is english (en)
  String entrySelectedSheetConfirmRevokeBanUser() {
    if (languageLocale == 'de') return 'Verbannung aufheben?';
    return 'Revoke ban?';
  }

  /// Localizes the label
  /// ```dart
  /// 'As a result, this user can see the group again and participate in it.'
  /// ```
  /// * default is english (en)
  String entrySelectedSheetConfirmRevokeBanUserInfo() {
    if (languageLocale == 'de') return 'Dadurch kann dieser die Gruppe wieder sehen und an der Gruppe teilnehmen.';
    return 'As a result, this user can see the group again and participate in it.';
  }

  /// Localizes the label
  /// ```dart
  /// 'back'
  /// ```
  /// * default is english (en)
  String entrySelectedSheetErrorButtonLabel() {
    if (languageLocale == 'de') return 'Zurück';
    return 'Back';
  }

  /// Localizes the label
  /// ```dart
  /// '$modelName created at $date';
  /// ```
  /// * default is english (en)
  String entrySelectedSheetCreatedAt({required String modelName, required String date, required String timezone}) {
    if (languageLocale == 'de') return '$modelName erstellt am $date ($timezone)';
    return '$modelName created at $date ($timezone)';
  }

  /// Localizes the label
  /// ```dart
  /// return '$date ($timezone)';
  /// ```
  /// * default is english (en)
  String basicLabelsDateTimeAndTimezone({required String date, required String timezone}) {
    if (languageLocale == 'de') return '$date\n(Zeitzone • $timezone)';
    return '$date\n(Timezone • $timezone)';
  }

  /// Localizes the label
  /// ```dart
  /// '$fieldLabel copied'
  /// ```
  /// * default is english (en)
  String entrySelectedSheetCopyWith({required String fieldLabel}) {
    if (languageLocale == 'de') return '$fieldLabel kopiert';
    return '$fieldLabel copied';
  }

  /// Localizes the label
  /// ```dart
  /// 'latitude copied'
  /// ```
  /// * default is english (en)
  String entrySelectedSheetCopyLatitude() {
    if (languageLocale == 'de') return 'Breitengrad kopiert';
    return 'Latitude copied';
  }

  /// Localizes the label
  /// ```dart
  /// 'try again'
  /// ```
  /// * default is english (en)
  String entrySelectedSheetTryLoadingImagesAgain() {
    if (languageLocale == 'de') return 'Noch einmal versuchen';
    return 'Try again';
  }

  /// Localizes the label
  /// ```dart
  /// 'try again'
  /// ```
  /// * default is english (en)
  String entrySelectedSheetTryLoadingTagsAgain() {
    if (languageLocale == 'de') return 'Noch einmal versuchen';
    return 'Try again';
  }

  /// Localizes the label
  /// ```dart
  /// 'latitude'
  /// ```
  /// * default is english (en)
  String entrySelectedSheetLatitude() {
    if (languageLocale == 'de') return 'Breitengrad';
    return 'Latitude';
  }

  /// Localizes the label
  /// ```dart
  /// 'longitude copied'
  /// ```
  /// * default is english (en)
  String entrySelectedSheetCopyLongitude() {
    if (languageLocale == 'de') return 'Längengrad kopiert';
    return 'Longitude copied';
  }

  /// Localizes the label
  /// ```dart
  /// 'longitude'
  /// ```
  /// * default is english (en)
  String entrySelectedSheetLongitude() {
    if (languageLocale == 'de') return 'Längengrad';
    return 'Longitude';
  }

  /// Localizes the label
  /// ```dart
  /// '+ $value'
  /// ```
  /// * default is english (en)
  String entrySelectedQuickActionAdd({required String value}) {
    if (languageLocale == 'de') return '+ $value';
    return '+ $value';
  }

  /// Localizes the label
  /// ```dart
  /// '- $value'
  /// ```
  /// * default is english (en)
  String entrySelectedQuickActionSubtract({required String value}) {
    if (languageLocale == 'de') return '- $value';
    return '- $value';
  }

  /// Localizes the label
  /// ```dart
  /// 'invert'
  /// ```
  /// * default is english (en)
  String entrySelectedQuickActionInvert() {
    if (languageLocale == 'de') return 'Invertieren';
    return 'Invert';
  }

  /// Localizes the label
  /// ```dart
  /// 'done'
  /// ```
  /// * default is english (en)
  String entrySelectedDefaultQuickActionNotification() {
    if (languageLocale == 'de') return 'Fertig';
    return 'Done';
  }

  /// Localizes the label
  /// ```dart
  /// 'added'
  /// ```
  /// * default is english (en)
  String entrySelectedAddedQuickActionNotification() {
    if (languageLocale == 'de') return 'Addiert';
    return 'Added';
  }

  /// Localizes the label
  /// ```dart
  /// 'subtracted'
  /// ```
  /// * default is english (en)
  String entrySelectedSubtractedQuickActionNotification() {
    if (languageLocale == 'de') return 'Subtrahiert';
    return 'Subtracted';
  }

  /// Localizes the label
  /// ```dart
  /// 'inverted'
  /// ```
  /// * default is english (en)
  String entrySelectedInvertedQuickActionNotification() {
    if (languageLocale == 'de') return 'Invertiert';
    return 'Inverted';
  }

  /// Localizes the label
  /// ```dart
  /// 'set as entry preview copy'
  /// ```
  /// * default is english (en)
  String entrySelectedSetAsEntryPreviewCopy() {
    if (languageLocale == 'de') return 'Als Kopiervariable festlegen';
    return 'Set as entry preview copy';
  }

  /// Localizes the label
  /// ```dart
  /// 'Remove thirdline'
  /// ```
  /// * default is english (en)
  String entrySelectedRemoveThirdline() {
    if (languageLocale == 'de') return 'Drittzeile entfernen';
    return 'Remove thirdline';
  }

  /// Localizes the label
  /// ```dart
  /// 'Remove subtitle'
  /// ```
  /// * default is english (en)
  String entrySelectedRemoveSubtitle() {
    if (languageLocale == 'de') return 'Untertitel entfernen';
    return 'Remove subtitle';
  }

  /// Localizes the label
  /// ```dart
  /// 'Thirdline removed'
  /// ```
  /// * default is english (en)
  String entrySelectedRemoveThirdlineNotification() {
    if (languageLocale == 'de') return 'Drittzeile entfernt';
    return 'Thirdline removed';
  }

  /// Localizes the label
  /// ```dart
  /// 'Subtitle removed'
  /// ```
  /// * default is english (en)
  String entrySelectedRemoveSubtitleNotification() {
    if (languageLocale == 'de') return 'Untertitel entfernt';
    return 'Subtitle removed';
  }

  /// Localizes the label
  /// ```dart
  /// 'set as entry preview subtitle'
  /// ```
  /// * default is english (en)
  String entrySelectedSetAsEntryPreviewSubtitle() {
    if (languageLocale == 'de') return 'Als Untertitel festlegen';
    return 'Set as entry preview subtitle';
  }

  /// Localizes the label
  /// ```dart
  /// 'set as entry preview third line'
  /// ```
  /// * default is english (en)
  String entrySelectedSetAsEntryPreviewThirdline() {
    if (languageLocale == 'de') return 'Als Drittzeile festlegen';
    return 'Set as entry preview third line';
  }

  /// Localizes the label
  /// ```dart
  /// 'Set a notification'
  /// ```
  /// * default is english (en)
  String entrySelectedSetNotificationOption() {
    if (languageLocale == 'de') return 'Benachrichtigung anlegen';
    return 'Set a notification';
  }

  /// Localizes the label
  /// ```dart
  /// 'done'
  /// ```
  /// * default is english (en)
  String entrySelectedDefaultOptionsNotification() {
    if (languageLocale == 'de') return 'Fertig';
    return 'Done';
  }

  /// Localizes the label
  /// ```dart
  /// 'set as copy value'
  /// ```
  /// * default is english (en)
  String entrySelectedCopyOptionNotification({required String fieldLabel}) {
    if (languageLocale == 'de') return '$fieldLabel als Kopievariable festgelegt';
    return '$fieldLabel set as copy value';
  }

  /// Localizes the label
  /// ```dart
  /// 'set as subtitle'
  /// ```
  /// * default is english (en)
  String entrySelectedSubtitleOptionNotification({required String fieldLabel}) {
    if (languageLocale == 'de') return '$fieldLabel als Untertitel festgelegt';
    return '$fieldLabel set as subtitle';
  }

  /// Localizes the label
  /// ```dart
  /// 'set as thirdline'
  /// ```
  /// * default is english (en)
  String entrySelectedThirdlineOptionNotification({required String fieldLabel}) {
    if (languageLocale == 'de') return '$fieldLabel als Drittzeile festgelegt';
    return '$fieldLabel set as thirdline';
  }

  /// Localizes the label
  /// ```dart
  /// 'groups'
  /// ```
  /// * default is english (en)
  String entrySelectedSheetGroups() {
    if (languageLocale == 'de') return 'Gruppen';
    return 'Groups';
  }

  /// Localizes the label
  /// ```dart
  /// 'This entry is not in any groups yet.'
  /// ```
  /// * default is english (en)
  String entrySelectedSheetGroupsEmptyMessage() {
    if (languageLocale == 'de') return 'Dieser Eintrag ist in keiner Gruppe.';
    return 'This entry is not in any groups yet.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Select group'
  /// ```
  /// * default is english (en)
  String entrySelectedSheetSelectGroup() {
    if (languageLocale == 'de') return 'Gruppe auswählen';
    return 'Select group';
  }

  /// Localizes the label
  /// ```dart
  /// 'Tags'
  /// ```
  /// * default is english (en)
  String entrySelectedSheetTags() {
    if (languageLocale == 'de') return 'Tags';
    return 'Tags';
  }

  /// Localizes the label
  /// ```dart
  /// 'Are you sure that you want to delete this entry?'
  /// ```
  /// * default is english (en)
  String entrySelectedSheetConfirmDeleteTitle() {
    if (languageLocale == 'de') return 'Diesen Eintrag wirklich löschen?';
    return 'Are you sure that you want to delete this entry?';
  }

  /// Localizes the label
  /// ```dart
  /// 'This will also delete all notifications of this entry.'
  /// ```
  /// * default is english (en)
  String entrySelectedSheetConfirmDeleteSubtitle() {
    if (languageLocale == 'de') return 'Dies löscht auch alle Benachrichtigungen dieses Eintrags.';
    return 'This will also delete all notifications of this entry.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Delete this notification?'
  /// ```
  /// * default is english (en)
  String entrySelectedSheetConfirmDeleteNotification() {
    if (languageLocale == 'de') return 'Benachrichtigung wirklich löschen?';
    return 'Delete this notification?';
  }

  /// Localizes the label
  /// ```dart
  /// 'entry edited'
  /// ```
  /// * default is english (en)
  String entrySelectedSheetEntryEditedNotification() {
    if (languageLocale == 'de') return 'Eintrag bearbeitet';
    return 'Entry edited';
  }

  /// Localizes the label
  /// ```dart
  /// 'entry deleted'
  /// ```
  /// * default is english (en)
  String entrySelectedSheetEntryDeletedNotification() {
    if (languageLocale == 'de') return 'Eintrag gelöscht';
    return 'Entry deleted';
  }

  /// Localizes the label
  /// ```dart
  /// 'edit entry'
  /// ```
  /// * default is english (en)
  String entrySelectedSheetFloatingButtonLabel() {
    if (languageLocale == 'de') return 'Bearbeiten';
    return 'Edit entry';
  }

  /// Localizes the label
  /// ```dart
  /// wantEncryption ? 'decrypt image ${currentImage + 1} of $totalImages' : 'loading image ${currentImage + 1} of $totalImages';
  /// ```
  /// * default is english (en)
  String entrySelectedSheetCubitLoadImages({required int currentImage, required int totalImages, required bool wantEncryption}) {
    if (languageLocale == 'de') return wantEncryption ? 'entschlüssle Bild ${currentImage + 1} von $totalImages' : 'lade Bild ${currentImage + 1} von $totalImages';
    return wantEncryption ? 'decrypt image ${currentImage + 1} of $totalImages' : 'loading image ${currentImage + 1} of $totalImages';
  }

  //-----------------------------------------------
  //--------------- Confirm Sheet Labels ----------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Confirm'
  /// ```
  /// * default is english (en)
  String confirmSheetConfirmButtonLabel() {
    if (languageLocale == 'de') return 'Bestätigen';
    return 'Confirm';
  }

  /// Localizes the label
  /// ```dart
  /// 'Cancel'
  /// ```
  /// * default is english (en)
  String confirmSheetDismissButtonLabel() {
    if (languageLocale == 'de') return 'Abbrechen';
    return 'Cancel';
  }

  //-----------------------------------------------
  //---------------- Password Generator Labels ----
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Password generator'
  /// ```
  /// * default is english (en)
  String passwordGenerator() {
    if (languageLocale == 'de') return 'Passwortgenerator';
    return 'Password generator';
  }

  /// Localizes the label
  /// ```dart
  /// 'options'
  /// ```
  /// * default is english (en)
  String passwordGeneratorOptions() {
    if (languageLocale == 'de') return 'Konfigurationen';
    return 'Options';
  }

  /// Localizes the label
  /// ```dart
  /// 'lower case letters'
  /// ```
  /// * default is english (en)
  String passwordGeneratorLowerCaseLetters() {
    if (languageLocale == 'de') return 'Kleinbuchstaben';
    return 'Lower case letters';
  }

  /// Localizes the label
  /// ```dart
  /// 'upper case letters'
  /// ```
  /// * default is english (en)
  String passwordGeneratorUpperCaseLetters() {
    if (languageLocale == 'de') return 'Großbuchstaben';
    return 'Upper case letters';
  }

  /// Localizes the label
  /// ```dart
  /// 'symbols'
  /// ```
  /// * default is english (en)
  String passwordGeneratorSymbols() {
    if (languageLocale == 'de') return 'Symbole';
    return 'Symbols';
  }

  /// Localizes the label
  /// ```dart
  /// 'numbers'
  /// ```
  /// * default is english (en)
  String passwordGeneratorNumbers() {
    if (languageLocale == 'de') return 'Zahlen';
    return 'Numbers';
  }

  /// Localizes the label
  /// ```dart
  /// 'UUID'
  /// ```
  /// * default is english (en)
  String passwordGeneratorUUID() {
    if (languageLocale == 'de') return 'UUID';
    return 'UUID';
  }

  /// Localizes the label
  /// ```dart
  /// 'password length'
  /// ```
  /// * default is english (en)
  String passwordGeneratorPasswordLength() {
    if (languageLocale == 'de') return 'Passwortlänge';
    return 'Password length';
  }

  /// Localizes the label
  /// ```dart
  /// 'current length: $length'
  /// ```
  /// * default is english (en)
  String passwordGeneratorCurrentPasswordLength({required int length}) {
    if (languageLocale == 'de') return 'Passwortlänge: $length';
    return 'Current length: $length';
  }

  /// Localizes the label
  /// ```dart
  /// 'generate password'
  /// ```
  /// * default is english (en)
  String passwordGeneratorGeneratePassword() {
    if (languageLocale == 'de') return 'Passwort erstellen';
    return 'Generate password';
  }

  /// Localizes the label
  /// ```dart
  /// 'copy this password'
  /// ```
  /// * default is english (en)
  String passwordGeneratorCopyPassword() {
    if (languageLocale == 'de') return 'Dieses Passwort kopieren';
    return 'Copy this password';
  }

  /// Localizes the label
  /// ```dart
  /// 'password copied'
  /// ```
  /// * default is english (en)
  String passwordGeneratorPasswordCopiedNotification() {
    if (languageLocale == 'de') return 'Passwort kopiert';
    return 'Password copied';
  }

  //-----------------------------------------------
  //--------------- Field Labels ------------------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Email';
  /// ```
  /// * default is english (en)
  String fieldTypeEmail() {
    if (languageLocale == 'de') return 'Email';
    return 'Email';
  }

  /// Localizes the label
  /// ```dart
  /// 'username';
  /// ```
  /// * default is english (en)
  String fieldTypeUsername() {
    if (languageLocale == 'de') return 'Username';
    return 'Username';
  }

  /// Localizes the label
  /// ```dart
  /// 'password';
  /// ```
  /// * default is english (en)
  String fieldTypePassword() {
    if (languageLocale == 'de') return 'Passwort';
    return 'Password';
  }

  /// Localizes the label
  /// ```dart
  /// 'phone';
  /// ```
  /// * default is english (en)
  String fieldTypePhone() {
    if (languageLocale == 'de') return 'Telefon';
    return 'Phone';
  }

  /// Localizes the label
  /// ```dart
  /// 'Measurement';
  /// ```
  /// * default is english (en)
  String fieldTypeMeasurement() {
    if (languageLocale == 'de') return 'Messwert';
    return 'Measurement';
  }

  /// Localizes the label
  /// ```dart
  /// 'Emotion';
  /// ```
  /// * default is english (en)
  String fieldTypeEmotion() {
    if (languageLocale == 'de') return 'Emotion';
    return 'Emotion';
  }

  /// Localizes the label
  /// ```dart
  /// 'Avatar Image';
  /// ```
  /// * default is english (en)
  String fieldTypeAvatarImage() {
    if (languageLocale == 'de') return 'Avatar Bild';
    return 'Avatar Image';
  }

  /// Localizes the label
  /// ```dart
  /// 'True/False (Boolean)';
  /// ```
  /// * default is english (en)
  String fieldTypeBoolean() {
    if (languageLocale == 'de') return 'Wahr/Falsch (Boolesch)';
    return 'True/False (Boolean)';
  }

  /// Localizes the label
  /// ```dart
  /// 'Website';
  /// ```
  /// * default is english (en)
  String fieldTypeWebsite() {
    if (languageLocale == 'de') return 'Webseite';
    return 'Website';
  }

  /// Localizes the label
  /// ```dart
  /// 'Text';
  /// ```
  /// * default is english (en)
  String fieldTypeText() {
    if (languageLocale == 'de') return 'Text';
    return 'Text';
  }

  /// Localizes the label
  /// ```dart
  /// 'Number';
  /// ```
  /// * default is english (en)
  String fieldTypeNumber() {
    if (languageLocale == 'de') return 'Zahl';
    return 'Number';
  }

  /// Localizes the label
  /// ```dart
  /// 'Money';
  /// ```
  /// * default is english (en)
  String fieldTypeMoney() {
    if (languageLocale == 'de') return 'Geld';
    return 'Money';
  }

  /// Localizes the label
  /// ```dart
  /// 'Date';
  /// ```
  /// * default is english (en)
  String fieldTypeDate() {
    if (languageLocale == 'de') return 'Datum';
    return 'Date';
  }

  /// Localizes the label
  /// ```dart
  /// 'Time';
  /// ```
  /// * default is english (en)
  String fieldTypeTimeOfDay() {
    if (languageLocale == 'de') return 'Uhrzeit';
    return 'Time';
  }

  /// Localizes the label
  /// ```dart
  /// 'Date and time';
  /// ```
  /// * default is english (en)
  String fieldTypeDateAndTime() {
    if (languageLocale == 'de') return 'Datum und Uhrzeit';
    return 'Date and time';
  }

  /// Localizes the label
  /// ```dart
  /// 'Selector';
  /// ```
  /// * default is english (en)
  String fieldTypeSelector() {
    if (languageLocale == 'de') return 'Auswahl';
    return 'Selector';
  }

  /// Localizes the label
  /// ```dart
  /// 'Model entry';
  /// ```
  /// * default is english (en)
  String fieldTypeEntryModelReference() {
    if (languageLocale == 'de') return 'Eintragsvorlage';
    return 'Model entry';
  }

  /// Localizes the label
  /// ```dart
  /// 'Entry';
  /// ```
  /// * default is english (en)
  String fieldTypeEntryReference() {
    if (languageLocale == 'de') return 'Eintrag';
    return 'Entry';
  }

  /// Localizes the label
  /// ```dart
  /// 'Location';
  /// ```
  /// * default is english (en)
  String fieldTypeLocation() {
    if (languageLocale == 'de') return 'Standort';
    return 'Location';
  }

  /// Localizes the label
  /// ```dart
  /// 'Images';
  /// ```
  /// * default is english (en)
  String fieldTypeImages() {
    if (languageLocale == 'de') return 'Bilder';
    return 'Images';
  }

  /// Localizes the label
  /// ```dart
  /// 'Payment';
  /// ```
  /// * default is english (en)
  String modelEntryPayment() {
    if (languageLocale == 'de') return 'Zahlung';
    return 'Payment';
  }

  /// Localizes the label
  /// ```dart
  /// 'Shared expense';
  /// ```
  /// * default is english (en)
  String modelEntrySharedExpense() {
    if (languageLocale == 'de') return 'Geteilte Ausgabe';
    return 'Shared expense';
  }

  /// Localizes the label
  /// ```dart
  /// 'Files';
  /// ```
  /// * default is english (en)
  String fieldTypeFiles() {
    if (languageLocale == 'de') return 'Dateien';
    return 'Files';
  }

  /// Localizes the label
  /// ```dart
  /// 'Payment';
  /// ```
  /// * default is english (en)
  String fieldTypePayment() {
    if (languageLocale == 'de') return 'Zahlung';
    return 'Payment';
  }

  /// Localizes the label
  /// ```dart
  /// 'Date of birth';
  /// ```
  /// * default is english (en)
  String fieldTypeDateOfBirth() {
    if (languageLocale == 'de') return 'Geburtsdatum';
    return 'Date of birth';
  }

  /// Localizes the label
  /// ```dart
  /// 'Tags';
  /// ```
  /// * default is english (en)
  String fieldTypeTags() {
    if (languageLocale == 'de') return 'Tags';
    return 'Tags';
  }

  /// Localizes the label
  /// ```dart
  /// 'i.e. email, first name, notes, ...';
  /// ```
  /// * default is english (en)
  String fieldTypeTextHint() {
    if (languageLocale == 'de') return 'z.b. Email, Vorname, Notizen, ...';
    return 'i.e. email, first name, notes, ...';
  }

  /// Localizes the label
  /// ```dart
  /// 'i.e. password, access code, pin, ...';
  /// ```
  /// * default is english (en)
  String fieldTypePasswordHint() {
    if (languageLocale == 'de') return 'z.b. Passwort, Zugangscode, PIN, ...';
    return 'i.e. password, access code, pin, ...';
  }

  /// Localizes the label
  /// ```dart
  /// 'i.e. work, private, mobile, ...';
  /// ```
  /// * default is english (en)
  String fieldTypePhoneHint() {
    if (languageLocale == 'de') return 'z.b. Arbeit, Privat, Mobil, ...';
    return 'i.e. work, private, mobile, ...';
  }

  /// Localizes the label
  /// ```dart
  /// 'i.e. birthday, anniversary, deadline, ...';
  /// ```
  /// * default is english (en)
  String fieldTypeDateHint() {
    if (languageLocale == 'de') return 'z.b. Geburtstag, Jahrestag, Deadline, ...';
    return 'i.e. birthday, anniversary, deadline, ...';
  }

  /// Localizes the label
  /// ```dart
  /// 'i.e. reminder, start, end, ...';
  /// ```
  /// * default is english (en)
  String fieldTypeTimeOfDayHint() {
    if (languageLocale == 'de') return 'z.b. Erinnerung, Start, Ende, ...';
    return 'i.e. reminder, start, end, ...';
  }

  /// Localizes the label
  /// ```dart
  /// 'i.e. quantity, existing, required amount, ...';
  /// ```
  /// * default is english (en)
  String fieldTypeNumberHint() {
    if (languageLocale == 'de') return 'z.b. Anzahl, Existiert, Nötiger Betrag, ...';
    return 'i.e. quantity, existing, required amount, ...';
  }

  /// Localizes the label
  /// ```dart
  /// 'i.e. email, work, private, ...';
  /// ```
  /// * default is english (en)
  String fieldTypeEmailHint() {
    if (languageLocale == 'de') return 'z.b. Email, Arbeit, Privat, ...';
    return 'i.e. email, work, private, ...';
  }

  /// Localizes the label
  /// ```dart
  /// 'i.e. price, costs, amount, ...';
  /// ```
  /// * default is english (en)
  String fieldTypeMoneyHint() {
    if (languageLocale == 'de') return 'z.b. Preis, Kosten, Betrag, ...';
    return 'i.e. price, costs, amount, ...';
  }

  /// Localizes the label
  /// ```dart
  /// 'i.e. website, more info, ...';
  /// ```
  /// * default is english (en)
  String fieldTypeWebsiteHint() {
    if (languageLocale == 'de') return 'z.b. Website, Mehr Informationen, ...';
    return 'i.e. website, more info, ...';
  }

  /// Localizes the label
  /// ```dart
  /// 'i.e. username, avatar name, character, ...';
  /// ```
  /// * default is english (en)
  String fieldTypeUsernameHint() {
    if (languageLocale == 'de') return 'z.b. Username, Avatarname, Charaktername ...';
    return 'i.e. username, avatar name, character, ...';
  }

  /// Localizes the label
  /// ```dart
  /// 'i.e. deadline, meeting, reminder, ...';
  /// ```
  /// * default is english (en)
  String fieldTypeDateAndTimeHint() {
    if (languageLocale == 'de') return 'z.b. Deadline, Meeting, Erinnerung ...';
    return 'i.e. deadline, meeting, reminder, ...';
  }

  /// Localizes the label
  /// ```dart
  /// 'i.e. type, object, ...';
  /// ```
  /// * default is english (en)
  String fieldTypeSelectorHint() {
    if (languageLocale == 'de') return 'z.b. Typ, Objekt, ...';
    return 'i.e. type, object, ...';
  }

  /// Localizes the label
  /// ```dart
  /// 'i.e. logins, persons, ...';
  /// ```
  /// * default is english (en)
  String fieldTypeEntryModelsHint() {
    if (languageLocale == 'de') return 'z.b. Logins, Personen, ...';
    return 'i.e. Logins, Persons, ...';
  }

  /// Localizes the label
  /// ```dart
  /// 'i.e. members, entries, ...';
  /// ```
  /// * default is english (en)
  String fieldTypeEntryHint() {
    if (languageLocale == 'de') return 'z.b. Mitglieder, Einträge, ...';
    return 'i.e. Members, Entries, ...';
  }

  /// Localizes the label
  /// ```dart
  /// 'i.e. location, home, point of intrest, ...';
  /// ```
  /// * default is english (en)
  String fieldTypeLocationHint() {
    if (languageLocale == 'de') return 'z.b. Standort, Zuhause, Interessanter Ort, ...';
    return 'i.e. Location, Home, Point of intrest, ...';
  }

  /// Localizes the label
  /// ```dart
  /// 'i.e. picture, reference, object ...';
  /// ```
  /// * default is english (en)
  String fieldTypeImagesHint() {
    if (languageLocale == 'de') return 'z.b. Bild, Referenzen, Objekte, ...';
    return 'i.e. Picture, References, Objects ...';
  }

  /// Localizes the label
  /// ```dart
  /// 'i.e. picture, reference, object ...';
  /// ```
  /// * default is english (en)
  String fieldTypeFilesHint() {
    if (languageLocale == 'de') return 'z.b. Dateien, Referenzen, Objekte, ...';
    return 'i.e. Files, References, Objects ...';
  }

  /// Localizes the label
  /// ```dart
  /// 'i.e. Payments, Expenses, Income, ...';
  /// ```
  /// * default is english (en)
  String fieldTypePaymentsHint() {
    if (languageLocale == 'de') return 'z.b. Zahlung, Ausgaben, Einnahmen ...';
    return 'i.e. Payments, Expenses, Income, ...';
  }

  /// Localizes the label
  /// ```dart
  /// 'i.e. born at, birthday, ...';
  /// ```
  /// * default is english (en)
  String fieldTypeDateOfBirthHint() {
    if (languageLocale == 'de') return 'z.b. geboren am, Geburtstag, ...';
    return 'i.e. Born at, Birthday, ...';
  }

  /// Localizes the label
  /// ```dart
  /// 'i.e. groceries, friends, short_trip, ...';
  /// ```
  /// * default is english (en)
  String fieldTypeTagsHint() {
    if (languageLocale == 'de') return 'z.b. Tags, Kategorien, ...';
    return 'i.e. Tags, Categories, ...';
  }

  /// Localizes the label
  /// ```dart
  /// 'i.e. Velocity, Distance, Weight, ...';
  /// ```
  /// * default is english (en)
  String fieldTypeMeasurementHint() {
    if (languageLocale == 'de') return 'z.b. Geschwindigkeit, Distanz, Gewicht, ...';
    return 'i.e. Velocity, Distance, Weight, ...';
  }

  /// Localizes the label
  /// ```dart
  /// 'i.e. Emotion, Sentiment, Perception, ...';
  /// ```
  /// * default is english (en)
  String fieldTypeEmotionHint() {
    if (languageLocale == 'de') return 'z.b. Emotion, Gefühl, Empfindung, ...';
    return 'i.e. Emotion, Sentiment, Perception, ...';
  }

  /// Localizes the label
  /// ```dart
  /// 'i.e. Profile picture, Avatar, ...';
  /// ```
  /// * default is english (en)
  String fieldTypeAvatarImageHint() {
    if (languageLocale == 'de') return 'z.b. Profilbild, Avatar, ...';
    return 'i.e. Profile picture, Avatar, ...';
  }

  /// Localizes the label
  /// ```dart
  /// 'i.e. Has attended, Exercise submitted, ...';
  /// ```
  /// * default is english (en)
  String fieldTypeBooleanDataHint() {
    if (languageLocale == 'de') return 'z.b. Hat teilgenommen, Übung eingereicht, ...';
    return 'i.e. Has attended, Exercise submitted, ...';
  }

  /// Localizes the label
  /// ```dart
  /// 'choose measurement category';
  /// ```
  /// * default is english (en)
  String chooseMeasurementCategory({required String category}) {
    if (languageLocale == 'de') return category.isEmpty ? 'Messkategorie auswählen' : category;
    return category.isEmpty ? 'Choose measurement category' : category;
  }

  /// Localizes the label
  /// ```dart
  /// 'Unit';
  /// ```
  /// * default is english (en)
  String chooseMeasurementUnit({required String unit}) {
    if (languageLocale == 'de') return unit.isEmpty ? 'Einheit' : unit;
    return unit.isEmpty ? 'Unit' : unit;
  }

  /// Localizes the label
  /// ```dart
  /// 'Length'
  /// ```
  /// * default is english (en)
  String measureCategoryDistance() {
    if (languageLocale == 'de') return 'Länge';
    return 'Length';
  }

  /// Localizes the label
  /// ```dart
  /// 'Weight'
  /// ```
  /// * default is english (en)
  String measureCategoryMass() {
    if (languageLocale == 'de') return 'Gewicht';
    return 'Weight';
  }

  /// Localizes the label
  /// ```dart
  /// 'Volume'
  /// ```
  /// * default is english (en)
  String measureCategoryVolume() {
    if (languageLocale == 'de') return 'Volumen';
    return 'Volume';
  }

  /// Localizes the label
  /// ```dart
  /// 'Time'
  /// ```
  /// * default is english (en)
  String measureCategoryTime() {
    if (languageLocale == 'de') return 'Zeit';
    return 'Time';
  }

  /// Localizes the label
  /// ```dart
  /// 'Temperature'
  /// ```
  /// * default is english (en)
  String measureCategoryTemperature() {
    if (languageLocale == 'de') return 'Temperatur';
    return 'Temperature';
  }

  /// Localizes the label
  /// ```dart
  /// 'Area'
  /// ```
  /// * default is english (en)
  String measureCategoryArea() {
    if (languageLocale == 'de') return 'Fläche';
    return 'Area';
  }

  /// Localizes the label
  /// ```dart
  /// 'Velocity'
  /// ```
  /// * default is english (en)
  String measureCategoryVelocity() {
    if (languageLocale == 'de') return 'Geschwindigkeit';
    return 'Velocity';
  }

  /// Localizes the label
  /// ```dart
  /// 'Energy'
  /// ```
  /// * default is english (en)
  String measureCategoryEnergy() {
    if (languageLocale == 'de') return 'Energie';
    return 'Energy';
  }

  /// Localizes the label
  /// ```dart
  /// 'Power'
  /// ```
  /// * default is english (en)
  String measureCategoryPower() {
    if (languageLocale == 'de') return 'Leistung';
    return 'Power';
  }

  /// Localizes the label
  /// ```dart
  /// 'Pressure'
  /// ```
  /// * default is english (en)
  String measureCategoryPressure() {
    if (languageLocale == 'de') return 'Druck';
    return 'Pressure';
  }

  /// Localizes the label
  /// ```dart
  /// 'Count'
  /// ```
  /// * default is english (en)
  String measureCategoryCount() {
    if (languageLocale == 'de') return 'Anzahl';
    return 'Count';
  }

  /// Localizes the label
  /// ```dart
  /// 'Sound'
  /// ```
  /// * default is english (en)
  String measureCategorySound() {
    if (languageLocale == 'de') return 'Lautstärke';
    return 'Sound';
  }

  /// Localizes the label
  /// ```dart
  /// 'Measurement categories'
  /// ```
  /// * default is english (en)
  String measureCategoryPickerSheetTitle() {
    if (languageLocale == 'de') return 'Messkategorien';
    return 'Measurement categories';
  }

  /// Localizes the label
  /// ```dart
  /// 'Units'
  /// ```
  /// * default is english (en)
  String measureUnitPickerSheetTitle() {
    if (languageLocale == 'de') return 'Einheiten';
    return 'Units';
  }

  /// Localizes the label
  /// ```dart
  /// if (value == null) return "Choose";
  /// if (value) return "True";
  ///  return 'False';
  /// ```
  /// * default is english (en)
  String booleanSwitchLabel({required bool? value}) {
    if (languageLocale == 'de') {
      if (value == null) return "Auswählen";
      if (value) return "Wahr";
      return 'Falsch';
    }

    if (value == null) return "Choose";
    if (value) return "True";
    return 'False';
  }

  //-----------------------------------------------
  //--------------- CustomExpenseInputTile Labels
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Currency';
  /// ```
  /// * default is english (en)
  String currency() {
    if (languageLocale == 'de') return 'Währung';
    return 'Currency';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please first assign a participant to this group.';
  /// ```
  /// * default is english (en)
  String participantRequired({required bool isImportMatch}) {
    if (languageLocale == 'de') return 'Bitte weiße der Gruppe${isImportMatch ? ', in die importiert werden soll,' : ''} zunächst, in den Gruppeneinstellungen, Mitwirkende zu.';
    return 'Please first assign a participant to ${isImportMatch ? 'the group that you want to import to' : 'this group'}.\n\nThis can be done in the group settings.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Paid by';
  /// ```
  /// * default is english (en)
  String expenseInputPaidBy() {
    if (languageLocale == 'de') return 'Bezahlt von';
    return 'Paid by';
  }

  /// Localizes the label
  /// ```dart
  /// 'Expense date';
  /// ```
  /// * default is english (en)
  String expenseExpenseDate() {
    if (languageLocale == 'de') return 'Ausgabendatum';
    return 'Expense date';
  }

  /// Localizes the label
  /// ```dart
  /// 'Total';
  /// ```
  /// * default is english (en)
  String expenseTotalAmount() {
    if (languageLocale == 'de') return 'Gesamt';
    return 'Total';
  }

  /// Localizes the label
  /// ```dart
  /// 'The currency you selected differs from group default $defaultCurrencyCode.\n\nThe following exchange rate was used to convert from \n$selectedCurrencyCode to $defaultCurrencyCode.\n\n$exchangeRate';
  /// ```
  /// * default is english (en)
  String expenseRateConversionInfo({required String defaultCurrencyCode, required String selectedCurrencyCode, required double exchangeRate}) {
    if (languageLocale == 'de') return 'Ausgewählte Währung unterscheidet sich von der Standardwährung $defaultCurrencyCode der ausgewählten Gruppe.\n\nFolgender Wechselkurs wurde für die Umwechslung von $selectedCurrencyCode zu $defaultCurrencyCode verwendet.\n\n$exchangeRate';
    return 'The currency you selected differs from group default $defaultCurrencyCode.\n\nThe following exchange rate was used to convert from \n$selectedCurrencyCode to $defaultCurrencyCode.\n\n$exchangeRate';
  }

  /// Localizes the label
  /// ```dart
  /// 'exchange rate';
  /// ```
  /// * default is english (en)
  String expenseExchangeRate() {
    if (languageLocale == 'de') return 'Wechselkurs';
    return 'Exchange rate';
  }

  /// Localizes the label
  /// ```dart
  /// 'For';
  /// ```
  /// * default is english (en)
  String expenseFor() {
    if (languageLocale == 'de') return 'Für';
    return 'For';
  }

  /// Localizes the label
  /// ```dart
  /// 'Distribute equally';
  /// ```
  /// * default is english (en)
  String expenseDistributeEqually() {
    if (languageLocale == 'de') return 'Gleichmäßig aufteilen';
    return 'Distribute equally';
  }

  /// Localizes the label
  /// ```dart
  /// 'Set this to true if you do not want this payment to be considered in certain calculations.\n\nThis value should be, for example, set to true if this payment was already compensated for by other means like selling ones labour or selling an object.';
  /// ```
  /// * default is english (en)
  String infoExpenseIsCompensated() {
    if (languageLocale == 'de') return 'Mit dieser Option kann angegeben werden das diese Zahlung in bestimmten Kalkulation ignoriert werden soll.\n\nDies ist zum Beispiel hilfreich, wenn diese Zahlung bereits durch eine andere Art kompensiert wurde wie beispielsweise bei dem Verkauf der eigenen Arbeitskraft oder bei dem Verkauf eines Objekts.';
    return 'Set this to true if you do not want this payment to be considered in certain calculations.\n\nThis value should be, for example, set to true if this payment was already compensated for by other means like selling ones labour or selling an object.';
  }

  //-----------------------------------------------
  //--------------- CardDisplayExpense Labels
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Total amount';
  /// ```
  /// * default is english (en)
  String totalAmount() {
    if (languageLocale == 'de') return 'Gesamt';
    return 'Total';
  }

  /// Localizes the label
  /// ```dart
  /// 'Converted';
  /// ```
  /// * default is english (en)
  String totalConverted() {
    if (languageLocale == 'de') return 'Umgerechnet';
    return 'Converted';
  }

  /// Localizes the label
  /// ```dart
  /// 'Paid by';
  /// ```
  /// * default is english (en)
  String paidBy() {
    if (languageLocale == 'de') return 'Bezahlt von';
    return 'Paid by';
  }

  /// Localizes the label
  /// ```dart
  /// 'Expense date\n(YYYY-MM-DD)';
  /// ```
  /// * default is english (en)
  String expenseDate() {
    if (languageLocale == 'de') return 'Ausgabendatum\n(JJJJ-MM-TT)';
    return 'Expense date\n(YYYY-MM-DD)';
  }

  /// Localizes the label
  /// ```dart
  /// '(YYYY-MM-DD)';
  /// ```
  /// * default is english (en)
  String dateOnlyFormat() {
    if (languageLocale == 'de') return '(JJJJ-MM-TT)';
    return '(YYYY-MM-DD)';
  }

  /// Localizes the label
  /// ```dart
  /// 'Distribution';
  /// ```
  /// * default is english (en)
  String expenseDistribution() {
    if (languageLocale == 'de') return 'Aufteilung';
    return 'Distribution';
  }

  /// Localizes the label
  /// ```dart
  /// return 'This payment has been labeled as "is compensated" and will be ignored in certain calculations.';
  /// ```
  /// * default is english (en)
  String displayIsCompensated() {
    if (languageLocale == 'de') return 'Diese Zahlung ist als bereits kompensiert gekennzeichnet und wird in bestimmten Kalkulationen ignoriert.';
    return 'This payment has been labeled as "is compensated" and will be ignored in certain calculations.';
  }

  //-----------------------------------------------
  //--------------- AddGroupSheet Labels ----------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Group name';
  /// ```
  /// * default is english (en)
  String groupName() {
    if (languageLocale == 'de') return 'Gruppenname';
    return 'Group name';
  }

  /// Localizes the label
  /// ```dart
  /// 'Group description';
  /// ```
  /// * default is english (en)
  String groupDescription() {
    if (languageLocale == 'de') return 'Gruppenbeschreibung';
    return 'Group info';
  }

  /// Localizes the label
  /// ```dart
  /// 'A group name is required.';
  /// ```
  /// * default is english (en)
  String addGroupSheetMember() {
    if (languageLocale == 'de') return 'Mitglieder';
    return 'Members';
  }

  /// Localizes the label
  /// ```dart
  /// 'Add a member';
  /// ```
  /// * default is english (en)
  String addGroupSheetAddMember() {
    if (languageLocale == 'de') return 'Mitglied hinzufügen';
    return 'Add a member';
  }

  /// Localizes the label
  /// ```dart
  /// 'Members enable certain statistical evaluations and add comparisment functionality.\n\nThis is for example needed to calculate shared expenses.';
  /// ```
  /// * default is english (en)
  String createGroupSheetAddParticipantInfoMessage() {
    if (languageLocale == 'de') return 'Mitwirkende ermöglichen bestimmte statistische Auswertungen und Vergleiche.\n\nMitwirkende sind zum Beispiel notwendig um geteilte Ausgaben zu berechnen.';
    return 'A participant enables certain statistical evaluations and adds comparisment functionality.\n\nThis is for example needed to calculate shared expenses.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Quick add reference';
  /// ```
  /// * default is english (en)
  String addGroupSheetQuickAddReference() {
    if (languageLocale == 'de') return 'Schnelles hinzufügen';
    return 'Quick add reference';
  }

  /// Localizes the label
  /// ```dart
  /// 'select reference';
  /// ```
  /// * default is english (en)
  String addGroupSheetSelectQuickAddReference() {
    if (languageLocale == 'de') return 'Referenz auswählen';
    return 'select reference';
  }

  /// Localizes the label
  /// ```dart
  /// 'Select an entry model to quickly add a new entry of this kind to this group if you long press the add button.';
  /// ```
  /// * default is english (en)
  String addGroupSheetQuickAddReferenceInfoMessage() {
    if (languageLocale == 'de') return 'Wähle eine Eintragsvorlage aus um schnell einen Eintrag dieser Art, durch langes pressen der hinzufügen Taste, zu dieser Gruppe hinzuzufügen.';
    return 'Select an entry model to quickly add a new entry of this kind to this group if you long press the add button.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Currency';
  /// ```
  /// * default is english (en)
  String addGroupSheetCurrency() {
    if (languageLocale == 'de') return 'Währung';
    return 'Currency';
  }

  /// Localizes the label
  /// ```dart
  /// 'Assign a default currency to this group.\n\nThis enables certain statistical evaluations and some comparisment functionalities.\n\nThis is for example needed to calculate shared expenses.';
  /// ```
  /// * default is english (en)
  String addGroupSheetCurrencyInfoMessage() {
    if (languageLocale == 'de') {
      return 'Ordne dieser Gruppe eine Standardwährung zu.\n\nDies ermöglicht bestimmte statistische Auswertungen und Vergleiche.\n\nEine Standardwährung ist zum Beispiel notwendig um geteilte Ausgaben zu berechnen.';
    }
    return 'Assign a default currency to this group.\n\nThis enables certain statistical evaluations and some comparisment functionalities.\n\nThis is for example needed to calculate shared expenses.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Lock group';
  /// ```
  /// * default is english (en)
  String addGroupSheetLockGroup() {
    if (languageLocale == 'de') return 'Gruppe sperren';
    return 'Lock group';
  }

  /// Localizes the label
  /// ```dart
  /// 'Protect group';
  /// ```
  /// * default is english (en)
  String addGroupSheetProtectGroup() {
    if (languageLocale == 'de') return 'Gruppe schützen';
    return 'Protect group';
  }

  /// Localizes the label
  /// ```dart
  /// 'Encrypt group';
  /// ```
  /// * default is english (en)
  String addGroupSheetEncryptGroup() {
    if (languageLocale == 'de') return 'Gruppe verschlüsseln';
    return 'Encrypt group';
  }

  /// Localizes the label
  /// ```dart
  /// 'If this is enabled a password needs to be provided to access this group.\n\nTo use this feature please set an app password in the main menu.';
  /// ```
  /// * default is english (en)
  String addGroupSheetProtectGroupInfoMessage() {
    if (languageLocale == 'de') return 'Wenn diese Funktion aktiviert ist, wird ein Passwort abgefragt wenn auf diese Gruppe zugegriffen wird.\n\nBitte erstelle ein App Passwort im Menu auf der Startseite um diese Funktion zu nutzen.';
    return 'If this is enabled a password needs to be provided to access this group.\n\nTo use this feature please set an app password in the main menu.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Use this to encrypt entries of this group.';
  /// ```
  /// * default is english (en)
  String addGroupSheetEncryptGroupInfoMessage() {
    if (languageLocale == 'de') return 'Verwende dies um die Einträge in dieser Gruppe zu verschlüsseln.';
    return 'Use this to encrypt entries of this group.';
  }

  /// Localizes the label
  /// ```dart
  /// 'If this is turned on no new entries can be added to this group.';
  /// ```
  /// * default is english (en)
  String addGroupSheetLockGroupInfoMessage() {
    if (languageLocale == 'de') return 'Wenn diese Funktion aktiviert ist können keine neuen Objekte zu dieser Gruppe hinzugefügt werden.';
    return 'If this is activated no new objects can be added to this group.';
  }

  /// Localizes the label
  /// ```dart
  /// return vertical ? 'Vertical list' : 'Horizontal list';
  /// ```
  /// * default is english (en)
  String addGroupSheetDisplaySubgroupsAsList({required bool vertical}) {
    if (languageLocale == 'de') return vertical ? 'Als vertikale Liste' : 'Als horizontale Liste';
    return vertical ? 'As vertical list' : 'As horizontal list';
  }

  /// Localizes the label
  /// ```dart
  /// 'If this is activated, subgroups will be displayed in a vertical list rather than a horizontal one.';
  /// ```
  /// * default is english (en)
  String addGroupSheetDisplaySubgroupsAsListInfoMessage() {
    if (languageLocale == 'de') return 'Wenn diese Funktion aktiviert ist werden die Untergruppen in einer vertikalen Liste angezeigt anstatt in einer horizontaler Liste.';
    return 'If this is activated, subgroups will be displayed in a vertical list rather than a horizontal one.';
  }

  /// Localizes the label
  /// ```dart
  /// 'hide entries';
  /// ```
  /// * default is english (en)
  String addGroupSheetHideEntries() {
    if (languageLocale == 'de') return 'Einträge verstecken';
    return 'hide entries';
  }

  /// Localizes the label
  /// ```dart
  /// 'If this is activated entries section will be hidden if there are no entries in this group.';
  /// ```
  /// * default is english (en)
  String addGroupSheetHideEntriesInfoMessage() {
    if (languageLocale == 'de') return 'Wenn diese Funktion aktiviert ist, wird der Bereich in dem die Einträge angezeigt werden versteckt solange keine Einträge in der Gruppe sind.';
    return 'If this is activated entries section will be hidden if there are no entries in this group.';
  }

  /// Localizes the label
  /// ```dart
  /// 'hide subgroups';
  /// ```
  /// * default is english (en)
  String addGroupSheetHideSubgroups() {
    if (languageLocale == 'de') return 'Untergruppen verstecken';
    return 'hide subgroups';
  }

  /// Localizes the label
  /// ```dart
  /// 'If this is activated, subgroups section will be hidden if there are no subgroups in this group.';
  /// ```
  /// * default is english (en)
  String addGroupSheetHideSubgroupsInfoMessage() {
    if (languageLocale == 'de') return 'Wenn diese Funktion aktiviert ist, wird der Bereich in dem die Untergruppen angezeigt werden versteckt solange keine Untergruppen in der Gruppe sind.';
    return 'If this is activated, subgroups section will be hidden if there are no subgroups in this group.';
  }

  /// Localizes the label
  /// ```dart
  /// isEdit ? 'update' : 'create';
  /// ```
  /// * default is english (en)
  String addGroupSheetFLoatingActionBarLabel({required bool isEdit}) {
    if (languageLocale == 'de') return isEdit ? 'aktualisieren' : 'erstellen';
    return isEdit ? 'update' : 'create';
  }

  //-----------------------------------------------
  //--------------- Create Participant Sheet
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// return 'Remove member from participant?';
  /// ```
  /// * default is english (en)
  String createParticipantSheetConfirmRemoveMember() {
    if (languageLocale == 'de') return 'Mitglied wirklich entfernen?';
    return 'Remove member from participant?';
  }

  /// Localizes the label
  /// ```dart
  /// return isEdit ? 'Edit Participant' : 'Create Participant';
  /// ```
  /// * default is english (en)
  String createParticipantSheetTitle({required bool isEdit}) {
    if (languageLocale == 'de') return isEdit ? 'Mitwirkende bearbeiten' : 'Mitwirkende erstellen';
    return isEdit ? 'Edit Participant' : 'Create Participant';
  }

  /// Localizes the label
  /// ```dart
  /// isEdit ? 'Are you sure that you do not want to save made edits?' : 'Are you sure that you do not want to create this participant?';
  /// ```
  /// * default is english (en)
  String createParticipantSheetCubitConfirmCloseMessage({required bool isEdit}) {
    if (languageLocale == 'de') return isEdit ? 'Gemachte Änderungen sicher nicht speichern?' : 'Mitwirkende sicher nicht speichern?';
    return isEdit ? 'Are you sure that you do not want to save made edits?' : 'Are you sure that you do not want to create this participant?';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Add member';
  /// ```
  /// * default is english (en)
  String createParticipantSheetAddMember() {
    if (languageLocale == 'de') return 'Mitglied hinzufügen';
    return 'Add member';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Participant name';
  /// ```
  /// * default is english (en)
  String createParticipantSheetParticipantName() {
    if (languageLocale == 'de') return 'Mitwirkende name';
    return 'Participant name';
  }

  /// Localizes the label
  /// ```dart
  /// return 'I.e. family, friends, co-workers, ...';
  /// ```
  /// * default is english (en)
  String createParticipantSheetParticipantHints() {
    if (languageLocale == 'de') return 'Z.B. Familie, Freunde, Team, ...';
    return 'I.e. family, friends, co-workers, ...';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Choose existing member';
  /// ```
  /// * default is english (en)
  String createParticipantSheetCubitSelectExistingMember() {
    if (languageLocale == 'de') return 'Existierendes Mitglied auswählen';
    return 'Choose existing member';
  }

  /// Localizes the label
  /// ```dart
  /// 'Create new member';
  /// ```
  /// * default is english (en)
  String createParticipantSheetCubitCreateNewMember() {
    if (languageLocale == 'de') return 'Neues Mitglied erstellen';
    return 'Create new member';
  }

  /// Localizes the label
  /// ```dart
  /// 'Remove participant from group';
  /// ```
  /// * default is english (en)
  String createParticipantSheetCubitRemoveParticipantFromGroup() {
    if (languageLocale == 'de') return 'Mitwirkende aus Gruppe entfernen';
    return 'Remove participant from group';
  }

  //-----------------------------------------------
  //--------------- AddGroupSheetCubit Labels -----
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// isEdit ? 'Are you sure that you do not want to save made edits?' : 'Are you sure that you do not want to create this group?';
  /// ```
  /// * default is english (en)
  String addGroupSheetCubitConfirmCloseMessage({required bool isEdit}) {
    if (languageLocale == 'de') return isEdit ? 'Gemachte Änderungen sicher nicht speichern?' : 'Gruppe sicher nicht speichern?';
    return isEdit ? 'Are you sure that you do not want to save made edits?' : 'Are you sure that you do not want to create this group?';
  }

  /// Localizes the label
  /// ```dart
  /// 'select an entry as member';
  /// ```
  /// * default is english (en)
  String createParticipantSheetCubitSelectEntryAsMember() {
    if (languageLocale == 'de') return 'Eintrag als Mitglied auswählen';
    return 'Select an entry as member';
  }

  /// Localizes the label
  /// ```dart
  /// 'member added';
  /// ```
  /// * default is english (en)
  String addGroupSheetCubitMemberAddedNotification() {
    if (languageLocale == 'de') return 'Mitglied erstellt';
    return 'member added';
  }

  /// Localizes the label
  /// ```dart
  /// 'member name';
  /// ```
  /// * default is english (en)
  String createParticipantSheetCubitMemberNameHint() {
    if (languageLocale == 'de') return 'Mitgliedsname';
    return 'member name';
  }

  /// Localizes the label
  /// ```dart
  /// 'Delete member?';
  /// ```
  /// * default is english (en)
  String addGroupSheetCubitConfirmDeleteMember() {
    if (languageLocale == 'de') return 'Mitglied löschen?';
    return 'Delete member?';
  }

  /// Localizes the label
  /// ```dart
  /// 'member removed';
  /// ```
  /// * default is english (en)
  String addGroupSheetCubitMemberRemovedNotification() {
    if (languageLocale == 'de') return 'Mitglied gelöscht';
    return 'member removed';
  }

  /// Localizes the label
  /// ```dart
  /// 'group created';
  /// ```
  /// * default is english (en)
  String addGroupSheetCubitGroupCreatedNotification() {
    if (languageLocale == 'de') return 'Gruppe erstellt';
    return 'group created';
  }

  /// Localizes the label
  /// ```dart
  /// 'group edited';
  /// ```
  /// * default is english (en)
  String addGroupSheetCubitGroupEditedNotification() {
    if (languageLocale == 'de') return 'Gruppe bearbeitet';
    return 'group edited';
  }

  //-----------------------------------------------
  //--------------- Member Labels ----------------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'unknown member';
  /// ```
  /// * default is english (en)
  String unknownMember() {
    if (languageLocale == 'de') return 'Unbekanntes Mitglied';
    return 'Unknown member';
  }

  /// Localizes the label
  /// ```dart
  /// 'deleted member';
  /// ```
  /// * default is english (en)
  String deletedMember() {
    if (languageLocale == 'de') return 'gelöschtes Mitglied';
    return 'deleted member';
  }

  //-----------------------------------------------
  //---------------- Privacy Policy sheet ---------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Privacy policy';
  /// ```
  /// * default is english (en)
  String privacyPolicySheetTitle() {
    if (languageLocale == 'de') return 'Datenschutzrichtlinien';
    return 'Privacy policy';
  }

  /// Localizes the label
  /// ```dart
  /// 'Terms & Conditions';
  /// ```
  /// * default is english (en)
  String basicLabelsTermsAndConditions() {
    if (languageLocale == 'de') return 'Bedingungen & Konditionen';
    return 'Terms & Conditions';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please accept our terms and conditions to be able to participate in shared groups.';
  /// ```
  /// * default is english (en)
  String basicLabelsTermsAndConditionsInfoMessage() {
    if (languageLocale == 'de') return 'Bitte akzpetiere unsere Bedingungen & Konditionen um an geteilten Gruppen teilnehmen zu können.';
    return 'Please accept our terms and conditions to be able to participate in shared groups.';
  }

  /// Localizes the label
  /// ```dart
  /// 'retry';
  /// ```
  /// * default is english (en)
  String privacyPolicySheetRetry() {
    if (languageLocale == 'de') return 'Noch einmal versuchen';
    return 'Try again';
  }

  //-----------------------------------------------
  //---------------- User Agreement sheet ---------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'User agreement';
  /// ```
  /// * default is english (en)
  String userAgreementSheetTitle() {
    if (languageLocale == 'de') return 'Nutzervereinbarung';
    return 'User agreement';
  }

  /// Localizes the label
  /// ```dart
  /// 'retry';
  /// ```
  /// * default is english (en)
  String userAgreementSheetRetry() {
    if (languageLocale == 'de') return 'Noch einmal versuchen';
    return 'Try again';
  }

  //-----------------------------------------------
  //---------------- API --------------------------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'Internal server error. Something went wrong on our side, please try again.';
  /// ```
  /// * default is english (en)
  String failureApiInternalServerError() {
    if (languageLocale == 'de') return 'Internal server error.\n\nSieht aus als liegt der Fehler bei uns, bitte versuche es noch einmal.';
    return 'Internal server error.\n\nSomething went wrong on our side, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'No data was returned, please try again.';
  /// ```
  /// * default is english (en)
  String failureApiEmptyResponseBody() {
    if (languageLocale == 'de') return 'Es wurden keine Daten übertrage, bitte versuche es noch einmal.';
    return 'No data was returned, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'An error occurred, please try again.';
  /// ```
  /// * default is english (en)
  String failureApiGenericError() {
    if (languageLocale == 'de') return 'Ein Fehler ist aufgetreten, bitte versuche es noch einmal.';
    return 'An error occurred, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Valid authorization is missing, request denied.';
  /// ```
  /// * default is english (en)
  String failureApiUnauthorizedRequest() {
    if (languageLocale == 'de') return 'Fehlende Autorisierung, Anfrage abgelehnt.';
    return 'Valid authorization is missing, request denied.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Received response code is unknown, please try again.';
  /// ```
  /// * default is english (en)
  String failureApiUnknownResponseCode() {
    if (languageLocale == 'de') return 'Erhaltene Identifizierung ist unbekannt, bitte versuche es noch einmal.';
    return 'Received response code is unknown, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'This took to long, please try again.';
  /// ```
  /// * default is english (en)
  String failureApiHttpTimeout() {
    if (languageLocale == 'de') return 'Das hat zu lange gedauert, bitte versuche es noch einmal.';
    return 'This took to long, please try again.';
  }

  //-----------------------------------------------
  //--------------- Failure Labels ----------------
  //-----------------------------------------------

  /// Localizes the label
  /// ```dart
  /// 'An error occurred, please try again.';
  /// ```
  /// * default is english (en)
  String failureGenericError() {
    if (languageLocale == 'de') return 'Etwas ist schief gelaufen, bitte versuche es noch einmal.';
    return 'An error occurred, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Model name cannot be empty.';
  /// ```
  /// * default is english (en)
  String failureEmptyModelName() {
    if (languageLocale == 'de') return 'Eintragsvorlagenname ist notwendig.';
    return 'Model name cannot be empty.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please provide labels for all fields.';
  /// ```
  /// * default is english (en)
  String failureEmptyLabels() {
    if (languageLocale == 'de') return 'Bitte vergib Namen für alle Felder.';
    return 'Please provide labels for all fields.';
  }

  /// Localizes the label
  /// ```dart
  /// 'At least one field is required.';
  /// ```
  /// * default is english (en)
  String failureNoEmptyModelFieldsCreated() {
    if (languageLocale == 'de') return 'Mindestens ein Feld ist notwendig.';
    return 'At least one field is required.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Database initialization failed, please try again.';
  /// ```
  /// * default is english (en)
  String failureDBinitFailed() {
    if (languageLocale == 'de') return 'Datenbankinitialisierung ist fehlgeschlagen, bitte versuche es noch einmal.';
    return 'Database initialization failed, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'App initialization failed, please try again.';
  /// ```
  /// * default is english (en)
  String failureAppInitFailed() {
    if (languageLocale == 'de') return 'Appinitialisierung ist fehlgeschlagen, bitte versuche es noch einmal.';
    return 'App initialization failed, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to register access password, please try again.';
  /// ```
  /// * default is english (en)
  String failureRegisterPasswordFailed() {
    if (languageLocale == 'de') return 'Registrierung des Zugangspassworts ist fehlgeschlagen, bitte versuche es noch einmal.';
    return 'Failed to register access password, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Access denied';
  /// ```
  /// * default is english (en)
  String failureAccessDenied() {
    if (languageLocale == 'de') return 'Zugriff verwehrt';
    return 'Access denied';
  }

  /// Localizes the label
  /// ```dart
  /// 'This entry is already tagged with this group.';
  /// ```
  /// * default is english (en)
  String failureAlreadyTaggedWithGroup() {
    if (languageLocale == 'de') return 'Dieser Eintrag ist schon in dieser Gruppe.';
    return 'This entry is already tagged with this group.';
  }

  /// Localizes the label
  /// ```dart
  /// 'An entry model with this name already exists.';
  /// ```
  /// * default is english (en)
  String failureEntryModelAlreadyExists() {
    if (languageLocale == 'de') return 'Eine Eintragsvorlage mit diesem Namen existiert bereits.';
    return 'An entry model with this name already exists.';
  }

  /// Localizes the label
  /// ```dart
  /// 'The field $fieldName is missing a required value.';
  /// ```
  /// * default is english (en)
  String failureRequiredValueMissing({required String fieldName}) {
    if (languageLocale == 'de') return 'Dem Feld "$fieldName" fehlt ein notwendiger Wert.';
    return 'The field "$fieldName" is missing a required value.';
  }

  /// Localizes the label
  /// ```dart
  /// 'No edits made.';
  /// ```
  /// * default is english (en)
  String failureNothingWasEdited() {
    if (languageLocale == 'de') return 'Es wurde nichts bearbeitet.';
    return 'No edits made.';
  }

  /// Localizes the label
  /// ```dart
  /// 'No entry data provided.';
  /// ```
  /// * default is english (en)
  String failureNoEntryDataProvided() {
    if (languageLocale == 'de') return 'Keine Eintragsdaten gefunden.';
    return 'No entry data provided.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Only empty groups can be deleted.';
  /// ```
  /// * default is english (en)
  String failureGroupIsNotEmpty() {
    if (languageLocale == 'de') return 'Nur leere Gruppen können gelöscht werden.';
    return 'Only empty groups can be deleted.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Entry must be tagged with another group in order to delete it from this group.';
  /// ```
  /// * default is english (en)
  String failureCurrentGroupIsRequired() {
    if (languageLocale == 'de') return 'Eintrag muss mit einer anderen Gruppe assoziiert sein um aus dieser Gruppe gelöscht werden zu können.';
    return 'Entry must be tagged with another group in order to delete it from this group.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please selected or create a group for this entry.';
  /// ```
  /// * default is english (en)
  String failureGroupRequired() {
    if (languageLocale == 'de') return 'Einträge müssen mit einer Gruppe assoziert sein.';
    return 'Please selected or create a group for this entry.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Only empty entry models can be deleted.';
  /// ```
  /// * default is english (en)
  String failureEntryModelIsNotEmpty() {
    if (languageLocale == 'de') return 'Eintragsvorlagen können nur gelöscht werden wenn sie mit keinem Eintrag assoziert sind.';
    return 'Only empty entry models can be deleted.';
  }

  /// Localizes the label
  /// ```dart
  /// 'You have entries saved that have data connected to this field.';
  /// ```
  /// * default is english (en)
  String failureEntriesWithFieldDataExist() {
    if (languageLocale == 'de') return 'Es existieren Einträge die Daten mit diesem Feld assoziert haben.';
    return 'You have entries saved that have data connected to this field.';
  }

  /// Localizes the label
  /// ```dart
  /// 'No copy field selected yet.';
  /// ```
  /// * default is english (en)
  String failureCopyFieldNotSet() {
    if (languageLocale == 'de') return 'Es wurde noch nicht festgelegt welches Feld kopiert werden soll.';
    return 'No copy field selected yet.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Selected copy field does not exist in this entry.';
  /// ```
  /// * default is english (en)
  String failureCopyFieldDoesNotExist() {
    if (languageLocale == 'de') return 'Das festgelegte Kopierfeld existiert nicht in diesem Eintrag.';
    return 'Selected copy field does not exist in this entry.';
  }

  /// Localizes the label
  /// ```dart
  /// 'This measure category was not found.';
  /// ```
  /// * default is english (en)
  String unknownMeasureCategory() {
    if (languageLocale == 'de') return 'Diese Messkategorie konnte nicht gefunden werden.';
    return 'This measure category was not found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Copy value is empty for this entry.';
  /// ```
  /// * default is english (en)
  String failureCopyValueEmpty() {
    if (languageLocale == 'de') return 'Es wurden keine Daten für das Kopierfeld dieses Eintrags festgelegt.';
    return 'Copy value is empty for this entry.';
  }

  /// Localizes the label
  /// ```dart
  /// 'This group already exists.';
  /// ```
  /// * default is english (en)
  String failureGroupAlreadyExists() {
    if (languageLocale == 'de') return 'Diese Gruppe existiert bereits.';
    return 'This group already exists.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to create group, please try again.';
  /// ```
  /// * default is english (en)
  String failureFailedToCreateGroup() {
    if (languageLocale == 'de') return 'Fehler beim erstellen der Gruppe, bitte versuche es noch einmal.';
    return 'Failed to create group, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to update entry, please try again.';
  /// ```
  /// * default is english (en)
  String failureFailedToUpdateEntry() {
    if (languageLocale == 'de') return 'Fehler beim bearbeiten des Eintrags, bitte versuche es noch einmal.';
    return 'Failed to update entry, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to create entry, please try again.';
  /// ```
  /// * default is english (en)
  String failureFailedToCreateEntry() {
    if (languageLocale == 'de') return 'Fehler beim erstellen des Eintrags, bitte versuche es noch einmal.';
    return 'Failed to create entry, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to delete group, please try again.';
  /// ```
  /// * default is english (en)
  String failureFailedToDeleteGroup() {
    if (languageLocale == 'de') return 'Fehler beim löschen der Gruppe, bitte versuche es noch einmal.';
    return 'Failed to delete group, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to delete entry, please try again.';
  /// ```
  /// * default is english (en)
  String failureFailedToDeleteEntry() {
    if (languageLocale == 'de') return 'Fehler beim löschen des Eintrags, bitte versuche es noch einmal.';
    return 'Failed to delete entry, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to create entry model, please try again.';
  /// ```
  /// * default is english (en)
  String failureFailedToCreateEntryModel() {
    if (languageLocale == 'de') return 'Fehler beim erstellen der Eintragsvorlage, bitte versuche es noch einmal.';
    return 'Failed to create entry model, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to update entry model, please try again.';
  /// ```
  /// * default is english (en)
  String failureFailedToUpdateEntryModel() {
    if (languageLocale == 'de') return 'Fehler beim bearbeiten der Eintragsvorlage, bitte versuche es noch einmal.';
    return 'Failed to update entry model, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please provide entry model data.';
  /// ```
  /// * default is english (en)
  String failureNoEntryModelDataProvided() {
    if (languageLocale == 'de') return 'Keine Eintragsvorlagendaten gefunden.';
    return 'Please provide entry model data.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to delete entry model, please try again.';
  /// ```
  /// * default is english (en)
  String failureFailedToDeleteEntryModel() {
    if (languageLocale == 'de') return 'Fehler beim löschen der Eintragsvorlage, bitte versuche es noch einmal.';
    return 'Failed to delete entry model, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'The value you have provided is not a number.';
  /// ```
  /// * default is english (en)
  String failureInvalidNumberInput({required String fieldName}) {
    if (languageLocale == 'de') return fieldName.isEmpty ? 'Eingabe ist keine valide Zahl.' : 'Eingabe für das Feld "$fieldName" ist keine Zahl.';
    return fieldName.isEmpty ? 'Provided value is not a valid number.' : 'The value you have provided for "$fieldName" is not a number.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to create settings, please try again.';
  /// ```
  /// * default is english (en)
  String failureFailedToCreateSettings() {
    if (languageLocale == 'de') return 'Fehler beim erstellen der Einstellungen, bitte versuche es noch einmal.';
    return 'Failed to create settings, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to update settings, please try again.';
  /// ```
  /// * default is english (en)
  String failureFailedToUpdateSettings() {
    if (languageLocale == 'de') return 'Fehler beim bearbeiten der Einstellungen, bitte versuche es noch einmal.';
    return 'Failed to update settings, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'The invite link for this group has reached its usage limit.\n\nYou cannot join the group using this link at the moment.\n\nPlease try again later or contact the group admin for further assistance.';
  /// ```
  /// * default is english (en)
  String infoMessageGroupLimitReached() {
    if (languageLocale == 'de') return 'Der Einladungslink für diese Gruppe hat sein Nutzungslimit erreicht.\n\nGruppenbeitritt über diesen Link ist derzeit nicht möglich.\n\nBitte versuche es später erneut oder kontaktiere den Gruppenadministrator für weitere Unterstützung.';
    return 'The invite link for this group has reached its usage limit.\n\nYou cannot join the group using this link at the moment.\n\nPlease try again later or contact the group admin for further assistance.';
  }

  /// Localizes the label
  /// ```dart
  /// 'The invite link for this group has expired.\n\nYou cannot join the group using this link at the moment.\n\nPlease try again later or contact the group admin for further assistance.';
  /// ```
  /// * default is english (en)
  String infoMessageGroupInviteLinkExpired() {
    if (languageLocale == 'de') return 'Der Einladungslink für diese Gruppe ist abgelaufen.\n\nGruppenbeitritt über diesen Link ist derzeit nicht möglich.\n\nBitte versuche es später erneut oder kontaktiere den Gruppenadministrator für weitere Unterstützung.';
    return 'The invite link for this group has expired.\n\nYou cannot join the group using this link at the moment.\n\nPlease try again later or contact the group admin for further assistance.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please create a selection.';
  /// ```
  /// * default is english (en)
  String failureNoSelectionWasMade() {
    if (languageLocale == 'de') return 'Bitte triff eine Auswahl.';
    return 'Please create a selection.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to access data, please try again.';
  /// ```
  /// * default is english (en)
  String failureFailedToInitializeEntrySelectorData() {
    if (languageLocale == 'de') return 'Fehler beim Datenaufruf, bitte versuche es noch einmal.';
    return 'Failed to access data, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please select an Model Entry.';
  /// ```
  /// * default is english (en)
  String failureNoModelEntrySelected() {
    if (languageLocale == 'de') return 'Bitte wähle eine Eintragsvorlage aus.';
    return 'Please select an model entry.';
  }

  /// Localizes the label
  /// ```dart
  /// 'This entry model cannot be deleted because there are entries connected to it.';
  /// ```
  /// * default is english (en)
  String failureEntryModelIsReferenced() {
    if (languageLocale == 'de') return 'Diese Eintragsvorlage kann nicht gelöscht werden, da es Einträge gibt die auf dieser basieren.';
    return 'This entry model cannot be deleted because there are entries connected to it.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Entry Model connected to this entry could not be found.';
  /// ```
  /// * default is english (en)
  String failureEntryModelNotFound() {
    if (languageLocale == 'de') return 'Die mit diesem Eintrag verbundene Eintragsvorlage konnte nicht gefunden werden.';
    return 'Entry Model connected to this entry could not be found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to update group, please try again.';
  /// ```
  /// * default is english (en)
  String failedToUpdateGroup() {
    if (languageLocale == 'de') return 'Fehler beim bearbeiten der Gruppe, bitte versuche es noch einmal.';
    return 'Failed to update group, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Images can only be edited if they are decrypted.';
  /// ```
  /// * default is english (en)
  String failureImagesAreDecrypting() {
    if (languageLocale == 'de') return 'Nur entschlüsselte Bilder können bearbeitet werden.';
    return 'Images can only be edited if they are decrypted.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Notifications are disabled.';
  /// ```
  /// * default is english (en)
  String failureNotificationsDisabled() {
    if (languageLocale == 'de') return 'Benachrichtigungen sind deaktiviert.';
    return 'Notifications are disabled.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Scheduleing notification failed.';
  /// ```
  /// * default is english (en)
  String failureSchedulingNotification() {
    if (languageLocale == 'de') return 'Anlegen der Benachrichtigung ist fehlgeschlagen.';
    return 'Scheduleing notification failed.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Notifications are not implemented for current platform.';
  /// ```
  /// * default is english (en)
  String failureNotificationsNotImplemented() {
    if (languageLocale == 'de') return 'Für diese Platform sind Benachrichtigungen noch nicht möglich.';
    return 'Notifications are not implemented for current platform.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Notifications cannot be in the past.';
  /// ```
  /// * default is english (en)
  String failureNotificationCannotBeInPast() {
    if (languageLocale == 'de') return 'Benachrichtigungen können nicht für die Vergangenheit angelegt werden.';
    return 'Notifications cannot be in the past.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Notification title cannot be empty.';
  /// ```
  /// * default is english (en)
  String failureNotificationTitleCannotBeEmpty() {
    if (languageLocale == 'de') return 'Bitte gib einen Title für die Benachrichtigung an.';
    return 'Notification title cannot be empty.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Initializeing notification plugin failed.';
  /// ```
  /// * default is english (en)
  String failureNotificationInitError() {
    if (languageLocale == 'de') return 'Initialisierung des Benachrichtigungsplugin ist fehlgeschlagen.';
    return 'Initializeing notification plugin failed.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Notification ID is not unique. Please try again to generate another ID.';
  /// ```
  /// * default is english (en)
  String failureNotificationIdIsNotUnique() {
    if (languageLocale == 'de') return 'Benachrichtigungs ID ist nicht einmalig. Bitte versuche es noch einmal um eine andere ID zu generieren.';
    return 'Notification ID is not unique. Please try again to generate another ID.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to access notification data.';
  /// ```
  /// * default is english (en)
  String failureNotificationPayloadInvalid() {
    if (languageLocale == 'de') return 'Fehler beim abrufen der Benachrichtigungsdaten.';
    return 'Failed to access notification data.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please provide a total amount for the field $fieldName.';
  /// ```
  /// * default is english (en)
  String failureExpeneseTotalNotSet({required String fieldName}) {
    if (languageLocale == 'de') return 'Bitte gib einen Gesamtbetrag für das Feld "$fieldName" an.';
    return 'Please provide a total amount for the field "$fieldName".';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please provide a valid total amount for the field $fieldName.';
  /// ```
  /// * default is english (en)
  String failurePaymentInvalidNumber({required String fieldName}) {
    if (languageLocale == 'de') return 'Bitte gib einen validen Gesamtbetrag für das Feld "$fieldName" an.';
    return 'Please provide a valid total amount for the field "$fieldName".';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please provide a total amount that is greater than zero for field $fieldName.';
  /// ```
  /// * default is english (en)
  String failureExpeneseTotalNotGreaterZero({required String fieldName}) {
    if (languageLocale == 'de') return 'Der Gesamtbetrag für das Feld "$fieldName" muss größer Null sein.';
    return 'Please provide a total amount that is greater than zero for field "$fieldName".';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please provide a currency for field $fieldName.';
  /// ```
  /// * default is english (en)
  String failureExpeneseTotalCurrencyNotSet({required String fieldName}) {
    if (languageLocale == 'de') return 'Bitte gib eine Währung für das Feld "$fieldName" an.';
    return 'Please provide a currency for field "$fieldName".';
  }

  /// Localizes the label
  /// ```dart
  /// 'Shares do not add up to total for field $fieldName.';
  /// ```
  /// * default is english (en)
  String failureExpeneseTotalDiffersFromShares({required String fieldName}) {
    if (languageLocale == 'de') return 'Der Gesamtbetrag unterscheidet sich von den aufaddierten Teilbeträgen für das Feld "$fieldName".';
    return 'Shares do not add up to total for field "$fieldName".';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please indicate who paid for the exepense for field $fieldName.';
  /// ```
  /// * default is english (en)
  String failureExpenesePaidByNotSelected({required String fieldName}) {
    if (languageLocale == 'de') return 'Bitte gib an wer für die Ausgabe bezahlt hat für das Feld "$fieldName".';
    return 'Please indicate who paid for the expense for field "$fieldName".';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please provide an exchange rate for field $fieldName.';
  /// ```
  /// * default is english (en)
  String expenseExchangeRateToDefaultInvalid({required String fieldName}) {
    if (languageLocale == 'de') return 'Bitte gib einen Wechselkurs für das Feld "$fieldName" an.';
    return 'Please provide an exchange rate for field "$fieldName".';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to create participant, please try again.';
  /// ```
  /// * default is english (en)
  String failedToCreateParticipant() {
    if (languageLocale == 'de') return 'Fehler beim erstellen des Mitglieds, bitte versuche es noch einmal';
    return 'Failed to create participant, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to update participant, please try again.';
  /// ```
  /// * default is english (en)
  String failedToUpdateParticipant() {
    if (languageLocale == 'de') return 'Fehler beim aktualisieren des Mitglieds, bitte versuche es noch einmal';
    return 'Failed to update participant, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to delete participant, please try again.';
  /// ```
  /// * default is english (en)
  String failedToDeleteParticipant() {
    if (languageLocale == 'de') return 'Fehler beim löschen des Mitglieds, bitte versuche es noch einmal';
    return 'Failed to delete participant, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'This entry is already a member.';
  /// ```
  /// * default is english (en)
  String failureEntryIsAlreadyMember() {
    if (languageLocale == 'de') return 'Dieser Eintrag ist bereits Mitglied.';
    return 'This entry is already a member.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please provide group data.';
  /// ```
  /// * default is english (en)
  String failureNoGroupData() {
    if (languageLocale == 'de') return 'Bitte gib Gruppendaten an.';
    return 'Please provide group data.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please provide a group name.';
  /// ```
  /// * default is english (en)
  String failureNoGroupName() {
    if (languageLocale == 'de') return 'Ein Gruppenname ist erforderlich.';
    return 'Please provide a group name.';
  }

  /// Localizes the label
  /// ```dart
  /// 'A previously made reference cannot be changed.';
  /// ```
  /// * default is english (en)
  String failureReferenceCannotChange() {
    if (languageLocale == 'de') return 'Referenzen können derzeit nicht bearbeitet werden.';
    return 'A previously made reference cannot be changed.';
  }

  /// Localizes the label
  /// ```dart
  /// 'This entry cannot be deleted because it is referenced as a member.';
  /// ```
  /// * default is english (en)
  String failureEntryIsReferencedAsMember() {
    if (languageLocale == 'de') return 'Dieser Eintrag kann nicht gelöscht werden weil er als Mitglied referenziert ist.';
    return 'This entry cannot be deleted because it is referenced as a member.';
  }

  /// Localizes the label
  /// ```dart
  /// 'This entry can only be added to one group because it depends on the members of this group.';
  /// ```
  /// * default is english (en)
  String failureInvalidNumberOfGroups() {
    if (languageLocale == 'de') return 'Dieser Eintrag kann nur zu einer einzelnen Gruppe hinzugefügt werden weil er von den Gruppenmitgliedern abhängig ist.';
    return 'This entry can only be added to one group because it depends on the members of this group.';
  }

  /// Localizes the label
  /// ```dart
  /// 'This group is locked.';
  /// ```
  /// * default is english (en)
  String failureGroupIsLocked() {
    if (languageLocale == 'de') return 'Diese Gruppe ist gesperrt.';
    return 'This group is locked.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Amount cannot be negative.';
  /// ```
  /// * default is english (en)
  String failureNegativeNumber() {
    if (languageLocale == 'de') return 'Betrag darf nicht negativ sein.';
    return 'Amount cannot be negative.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please delete all subgroups first.';
  /// ```
  /// * default is english (en)
  String failureGroupContainsSubgroups() {
    if (languageLocale == 'de') return 'Bitte lösche zunächst alle Untergruppen.';
    return 'Please delete all subgroups first.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please first add a quick add reference for this group in the edit group section.';
  /// ```
  /// * default is english (en)
  String failureInvalidQuickAddReference() {
    if (languageLocale == 'de') return 'Bitte wähle zunächst aus welchen Eintrag du schnell hinzufügen willst.';
    return 'Please first add a quick add reference for this group in the edit group section.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Edit denied.';
  /// ```
  /// * default is english (en)
  String failureEditDenied() {
    if (languageLocale == 'de') return 'Aktualisierung verweigert.';
    return 'Edit denied.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please provide a valid positive natural number.';
  /// ```
  /// * default is english (en)
  String failurePinDoesNotMeetRequirements() {
    if (languageLocale == 'de') return 'Bitte gib eine valide positive natürliche Zahl an.';
    return 'Please provide a valid positive natural number.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Pin must consist of at least 4 digits.';
  /// ```
  /// * default is english (en)
  String failurePinLengthInvalid() {
    if (languageLocale == 'de') return 'Bitte gib mindestens 4 Ziffern an.';
    return 'Pin must consist of at least 4 digits.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Cannot reference entry that is currently being edited.';
  /// ```
  /// * default is english (en)
  String failureCannotReferenceSelf() {
    if (languageLocale == 'de') return 'Eintrag der derzeit bearbeitet wird kann nicht referenziert werden.';
    return 'Cannot reference entry that is currently being edited.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to load chart, entry model not found.';
  /// ```
  /// * default is english (en)
  String failureChartEntryModelNotFound() {
    if (languageLocale == 'de') return 'Fehler beim laden des Diagramms, Eintragsvorlage nicht gefunden.';
    return 'Failed to load chart, entry model not found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to load chart, field identification not found.';
  /// ```
  /// * default is english (en)
  String failureChartFieldIdentificationNotFound() {
    if (languageLocale == 'de') return 'Fehler beim laden des Diagramms, Datenfeld nicht gefunden.';
    return 'Failed to load chart, field identification not found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Error loading bars.';
  /// ```
  /// * default is english (en)
  String failureChartErrorLoadingBars() {
    if (languageLocale == 'de') return 'Fehler beim laden der Diagrammbalken.';
    return 'Error loading bars.';
  }

  /// Localizes the label
  /// ```dart
  /// 'No chart data available.';
  /// ```
  /// * default is english (en)
  String failureChartNoDataAvailable() {
    if (languageLocale == 'de') return 'Keine Diagrammdaten verfügbar.';
    return 'No chart data available.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to create chart, please try again.';
  /// ```
  /// * default is english (en)
  String failureChartCreation() {
    if (languageLocale == 'de') return 'Fehler beim erstellen des Diagramms, bitte versuch es noch einmal.';
    return 'Failed to create chart, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to update chart, please try again.';
  /// ```
  /// * default is english (en)
  String failureChartUpdate() {
    if (languageLocale == 'de') return 'Fehler beim aktualisieren des Diagramms, bitte versuch es noch einmal.';
    return 'Failed to update chart, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to delete chart, please try again.';
  /// ```
  /// * default is english (en)
  String failureChartDelete() {
    if (languageLocale == 'de') return 'Fehler beim löschen des Diagramms, bitte versuch es noch einmal.';
    return 'Failed to delete chart, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to add reference, please try again.';
  /// ```
  /// * default is english (en)
  String failureAddingReference() {
    if (languageLocale == 'de') return 'Fehler beim erstellen der Referenz, bitte versuche es noch einmal.';
    return 'Failed to add reference, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to delete reference, please try again.';
  /// ```
  /// * default is english (en)
  String failureDeleteReference() {
    if (languageLocale == 'de') return 'Fehler beim löschen der Referenz, bitte versuche es noch einmal.';
    return 'Failed to delete reference, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'It seems like selected group is empty.\n\nAdd some entries to see charts.';
  /// ```
  /// * default is english (en)
  String failureChartEmptyGroup() {
    if (languageLocale == 'de') return 'Anscheinend ist die ausgewählte Gruppe leer.\n\nFüge zunächst Einträge zu der Gruppe hinzu,um Diagramme angezeigt zu bekommen.';
    return 'It seems like selected group is empty.\n\nAdd some entries to see charts.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please first select base data.';
  /// ```
  /// * default is english (en)
  String failureChartSelectBaseData() {
    if (languageLocale == 'de') return 'Bitte wähle zunächst die Stammdaten aus.';
    return 'Please first select base data.';
  }

  /// Localizes the label
  /// ```dart
  /// 'This field has currently no chart instructions available. Please choose a different base data field.';
  /// ```
  /// * default is english (en)
  String failureChartNoChartInstructionsAvailable() {
    if (languageLocale == 'de') return 'Für dieses Datenfeld können im Moment noch keine Diagramme erstellt werden. Bitte wähle andere Stammdaten aus.';
    return 'This field has currently no chart instructions available. Please choose a different base data field.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please first assign members to selected group.';
  /// ```
  /// * default is english (en)
  String failureNoMembersAssignedToGroup() {
    if (languageLocale == 'de') return 'Bitte weise der ausgewählter Gruppe zunächst, in den Gruppeneinstellungen, Mitglieder zu.';
    return 'Please first assign members to selected group.\n\nThis can be done in the group settings.';
  }

  /// Localizes the label
  /// ```dart
  /// 'No chart bars created.';
  /// ```
  /// * default is english (en)
  String failureNoChartBarsCreated() {
    if (languageLocale == 'de') return 'Keine Diagrammbalken erstellt.';
    return 'No chart bars created.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Selection data needs to be of same type.';
  /// ```
  /// * default is english (en)
  String failureSelectionDataDiffers() {
    if (languageLocale == 'de') return 'Eine Auswahl kann nur aus gleichen Datentypen bestehen.';
    return 'Selection data needs to be of same type.';
  }

  /// Localizes the label
  /// ```dart
  /// 'This item already exists in selection.';
  /// ```
  /// * default is english (en)
  String failureEqualSelectionValue() {
    if (languageLocale == 'de') return 'Dieses Element ist bereits in dieser Auswahl.';
    return 'This item already exists in selection.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please first select base field.';
  /// ```
  /// * default is english (en)
  String failureNoBaseFieldSelected() {
    if (languageLocale == 'de') return 'Bitte wähle zunächst ein Datenfeld aus.';
    return 'Please first select base field.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Unknown combination, please try again.';
  /// ```
  /// * default is english (en)
  String failureUnknownCombination() {
    if (languageLocale == 'de') return 'Kombination umbekannt, bitte versuche es noch einmal.';
    return 'Unknown combination, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'This is currently under construction, sorry for the inconvenience.';
  /// ```
  /// * default is english (en)
  String failureCurrentlyUnderConstruction() {
    if (languageLocale == 'de') return 'Dies befindet sich derzeit im Aufbau, bitte versuche es später noch einmal.';
    return 'This is currently under construction, please try again later.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please first select a combine field.';
  /// ```
  /// * default is english (en)
  String failureNoCombineField() {
    if (languageLocale == 'de') return 'Bitte wähle zunächst ein Kombinationsfeld aus.';
    return 'Please first select a combine field.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please first select a member.';
  /// ```
  /// * default is english (en)
  String failureNoMemberSelected() {
    if (languageLocale == 'de') return 'Bitte wähle zunächst ein Mitglied aus.';
    return 'Please first select a member.';
  }

  /// Localizes the label
  /// ```dart
  /// 'An entry name is required.';
  /// ```
  /// * default is english (en)
  String failureEntryNameRequired() {
    if (languageLocale == 'de') return 'Bitte gib einen Eintragsnamen an.';
    return 'An entry name is required.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to create user, please try again.';
  /// ```
  /// * default is english (en)
  String failureToCreateUser() {
    if (languageLocale == 'de') return 'Benutzererstellung fehlgeschlagen, bitte versuche es noch einmal';
    return 'Failed to create user, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to update user, please try again.';
  /// ```
  /// * default is english (en)
  String failureToUpdateUser() {
    if (languageLocale == 'de') return 'Aktualisierung fehlgeschlagen, bitte versuche es noch einmal';
    return 'Failed to update user, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to create tag, please try again.';
  /// ```
  /// * default is english (en)
  String failureToCreateTag() {
    if (languageLocale == 'de') return 'Erstellen des Tags fehlgeschlagen, bitte versuche es noch einmal';
    return 'Failed to create tag, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to create tag, please try again.';
  /// ```
  /// * default is english (en)
  String failureInvalidTag() {
    if (languageLocale == 'de') return 'Ungültiges Tag, bitte verwende nur Kleinbuchstaben, Zahlen, Leerzeichen und folgende Sonderzeichen:\n% = ~ & °';
    return 'Invalid tag, please only use lower case letters, numbers, spaces and the following special characters:\n% = ~ & °';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please provide a Tag for field $fieldName.';
  /// ```
  /// * default is english (en)
  String failureSharedExpenseTagRequired({required String fieldName}) {
    if (languageLocale == 'de') return 'Bitte gib ein Tag für das Feld "$fieldName" an.';
    return 'Please provide a Tag for field "$fieldName".';
  }

  /// Localizes the label
  /// ```dart
  /// 'Invalid pin.\n\nThe maximum length is 25 characters.';
  /// ```
  /// * default is english (en)
  String failureAccessPinTooLong() {
    if (languageLocale == 'de') return 'Pin ungültig.\n\nDie maximale Länge ist 25 Zeichen.';
    return 'Invalid pin.\n\nThe maximum length is 25 characters.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Invalid pin.\n\nOnly lower case letters, upper case letters and numbers are allowed.';
  /// ```
  /// * default is english (en)
  String failureAccessInvalidCharacters() {
    if (languageLocale == 'de') return 'Pin ungültig.\n\nEs sind nur Kleinbuchstaben, Grossbuchstaben und Nummern erlaubt.';
    return 'Invalid pin.\n\nOnly lower case letters, upper case letters and numbers are allowed.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please provide an access pin.';
  /// ```
  /// * default is english (en)
  String failureAccessPinRequired() {
    if (languageLocale == 'de') return 'Bitte gib einen Zugangspin an.';
    return 'Please provide an access pin.';
  }

  /// Localizes the label
  /// ```dart
  /// 'try again';
  /// ```
  /// * default is english (en)
  String groupInviteSheetTryAgain() {
    if (languageLocale == 'de') return 'Noch einmal versuchen';
    return 'Try again';
  }

  /// Localizes the label
  /// ```dart
  /// 'load group...';
  /// ```
  /// * default is english (en)
  String groupInviteSheetIsLoadingMessage() {
    if (languageLocale == 'de') return 'Gruppe laden...';
    return 'Load group...';
  }

  /// Localizes the label
  /// ```dart
  /// 'Validate access';
  /// ```
  /// * default is english (en)
  String groupInviteSheetTitlePinRequired() {
    if (languageLocale == 'de') return 'Zugang bestätigen';
    return 'Validate access';
  }

  /// Localizes the label
  /// ```dart
  /// 'Access pin';
  /// ```
  /// * default is english (en)
  String groupInviteSheetAccessPin() {
    if (languageLocale == 'de') return 'Zugangspin';
    return 'Access pin';
  }

  /// Localizes the label
  /// ```dart
  /// 'This group is protected by an access pin.\n\nPlease provide the correct pin to gain access to this group.';
  /// ```
  /// * default is english (en)
  String groupInviteSheetAccessPinInfoMessage() {
    if (languageLocale == 'de') return 'Diese Gruppe ist durch eine Pin geschützt.\n\nBitte gib die richtige Pin an um Zugang zu dieser Gruppe zu erhalten.';
    return 'This group is protected by an access pin.\n\nPlease provide the correct pin to gain access to this group.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Join group';
  /// ```
  /// * default is english (en)
  String groupInviteSheetTitle() {
    if (languageLocale == 'de') return 'Gruppe beitreten';
    return 'Join group';
  }

  /// Localizes the label
  /// ```dart
  /// return openWrites ? 'Anyone can add or update entries to this group.' : 'Only group creator can add entries to this group.';
  /// ```
  /// * default is english (en)
  String groupInviteSheetOpenWrites({required bool openWrites}) {
    if (languageLocale == 'de') return openWrites ? 'Jeder kann Einträge zu dieser Gruppe hinzufügen oder aktualisieren.' : 'Nur der Gruppenersteller kann Einträge zu dieser Gruppe hinzufügen oder aktualisieren.';
    return openWrites ? 'Anyone can add or update entries to this group.' : 'Only group creator can add entries to this group.';
  }

  /// Localizes the label
  /// ```dart
  /// return offlineFirst ? 'This is an offline first group' : 'This is an online first group';
  /// ```
  /// * default is english (en)
  String groupInviteSheetOfflineFirst({required bool offlineFirst}) {
    if (languageLocale == 'de') return offlineFirst ? 'Dies ist eine offline zuerst Gruppe' : 'Diese ist eine online zuerst Gruppe';
    return offlineFirst ? 'This is an offline first group' : 'This is an online first group';
  }

  /// Localizes the label
  /// ```dart
  /// if (offlineFirst == false) return 'Entries of this group wont be saved locally.';
  /// if (entriesCount == 1) return 'Joining this group will currently download and save 1 Entry on this device.';
  /// return 'Joining this group will currently download and save $entriesCount Entries on this device.';
  /// ```
  /// * default is english (en)
  String groupInviteSheetOfflineFirstInfoMessage({required bool offlineFirst, required int entriesCount}) {
    if (languageLocale == 'de') {
      if (offlineFirst == false) return 'Einträge dieser Gruppe werden nicht auf dem Gerät gespeichert.';
      if (entriesCount == 1) return 'Das beitreten dieser Gruppe wird derzeit 1 Eintrag herunterladen und auf dem Gerät speichern.';
      return 'Das beitreten dieser Gruppe wird derzeit $entriesCount Einträge herunterladen und auf dem Gerät speichern.';
    }

    if (offlineFirst == false) return 'Entries of this group wont be saved locally.';
    if (entriesCount == 1) return 'Joining this group will currently download and save 1 Entry on this device.';
    return 'Joining this group will currently download and save $entriesCount Entries on this device.';
  }

  /// Localizes the label
  /// ```dart
  /// return pinRequired ? 'Request access' : 'Join group';
  /// ```
  /// * default is english (en)
  String groupInviteSheetMainButton({required bool pinRequired}) {
    if (languageLocale == 'de') return pinRequired ? 'Zugang anfordern' : 'Gruppe beitreten';
    return pinRequired ? 'Request access' : 'Join group';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to create member, please try again.';
  /// ```
  /// * default is english (en)
  String failedToCreateMember() {
    if (languageLocale == 'de') return 'Mitglied erstellen fehlgeschlagen, bitte versuche es noch einmal.';
    return 'Failed to create member, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to update member, please try again.';
  /// ```
  /// * default is english (en)
  String failedToUpdateMember() {
    if (languageLocale == 'de') return 'Mitglied aktualisierung fehlgeschlagen, bitte versuche es noch einmal.';
    return 'Failed to update member, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'This member is already part of this participant.';
  /// ```
  /// * default is english (en)
  String failureMemberAlreadyPartOfParticipant() {
    if (languageLocale == 'de') return 'Dieses Mitglied ist bereits Teil der Mitwirkenden.';
    return 'This member is already part of this participant.';
  }

  /// Localizes the label
  /// ```dart
  /// 'No members created yet.';
  /// ```
  /// * default is english (en)
  String failureNoMembersCreated() {
    if (languageLocale == 'de') return 'Noch keine Mitglieder erstellt.';
    return 'No members created yet.';
  }

  /// Localizes the label
  /// ```dart
  /// 'An object with this id already exists.';
  /// ```
  /// * default is english (en)
  String failureStorageObjectExists() {
    if (languageLocale == 'de') return 'Ein Objekt mit dieser ID existiert bereits.';
    return 'An object with this id already exists.';
  }

  /// Localizes the label
  /// ```dart
  /// 'An object with this id does not exist.';
  /// ```
  /// * default is english (en)
  String failureStorageObjectDoesNotExist() {
    if (languageLocale == 'de') return 'Ein Objekt mit dieser ID existiert nicht.';
    return 'An object with this id does not exist.';
  }

  /// Localizes the label
  /// ```dart
  /// 'This collection does not exist.';
  /// ```
  /// * default is english (en)
  String failureStorageUnknownCollection() {
    if (languageLocale == 'de') return 'Diese Kollektion existiert nicht.';
    return 'This collection does not exist.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to load groups, please try again.';
  /// ```
  /// * default is english (en)
  String failureToLoadGroups() {
    if (languageLocale == 'de') return 'Laden der Gruppen fehlgeschlagen, bitte versuche es noch einmal.';
    return 'Failed to load groups, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to load entries, please try again.';
  /// ```
  /// * default is english (en)
  String failureToLoadEntries() {
    if (languageLocale == 'de') return 'Laden der Einträge fehlgeschlagen, bitte versuche es noch einmal.';
    return 'Failed to load entries, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please assign at least one Member to this Participant.';
  /// ```
  /// * default is english (en)
  String failureEmptyParticipantMembers() {
    if (languageLocale == 'de') return 'Bitte weise mindestens ein Mitglied zu.';
    return 'Please assign at least one Member to this Participant.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Unknown group type, please try again.';
  /// ```
  /// * default is english (en)
  String failureUnknownGroupType() {
    if (languageLocale == 'de') return 'Unbekannter Gruppentyp, bitte versuche es noch einmal.';
    return 'Unknown group type, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to load subgroups, please try again.';
  /// ```
  /// * default is english (en)
  String failureToLoadSubgroups() {
    if (languageLocale == 'de') return 'Laden der Untergruppen fehlgeschlagen, bitte versuche es noch einmal.';
    return 'Failed to load subgroups, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please assign a name to this Participant.';
  /// ```
  /// * default is english (en)
  String failureEmptyParticipantName() {
    if (languageLocale == 'de') return 'Bitte gib einen Namen für die Mitwirkenden an.';
    return 'Please assign a name to this Participant.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to create exchange rate, please try again.';
  /// ```
  /// * default is english (en)
  String failedToCreateExchangeRate() {
    if (languageLocale == 'de') return 'Erstellen des Wechselkurses fehlgeschlagen, bitte versuche es noch einmal.';
    return 'Failed to create exchange rate, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'A member with this name already exists.';
  /// ```
  /// * default is english (en)
  String memberNameExists() {
    if (languageLocale == 'de') return 'Ein Teilnehmer mit diesem Namen existiert bereits.';
    return 'A member with this name already exists.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to create shared group, please try again.';
  /// ```
  /// * default is english (en)
  String failedToCreateSharedGroup() {
    if (languageLocale == 'de') return 'Fehler beim erstellen der geteilten Gruppe. Bitte versuche es nocheinmal.';
    return 'Failed to create shared group, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Requested group was not found, it may have been deleted.';
  /// ```
  /// * default is english (en)
  String sharedGroupNotFound() {
    if (languageLocale == 'de') return 'Gruppe konnte nicht gefunden werden. Möglicherweise wurde diese gelöscht.';
    return 'Requested group was not found, it may have been deleted.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Only the group creator can edit this group.';
  /// ```
  /// * default is english (en)
  String groupEditPermitted() {
    if (languageLocale == 'de') return 'Nur der Gruppenersteller kann diese Gruppe bearbeiten.';
    return 'Only the group creator can edit this group.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Could not find referenced participant.';
  /// ```
  /// * default is english (en)
  String participantNotFound() {
    if (languageLocale == 'de') return 'Referenzierte Mitwirkende konnten nicht gefunden werden.';
    return 'Could not find referenced participant.';
  }

  /// Localizes the label
  /// ```dart
  /// 'No ModelEntry created yet.';
  /// ```
  /// * default is english (en)
  String noModelEntryCreatedYet() {
    if (languageLocale == 'de') return 'Noch keine Eintragsvorlage erstellt.';
    return 'No ModelEntry created yet.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Update failed, please try again.';
  /// ```
  /// * default is english (en)
  String failedToPutRecentEntry() {
    if (languageLocale == 'de') return 'Aktualisierung fehlgeschlagen, bitte versuche es noch einmal.';
    return 'Update failed, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Delete failed, please try again.';
  /// ```
  /// * default is english (en)
  String failedToDeleteRecentEntry() {
    if (languageLocale == 'de') return 'Löschen fehlgeschlagen, bitte versuche es noch einmal.';
    return 'Delete failed, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Currently images cannot be stored online.';
  /// ```
  /// * default is english (en)
  String imagesCloudStorageUnavailable() {
    if (languageLocale == 'de') return 'Derzeit können Bilder nicht online gespeichert werden.';
    return 'Currently images cannot be stored online.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Currently files cannot be stored online.';
  /// ```
  /// * default is english (en)
  String filesCloudStorageUnavailable() {
    if (languageLocale == 'de') return 'Derzeit können Dateien nicht online gespeichert werden.';
    return 'Currently files cannot be stored online.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Currently references to other entries cannot be stored online.';
  /// ```
  /// * default is english (en)
  String entryReferenceStorageUnavailable() {
    if (languageLocale == 'de') return 'Derzeit können Referenzen zu anderen Einträgen nicht online gespeichert werden.';
    return 'Currently references to other entries cannot be stored online.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to load model entries, please try again.';
  /// ```
  /// * default is english (en)
  String failedToLoadModelEntries() {
    if (languageLocale == 'de') return 'Laden der Eintragsvorlagen fehlgeschlagen, bitte versuche es noch einmal.';
    return 'Failed to load model entries, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'You do not have edit permissions for this entry.';
  /// ```
  /// * default is english (en)
  String entryEditProhibited() {
    if (languageLocale == 'de') return 'Du kannst diesen Eintrag nicht bearbeiten.';
    return 'You do not have edit permissions for this entry.';
  }

  /// Localizes the label
  /// ```dart
  /// 'You do not have the permission to add an entry to this group.';
  /// ```
  /// * default is english (en)
  String entryAddProhibited() {
    if (languageLocale == 'de') return 'Du kannst zu dieser Gruppe keine Einträge hinzufügen.';
    return 'You do not have the permission to add an entry to this group.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Only the group creator can delete this group.';
  /// ```
  /// * default is english (en)
  String groupDeletePermitted() {
    if (languageLocale == 'de') return 'Nur der Gruppenersteller kann diese Gruppe löschen.';
    return 'Only the group creator can delete this group.';
  }

  /// Localizes the label
  /// ```dart
  /// 'You do not have permission to delete this subgroup.';
  /// ```
  /// * default is english (en)
  String subgroupDeleteProhibited() {
    if (languageLocale == 'de') return 'Fehlende Berechtigung zum löschen der Untergruppe.';
    return 'You do not have permission to delete this subgroup.';
  }

  /// Localizes the label
  /// ```dart
  /// 'You do not have permission to delete this entry.';
  /// ```
  /// * default is english (en)
  String entryDeleteProhibited() {
    if (languageLocale == 'de') return 'Fehlende Berechtigung zum löschen des Eintrags.';
    return 'You do not have permission to delete this entry.';
  }

  /// This getter can be used to access the info message based on invite specs.
  String infoMessageInviteLink({required InviteSpecs inviteSpecs}) {
    // Convenience variables.
    final bool hasLimit = inviteSpecs.usageLimit != null;
    final bool hasExpirationDate = inviteSpecs.expirationDateInUtc != null;
    final DateTime nowInUtc = DateTime.now().toUtc();

    // * Unlimited.
    if (hasLimit == false && hasExpirationDate == false) {
      if (languageLocale == 'de') return 'Derzeitiger Einladungslink hat keine Limits und läuft nicht ab.\n\nDas bedeutet, dass jeder der diesen Link hat der Gruppe beitreten kann.\n\nDies kann unter "Gruppe bearbeiten" geändert werden.';
      return 'Current invite link does not impose any limits and does not expire.\n\nThis means anyone that has this link can join this group.\n\nYou can change this in the "Edit group" section.';
    }

    // * Usage exhausted.
    if (hasLimit && inviteSpecs.usageLimit! <= 0) {
      if (languageLocale == 'de') return 'Derzeitiger Einladungslink verhindert das der Gruppe beigetreten werden kann, weil das Nutzungslimit erschöpft ist.\n\nDies kann unter "Gruppe bearbeiten" geändert werden.';
      return 'Current invite link prevents anyone from joining the group because usage limit has been exhausted.\n\nYou can change this in the "Edit group" section.';
    }

    // * Expiration exhausted.
    if (hasExpirationDate && inviteSpecs.expirationDateInUtc!.isBefore(nowInUtc)) {
      if (languageLocale == 'de') return 'Derzeitiger Einladungslink verhindert das der Gruppe beigetreten werden kann, weil das Ablaufdatum erreicht wurde.\n\nDies kann unter "Gruppe bearbeiten" geändert werden.';
      return 'Current invite link prevents anyone from joining the group because it has expired.\n\nYou can change this in the "Edit group" section.';
    }

    // * Return default.
    return '';
  }

  /// Localizes the label
  /// ```dart
  /// 'Invalid group type for this action.';
  /// ```
  /// * default is english (en)
  String failureInvalidGroupType() {
    if (languageLocale == 'de') return 'Ungültiger Gruppentyp für diese Aktion.';
    return 'Invalid group type for this action.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to fetch suggestions.';
  /// ```
  /// * default is english (en)
  String failureToFetchSuggestions() {
    if (languageLocale == 'de') return 'Fehler beim laden der Vorschläge.';
    return 'Failed to fetch suggestions.';
  }

  /// Localizes the label
  /// ```dart
  /// 'You cannot add a subgroup to this group.';
  /// ```
  /// * default is english (en)
  String subgroupAddProhibited() {
    if (languageLocale == 'de') return 'Du kannst zu dieser Gruppe keine Untergruppe hinzufügen.';
    return 'You cannot add a subgroup to this group.';
  }

  /// Localizes the label
  /// ```dart
  /// 'You do not have permissions to edit this subgroup.';
  /// ```
  /// * default is english (en)
  String subgroupEditProhibited() {
    if (languageLocale == 'de') return 'Du hast nicht die Berechtigungen zum bearbeiten dieser Untergruppe.';
    return 'You do not have permissions to edit this subgroup.';
  }

  /// Localizes the label
  /// ```dart
  /// 'A root group reference is required.';
  /// ```
  /// * default is english (en)
  String rootGroupRequired() {
    if (languageLocale == 'de') return 'Die Stammgruppenreferenz ist notwendig.';
    return 'A root group reference is required.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to delete preferences, please try again.';
  /// ```
  /// * default is english (en)
  String failedToDeleteModelEntryPrefs() {
    if (languageLocale == 'de') return 'Fehler beim löschen der Präferenzen, bitte versuche es noch einmal.';
    return 'Failed to delete preferences, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to create preferences, please try again.';
  /// ```
  /// * default is english (en)
  String failedToCreateModelEntryPrefs() {
    if (languageLocale == 'de') return 'Fehler beim erstellen der Präferenzen, bitte versuche es noch einmal.';
    return 'Failed to create preferences, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to update preferences, please try again.';
  /// ```
  /// * default is english (en)
  String failedToUpdateModelEntryPrefs() {
    if (languageLocale == 'de') return 'Fehler beim aktualisieren der Präferenzen, bitte versuche es noch einmal.';
    return 'Failed to update preferences, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'This feature is not yet implemented, please try again later.';
  /// ```
  /// * default is english (en)
  String unimplemented() {
    if (languageLocale == 'de') return 'Diese Funktion ist noch nicht implementiert, bitte versuche es später noch einmal.';
    return 'This feature is not yet implemented, please try again later.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to save preferences, please try again.';
  /// ```
  /// * default is english (en)
  String failedToPutModelEntryPrefs() {
    if (languageLocale == 'de') return 'Fehler beim Speichern der Präferenzen, bitte versuche es noch einmal.';
    return 'Failed to save preferences, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to save preferences, please try again.';
  /// ```
  /// * default is english (en)
  String failedToCreateGroupPrefs() {
    if (languageLocale == 'de') return 'Fehler beim Speichern der Präferenzen, bitte versuche es noch einmal.';
    return 'Failed to save preferences, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to update preferences, please try again.';
  /// ```
  /// * default is english (en)
  String failedToUpdateGroupPrefs() {
    if (languageLocale == 'de') return 'Fehler beim aktualisieren der Präferenzen, bitte versuche es noch einmal.';
    return 'Failed to update preferences, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to delete preferences, please try again.';
  /// ```
  /// * default is english (en)
  String failedToDeleteGroupPrefs() {
    if (languageLocale == 'de') return 'Fehler beim löschen der Präferenzen, bitte versuche es noch einmal.';
    return 'Failed to delete preferences, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to save preferences, please try again.';
  /// ```
  /// * default is english (en)
  String failedToPutGroupPrefs() {
    if (languageLocale == 'de') return 'Fehler beim Speichern der Präferenzen, bitte versuche es noch einmal.';
    return 'Failed to save preferences, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Remove from restrictions?';
  /// ```
  /// * default is english (en)
  String createGroupSheetRemoveModelEntry() {
    if (languageLocale == 'de') return 'Aus Beschränkungen entfernen?';
    return 'Remove from restrictions?';
  }

  /// Localizes the label
  /// ```dart
  /// 'Deleted ModelEntry';
  /// ```
  /// * default is english (en)
  String deletedModelEntry() {
    if (languageLocale == 'de') return 'Gelöschte Eintragsvorlage';
    return 'Deleted ModelEntry';
  }

  /// Localizes the label
  /// ```dart
  /// 'Selected quick add ModelEntry was deleted.';
  /// ```
  /// * default is english (en)
  String quickAddReferenceDeleted() {
    if (languageLocale == 'de') return 'Ausgewählte Eintragsvorlage wurde gelöscht.';
    return 'Selected quick add ModelEntry was deleted.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Cannot add this entry to this group because this group does not allow ModelEntry of this type.';
  /// ```
  /// * default is english (en)
  String modelEntryNotInRestrictions() {
    if (languageLocale == 'de') return 'Dieser Eintrag kann nicht zu dieser Gruppe hinzugefügt werden weil diese Gruppe Eintragsvorlagen dieses Typs nicht erlaubt.';
    return 'Cannot add this entry to this group because this group does not allow ModelEntry of this type.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please authenticate before trying to join a group.';
  /// ```
  /// * default is english (en)
  String loginRequiredBeforeDeepLink() {
    if (languageLocale == 'de') return 'Bitte authentisiere dich bevor du versuchst einer Gruppe beizutreten.';
    return 'Please authenticate before trying to join a group.';
  }

  /// Localizes the label
  /// ```dart
  /// return isShared ? 'Common model entries are available to all group members.' : 'Restrictions can be used to make sure that only Entries of specified types can be added to this group.';
  /// ```
  /// * default is english (en)
  String createGroupRestrictionsInfoMessage({required bool isShared}) {
    if (languageLocale == 'de') return isShared ? 'Gemeinsame Eintragsvorlagen stehen allen Gruppenmitgliedern zu Verfügung.' : 'Verwende Beschränkungen um sicherzustellen, dass nur Einträge des ausgewählten Typs dieser Gruppe hinzugefügt werden können.';
    return isShared ? 'Common model entries are available to all group members.' : 'Restrictions can be used to make sure that only Entries of specified types can be added to this group.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Use this to ensure that only Entries of specified types can be added to this group.';
  /// ```
  /// * default is english (en)
  String restrictToCommonInfoMessage() {
    if (languageLocale == 'de') return 'Verwende dies, um sicherzustellen, dass nur Einträge die diese Eintragsvorlagen verwenden zu dieser Gruppe hinzugefügt werden können.';
    return 'Use this to ensure that only entries that use specified model entries can be added to this group.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please pick a measurement unit.';
  /// ```
  /// * default is english (en)
  String measurementUnitIsRequired({required String fieldName}) {
    if (languageLocale == 'de') return 'Bitte gib für das Feld "$fieldName" eine Messeinheit an.';
    return 'Please pick a measurement unit for the field "$fieldName".';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please pick a measurement date.';
  /// ```
  /// * default is english (en)
  String measurementDateIsRequired({required String fieldName}) {
    if (languageLocale == 'de') return 'Bitte gib für das Feld "$fieldName" ein Messdatum an.';
    return 'Please pick a measurement date for the field "$fieldName".';
  }

  /// Localizes the label
  /// ```dart
  /// 'Set default exchange rates.';
  /// ```
  /// * default is english (en)
  String setDefaultExchangeRates() {
    if (languageLocale == 'de') return 'Standard Wechselkurse festlegen';
    return 'Set default exchange rates.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Choose from currency code';
  /// ```
  /// * default is english (en)
  String chooseFromCurrency() {
    if (languageLocale == 'de') return 'Von Währung wählen';
    return 'Choose from currency code';
  }

  /// Localizes the label
  /// ```dart
  /// 'Choose to currency code';
  /// ```
  /// * default is english (en)
  String chooseToCurrency() {
    if (languageLocale == 'de') return 'Zu Währung wählen';
    return 'Choose to currency code';
  }

  /// Localizes the label
  /// ```dart
  /// 'Set exchange rate';
  /// ```
  /// * default is english (en)
  String setExchangeRate() {
    if (languageLocale == 'de') return 'Wechselkurs festlegen';
    return 'Set exchange rate';
  }

  /// Localizes the label
  /// ```dart
  /// '$fromCurrency to $toCurrency: $exchangeRate';
  /// ```
  /// * default is english (en)
  String defaultExchangeRatesChipLabel({required String fromCurrency, required String toCurrency, required String exchangeRate}) {
    if (languageLocale == 'de') return '$fromCurrency zu $toCurrency: $exchangeRate';
    return '$fromCurrency to $toCurrency: $exchangeRate';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please pick a date for the field "$fieldName".';
  /// ```
  /// * default is english (en)
  String moneyDateIsRequired({required String fieldName}) {
    if (languageLocale == 'de') return 'Bitte gib ein Datum für das Feld "$fieldName" an.';
    return 'Please pick a date for the field "$fieldName".';
  }

  /// Localizes the label
  /// ```dart
  /// 'Made selection is invalid.';
  /// ```
  /// * default is english (en)
  String invalidEmotionItem() {
    if (languageLocale == 'de') return 'Gemachte Auswahl is ungültig.';
    return 'Made selection is invalid.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Currently avatar images cannot be stored online.';
  /// ```
  /// * default is english (en)
  String avatarImageStorageUnavailable() {
    if (languageLocale == 'de') return 'Derzeit können Avatarbilder nicht online gespeichert werden.';
    return 'Currently avatar images cannot be stored online.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Happiness';
  /// ```
  /// * default is english (en)
  String emotionHappiness() {
    if (languageLocale == 'de') return 'Freude';
    return 'Happiness';
  }

  /// Localizes the label
  /// ```dart
  /// 'Sadness';
  /// ```
  /// * default is english (en)
  String emotionSadness() {
    if (languageLocale == 'de') return 'Traurigkeit';
    return 'Sadness';
  }

  /// Localizes the label
  /// ```dart
  /// 'Fear';
  /// ```
  /// * default is english (en)
  String emotionFear() {
    if (languageLocale == 'de') return 'Angst';
    return 'Fear';
  }

  /// Localizes the label
  /// ```dart
  /// 'Anger';
  /// ```
  /// * default is english (en)
  String emotionAnger() {
    if (languageLocale == 'de') return 'Wut';
    return 'Anger';
  }

  /// Localizes the label
  /// ```dart
  /// 'Surprise';
  /// ```
  /// * default is english (en)
  String emotionSurprise() {
    if (languageLocale == 'de') return 'Überraschung';
    return 'Surprise';
  }

  /// Localizes the label
  /// ```dart
  /// 'Disgust';
  /// ```
  /// * default is english (en)
  String emotionDisgust() {
    if (languageLocale == 'de') return 'Ekel';
    return 'Disgust';
  }

  /// Localizes the label
  /// ```dart
  /// 'Melancholy';
  /// ```
  /// * default is english (en)
  String emotionMelancholy() {
    if (languageLocale == 'de') return 'Melancholie';
    return 'Melancholy';
  }

  /// Localizes the label
  /// ```dart
  /// 'Enthusiasm';
  /// ```
  /// * default is english (en)
  String emotionEnthusiasm() {
    if (languageLocale == 'de') return 'Begeisterung';
    return 'Enthusiasm';
  }

  /// Localizes the label
  /// ```dart
  /// 'Contentment';
  /// ```
  /// * default is english (en)
  String emotionContentment() {
    if (languageLocale == 'de') return 'Zufriedenheit';
    return 'Contentment';
  }

  /// Localizes the label
  /// ```dart
  /// 'Confusion';
  /// ```
  /// * default is english (en)
  String emotionConfusion() {
    if (languageLocale == 'de') return 'Verwirrung';
    return 'Confusion';
  }

  /// Localizes the label
  /// ```dart
  /// 'Bitterness';
  /// ```
  /// * default is english (en)
  String emotionBitterness() {
    if (languageLocale == 'de') return 'Verbitterung';
    return 'Bitterness';
  }

  /// Localizes the label
  /// ```dart
  /// 'Nostalgia';
  /// ```
  /// * default is english (en)
  String emotionNostalgia() {
    if (languageLocale == 'de') return 'Nostalgie';
    return 'Nostalgia';
  }

  /// Localizes the label
  /// ```dart
  /// 'Jealousy';
  /// ```
  /// * default is english (en)
  String emotionJealousy() {
    if (languageLocale == 'de') return 'Eifersucht';
    return 'Jealousy';
  }

  /// Localizes the label
  /// ```dart
  /// 'Guilt';
  /// ```
  /// * default is english (en)
  String emotionGuilt() {
    if (languageLocale == 'de') return 'Schuld';
    return 'Guilt';
  }

  /// Localizes the label
  /// ```dart
  /// 'Anxiety';
  /// ```
  /// * default is english (en)
  String emotionAnxiety() {
    if (languageLocale == 'de') return 'Anxiety';
    return 'Anxiety';
  }

  /// Localizes the label
  /// ```dart
  /// 'Curiosity';
  /// ```
  /// * default is english (en)
  String emotionCuriosity() {
    if (languageLocale == 'de') return 'Neugier';
    return 'Curiosity';
  }

  /// Localizes the label
  /// ```dart
  /// 'Compassion';
  /// ```
  /// * default is english (en)
  String emotionCompassion() {
    if (languageLocale == 'de') return 'Mitgefühl';
    return 'Compassion';
  }

  /// Localizes the label
  /// ```dart
  /// 'Pride';
  /// ```
  /// * default is english (en)
  String emotionPride() {
    if (languageLocale == 'de') return 'Stolz';
    return 'Pride';
  }

  /// Localizes the label
  /// ```dart
  /// 'Shame';
  /// ```
  /// * default is english (en)
  String emotionShame() {
    if (languageLocale == 'de') return 'Scham';
    return 'Shame';
  }

  /// Localizes the label
  /// ```dart
  /// 'Regret';
  /// ```
  /// * default is english (en)
  String emotionRegret() {
    if (languageLocale == 'de') return 'Bedauern';
    return 'Regret';
  }

  /// Localizes the label
  /// ```dart
  /// 'Anticipation';
  /// ```
  /// * default is english (en)
  String emotionAnticipation() {
    if (languageLocale == 'de') return 'Vorfreude';
    return 'Anticipation';
  }

  /// Localizes the label
  /// ```dart
  /// 'Satisfaction';
  /// ```
  /// * default is english (en)
  String emotionSatisfaction() {
    if (languageLocale == 'de') return 'Befriedigung';
    return 'Satisfaction';
  }

  /// Localizes the label
  /// ```dart
  /// 'Arousal';
  /// ```
  /// * default is english (en)
  String emotionArousal() {
    if (languageLocale == 'de') return 'Erregung';
    return 'Arousal';
  }

  /// Localizes the label
  /// ```dart
  /// 'Love';
  /// ```
  /// * default is english (en)
  String emotionLove() {
    if (languageLocale == 'de') return 'Liebe';
    return 'Love';
  }

  /// Localizes the label
  /// ```dart
  /// 'Hate';
  /// ```
  /// * default is english (en)
  String emotionHate() {
    if (languageLocale == 'de') return 'Hass';
    return 'Hate';
  }

  /// Localizes the label
  /// ```dart
  /// 'Irritation';
  /// ```
  /// * default is english (en)
  String emotionIrritation() {
    if (languageLocale == 'de') return 'Gereiztheit';
    return 'Irritation';
  }

  /// Localizes the label
  /// ```dart
  /// 'Empathy';
  /// ```
  /// * default is english (en)
  String emotionEmpathy() {
    if (languageLocale == 'de') return 'Empathie';
    return 'Empathy';
  }

  /// Localizes the label
  /// ```dart
  /// 'Resentment';
  /// ```
  /// * default is english (en)
  String emotionResentment() {
    if (languageLocale == 'de') return 'Groll';
    return 'Resentment';
  }

  /// Localizes the label
  /// ```dart
  /// 'Awe';
  /// ```
  /// * default is english (en)
  String emotionAwe() {
    if (languageLocale == 'de') return 'Erfurcht';
    return 'Awe';
  }

  /// Localizes the label
  /// ```dart
  /// 'Hope';
  /// ```
  /// * default is english (en)
  String emotionHope() {
    if (languageLocale == 'de') return 'Hoffnung';
    return 'Hope';
  }

  /// Localizes the label
  /// ```dart
  /// 'Relief';
  /// ```
  /// * default is english (en)
  String emotionRelief() {
    if (languageLocale == 'de') return 'Erleichterung';
    return 'Relief';
  }

  /// Localizes the label
  /// ```dart
  /// 'Despair';
  /// ```
  /// * default is english (en)
  String emotionDespair() {
    if (languageLocale == 'de') return 'Verzweiflung';
    return 'Despair';
  }

  /// Localizes the label
  /// ```dart
  /// 'Frustration';
  /// ```
  /// * default is english (en)
  String emotionFrustration() {
    if (languageLocale == 'de') return 'Frustration';
    return 'Frustration';
  }

  /// Localizes the label
  /// ```dart
  /// 'Gratitude';
  /// ```
  /// * default is english (en)
  String emotionGratitude() {
    if (languageLocale == 'de') return 'Dankbarkeit';
    return 'Gratitude';
  }

  /// Localizes the label
  /// ```dart
  /// 'Envy';
  /// ```
  /// * default is english (en)
  String emotionEnvy() {
    if (languageLocale == 'de') return 'Neid';
    return 'Envy';
  }

  /// Localizes the label
  /// ```dart
  /// 'Loneliness';
  /// ```
  /// * default is english (en)
  String emotionLoneliness() {
    if (languageLocale == 'de') return 'Einsamkeit';
    return 'Loneliness';
  }

  /// Localizes the label
  /// ```dart
  /// 'To use this field, please first set a default currency in the group settings.';
  /// ```
  /// * default is english (en)
  String defaultCurrencyRequired() {
    if (languageLocale == 'de') return 'Bitte lege zunächst eine Standardwährung in den Gruppeneinstellungen fest, um dieses Feld verwenden zu können.';
    return 'To use this field, please first set a default currency in the group settings.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Boredom';
  /// ```
  /// * default is english (en)
  String emotionBoredom() {
    if (languageLocale == 'de') return 'Langeweile';
    return 'Boredom';
  }

  /// Localizes the label
  /// ```dart
  /// 'Tired';
  /// ```
  /// * default is english (en)
  String emotionTiredness() {
    if (languageLocale == 'de') return 'Müde';
    return 'Tired';
  }

  /// Localizes the label
  /// ```dart
  /// 'Rested';
  /// ```
  /// * default is english (en)
  String emotionRested() {
    if (languageLocale == 'de') return 'Ausgeruht';
    return 'Rested';
  }

  /// Localizes the label
  /// ```dart
  /// 'Resignation';
  /// ```
  /// * default is english (en)
  String emotionResignation() {
    if (languageLocale == 'de') return 'Resignation';
    return 'Resignation';
  }

  /// Localizes the label
  /// ```dart
  /// 'Discouraged';
  /// ```
  /// * default is english (en)
  String emotionDiscouraged() {
    if (languageLocale == 'de') return 'Mutlos';
    return 'Discouraged';
  }

  /// Localizes the label
  /// ```dart
  /// 'Choose emotion';
  /// ```
  /// * default is english (en)
  String chooseEmotionButtonLabel({required String emotion}) {
    if (languageLocale == 'de') return emotion.isEmpty ? 'Emotion auswählen' : emotion;
    return emotion.isEmpty ? 'Choose emotion' : emotion;
  }

  /// Localizes the label
  /// ```dart
  /// return occurrence ?? 'Date';
  /// ```
  /// * default is english (en)
  String chooseOccurrenceButtonLabel({required String? occurrence}) {
    if (languageLocale == 'de') return occurrence ?? 'Datum';
    return occurrence ?? 'Date';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Occurrence date';
  /// ```
  /// * default is english (en)
  String chooseOccurrence() {
    if (languageLocale == 'de') return 'Datum';
    return 'Occurrence date';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Emotion';
  /// ```
  /// * default is english (en)
  String chooseEmotion() {
    if (languageLocale == 'de') return 'Emotion';
    return 'Emotion';
  }

  /// Localizes the label
  /// ```dart
  /// 'Emotions'';
  /// ```
  /// * default is english (en)
  String emotionPickerSheetTitle() {
    if (languageLocale == 'de') return 'Emotionen';
    return 'Emotions';
  }

  /// Localizes the label
  /// ```dart
  /// 'Add emotion';
  /// ```
  /// * default is english (en)
  String addEmotionButtonLabel() {
    if (languageLocale == 'de') return 'Emotion hinzufügen';
    return 'Add emotion';
  }

  /// Localizes the label
  /// ```dart
  /// 'Pick emotion';
  /// ```
  /// * default is english (en)
  String addEmotionSheetTitle() {
    if (languageLocale == 'de') return 'Emotion auswählen';
    return 'Pick emotion';
  }

  /// Localizes the label
  /// ```dart
  /// 'Choose intensity';
  /// ```
  /// * default is english (en)
  String chooseIntensity() {
    if (languageLocale == 'de') return 'Intensität auswählen';
    return 'Choose intensity';
  }

  /// Localizes the label
  /// ```dart
  /// 'Choose avatar image';
  /// ```
  /// * default is english (en)
  String chooseAvatarImage() {
    if (languageLocale == 'de') return 'Avatarbild auswählen';
    return 'Choose avatar image';
  }

  /// Localizes the label
  /// ```dart
  /// 'Created at';
  /// ```
  /// * default is english (en)
  String entrySheetCreatedAt() {
    if (languageLocale == 'de') return 'Erstellt am';
    return 'Created at';
  }

  /// Localizes the label
  /// ```dart
  /// 'This group does not have a description.';
  /// ```
  /// * default is english (en)
  String groupInviteSheetNoDescription() {
    if (languageLocale == 'de') return 'Für diese Gruppe ist keine Beschreibung verfügbar.';
    return 'This group does not have a description.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Delete entry $counter of $total';
  /// ```
  /// * default is english (en)
  String loadingMessageGroupDelete({required int counter, required int total}) {
    if (languageLocale == 'de') return 'Lösche Eintrag $counter von $total';
    return 'Delete entry $counter of $total';
  }

  /// Localizes the label
  /// ```dart
  /// 'Prepare group delete...';
  /// ```
  /// * default is english (en)
  String localGroupPrepareDeleteLoadingMessage() {
    if (languageLocale == 'de') return 'Löschung vorbereiten...';
    return 'Prepare group delete...';
  }

  /// Localizes the label
  /// ```dart
  /// 'This is displayed in your local time but will be saved in UTC.';
  /// ```
  /// * default is english (en)
  String dateTimeInfoMessage() {
    if (languageLocale == 'de') return 'Wird in lokaler Zeit angezeigt, aber in UTC gespeichert.';
    return 'This is displayed in your local time but will be saved in UTC.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Timezone';
  /// ```
  /// * default is english (en)
  String basicLabelsChooseTimezone() {
    if (languageLocale == 'de') return 'Zeitzone';
    return 'Timezone';
  }

  /// Localizes the label
  /// ```dart
  /// 'Timezones';
  /// ```
  /// * default is english (en)
  String basicLabelsTimezones() {
    if (languageLocale == 'de') return 'Zeitzonen';
    return 'Timezones';
  }

  /// Localizes the label
  /// ```dart
  /// return isEditDefault ? 'Edit self default entry' : 'Create self default entry';
  /// ```
  /// * default is english (en)
  String entrySelectedSetDefaultEntrySelf({required bool isEditDefaultSelf}) {
    if (languageLocale == 'de') return isEditDefaultSelf ? 'Eigenen Standardeintrag bearbeiten' : 'Eigenen Standardeintrag erstellen';
    return isEditDefaultSelf ? 'Edit self default entry' : 'Create self default entry';
  }

  /// Localizes the label
  /// ```dart
  /// return isEditDefaultEveryone ? 'Edit default entry for everyone' : 'Create default entry for everyone';
  /// ```
  /// * default is english (en)
  String entrySelectedSetDefaultEntryEveryone({required bool isEditDefaultEveryone}) {
    if (languageLocale == 'de') return isEditDefaultEveryone ? 'Standardeintrag für alle bearbeiten' : 'Standardeintrag für alle erstellen';
    return isEditDefaultEveryone ? 'Edit default entry for everyone' : 'Create default entry for everyone';
  }

  /// Localizes the label
  /// ```dart
  /// 'Validate defaults...'
  /// ```
  /// * default is english (en)
  String entrySheetCubitValidateDefault() {
    if (languageLocale == 'de') return 'Validiere Standards...';
    return 'Validate defaults...';
  }

  /// Localizes the label
  /// ```dart
  /// 'For whom should this default apply?'
  /// ```
  /// * default is english (en)
  String setDefaultTitle() {
    if (languageLocale == 'de') return 'Für wen soll der Standard gelten?';
    return 'For whom should this default apply?';
  }

  /// Localizes the label
  /// ```dart
  /// 'For myself'
  /// ```
  /// * default is english (en)
  String setDefaultSelf() {
    if (languageLocale == 'de') return 'Für mich selbst';
    return 'For myself';
  }

  /// Localizes the label
  /// ```dart
  /// 'For everyone'
  /// ```
  /// * default is english (en)
  String setDefaultEveryone() {
    if (languageLocale == 'de') return 'Für alle';
    return 'For everyone';
  }

  /// Localizes the label
  /// ```dart
  /// 'Users that use your model entry will be able to see these default values if you choose to set the default for everyone.\n\nThis is for example relevant if you set this model entry as a restriction in a group.'
  /// ```
  /// * default is english (en)
  String setDefaultInfoMessage() {
    if (languageLocale == 'de') return 'Falls du den Standard für alle setzt, können andere Benutzer die deine Eintragsvorlage verwenden, diese Standardwerte sehen.\n\nDas ist Beispielsweise relevant, falls du die Eintragsvorlagen die in einer Gruppe verwendet werden können, mit dieser Eintragsvorlage beschränkt hast.';
    return 'Users that use your model entry will be able to see these default values if you choose to set the default for everyone.\n\nThis is for example relevant if you set this model entry as a restriction in a group.';
  }

  /// Localizes the label
  /// ```dart
  /// 'No participants created yet.'
  /// ```
  /// * default is english (en)
  String noParticipantsCreated() {
    if (languageLocale == 'de') return 'Noch keine Mitwirkende erstellt.';
    return 'No participants created yet.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please consider, that the default currency of shared groups can only be changed if the group is empty!\n\nThe reason for this is to prevent the risk of incorrect exchange rates being used.'
  /// ```
  /// * default is english (en)
  String infoMessageDefaultCurrencySharedGroup() {
    if (languageLocale == 'de') return 'Bitte beachte, das die Standardwährung von geteilten Gruppen nur geändert werden kann, wenn die Gruppe leer ist.\n\nDer Grund dafür ist, das anonsten die Gefahr besteht das falsche Wechselkurse verwendet werden.';
    return 'Please consider, that the default currency of shared groups can only be changed if the group is empty!\n\nThe reason for this is to prevent the risk of incorrect exchange rates being used.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Referenced object was not found.'
  /// ```
  /// * default is english (en)
  String apiReferencedObjectNotFound() {
    if (languageLocale == 'de') return 'Referenzobjekt konnte nicht gefunden werden.';
    return 'Referenced object was not found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Database transaction failed, please try again.'
  /// ```
  /// * default is english (en)
  String apiDatabaseTransactionFailed() {
    if (languageLocale == 'de') return 'Datenbankoperation ist fehlgeschlagen, bitte versuche es noch einmal.';
    return 'Database transaction failed, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to delete object, please try again.'
  /// ```
  /// * default is english (en)
  String apiObjectDeleteFailed() {
    if (languageLocale == 'de') return 'Löschen fehlgeschlagen, bitte versuche es noch einmal.';
    return 'Failed to delete object, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'This object was deleted.'
  /// ```
  /// * default is english (en)
  String apiObjectWasDeleted() {
    if (languageLocale == 'de') return 'Dieses Objekt wurde gelöscht.';
    return 'This object was deleted.';
  }

  /// Localizes the label
  /// ```dart
  /// 'This username is not available.'
  /// ```
  /// * default is english (en)
  String apiUsernameNotAvailable() {
    if (languageLocale == 'de') return 'Dieser Username ist nicht verfügbar.';
    return 'This username is not available.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Request limit was exceeded, please try again later.'
  /// ```
  /// * default is english (en)
  String apiRequestLimitExceeded() {
    if (languageLocale == 'de') return 'Zu viele Anfragen, bitte versuche es später wieder.';
    return 'Request limit was exceeded, please try again later.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Invalid permission to access this endpoint.'
  /// ```
  /// * default is english (en)
  String apiEndpointAccessProhibited() {
    if (languageLocale == 'de') return 'Fehlende Berechtigung für diesen Endpunkt.';
    return 'Invalid permission to access this endpoint.';
  }

  /// Localizes the label
  /// ```dart
  /// 'No IP address provided, request denied.'
  /// ```
  /// * default is english (en)
  String apiNoIPAddressProvided() {
    if (languageLocale == 'de') return 'Keine IP Addresse angegeben, Anfrage abgelehnt.';
    return 'No IP address provided, request denied.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Invalid endpoint.'
  /// ```
  /// * default is english (en)
  String apiInvalidEndpoint() {
    if (languageLocale == 'de') return 'Ungültiger Endpunkt.';
    return 'Invalid endpoint.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Exchange rate from $from to $to not found, calculation not accurately possible.';
  /// ```
  /// * default is english (en)
  String exchangeRateNotFound({required String from, required String to}) {
    if (languageLocale == 'de') return 'Wechselkurs von $from nach $to nicht verfügbar, Kalkulation kann nicht fehlerfrei durchgeführt werden.';
    return 'Exchange rate from $from to $to not found, calculation not accurately possible.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Unknown chart instruction.'
  /// ```
  /// * default is english (en)
  String unknownChartInstruction() {
    if (languageLocale == 'de') return 'Unbekannte Statistik Instruktion.';
    return 'Unknown chart instruction.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Group info'
  /// ```
  /// * default is english (en)
  String groupInfo() {
    if (languageLocale == 'de') return 'Gruppendaten';
    return 'Group info';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Members total spent in $defaultCurrencyCode';
  /// ```
  /// * default is english (en)
  String titleExpenseDataMembersTotalSpent({required String defaultCurrencyCode}) {
    if (languageLocale == 'de') return 'Mitglieder Gesamtausgaben in $defaultCurrencyCode';
    return 'Members total spent in $defaultCurrencyCode';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Yearly total spent in $defaultCurrencyCode';
  /// ```
  /// * default is english (en)
  String yearlyTotalSpentByMember({required String defaultCurrencyCode}) {
    if (languageLocale == 'de') return 'Ausgaben pro Jahr in $defaultCurrencyCode';
    return 'Yearly total spent in $defaultCurrencyCode';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Is compensated';
  /// ```
  /// * default is english (en)
  String expenseIsCompensated() {
    if (languageLocale == 'de') return 'Ist kompensiert';
    return 'Is compensated';
  }

  /// Localizes the label
  /// ```dart
  /// return '$timeInterval total spent in $defaultCurrencyCode';
  /// ```
  /// * default is english (en)
  String titleExpenseDataAbsolutExpensesByMemberOverTime({required String defaultCurrencyCode, required String timeInterval}) {
    if (languageLocale == 'de') {
      if (timeInterval == PickerItem.intervalYearly) return 'Absolute Ausgaben pro Jahr in $defaultCurrencyCode';
      if (timeInterval == PickerItem.intervalMonthly) return 'Absolute Ausgaben pro Monat in $defaultCurrencyCode';
      if (timeInterval == PickerItem.intervalDaily) return 'Absolute Ausgaben pro Tag in $defaultCurrencyCode';
    }

    if (timeInterval == PickerItem.intervalYearly) return 'Absolute yearly expenses in $defaultCurrencyCode';
    if (timeInterval == PickerItem.intervalMonthly) return 'Absolute monthly expenses in $defaultCurrencyCode';
    return 'Absolute daily expenses in $defaultCurrencyCode';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Total costs in $defaultCurrencyCode';
  /// ```
  /// * default is english (en)
  String titleExpenseDataMembersTotalCosts({required String defaultCurrencyCode}) {
    if (languageLocale == 'de') {
      return 'Gesamtkosten in $defaultCurrencyCode';
    }

    return 'Total costs in $defaultCurrencyCode';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Overall costs in $defaultCurrencyCode';
  /// ```
  /// * default is english (en)
  String titleExpenseDataOverallCostsByTag({required String defaultCurrencyCode}) {
    if (languageLocale == 'de') {
      return 'Gesamtkosten nach Kategorie in $defaultCurrencyCode';
    }

    return 'Overall costs by tag in $defaultCurrencyCode';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Numerical progression';
  /// ```
  /// * default is english (en)
  String titleNumberDataNumericalProgression() {
    if (languageLocale == 'de') {
      return 'Numerische Entwicklung';
    }

    return 'Numerical progression';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Numerical progression accumulated';
  /// ```
  /// * default is english (en)
  String titleNumberDataNumericalProgressionAccumulated() {
    if (languageLocale == 'de') {
      return 'Numerische Entwicklung akkumuliert';
    }

    return 'Numerical progression accumulated';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Numerical progression';
  /// ```
  /// * default is english (en)
  String titleMoneyDataNumericalProgression({required String currencyCode}) {
    if (languageLocale == 'de') {
      return 'Werte der Einträge in $currencyCode';
    }

    return 'Values by entries in $currencyCode';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Numerical progression accumulated';
  /// ```
  /// * default is english (en)
  String titleMoneyDataNumericalProgressionAccumulated({required String currencyCode}) {
    if (languageLocale == 'de') {
      return 'Gesamtbilanz im Zeitverlauf in $currencyCode';
    }

    return 'Total balance trend in $currencyCode';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Numerical distribution of entries';
  /// ```
  /// * default is english (en)
  String titleNumberDataNumericalOrder() {
    if (languageLocale == 'de') {
      return 'Zahlen in absteigender Reihenfolge';
    }

    return 'Numbers in descending order';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Boolean values of recent entries';
  /// ```
  /// * default is english (en)
  String titleBooleanDataTrueFalseHistory() {
    if (languageLocale == 'de') {
      return 'Boolsche Zustände der letzten Einträge';
    }

    return 'Boolean values of recent entries';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Email Frequency in Group';
  /// ```
  /// * default is english (en)
  String titleEmailDataFrequencyDistribution() {
    if (languageLocale == 'de') return 'E-Mail-Häufigkeiten';
    return 'Email Frequencies';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Birthdays per month';
  /// ```
  /// * default is english (en)
  String titleDateOfBirthDataBirthdaysPerMonth() {
    if (languageLocale == 'de') return 'Geburtstage pro Monat';
    return 'Birthdays per month';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Entries by category';
  /// ```
  /// * default is english (en)
  String titleTagsDataEntriesByTag() {
    if (languageLocale == 'de') return 'Einträge nach Kategorie';
    return 'Entries by category';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Average intensity';
  /// ```
  /// * default is english (en)
  String titleEmotionDataAverageIntensityByEmotion() {
    if (languageLocale == 'de') return 'Durchschnittliche Intensität';
    return 'Average intensity';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Average wellbeing';
  /// ```
  /// * default is english (en)
  String titleEmotionDataAverageWellbeing() {
    if (languageLocale == 'de') return 'Durchschnittliches Wohlbefinden';
    return 'Average wellbeing';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Latest Measurements';
  /// ```
  /// * default is english (en)
  String titleMeasurementDataProgressionOfValue({required bool isShared}) {
    if (languageLocale == 'de') return isShared ? 'Letzte Messwerte' : 'Messwerte in absteigeigender Reihenfolge';
    return 'Measurements in descending order';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Income over time';
  /// ```
  /// * default is english (en)
  String titleMoneyDataIncomeOverTime({required String currencyCode}) {
    if (languageLocale == 'de') return 'Einkommen im Zeitverlauf in $currencyCode';
    return 'Income over time in $currencyCode';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Expenses over time';
  /// ```
  /// * default is english (en)
  String titleMoneyDataExpensesOverTime({required String currencyCode}) {
    if (languageLocale == 'de') return 'Ausgaben im Zeitverlauf in $currencyCode';
    return 'Expenses over time in $currencyCode';
  }

  /// Localizes the label
  /// ```dart
  /// return '$timeInterval absolut income in $defaultCurrencyCode';
  /// ```
  /// * default is english (en)
  String titleExpenseDataAbsolutIncomeByMemberOverTime({required String defaultCurrencyCode, required String timeInterval}) {
    if (languageLocale == 'de') {
      if (timeInterval == PickerItem.intervalYearly) return 'Absolute Einnahmen pro Jahr in $defaultCurrencyCode';
      if (timeInterval == PickerItem.intervalMonthly) return 'Absolute Einnahmen pro Monat in $defaultCurrencyCode';
      if (timeInterval == PickerItem.intervalDaily) return 'Absolute Einnahmen pro Tag in $defaultCurrencyCode';
    }

    if (timeInterval == PickerItem.intervalYearly) return 'Absolute yearly income in $defaultCurrencyCode';
    if (timeInterval == PickerItem.intervalMonthly) return 'Absolute monthly income in $defaultCurrencyCode';
    return 'Absolute daily income in $defaultCurrencyCode';
  }

  /// Localizes the label
  /// ```dart
  /// return '$timeInterval profits/losses in $defaultCurrencyCode';
  /// ```
  /// * default is english (en)
  String titleExpenseDataAbsolutProfitsOrLossesOverTime({required String defaultCurrencyCode, required String timeInterval}) {
    if (languageLocale == 'de') {
      if (timeInterval == PickerItem.intervalYearly) return 'Absoluter Gewinn/Verlust pro Jahr in $defaultCurrencyCode';
      if (timeInterval == PickerItem.intervalMonthly) return 'Absoluter Gewinn/Verlust pro Monat in $defaultCurrencyCode';
      if (timeInterval == PickerItem.intervalDaily) return 'Absoluter Gewinn/Verlust pro Tag in $defaultCurrencyCode';
    }

    if (timeInterval == PickerItem.intervalYearly) return 'Absolute yearly profits/losses in $defaultCurrencyCode';
    if (timeInterval == PickerItem.intervalMonthly) return 'Absolute monthly profits/losses in $defaultCurrencyCode';
    return 'Absolute daily profits/losses in $defaultCurrencyCode';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Daily total spent in $defaultCurrencyCode';
  /// ```
  /// * default is english (en)
  String dailyTotalSpentByMember({required String defaultCurrencyCode}) {
    if (languageLocale == 'de') return 'Ausgaben pro Tag in $defaultCurrencyCode';
    return 'Daily total spent in $defaultCurrencyCode';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Considers all expense fields of selected year for selected member.';
  /// ```
  /// * default is english (en)
  String monthlyTotalSpentByMemberInfoLine({required double monthlyMean}) {
    if (languageLocale == 'de') return 'Berücksichtigt alle Felder des Typs Ausgabe des ausgewählten Jahres und für das ausgewählte Mitglied.\n\nMonatsdurchschnitt: $monthlyMean';
    return 'Considers all expense fields of selected year for selected member.\n\nMonthly average: $monthlyMean';
  }

  /// Localizes the label
  /// ```dart
  /// return '$timeInterval costs in $defaultCurrencyCode';
  /// ```
  /// * default is english (en)
  String titleExpenseDataCostsByMemberOverTime({required String defaultCurrencyCode, required String timeInterval}) {
    if (languageLocale == 'de') {
      if (timeInterval == PickerItem.intervalYearly) return 'Kosten pro Jahr in $defaultCurrencyCode';
      if (timeInterval == PickerItem.intervalMonthly) return 'Kosten pro Monat in $defaultCurrencyCode';
      if (timeInterval == PickerItem.intervalDaily) return 'Kosten pro Tag in $defaultCurrencyCode';
    }

    if (timeInterval == PickerItem.intervalYearly) return 'Yearly costs in $defaultCurrencyCode';
    if (timeInterval == PickerItem.intervalMonthly) return 'Monthly costs in $defaultCurrencyCode';
    return 'Daily costs in $defaultCurrencyCode';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Costs by Tags in $defaultCurrencyCode';
  /// ```
  /// * default is english (en)
  String titleExpenseDataCostsByTag({required String defaultCurrencyCode}) {
    if (languageLocale == 'de') {
      return 'Kosten nach Kategorien in $defaultCurrencyCode';
    }

    return 'Costs by Tags in $defaultCurrencyCode';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Share of total costs in $defaultCurrencyCode';
  /// ```
  /// * default is english (en)
  String titleExpenseDataMemberCostsOfOverallCosts({required String defaultCurrencyCode}) {
    if (languageLocale == 'de') return 'Gesamtkostenanteil in $defaultCurrencyCode';
    return 'Share of total costs in $defaultCurrencyCode';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Cost shares by tag';
  /// ```
  /// * default is english (en)
  String titleExpenseDataMemberCostSharesByTag() {
    if (languageLocale == 'de') return 'Kostenanteile nach Kategorie';
    return 'Cost shares by tag';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Overall cost shares by tag';
  /// ```
  /// * default is english (en)
  String titleExpenseDataOverallCostSharesByTag() {
    if (languageLocale == 'de') return 'Gesamtkostenanteile nach Kategorie';
    return 'Overall cost shares by tag';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Boolean Value Distribution';
  /// ```
  /// * default is english (en)
  String titleBooleanDataTrueFalseDistribution() {
    if (languageLocale == 'de') return 'Verteilung der Booleschen Zustände';
    return 'Boolean Value Distribution';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Frequency distribution';
  /// ```
  /// * default is english (en)
  String titleEmailDataFrequencyShares() {
    if (languageLocale == 'de') return 'Häufigkeitsverteilung';
    return 'Frequency distribution';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Provider distribution';
  /// ```
  /// * default is english (en)
  String titleEmailDataProviderShares() {
    if (languageLocale == 'de') return 'Provider Verteilung';
    return 'Provider distribution';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Username distribution';
  /// ```
  /// * default is english (en)
  String titleUsernameDataUsernameDistribution() {
    if (languageLocale == 'de') return 'Username Verteilung';
    return 'Username distribution';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Entries with and without image';
  /// ```
  /// * default is english (en)
  String titleAvatarImageDataHasImageDistribution() {
    if (languageLocale == 'de') return 'Einträge mit und ohne Bild';
    return 'Entries with and without image';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Avatar images with and without title';
  /// ```
  /// * default is english (en)
  String titleAvatarImageDataHasTitleDistribution() {
    if (languageLocale == 'de') return 'Avatarbilder mit und ohne Titel';
    return 'Avatar images with and without title';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Avatar images with and without text';
  /// ```
  /// * default is english (en)
  String titleAvatarImageDataHasTextDistribution() {
    if (languageLocale == 'de') return 'Avatarbilder mit und ohne Text';
    return 'Avatar images with and without text';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Birthdays per season';
  /// ```
  /// * default is english (en)
  String titleDateOfBirthDataSeasonalDistribution() {
    if (languageLocale == 'de') return 'Geburtstage nach Jahreszeit';
    return 'Birthdays per season';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Currencies';
  /// ```
  /// * default is english (en)
  String titleMoneyDataCurrencyDistribution() {
    if (languageLocale == 'de') return 'Währungen';
    return 'Currencies';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Expenses by tag';
  /// ```
  /// * default is english (en)
  String titleMoneyDataExpensesByCategory() {
    if (languageLocale == 'de') return 'Ausgaben nach Kategorie';
    return 'Expenses by tag';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Income by tag';
  /// ```
  /// * default is english (en)
  String titleMoneyDataIncomeByCategory() {
    if (languageLocale == 'de') return 'Einkommen nach Kategorie';
    return 'Income by tag';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Unknown tag';
  /// ```
  /// * default is english (en)
  String unknownTag() {
    if (languageLocale == 'de') return 'Unbekannter Tag';
    return 'Unknown tag';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Entries proportionally by category';
  /// ```
  /// * default is english (en)
  String titleTagsDataEntriesShareByTag() {
    if (languageLocale == 'de') return 'Einträge anteilig nach Kategorie';
    return 'Entries proportionally by category';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please provide exchange rates for these entries.';
  /// ```
  /// * default is english (en)
  String invalidEntriesInfoMessage() {
    if (languageLocale == 'de') return 'Bitte gib Wechselkurse für diese Einträge an.';
    return 'Please provide exchange rates for these entries.';
  }

  /// Localizes the label
  /// ```dart
  /// 'No invalid entries found!\n\nPlease click "Ready" to complete the process.';
  /// ```
  /// * default is english (en)
  String infoMessageNoInvalidExchangeRatesFound() {
    if (languageLocale == 'de') return 'Keine ungültigen Einträge gefunden!\n\nBitte klicke auf "Fertig" um den Prozess abzuschließen.';
    return 'No invalid entries found!\n\nPlease click "Ready" to complete the process.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Positive and negative emotions';
  /// ```
  /// * default is english (en)
  String titleEmotionDataPositiveNegativeProportion() {
    if (languageLocale == 'de') return 'Positive und negative Emotionen';
    return 'Positive and negative emotions';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Selected date is in the future.';
  /// ```
  /// * default is english (en)
  String dateIsInFutureWarning() {
    if (languageLocale == 'de') return 'Ausgewähltes Datum ist in der Zukunft.';
    return 'Selected date is in the future.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Debt balances in $defaultCurrencyCode';
  /// ```
  /// * default is english (en)
  String titleExpenseDataMembersDebtBalances({required String defaultCurrencyCode}) {
    if (languageLocale == 'de') return 'Schuldenstände in $defaultCurrencyCode';
    return 'Debt balances in $defaultCurrencyCode';
  }

  /// Localizes the label
  /// ```dart
  /// 'Considers all expense fields.\n\nOverall spent: $totalOfAllMembers';
  /// ```
  /// * default is english (en)
  String membersTotalSpentInfoLine({required double totalOfAllMembers}) {
    if (languageLocale == 'de') return 'Berücksichtigt alle Felder des Typs Ausgabe.\n\nGesamtausgaben: $totalOfAllMembers';
    return 'Considers all expense fields.\n\nOverall spent: $totalOfAllMembers';
  }

  /// Localizes the label
  /// ```dart
  /// 'yearly'
  /// ```
  /// * default is english (en)
  String timeIntervalYearly() {
    if (languageLocale == 'de') return 'Jährlich';
    return 'Yearly';
  }

  /// Localizes the label
  /// ```dart
  /// 'monthly'
  /// ```
  /// * default is english (en)
  String timeIntervalMonthly() {
    if (languageLocale == 'de') return 'Monatlich';
    return 'Monthly';
  }

  /// Localizes the label
  /// ```dart
  /// 'daily'
  /// ```
  /// * default is english (en)
  String timeIntervalDaily() {
    if (languageLocale == 'de') return 'Täglich';
    return 'Daily';
  }

  /// Localizes the label
  /// ```dart
  /// 'Consider all fields'
  /// ```
  /// * default is english (en)
  String considerAllFields() {
    if (languageLocale == 'de') return 'Alle Felder beachten';
    return 'Consider all fields';
  }

  /// Localizes the label
  /// ```dart
  /// 'Consider all years'
  /// ```
  /// * default is english (en)
  String considerAllYears() {
    if (languageLocale == 'de') return 'Alle Jahre beachten';
    return 'Consider all years';
  }

  /// Localizes the label
  /// ```dart
  /// 'Payments'
  /// ```
  /// * default is english (en)
  String titlePaymentsCharts() {
    if (languageLocale == 'de') return 'Zahlungen';
    return 'Payments';
  }

  /// Localizes the label
  /// ```dart
  /// 'Expenses'
  /// ```
  /// * default is english (en)
  String includeExcludeSelfPaymetns({required bool include}) {
    if (languageLocale == 'de') return include ? 'Selbstzahlungen ignorieren' : 'Selbstzahlungen einbeziehen';
    return include ? 'Exclude self payments' : 'Include self payments';
  }

  /// Localizes the label.
  /// * Returns info line depending on chart filter settings.
  /// * default is english (en)
  String infoLineExpenseDataCostsByMemberOverTime() {
    if (languageLocale == 'de') {
      return 'Selbstzahlungen werden einbezogen.';
    }

    return 'Self payments are included.';
  }

  /// Localizes the label.
  /// * Returns info line depending on chart filter settings.
  /// * default is english (en)
  String infoLineExpenseDataCostsByTag() {
    if (languageLocale == 'de') {
      return 'Falls eine Zahlung mehrere Kategorien besitzt, so werden diese anteilig aufgeteilt.';
    }

    return 'If a payment has multiple categories, they are distributed proportionally.';
  }

  /// Localizes the label.
  /// * Returns info line depending on chart filter settings.
  /// * default is english (en)
  String infoLineExpenseDataMembersTotalCosts() {
    if (languageLocale == 'de') {
      return 'Selbstzahlungen werden einbezogen.';
    }

    return 'Self payments are included.';
  }

  /// Localizes the label.
  /// * Returns info line depending on chart filter settings.
  /// * default is english (en)
  String infoLineExpenseDataDebtBalancesAllMembers() {
    if (languageLocale == 'de') {
      return 'Einnahmen und Ausgaben werden gegengerechnet ausser diese wurden als bereits abgegolten markiert.\n\nSelbstzahlungen werden ignoriert.';
    }

    return 'Income and expenses are offset against each other except if the were marked as already compensated.\n\nSelf payments are ignored.';
  }

  /// Localizes the label.
  /// * Returns info line depending on chart filter settings.
  /// * default is english (en)
  String infoLineExpenseDataMemberCostsOfOverallCosts() {
    if (languageLocale == 'de') {
      return 'Selbstzahlungen werden einbezogen.';
    }

    return 'Self payments are included.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Set expiration date'
  /// ```
  /// * default is english (en)
  String setExpirationDate() {
    if (languageLocale == 'de') return 'Ablaufdatum setzen';
    return 'Set expiration date';
  }

  /// Localizes the label
  /// ```dart
  /// 'Set usage limitations'
  /// ```
  /// * default is english (en)
  String setUsageLimitations() {
    if (languageLocale == 'de') return 'Nutzungslimits setzen';
    return 'Set usage limitations';
  }

  /// Localizes the label.
  /// * Returns info line depending on chart filter settings.
  /// * default is english (en)
  String infoLineExpenseDataMemberCostSharesByTag({required String filterByFieldId, required String fieldName}) {
    if (languageLocale == 'de') {
      return 'Selbstzahlungen werden einbezogen.';
    }

    return 'nSelf payments are included.';
  }

  /// Localizes the label.
  /// * Returns info line depending on chart filter settings.
  /// * default is english (en)
  String infoLineExpenseDataOverallCostSharesByTag({required String filterByFieldId, required String fieldName}) {
    if (languageLocale == 'de') {
      return 'Es werden die Kosten aller Teilnehmer berücksichtigt.';
    }

    return 'The costs of all members are regarded.';
  }

  /// Localizes the label.
  /// * Returns info line depending on chart filter settings.
  /// * default is english (en)
  String infoLineAvatarImageDataHasImageDistribution() {
    if (languageLocale == 'de') return 'Falls ein Eintrag mindestens ein Feld des Typs Avatarbild hat, wird dies als "Bild vorhanden" gewertet.';

    return 'Image counts as existing, if an entry has at least one field of the type avatar image';
  }

  /// Localizes the label.
  /// * Returns info line depending on chart filter settings.
  /// * default is english (en)
  String infoLineAvatarImageDataHasTitleDistribution() {
    if (languageLocale == 'de') return 'Es werden nur Einträge beachtet die ein Bild vorhanden haben.';

    return 'Only entries that have an image available are considered.';
  }

  /// Localizes the label.
  /// * Returns info line depending on chart filter settings.
  /// * default is english (en)
  String infoLineAvatarImageDataHasTextDistribution() {
    if (languageLocale == 'de') return 'Es werden nur Einträge beachtet die ein Bild vorhanden haben.';

    return 'Only entries that have an image available are considered.';
  }

  /// Localizes the label.
  /// * Returns info line depending on chart filter settings.
  /// * default is english (en)
  String infoLineTagsDataEntriesShareByTag({required String filterByFieldId}) {
    if (languageLocale == 'de') {
      if (filterByFieldId.isEmpty) {
        return 'Tags die mit einer Zahlung verbunden sind, werden ignoriert.';
      }

      return '';
    }

    if (filterByFieldId.isEmpty) {
      return 'Tags which are connected to a Payment field are ignored.';
    }

    return '';
  }

  /// Localizes the label.
  /// * Returns info line depending on chart filter settings.
  /// * default is english (en)
  String infoLineExpenseDataAbsolutExpensesByMemberOverTime() {
    if (languageLocale == 'de') {
      return 'Es werden nur die tatsächlich getätigten Geldabflüsse angezeigt, d.h. ausstehende Schulden werden ignoriert.';
    }

    return 'Only the actual outgoing cash flow is shown, i.e. outstanding debts are ignored.';
  }

  /// Localizes the label.
  /// * Returns info line depending on chart filter settings.
  /// * default is english (en)
  String infoLineExpenseDataAbsolutIncomeByMemberOverTime() {
    if (languageLocale == 'de') {
      return 'Es werden nur die tatsächlichen Geldzuflüsse angezeigt, d.h. es werden nur Zahlungen angezeigt, die als bereits abgegolten makiert wurden also nicht mehr zurückgezahlt werden müssen.';
    }

    return 'Only the actual incoming cash flow is shown, i.e. only payments that have been marked as compensated and therefore do not need to be repaid anymore.';
  }

  /// Localizes the label.
  /// * Returns info line depending on chart filter settings.
  /// * default is english (en)
  String infoLineExpenseDataOverallCostsByTag() {
    if (languageLocale == 'de') {
      return 'Es werden die Kosten aller Teilnehmer berücksichtigt.';
    }

    return 'The costs of all members are regarded.';
  }

  /// Localizes the label.
  /// * Returns info line depending on chart filter settings.
  /// * default is english (en)
  String infoLineTagsDataEntriesByTag({required String filterByFieldId}) {
    if (languageLocale == 'de') {
      if (filterByFieldId.isEmpty) {
        return 'Tags die mit einer Zahlung verbunden sind, werden ignoriert.';
      }

      return '';
    }

    if (filterByFieldId.isEmpty) {
      return 'Tags which are connected to a Payment field are ignored.';
    }

    return '';
  }

  /// Localizes the label.
  /// * Returns info line depending on chart filter settings.
  /// * default is english (en)
  String infoLineMeasurementDataProgressionOfValue() {
    if (languageLocale == 'de') {
      return 'Werte werden in die ausgewählte Einheit umgerechnet.';
    }

    return 'Values are converted into the selected unit.';
  }

  /// Localizes the label.
  /// * Returns info line depending on chart filter settings.
  /// * default is english (en)
  String infoLineExpenseDataMembersTotalSpent() {
    if (languageLocale == 'de') {
      return 'Es werden die absoluten Ausgaben angezeigt, d.h. ausstehende Einnahmen werden nicht gegengerechnet.';
    }

    return 'Shows the absolut total spent, which means potential income is not offsetted.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Filters used in the chart are also applied here.'
  /// ```
  /// * default is english (en)
  String infoMessageExpenseReportSheet() {
    if (languageLocale == 'de') return 'Im Diagramm angewendete Filter werden auch hier beachtet.';
    return 'Filters used in the chart are also applied here.';
  }

  /// Localizes the label
  /// ```dart
  /// 'All accounts are balanced out.'
  /// ```
  /// * default is english (en)
  String infoMessageCreditorsDebitors({required String defaultCurrency, required bool showAllTransactions, required String fieldLabel, required String filterByYear}) {
    if (languageLocale == 'de') {
      return '${showAllTransactions ? 'Es werden alle' : 'Es werden die minimal notwendigen'} Transaktionen die benötigt werden um alle Konten auf 0.00 $defaultCurrency auszugleichen angezeigt.\n\nZahlungen die als bereits abgegolten markiert wurden werden ignoriert.\n\nSelbstzahlungen werden ignoriert.\n\n${fieldLabel.isEmpty ? 'Es werden alle Zahlungsfelder beachtet.' : 'Es werden nur die Zahlung des Felds "$fieldLabel" beachtet.'}\n\n${filterByYear.isEmpty ? 'Es werden die Zahlungen des gesamten Zeitraums beachtet.' : 'Es werden nur die Zahlungen des Jahres $filterByYear beachtet.'}';
    }
    return '${showAllTransactions ? 'All' : 'The minimal necessary'} transactions to level all accounts to 0.00 $defaultCurrency are shown.\n\nPayments which have been labeled as compensated are ignored.\n\nSelf payments are ignored.\n\n${fieldLabel.isEmpty ? 'All payment fields are considered.' : 'Only the payments of the field "$fieldLabel" are considered.'}\n\n${filterByYear.isEmpty ? 'The complete time range is considered.' : 'Only payments of the year $filterByYear are considered.'}';
  }

  /// Localizes the label
  /// ```dart
  /// return showAllTransactions ? 'All transactions' : 'Optimized transactions';
  /// ```
  /// * default is english (en)
  String dropDownButtonShowAllTransactions({required bool showAllTransactions}) {
    if (languageLocale == 'de') return showAllTransactions ? 'Alle Transaktionen' : 'Optimierte Transaktionen';
    return showAllTransactions ? 'All transactions' : 'Optimized transactions';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters no costs have been found.'
  /// ```
  /// * default is english (en)
  String expenseDataCostsByMemberOverTimeNoDataAvailableMessage() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen wurden keine Kosten gefunden.';
    return 'For these filters no costs have been found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters no tags have been found.'
  /// ```
  /// * default is english (en)
  String expenseDataCostsByTagNoDataAvailableMessage() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen wurden keine Kosten gefunden.';
    return 'For these filters no costs have been found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters no costs have been found.'
  /// ```
  /// * default is english (en)
  String expenseDataMembersTotalCostsNoDataAvailableMessage() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen wurden keine Kosten gefunden.';
    return 'For these filters no costs have been found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters no costs have been found.'
  /// ```
  /// * default is english (en)
  String expenseDataMemberCostsOfOverallCostsNoDataMessage() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen wurden keine Kosten gefunden.';
    return 'For these filters no costs have been found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters no costs have been found.'
  /// ```
  /// * default is english (en)
  String expenseDataMemberCostSharesByTagNoDataMessage() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen wurden keine Kosten gefunden.';
    return 'For these filters no costs have been found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters no costs have been found.'
  /// ```
  /// * default is english (en)
  String expenseDataOverallCostSharesByTagNoDataMessage() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen wurden keine Kosten gefunden.';
    return 'For these filters no costs have been found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters no data has been found.'
  /// ```
  /// * default is english (en)
  String booleanDataTrueFalseDistributionNoDataMessage() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen wurden keine Daten gefunden.';
    return 'For these filters no data has been found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters no data has been found.'
  /// ```
  /// * default is english (en)
  String emailDataFrequencySharesNoDataMessage() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen wurden keine Daten gefunden.';
    return 'For these filters no data has been found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters no data has been found.'
  /// ```
  /// * default is english (en)
  String emailDataProviderSharesNoDataMessage() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen wurden keine Daten gefunden.';
    return 'For these filters no data has been found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters no data has been found.'
  /// ```
  /// * default is english (en)
  String usernameDataUsernameDistributionNoDataMessage() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen wurden keine Daten gefunden.';
    return 'For these filters no data has been found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters no data has been found.'
  /// ```
  /// * default is english (en)
  String avatarImageDataHasImageDistributionNoDataMessage() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen wurden keine Daten gefunden.';
    return 'For these filters no data has been found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters no data has been found.'
  /// ```
  /// * default is english (en)
  String avatarImageDataHasTitleDistributionNoDataMessage() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen wurden keine Daten gefunden.';
    return 'For these filters no data has been found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters no data has been found.'
  /// ```
  /// * default is english (en)
  String avatarImageDataHasTextDistributionNoDataMessage() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen wurden keine Daten gefunden.';
    return 'For these filters no data has been found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters no data has been found.'
  /// ```
  /// * default is english (en)
  String dateOfBirthDataSeasonalDistributionNoDataMessage() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen wurden keine Daten gefunden.';
    return 'For these filters no data has been found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters no data has been found.'
  /// ```
  /// * default is english (en)
  String basicLabelsNoDataFoundForFilters() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen wurden keine Daten gefunden.';
    return 'For these filters no data has been found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters no data has been found.'
  /// ```
  /// * default is english (en)
  String tagsDataEntriesShareByTagNoDataMessage() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen wurden keine Daten gefunden.';
    return 'For these filters no data has been found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters no data has been found.'
  /// ```
  /// * default is english (en)
  String emotionDataPositiveNegativeProportionNoDataMessage() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen wurden keine Daten gefunden.';
    return 'For these filters no data has been found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters all accounts are balanced out.'
  /// ```
  /// * default is english (en)
  String expenseDataMembersDebtBalancesNoDataAvailableMessage() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen sind die Konten ausgeglichen.';
    return 'For these filters all accounts are balanced out.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters no relevant expenses have been found.'
  /// ```
  /// * default is english (en)
  String expenseDataAbsolutExpensesByMemberOverTimeNoDataAvailableMessage() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen wurden keine Ausgaben gefunden.';
    return 'For these filters no expenses have been found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters no incomes have been found.'
  /// ```
  /// * default is english (en)
  String expenseDataAbsolutIncomeByMemberOverTimeNoDataAvailableMessage() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen wurden keine Einnahmen gefunden.';
    return 'For these filters no income has been found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters no profits or losses have been found.'
  /// ```
  /// * default is english (en)
  String expenseDataMemberAbsoluteProfitsAndLossesNoDataAvailableMessage() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen wurden keine Gewinne oder Verluste gefunden.';
    return 'For these filters no profits or losses have been found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters no costs have been found.'
  /// ```
  /// * default is english (en)
  String expenseDataOverallCostsByTagNoDataAvailableMessage() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen wurden keine Kosten gefunden.';
    return 'For these filters no costs have been found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters no data has been found.'
  /// ```
  /// * default is english (en)
  String numberDataNumericalProgressionNoDataAvailableMessage() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen wurden keine Daten gefunden.';
    return 'For these filters no data has been found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters all values are 0.0.'
  /// ```
  /// * default is english (en)
  String numberDataNumericalProgressionAllValuesAreZero() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen sind alle Werte gleich Null.';
    return 'For these filters all values are zero.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters no data has been found.'
  /// ```
  /// * default is english (en)
  String moneyDataNumericalProgressionNoDataAvailableMessage() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen wurden keine Daten gefunden.';
    return 'For these filters no data has been found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters all values are 0.0.'
  /// ```
  /// * default is english (en)
  String moneyDataNumericalProgressionAllValuesAreZero() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen sind alle Werte gleich Null.';
    return 'For these filters all values are zero.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters all values are zero.'
  /// ```
  /// * default is english (en)
  String numberDataNumericalProgressionNoDataAvailableMessageAllZero() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen sind alle Zahlen gleich Null.';
    return 'For these filters all values are zero.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters all values are zero.'
  /// ```
  /// * default is english (en)
  String numberDataNumericalOrderNoDataAvailableMessage() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen wurden keine Daten gefunden.';
    return 'For these filters no data has been found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters all values are zero.'
  /// ```
  /// * default is english (en)
  String numberDataNumericalOrderNoDataAvailableMessageAllZero() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen sind alle Zahlen gleich Null.';
    return 'For these filters all values are zero.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters no values have been found.'
  /// ```
  /// * default is english (en)
  String booleanDataTrueFalseHistoryNoDataAvailableMessage() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen wurden keine Werte gefunden.';
    return 'For these filters no values have been found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters no data has been found.'
  /// ```
  /// * default is english (en)
  String emailDataFrequencyDistributionNoDataAvailableMessage() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen wurden keine Daten gefunden.';
    return 'For these filters no data has been found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters no data has been found.'
  /// ```
  /// * default is english (en)
  String dateOfBirthDataBirthdaysPerMonthNoDataAvailableMessage() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen wurden keine Daten gefunden.';
    return 'For these filters no data has been found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters no data has been found.'
  /// ```
  /// * default is english (en)
  String tagsDataEntriesByTagNoDataAvailableMessage() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen wurden keine Daten gefunden.';
    return 'For these filters no data has been found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters no data has been found.'
  /// ```
  /// * default is english (en)
  String emotionDataAverageIntensityByEmotionNoDataAvailableMessage() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen wurden keine Daten gefunden.';
    return 'For these filters no data has been found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters no data has been found.'
  /// ```
  /// * default is english (en)
  String emotionDataAverageWellbeingNoDataAvailableMessage() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen wurden keine Daten gefunden.';
    return 'For these filters no data has been found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters no data has been found.'
  /// ```
  /// * default is english (en)
  String basicLabelsNoDataAvailable() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen wurden keine Daten gefunden.';
    return 'For these filters no data has been found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Please select a measurement category and a unit to display this chart.'
  /// ```
  /// * default is english (en)
  String categoryAndUnitRequired() {
    if (languageLocale == 'de') return 'Bitte wähle eine Messkategorie und eine Einheit aus.';
    return 'Please select a measurement category and a unit.';
  }

  /// Localizes the label
  /// ```dart
  /// 'For these filters no incomes have been found.'
  /// ```
  /// * default is english (en)
  String expenseDataMembersTotalSpentNoDataAvailableMessage() {
    if (languageLocale == 'de') return 'Für diese Filtereinstellungen wurden keine Ausgaben gefunden.';
    return 'For these filters no expenses have been found.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Failed to load settlement, please try again.'
  /// ```
  /// * default is english (en)
  String failedToLoadSettlement() {
    if (languageLocale == 'de') return 'Laden der Abrechnung fehlgeschlagen, bitte versuche es noch einmal.';
    return 'Failed to load settlement, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// 'It seems like there is no meaningful data in this group yet.'
  /// ```
  /// * default is english (en)
  String noMeaningfulDataInGroupYet() {
    if (languageLocale == 'de') return 'Es sieht danach aus als gäbe es noch keine aussagekräftigen Daten in dieser Gruppe.';
    return 'It seems like there is no meaningful data in this group yet.';
  }

  /// Localizes the label
  /// ```dart
  /// 'There are no charts available for this type yet.\n\nWe are working to change this as soon as possible.'
  /// ```
  /// * default is english (en)
  String noChartsForThisFieldType() {
    if (languageLocale == 'de') return 'Für diesen Feldtyp existieren noch keine Statistiken.\n\nWir arbeiten daran dies so schnell wie möglich zu ändern.';
    return 'There are no charts available for this type yet.\n\nWe are working to change this as soon as possible.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Used for service'
  /// ```
  /// * default is english (en)
  String usedForService() {
    if (languageLocale == 'de') return 'Verwendet bei';
    return 'Used for service';
  }

  /// Localizes the label
  /// ```dart
  /// 'Use the service option to save where this username is used.\n\nThis is optional.'
  /// ```
  /// * default is english (en)
  String usernameServiceInfoMessage() {
    if (languageLocale == 'de') return 'Verwende diese Option um zu speichern wo dieser Username verwendet wird.';
    return 'Use the service option to save where this username is used.';
  }

  /// Localizes the label
  /// ```dart
  /// 'Next birthdays'
  /// ```
  /// * default is english (en)
  String nextBirthdaysInfo() {
    if (languageLocale == 'de') return 'Nächste Geburtstage';
    return 'Next birthdays';
  }

  /// Localizes the label
  /// ```dart
  /// 'No birthdays found.'
  /// ```
  /// * default is english (en)
  String noUpcomingBirthday() {
    if (languageLocale == 'de') return 'Keine Geburtstage gefunden.';
    return 'No birthdays found.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Not born yet' ;
  /// ```
  /// * default is english (en)
  String notBornYet() {
    if (languageLocale == 'de') return 'Noch nicht geboren';
    return 'Not born yet';
  }

  /// Localizes the label
  /// ```dart
  /// return '$ageInDays days old';
  /// ```
  /// * default is english (en)
  String ageInDays({required int ageInDays}) {
    if (languageLocale == 'de') return '$ageInDays Tage alt';
    return '$ageInDays days old';
  }

  /// Localizes the label
  /// ```dart
  /// return '$ageInMonths months old';
  /// ```
  /// * default is english (en)
  String ageInMonths({required int ageInMonths}) {
    if (languageLocale == 'de') return '$ageInMonths Monate alt';
    return '$ageInMonths months old';
  }

  /// Localizes the label
  /// ```dart
  /// return '$ageInYears years old';
  /// ```
  /// * default is english (en)
  String ageInYears({required int ageInYears}) {
    if (languageLocale == 'de') return '$ageInYears Jahre alt';
    return '$ageInYears years old';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Shows upcoming birthdays that are within the next 120 days.';
  /// ```
  /// * default is english (en)
  String infoMessageNextBirthdays() {
    if (languageLocale == 'de') return 'Zeigt bevorstehende Geburtstage, die innerhalb der nächsten 120 Tage liegen.';
    return 'Shows upcoming birthdays that are within the next 120 days.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Birthday is today!';
  /// ```
  /// * default is english (en)
  String birthdayIsToday() {
    if (languageLocale == 'de') return 'Hat heute Geburtstag!';
    return 'Birthday is today!';
  }

  /// Localizes the label
  /// ```dart
  /// return 'This setting allows you to select a default currency, which will be used initially when creating a group.\n\nIf no default is set, the app will attempt to infer the currency based on the device\'s language locale.\n\nIf no meaningful assumption can be made, "USD" will be used as the default.';
  /// ```
  /// * default is english (en)
  String settingsSheetDefaultCurrencyInfoMessage() {
    if (languageLocale == 'de') return 'Diese Einstellung ermöglicht es, eine Standardwährung auszuwählen, die bei der Erstellung einer Gruppe verwendet wird.\n\nWenn keine Standardwährung festgelegt ist, versucht die App, eine Standardwährung basierend auf der Spracheinstellung des Geräts zu ermitteln.\n\nFalls keine sinnvolle Annahme getroffen werden kann, wird „USD“ als Standard verwendet.';
    return 'This setting allows you to select a default currency, which will be used initially when creating a group.\n\nIf no default is set, the app will attempt to infer the currency based on the device\'s language locale.\n\nIf no meaningful assumption can be made, "USD" will be used as the default.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Failed to find referenced cached chart items.';
  /// ```
  /// * default is english (en)
  String cachedChartItemsNotFound() {
    if (languageLocale == 'de') return 'Zwischengespeicherte Diagrammdaten konnten nicht gefunden werden.';
    return 'Failed to find referenced cached chart items.';
  }

  /// Localizes the label
  /// ```dart
  /// return canChangeParameters ? 'The currency can be changed when creating the entry.' : 'The currency cannot be changed when creating the entry.';
  /// ```
  /// * default is english (en)
  String canChangeCurrency({required bool canChangeParameters}) {
    if (languageLocale == 'de') return canChangeParameters ? 'Beim erstellen des Eintrags kann die Währung geändert werden.' : 'Beim erstellen des Eintrags kann die Währung nicht geändert werden.';
    return canChangeParameters ? 'The currency can be changed when creating the entry.' : 'The currency cannot be changed when creating the entry.';
  }

  /// Localizes the label
  /// ```dart
  /// return canChangeParameters ? 'The measurement category and the unit can be changed when creating the entry.' : 'The measurement category and the unit cannot be changed when creating the entry.';
  /// ```
  /// * default is english (en)
  String canChangeUnits({required bool canChangeParameters}) {
    if (languageLocale == 'de') return canChangeParameters ? 'Beim erstellen des Eintrags kann die Messkategorie und die Einheit geändert werden.' : 'Beim erstellen des Eintrags kann die Messkategorie und die Einheit nicht geändert werden.';
    return canChangeParameters ? 'The measurement category and the unit can be changed when creating the entry.' : 'The measurement category and the unit cannot be changed when creating the entry.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Prepareing additional data.\n\nThis may take some time.';
  /// ```
  /// * default is english (en)
  String chartsSheetContentLoadingMessage() {
    if (languageLocale == 'de') return 'Zusätzliche Daten werden vorbereitet.\n\nDies kann einige Zeit in Anspruch nehmen.';
    return 'Prepareing additional data.\n\nThis may take some time.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Currently all notifications of this app are grouped in this channel.';
  /// ```
  /// * default is english (en)
  String allNotificationsAreGroupedInOneChannel() {
    if (languageLocale == 'de') return 'Derzeit sind alle Benachrichtigungen in einem Channel gruppiert.';
    return 'Currently all notifications of this app are grouped in this channel.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Set notification';
  /// ```
  /// * default is english (en)
  String setNotification() {
    if (languageLocale == 'de') return 'Benachrichtigung anlegen';
    return 'Set notification';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Show notification';
  /// ```
  /// * default is english (en)
  String showNotification() {
    if (languageLocale == 'de') return 'Benachrichtigung anzeigen';
    return 'Show notification';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Notifications are only visible to you.';
  /// ```
  /// * default is english (en)
  String notificationsAreOnlyVisibleToYou() {
    if (languageLocale == 'de') return 'Benachrichtigung werden nur dir angezeigt.';
    return 'Notifications are only visible to you.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'No notifications set.';
  /// ```
  /// * default is english (en)
  String noNotificationsSet() {
    if (languageLocale == 'de') return 'Noch keine Benachrichtigungen angelegt.';
    return 'No notifications set.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Notifications';
  /// ```
  /// * default is english (en)
  String notifications() {
    if (languageLocale == 'de') return 'Benachrichtigungen';
    return 'Notifications';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Entry notifications';
  /// ```
  /// * default is english (en)
  String entryNotifications() {
    if (languageLocale == 'de') return 'Eintrags Benachrichtigungen';
    return 'Entry notifications';
  }

  /// Localizes the label
  /// ```dart
  /// return 'It`s the birthday of $entryName!';
  /// ```
  /// * default is english (en)
  String dateOfBirthNotificationTitle({required String entryName}) {
    if (languageLocale == 'de') return 'Der Geburtstag von $entryName ist heute!';
    return 'It`s the birthday of $entryName!';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Notification title (optional)';
  /// ```
  /// * default is english (en)
  String entrySheetNotificationTitle() {
    if (languageLocale == 'de') return 'Titel der Benachrichtigung (optional)';
    return 'Notification title (optional)';
  }

  /// Localizes the label
  /// ```dart
  /// return 'A participant ID is required.';
  /// ```
  /// * default is english (en)
  String participantIdRequired() {
    if (languageLocale == 'de') return 'Eine Teilnehmer ID ist notwendig für diese Anfrage.';
    return 'A participant ID is required.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Only 60 local notifications are allowed.';
  /// ```
  /// * default is english (en)
  String tooManyNotifications() {
    if (languageLocale == 'de') return 'Derzeit sind nur 60 lokale Benachrichtigungen erlaubt.';
    return 'Only 60 local notifications are allowed.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Please provide a password.';
  /// ```
  /// * default is english (en)
  String passwordCannotBeEmpty() {
    if (languageLocale == 'de') return 'Bitte gib ein Passwort an.';
    return 'Please provide a password.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Password cannot exceed 50 characters.';
  /// ```
  /// * default is english (en)
  String passwordIsTooLong() {
    if (languageLocale == 'de') return 'Passwort darf nicht länger als 50 Zeichen sein.';
    return 'Password cannot exceed 50 characters.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Provided password is incorrect.';
  /// ```
  /// * default is english (en)
  String incorrectPassword() {
    if (languageLocale == 'de') return 'Falsches Passwort.';
    return 'Provided password is incorrect.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'An app password is required to enable this function.\n\nPlease first set an app password in the main menu.';
  /// ```
  /// * default is english (en)
  String appPasswordRequired() {
    if (languageLocale == 'de') return 'Um diese Funktion zu nutzen ist ein App Passwort notwendig.\n\nBitte erstelle zunächst ein App Passwort im Menu der Startseite.';
    return 'An app password is required to enable this function.\n\nPlease first set an app password in the main menu.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Group password';
  /// ```
  /// * default is english (en)
  String createCustomPasswordSheetTitle() {
    if (languageLocale == 'de') return 'App Passwort';
    return 'App password';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Group default currency and current currency differ.\n\nWe will attempt to access the correct exchange rate through our servers.\n\nYou can set a custom exchange rate if you want to prevent this.';
  /// ```
  /// * default is english (en)
  String infoMessageCustomExchangeRate({required bool isDefault}) {
    if (languageLocale == 'de') return '${isDefault ? '' : 'Die Standardwährung der Gruppe und die aktuelle Währung unterscheiden sich.\n\n'}Wir werden versuchen, den korrekten Wechselkurs über unsere Server abzurufen.\n\nLege einen benutzerdefinierten Wechselkurs fest, um dies zu verhindern.';
    return '${isDefault ? '' : 'Group default currency and current currency differ.\n\n'}We will attempt to access the correct exchange rate through our servers.\n\nYou can set a custom exchange rate if you want to prevent this.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Create new password';
  /// ```
  /// * default is english (en)
  String createNewPassword() {
    if (languageLocale == 'de') return 'Neues Passwort erstellen';
    return 'Create new password';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Loading more entries...';
  /// ```
  /// * default is english (en)
  String loadingMoreEntries() {
    if (languageLocale == 'de') return 'Mehr Einträge laden...';
    return 'Loading more entries...';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Failed to load entries. Please try again.';
  /// ```
  /// * default is english (en)
  String failedToLoadEntries() {
    if (languageLocale == 'de') return 'Fehler beim laden der Einträge. Bitte versuche es noch einmal.';
    return 'Failed to load entries. Please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'It seems like there is no more content.';
  /// ```
  /// * default is english (en)
  String noMoreContent() {
    if (languageLocale == 'de') return 'Es sieht danach aus als wäre das alles.';
    return 'It seems like there is no more content.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Update password';
  /// ```
  /// * default is english (en)
  String updatePassword() {
    if (languageLocale == 'de') return 'Passwort aktualisieren';
    return 'Update password';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Check again';
  /// ```
  /// * default is english (en)
  String basicLabelsCheckAgain() {
    if (languageLocale == 'de') return 'Noch einmal nachsehen';
    return 'Check again';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Group alias';
  /// ```
  /// * default is english (en)
  String groupAlias() {
    if (languageLocale == 'de') return 'Gruppen Alias';
    return 'Group alias';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Alias copied';
  /// ```
  /// * default is english (en)
  String aliasCopied() {
    if (languageLocale == 'de') return 'Alias kopiert';
    return 'Alias copied';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Invite link';
  /// ```
  /// * default is english (en)
  String groupInviteLink() {
    if (languageLocale == 'de') return 'Einladungslink';
    return 'Invite link';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Link copied';
  /// ```
  /// * default is english (en)
  String inviteLinkCopied() {
    if (languageLocale == 'de') return 'Link kopiert';
    return 'Link copied';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Invite link as QR code';
  /// ```
  /// * default is english (en)
  String groupInviteLinkAsQrCode() {
    if (languageLocale == 'de') return 'Einladungslink als QR-Code';
    return 'Invite link as QR code';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Aquarius';
  /// ```
  /// * default is english (en)
  String zodiacSignAquarius() {
    if (languageLocale == 'de') return 'Wassermann';
    return 'Aquarius';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Pisces';
  /// ```
  /// * default is english (en)
  String zodiacSignPisces() {
    if (languageLocale == 'de') return 'Fische';
    return 'Pisces';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Aries';
  /// ```
  /// * default is english (en)
  String zodiacSignAries() {
    if (languageLocale == 'de') return 'Widder';
    return 'Aries';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Taurus';
  /// ```
  /// * default is english (en)
  String zodiacSignTaurus() {
    if (languageLocale == 'de') return 'Stier';
    return 'Taurus';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Gemini';
  /// ```
  /// * default is english (en)
  String zodiacSignGemini() {
    if (languageLocale == 'de') return 'Zwillinge';
    return 'Gemini';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Cancer';
  /// ```
  /// * default is english (en)
  String zodiacSignCancer() {
    if (languageLocale == 'de') return 'Krebs';
    return 'Cancer';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Leo';
  /// ```
  /// * default is english (en)
  String zodiacSignLeo() {
    if (languageLocale == 'de') return 'Löwe';
    return 'Leo';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Virgo';
  /// ```
  /// * default is english (en)
  String zodiacSignVirgo() {
    if (languageLocale == 'de') return 'Jungfrau';
    return 'Virgo';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Libra';
  /// ```
  /// * default is english (en)
  String zodiacSignLibra() {
    if (languageLocale == 'de') return 'Waage';
    return 'Libra';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Scorpio';
  /// ```
  /// * default is english (en)
  String zodiacSignScorpio() {
    if (languageLocale == 'de') return 'Skorpion';
    return 'Scorpio';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Sagittarius';
  /// ```
  /// * default is english (en)
  String zodiacSignSagittarius() {
    if (languageLocale == 'de') return 'Schütze';
    return 'Sagittarius';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Capricorn';
  /// ```
  /// * default is english (en)
  String zodiacSignCapricorn() {
    if (languageLocale == 'de') return 'Steinbock';
    return 'Capricorn';
  }

  /// Localizes the label
  /// ```dart
  /// return 'No group created yet. Please create a group and try again.';
  /// ```
  /// * default is english (en)
  String noGroupCreatedYet() {
    if (languageLocale == 'de') return 'Noch keine Gruppe erstellt. Bitte erstelle eine Gruppe und versuche es noch einmal.';
    return 'No group created yet. Please create a group and try again.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Please select a group that you want to import the data to.';
  /// ```
  /// * default is english (en)
  String importToGroupInfoMessage() {
    if (languageLocale == 'de') return 'Bitte wähle eine Gruppe in die importiert werden soll.';
    return 'Please select a group that you want to import the data to.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Currently only ".csv" files are supported.';
  /// ```
  /// * default is english (en)
  String chooseFileInfoMessage() {
    if (languageLocale == 'de') return 'Derzeit werden nur ".csv" Dateien unterstützt.';
    return 'Currently only ".csv" files are supported.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Import to $groupName';
  /// ```
  /// * default is english (en)
  String importToGroup({required String groupName}) {
    if (languageLocale == 'de') return 'Importieren nach "$groupName"';
    return 'Import to "$groupName"';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Export data';
  /// ```
  /// * default is english (en)
  String exportData() {
    if (languageLocale == 'de') return 'Daten exportieren';
    return 'Export data';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Match to model entry';
  /// ```
  /// * default is english (en)
  String matchToModelEntry() {
    if (languageLocale == 'de') return 'Mit Eintragsvorlage verknüpfen';
    return 'Match to model entry';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Supplied data has to be matched to a model entry in order to conduct import.\n\nYou can either choose an existing one or create a new model entry customized to the supplied data.';
  /// ```
  /// * default is english (en)
  String infoMessageMatchToModelEntry() {
    if (languageLocale == 'de') return 'Daten müssen mit einer Eintragsvorlage verknüpft werden um den Import zu ermöglichen.\n\nBitte wähle entweder eine bestehende passende Eintragsvorlage oder erstelle eine Neue welche an die bereitgestellten Daten angepasst ist.';
    return 'Supplied data has to be matched to a model entry in order to conduct import.\n\nYou can either choose an existing one or create a new model entry customized to the supplied data.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Please first choose a file to import.';
  /// ```
  /// * default is english (en)
  String noFileChosen() {
    if (languageLocale == 'de') return 'Bitte wähle zuerst eine Datei zum importieren aus.';
    return 'Please first choose a file to import.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Dateien im Format ".csv" verwenden ein Trennzeichen um den Start und das Ende von individuellen Datenpunkten zu markieren.\n\nNormalerweise wird "," verwendet jedoch wird im Deutsch sprachigem Raum oft ";" verwendet da Zahlen im deutschen Kontext mit der Formatierung intervenieren.';
  /// ```
  /// * default is english (en)
  String delimiterInfoMessage() {
    if (languageLocale == 'de') return 'Dateien im Format ".csv" verwenden ein Trennzeichen um den Start und das Ende von individuellen Datenpunkten zu markieren.\n\nNormalerweise ist dies "," jedoch wird im deutschsprachigem Raum oft ";" verwendet da Zahlen im deutschen Kontext mit der Formatierung intervenieren.';
    return 'Files of the type ".csv" utilize a delimiter which specifies start and end of a new data point.\n\nTypically "," is used.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Please first choose a file to import.';
  /// ```
  /// * default is english (en)
  String infoMessageImportClean() {
    if (languageLocale == 'de') return 'Bitte erstelle einen Beispiel-Eintrag.\n\nDieser wird verwendet, um die bereitgestellten Daten korrekt den in dem vorherigen Schritt ausgewählten Feldern zuzuordnen, indem zusätzlicher Kontext bereitgestellt wird.';
    return 'Please create a sample entry.\n\nThis is used to match provided data correctly to chosen fields in the previous step by giving additional context.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Match to model entry';
  /// ```
  /// * default is english (en)
  String entrySheetImportMatchInfoMessage() {
    if (languageLocale == 'de') return 'Wenn ein Wert in einem Eingabefeld angegeben wird, wird dieser als Standardwert für dieses Feld verwendet.\n\nDieser wird benutzt wie in den Importregeln festgelegt.';
    return 'The value used in a text field will be used as a default value for this field.\n\nThis value will be used as specified in the import rules.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Import succeeded';
  /// ```
  /// * default is english (en)
  String importSucceeded() {
    if (languageLocale == 'de') return 'Import erfolgreich';
    return 'Import succeeded';
  }

  /// Localizes the label
  /// ```dart
  /// return 'For the entry name a default value has to be provided even though it might be connected to a datapoint.';
  /// ```
  /// * default is english (en)
  String failureEntryNameDefaultRequired() {
    if (languageLocale == 'de') return 'Für den Eintragsnamen muss ein Standardwert angegeben werden selbst wenn dieser mit einem Datenpunkt verknüpft ist.';
    return 'For the entry name a default value has to be provided even though it might be connected to a datapoint.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Please first provide a sample entry.';
  /// ```
  /// * default is english (en)
  String failureSampleEntryRequired() {
    if (languageLocale == 'de') return 'Bitte erstelle zunächst einen Beispiel-Eintrag.';
    return 'Please first provide a sample entry.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'A invalid value was discovered in row $row for $rowKey.\n\nImport failed as specified.';
  /// ```
  /// * default is english (en)
  String importInvalidValueShouldFail({required String? rowKey, required int row, required bool tooManyChars}) {
    if (languageLocale == 'de') {
      if (rowKey == null || rowKey.isEmpty) return 'Ein fehlerhafter Wert wurde gefunden in Zeile $row. Dies liegt möglicherweise daran, dass keine Importreferenz angegeben wurde.\n\nImport fehlgeschlagen wie angegeben.';

      if (tooManyChars) {
        return 'Ein fehlerhafter Wert wurde in Zeile $row für $rowKey gefunden. Dies liegt möglicherweise daran, dass die Anzahl der Zeichen die maximale Grenze überschreitet.\n\nImport fehlgeschlagen wie angegeben.';
      }

      return 'Ein fehlerhafter Wert wurde gefunden in Zeile $row für $rowKey.\n\nImport fehlgeschlagen wie angegeben.';
    }

    if (rowKey == null || rowKey.isEmpty) return 'A invalid value was discovered in row $row. This might be because no import reference was provided.\n\nImport failed as specified.';

    if (tooManyChars) {
      return 'An invalid value was discovered in row $row for $rowKey. This might be because the character count exceeds the maximum limit.\n\nImport failed as specified.';
    }

    return 'A invalid value was discovered in row $row for $rowKey.\n\nImport failed as specified.';
  }

  /// Localizes the label
  /// ```dart
  /// if (category == null || category.isEmpty || unit == null || unit.isEmpty) return 'A invalid category/unit pair was discovered in $row.\n\nImport failed as specified.';
  /// return 'A invalid category/unit ($category/$unit) pair was discovered in row $row.\n\nImport failed as specified.';
  /// ```
  /// * default is english (en)
  String importInvalidMeasurementPair({required String? category, required String? unit, required int row}) {
    if (languageLocale == 'de') {
      if (category == null || category.isEmpty || unit == null || unit.isEmpty) return 'Ein fehlerhaftes Messkategorie/Messeinheit Paar wurde gefunden in Zeile $row.\n\nImport fehlgeschlagen wie angegeben.';
      return 'Ein fehlerhaftes Messkategorie/Messeinheit ($category/$unit) Paar wurde gefunden in Zeile $row.\n\nImport fehlgeschlagen wie angegeben.';
    }

    if (category == null || category.isEmpty || unit == null || unit.isEmpty) return 'A invalid category/unit pair was discovered in $row.\n\nImport failed as specified.';
    return 'A invalid category/unit ($category/$unit) pair was discovered in row $row.\n\nImport failed as specified.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'A missing value was discovered in row $row for $rowKey.\n\nImport failed as specified.';
  /// ```
  /// * default is english (en)
  String importMissingValueShouldFail({required String? rowKey, required int row}) {
    if (languageLocale == 'de') {
      if (rowKey == null || rowKey.isEmpty) return 'Ein Wert konnte nicht gefunden werden in Zeile $row. Dies liegt möglicherweise daran, dass keine Importreferenz angegeben wurde.\n\nImport fehlgeschlagen wie angegeben.';
      return 'Ein Wert konnte nicht gefunden werden in Zeile $row für $rowKey.\n\nImport fehlgeschlagen wie angegeben.';
    }

    if (rowKey == null || rowKey.isEmpty) return 'A missing value was discovered in row $row. This might be because no import reference was provided.\n\nImport failed as specified.';
    return 'A missing value was discovered in row $row for $rowKey.\n\nImport failed as specified.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Emotion data import failed in row $row because lists which indicate the emotion type, emotion intensity and emotion occurrence have a different number of items but they need to be of equal length.';
  /// ```
  /// * default is english (en)
  String importEmotionsListLengthsDiffer({required int row}) {
    if (languageLocale == 'de') {
      return 'Emotionen in Zeile $row konnten nicht importiert werden weil die Listen welche den Emotionstyp, die Intensität und das Datum unterschiedlich lang sind.';
    }

    return 'Emotion data import failed in row $row because lists which indicate the emotion type, emotion intensity and emotion occurrence have a different number of items but they need to be of equal length.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Entries imported: $index';
  /// ```
  /// * default is english (en)
  String loadingMessageEntriesImported({required int index}) {
    if (languageLocale == 'de') return 'Einträge importiert: $index';
    return 'Entries imported: $index';
  }

  /// Localizes the label
  /// ```dart
  /// return 'No exports left this month.';
  /// ```
  /// * default is english (en)
  String noSharedExportsLeft() {
    if (languageLocale == 'de') return 'Diesen Monat stehen keine Exporte mehr zur Verfügung.';
    return 'No exports left this month.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Exports left this month';
  /// ```
  /// * default is english (en)
  String exportsleft() {
    if (languageLocale == 'de') return 'Verbleibende Exporte diesen Monat';
    return 'Exports left this month';
  }

  /// Localizes the label
  /// ```dart
  /// return 'No group selected.';
  /// ```
  /// * default is english (en)
  String noGroupSelected() {
    if (languageLocale == 'de') return 'Keine Gruppe ausgewählt.';
    return 'No group selected.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Only group creator can export groups.';
  /// ```
  /// * default is english (en)
  String onlyGroupCreatorCanExport() {
    if (languageLocale == 'de') return 'Nur der Gruppenersteller kann Gruppen exportieren.';
    return 'Only group creator can export groups.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Please make sure that selected import reference fields are in the form of a list like "1,2,3".';
  /// ```
  /// * default is english (en)
  String infoMessageListRequired() {
    if (languageLocale == 'de') return 'Bitte stelle sicher, dass die Importreferenzen auf Listen in der Form "1,2,3" verweisen.';
    return 'Please make sure that selected import reference fields are in the form of a list like "1,2,3".';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Show data sample';
  /// ```
  /// * default is english (en)
  String showDataSample() {
    if (languageLocale == 'de') return 'Datensatz Stichprobe anzeigen';
    return 'Show data sample';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Show data sample';
  /// ```
  /// * default is english (en)
  String positiveForIncomeNegativeForExpenses() {
    if (languageLocale == 'de') return 'Verwende negative Werte für Ausgaben und positive Werte für Einnahmen.';
    return 'Use negative values for expenses and positive values for incomes.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Accessing required exchange rates...';
  /// ```
  /// * default is english (en)
  String accessingRequiredExchangeRates() {
    if (languageLocale == 'de') return 'Nach Wechselkursen suchen...';
    return 'Accessing required exchange rates...';
  }

  /// Localizes the label
  /// ```dart
  /// return 'This group is empty.';
  /// ```
  /// * default is english (en)
  String groupIsEmpty() {
    if (languageLocale == 'de') return 'Diese Gruppe is leer.';
    return 'This group is empty.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Failed to load files.';
  /// ```
  /// * default is english (en)
  String failedToLoadFiles() {
    if (languageLocale == 'de') return 'Fehler beim Laden der Dateien.';
    return 'Failed to load files.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Could not find model entry.';
  /// ```
  /// * default is english (en)
  String modelEntryNotFound() {
    if (languageLocale == 'de') return 'Eintragsvorlage konnte nicht gefunden werden.';
    return 'Could not find model entry.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Failed to access secrets needed for encryption, please try again.';
  /// ```
  /// * default is english (en)
  String failedToAccessSecrets() {
    if (languageLocale == 'de') return 'Fehler beim Laden der Schlüssel, die zum Verschlüsseln notwendig sind. Bitte versuche es noch einmal.';
    return 'Failed to access secrets needed for encryption, please try again.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Specified import rule is unknown.';
  /// ```
  /// * default is english (en)
  String unknownImportRule() {
    if (languageLocale == 'de') return 'Importregel ist unbekannt.';
    return 'Specified import rule is unknown.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Unknown field type discovered.';
  /// ```
  /// * default is english (en)
  String unknownFieldType() {
    if (languageLocale == 'de') return 'Unbekannter Feld Typ gefunden.';
    return 'Unknown field type discovered.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Caution!\n\nPlease be aware that entry names will not be encrypted and therefore should not contain sensible information!\n\nThe reason for this is, that encrypted data is not searchable and entries should maintain searchability.';
  /// ```
  /// * default is english (en)
  String entryNameisNotEncryptedInfoMessage() {
    if (languageLocale == 'de') return 'Achtung!\n\nBitte beachte, dass Eintragsnamen nicht verschlüsselt werden und daher keine sensiblen Informationen enthalten sollten!\n\nDer Grund dafür ist, dass verschlüsselte Daten nicht durchsuchbar sind, Einträge jedoch suchbar sein sollten.';
    return 'Caution!\n\nPlease be aware that entry names will not be encrypted and therefore should not contain sensible information!\n\nThe reason for this is, that encrypted data is not searchable and entries should maintain searchability.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Caution!\n\nPlease be aware that only the actual file will be encrypted.\n\nValues like the title or the caption are not encrypted and should not contain sensible information!';
  /// ```
  /// * default is english (en)
  String fileValuesNotEncryptedInfoMessage() {
    if (languageLocale == 'de') return 'Achtung!\n\nBitte beachte, dass nur die eigentliche Datei verschlüsselt wird!\n\nWerte wie der Titel oder die Beschriftung werden nicht verschlüsselt und sollten daher keine sensiblen Informationen enthalten!';
    return 'Caution!\n\nPlease be aware that only the actual file will be encrypted.\n\nValues like the title or the caption are not encrypted and should not contain sensible information!';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Caution!\n\nPlease be aware, that tags will not be encrypted and therefore should not contain sensible information!\n\nThe reason for this is, that encrypted data is not searchable and tags should maintain searchability.';
  /// ```
  /// * default is english (en)
  String tagsNotEncryptedInfoMessage() {
    if (languageLocale == 'de') return 'Achtung!\n\nBitte beachte, dass Tags nicht verschlüsselt werden und daher keine sensiblen Informationen enthalten sollten!\n\nDer Grund dafür ist, dass verschlüsselte Daten nicht durchsuchbar sind, Tags jedoch suchbar sein sollten.';
    return 'Caution!\n\nPlease be aware, that tags will not be encrypted and therefore should not contain sensible information!\n\nThe reason for this is, that encrypted data is not searchable and tags should maintain searchability.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Unknown time format.';
  /// ```
  /// * default is english (en)
  String unknownTimeFormat() {
    if (languageLocale == 'de') return 'Unbekanntes Zeitformat gefunden.';
    return 'Unknown time format.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Account is locked because to many invalid password attempts have been made.\n\nPlease try again later.';
  /// ```
  /// * default is english (en)
  String lockoutError() {
    if (languageLocale == 'de') return 'Konto ist gesperrt, da zu viele ungültige Passwortversuche unternommen wurden.\n\nBitte versuche es später noch einmal.';
    return 'Account is locked because to many invalid password attempts have been made.\n\nPlease try again later.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'No common model entries selected.';
  /// ```
  /// * default is english (en)
  String noCommonModelEntriesSelected() {
    if (languageLocale == 'de') return 'Keine gemeinsamen Eintragsvorlagen ausgewählt.';
    return 'No common model entries selected.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Exchange rate must be greater than zero.';
  /// ```
  /// * default is english (en)
  String customExchangeRateMustBeGreaterZero() {
    if (languageLocale == 'de') return 'Wechselkurs muss größer Null sein.';
    return 'Exchange rate must be greater than zero.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Caution!\n\nYou are about to save a password in a group that is not encrypted which means the password itself will also not be encrypted!\n\nA group and its contents can be encrypted by setting a password in the main menu and setting the "is protected" switch to true in the group settings.';
  /// ```
  /// * default is english (en)
  String passwordNotEncryptedWarning() {
    if (languageLocale == 'de') return 'Achtung!\n\nDu bist dabei, ein Passwort in einer Gruppe zu speichern, die nicht verschlüsselt ist. Das bedeutet, dass auch das Passwort selbst nicht verschlüsselt wird!\n\nEine Gruppe und deren Inhalte können verschlüsselt werden, indem im Hauptmenü ein Passwort festgelegt wird und in den Gruppeneinstellungen der Schalter „Gruppe verschlüsseln" auf „An“ gesetzt wird.\n\nBitte beachte, dass Gruppen nur verschlüsselt werden können wenn diese noch keine Eintrage beinhalten.';
    return 'Caution!\n\nYou are about to save a password in a group that is not encrypted which means the password itself will also not be encrypted!\n\nA group and its contents can be encrypted by setting a password in the main menu and setting the "Encrypt group" switch to true in the group settings.\n\nPlease consider that groups can only be encrypted if the group does not contain any entries yet.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Only the first $shownRows rows of provided data are shown.';
  /// ```
  /// * default is english (en)
  String dataPreview({required int shownRows}) {
    if (languageLocale == 'de') return 'Nur die ersten $shownRows Zeilen des Datensatzes werden angezeigt.';
    return 'Only the first $shownRows rows of provided data are shown.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'This group contains entries that need an exchange rate to accurately calculate charts but several were not found or are invalid.\n\nPlease provide exchange rates for these entries to continue.\n\nCurrently invalid: $numberOfInvalid';
  /// ```
  /// * default is english (en)
  String invalidExchangeRatesInfoMessage() {
    if (languageLocale == 'de') return 'In dieser Gruppe wurden Einträge gefunden die entweder keinen oder einen ungültigen Wechselkurs haben.\n\nBitte gib die benötigten Wechselkurse an um die Diagramme sehen zu können.';
    return 'This group contains entries that need an exchange rate to accurately calculate charts but several were not found or are invalid.\n\nPlease provide exchange rates for these entries to continue.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Set invalid value rule';
  /// ```
  /// * default is english (en)
  String setInvalidValueRule({required String? rule}) {
    if (languageLocale == 'de') {
      // Rule is empty or null, return initial string.
      if (rule == null || rule.isEmpty) return 'Regel für ungültige Werte';

      // Check which rule was chosen.
      final bool isFail = ImportSpecifications.importRuleFail == rule;
      final bool isSkip = ImportSpecifications.importRuleSkip == rule;
      final bool isDefaultOrFail = ImportSpecifications.importRuleDefaultOrFail == rule;
      final bool isDefaultOrSkip = ImportSpecifications.importRuleDefaultOrSkip == rule;

      if (isFail) return 'Import schlägt fehl';
      if (isSkip) return 'Import überspringt Wert';
      if (isDefaultOrFail) return 'Standardwert sonst fehlschlagen';
      if (isDefaultOrSkip) return 'Standardwert sonst überspringen';

      // Return default on unknown rule.
      return 'Regel bearbeiten';
    }

    // Rule is empty or null, return initial string.
    if (rule == null || rule.isEmpty) return 'Set invalid value rule';

    // Check which rule was chosen.
    final bool isFail = ImportSpecifications.importRuleFail == rule;
    final bool isSkip = ImportSpecifications.importRuleSkip == rule;
    final bool isDefaultOrFail = ImportSpecifications.importRuleDefaultOrFail == rule;
    final bool isDefaultOrSkip = ImportSpecifications.importRuleDefaultOrSkip == rule;

    if (isFail) return 'Import will fail';
    if (isSkip) return 'Import will skip value';
    if (isDefaultOrFail) return 'Use default or fail';
    if (isDefaultOrSkip) return 'use default or skip';

    // Return default on unknown rule.
    return 'Edit rule';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Set missing value rule';
  /// ```
  /// * default is english (en)
  String setMissingValueRule({required String? rule}) {
    if (languageLocale == 'de') {
      // Rule is empty or null, return initial string.
      if (rule == null || rule.isEmpty) return 'Regel für fehlende Werte';

      // Check which rule was chosen.
      final bool isFail = ImportSpecifications.importRuleFail == rule;
      final bool isSkip = ImportSpecifications.importRuleSkip == rule;
      final bool isDefaultOrFail = ImportSpecifications.importRuleDefaultOrFail == rule;
      final bool isDefaultOrSkip = ImportSpecifications.importRuleDefaultOrSkip == rule;

      if (isFail) return 'Import schlägt fehl';
      if (isSkip) return 'Import überspringt Wert';
      if (isDefaultOrFail) return 'Standardwert sonst fehlschlagen';
      if (isDefaultOrSkip) return 'Standardwert sonst überspringen';

      // Return default on unknown rule.
      return 'Regel bearbeiten';
    }

    // Rule is empty or null, return initial string.
    if (rule == null || rule.isEmpty) return 'Set missing value rule';

    // Check which rule was chosen.
    final bool isFail = ImportSpecifications.importRuleFail == rule;
    final bool isSkip = ImportSpecifications.importRuleSkip == rule;
    final bool isDefaultOrFail = ImportSpecifications.importRuleDefaultOrFail == rule;
    final bool isDefaultOrSkip = ImportSpecifications.importRuleDefaultOrSkip == rule;

    if (isFail) return 'Import will fail';
    if (isSkip) return 'Import will skip value';
    if (isDefaultOrFail) return 'Use default or fail';
    if (isDefaultOrSkip) return 'use default or skip';

    // Return default on unknown rule.
    return 'Edit rule';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Please choose what should happen if during import an invalid value is encountered.';
  /// ```
  /// * default is english (en)
  String infoMessageInvalidValueRule() {
    if (languageLocale == 'de') return 'Bitte lege fest, was passieren soll wenn während des Imports ein ungültiger Wert gefunden wird.';
    return 'Please choose what should happen if during import an invalid value is encountered.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Please choose what should happen if during import a missing value is encountered.';
  /// ```
  /// * default is english (en)
  String infoMessageMissingValueRule() {
    if (languageLocale == 'de') return 'Bitte lege fest, was passieren soll wenn während des Imports ein fehlender Wert gefunden wird.';
    return 'Please choose what should happen if during import a missing value is encountered.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'A missing default was discovered in row $row for $rowKey.\n\nImport failed as specified.';
  /// ```
  /// * default is english (en)
  String importMissingDefaultShouldFail({required String rowKey, required int row}) {
    if (languageLocale == 'de') return 'Es wurde kein Standardwert gefunden in der Zeile $row für $rowKey.\n\nImport fehlgeschlagen wie angegeben.';
    return 'A missing default was discovered in row $row for $rowKey.\n\nImport failed as specified.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Please set a rule for invalid values.';
  /// ```
  /// * default is english (en)
  String invalidValueRuleRequired() {
    if (languageLocale == 'de') return 'Bitte lege fest, was passieren soll wenn während des Imports ein ungültiger Wert gefunden wird.';
    return 'Please set a rule for invalid values.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Please set a rule for missing values.';
  /// ```
  /// * default is english (en)
  String missingValueRuleRequired() {
    if (languageLocale == 'de') return 'Bitte lege fest, was passieren soll wenn während des Imports ein fehlender Wert gefunden wird.';
    return 'Please set a rule for missing values.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Payment data import references are incomplete.';
  /// ```
  /// * default is english (en)
  String invalidPaymentImportReferences() {
    if (languageLocale == 'de') return 'Import Referenzen für das Zahlungsfeld sind unvollständig.';
    return 'Payment data import references are incomplete.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Please link members with datapoints to import payment data.';
  /// ```
  /// * default is english (en)
  String importInvalidMemberReferences() {
    if (languageLocale == 'de') return 'Bitte verknüpfe die Mitglieder mit Datenpunkten um Zahlungen zu importieren.';
    return 'Please link members with datapoints to import payment data.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Member with the name "$providedMemberName" could not be found.';
  /// ```
  /// * default is english (en)
  String importCouldNotFindMemberName({required String providedMemberName, required String rowKey, required int row}) {
    if (languageLocale == 'de') return 'Zahlendes Mitglid mit dem Namen "$providedMemberName" konnte nicht gefunden werden.';
    return 'Member with the name "$providedMemberName" could not be found.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Group lacks a participant.';
  /// ```
  /// * default is english (en)
  String groupDoesNotHaveAParticipant() {
    if (languageLocale == 'de') return 'Diese Gruppe hat noch keine Mitglieder.';
    return 'Group lacks a participant.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'An export is currently only possible as a "csv" file.\n\nPlease consider that exporting fields of the type "Images" and "Avatar Image" is currently not possible. They will be ignored during the export.';
  /// ```
  /// * default is english (en)
  String exportDataInfoMessage() {
    if (languageLocale == 'de') return 'Bitte wähle aus welche Gruppe exportiert werden soll.\n\nDerzeit ist das exportieren nur als "CSV" Datei möglich.\n\nBitte beachte, dass Felder der Typen "Bilder" und "Avatar Bild" derzeit nicht möglich ist. Diese werden beim exportieren ignoriert.';
    return 'Please choose a group to export.\n\nAn export is currently only possible as a "csv" file.\n\nPlease consider that exporting fields of the type "Images" and "Avatar Image" is currently not possible. They will be ignored during the export.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'There are currently no groups available for export.';
  /// ```
  /// * default is english (en)
  String noGroupsForExport() {
    if (languageLocale == 'de') return 'Derzeit sind keine Gruppen für den Export verfügbar.';
    return 'There are currently no groups available for export.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Exports of shared data is limited for security and cost reasons.';
  /// ```
  /// * default is english (en)
  String sharedExportsLimitsInfoMessage() {
    if (languageLocale == 'de') return 'Nur der Gruppenbesitzer kann exportieren.\n\nDer Export von geteilten Gruppen ist limitiert aus Sicherheits- und Kostengründen.';
    return 'Only the group owner can export.\n\nExports of shared data is limited for security and cost reasons.';
  }

  /// Localizes the label
  /// ```dart
  /// return 'Checking for files...';
  /// ```
  /// * default is english (en)
  String checkingForFiles() {
    if (languageLocale == 'de') return 'Nach Dateien suchen...';
    return 'Checking for files...';
  }
}
