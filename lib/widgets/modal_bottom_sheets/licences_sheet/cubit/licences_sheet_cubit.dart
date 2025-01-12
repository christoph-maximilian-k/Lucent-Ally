import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Config.
import '/config/app_durations.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/licences/licence_item.dart';
import '/data/models/licences/licences.dart';

// Sheets.
import '/widgets/modal_bottom_sheets/licences_sheet/display_licences_sheet.dart';

part 'licences_sheet_state.dart';

class LicencesSheetCubit extends Cubit<LicencesSheetState> {
  LicencesSheetCubit() : super(LicencesSheetState.initial());

  // #############################
  // Initialization
  // #############################

  /// Initialize state data.
  Future<void> initialize() async {
    try {
      // * Necessary to avoid UI delay.
      await Future.delayed(const Duration(milliseconds: AppDurations.avoidUIdelay));

      // Emit loading state.
      if (state.status != LicencesSheetStatus.pageIsLoading) {
        // Only emit state if cubit is open.
        if (isClosed) return;

        // Update state.
        emit(state.copyWith(
          failure: Failure.initial(),
          status: LicencesSheetStatus.pageIsLoading,
        ));
      }

      // * Get all licences.
      final List<LicenseEntry> listOfLicences = await LicenseRegistry.licenses.toList();

      // * Init helper list.
      Licences licences = Licences.initial();

      for (final LicenseEntry licenseEntry in listOfLicences) {
        // * Get packages of this licence.
        final List<String> licensePackages = licenseEntry.packages.toList();

        for (final String packageName in licensePackages) {
          // * Check if this package already exists.
          final LicenceItem? item = licences.getPackageByName(packageName: packageName);

          // * Package was found.
          if (item != null) {
            // * Add license.
            licences = licences.addLicenceToPackage(
              id: item.id,
              licenseEntry: licenseEntry,
            );

            continue;
          }

          // * Create Licence Item.
          final LicenceItem licenceItem = LicenceItem.initial().copyWith(
            packageName: packageName,
            licences: [licenseEntry],
          );

          // * A new package name was found.
          licences = licences.add(licenceItem: licenceItem);
        }
      }

      // Sort the licences alphabetically.
      licences = licences.sortAtoZ;

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        licences: licences,
        status: LicencesSheetStatus.waiting,
      ));
    } on Failure catch (failure) {
      // Output debug message.
      debugPrint('LicencesSheetCubit --> initialize() --> failure: ${failure.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: failure,
        status: LicencesSheetStatus.pageHasError,
      ));
    } catch (exception) {
      // Output debug message.
      debugPrint('LicencesSheetCubit --> initialize() --> exception: ${exception.toString()}');

      // Only emit state if cubit is open.
      if (isClosed) return;

      // Update state.
      emit(state.copyWith(
        pageFailure: Failure.genericError(),
        status: LicencesSheetStatus.pageHasError,
      ));
    }
  }

  // #############################
  // State
  // #############################

  /// This method gets invoked if user wants to dismiss failure message.
  void dismissFailure() {
    // Only emit new state if cubit is still active.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: LicencesSheetStatus.waiting,
    ));
  }

  /// This method can be used to close this sheet.
  Future<void> closeSheet() async {
    // Do nothing if state is already set to close.
    if (state.status == LicencesSheetStatus.close) return;

    // Only emit new state if cubit is still open.
    if (isClosed) return;

    emit(state.copyWith(
      failure: Failure.initial(),
      status: LicencesSheetStatus.close,
    ));
  }

  /// This method can be used to show licences of package.
  void showLicences({required BuildContext context, required LicenceItem licenceItem}) {
    // * Show LicencesSheet.
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => DisplayLicencesSheet(
        licenceItem: licenceItem,
      ),
    );
  }
}
