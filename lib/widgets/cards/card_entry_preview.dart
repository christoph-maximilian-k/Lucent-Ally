import 'package:flutter/material.dart';

// Config.
import '/config/app_icons.dart';

// User.
import '/main.dart';

// Models.
import '/data/models/failure.dart';
import '/data/models/model_entries/model_entry.dart';
import '/data/models/entries/entry.dart';
import '/data/models/cloud_user/cloud_user.dart';
import '/data/models/users/user.dart';

// Widgets.
import '/widgets/customs/custom_loading_spinner.dart';

class CardEntryPreview extends StatefulWidget {
  // Indications.
  final bool isShared;

  // Data.
  final ModelEntry? modelEntry;

  final Entry entry;

  /// This is for example null in main screen.
  final String? rootGrouOwner;

  // Card.
  final Function(Entry, ModelEntry) onEntrySelected;

  // Get user future.
  final Function()? getCloudUserFuture;
  final Function(CloudUser?, User)? onPressedUser;

  // First Trailing Icon Button.
  final IconData? firstTrailingIcon;
  final Color? firstTrailingIconColor;
  final String? firstTrailingIconTooltip;
  final Function(Entry, ModelEntry)? onFirstTrailingPressed;

  // Second Trailing Icon Button.
  final IconData? secondTrailingIcon;
  final String? secondTrailingIconTooltip;
  final Function(Entry, ModelEntry)? onSecondTrailingPressed;

  const CardEntryPreview({
    super.key,
    // Indications.
    required this.isShared,
    // Data.
    required this.modelEntry,
    required this.entry,
    this.rootGrouOwner,
    // Card.
    required this.onEntrySelected,
    // Get user future.
    this.getCloudUserFuture,
    this.onPressedUser,
    // First Trailing Icon Button.
    this.firstTrailingIcon,
    this.firstTrailingIconColor,
    this.firstTrailingIconTooltip,
    this.onFirstTrailingPressed,
    // Second Trailing Icon Button.
    this.secondTrailingIcon,
    this.secondTrailingIconTooltip,
    this.onSecondTrailingPressed,
  });

  @override
  State<CardEntryPreview> createState() => _CardEntryPreviewState();
}

class _CardEntryPreviewState extends State<CardEntryPreview> {
  Future<CloudUser?>? _cloudUserFuture;

  /// This function can be used to retrigger getting user.
  void _retriggerGetUser() {
    // Update the future and trigger a rebuild.
    setState(() {
      _cloudUserFuture = widget.getCloudUserFuture!();
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.getCloudUserFuture != null) _cloudUserFuture = widget.getCloudUserFuture!();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Builder(
        builder: (context) {
          // Display error.
          if (widget.modelEntry == null) {
            return SizedBox(
              height: 59.0,
              child: Center(
                child: Text(
                  Failure.entryModelNotFound().message,
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          // Convenience data.
          final String subtitle = widget.modelEntry!.getSubtitle(entry: widget.entry);
          final String thirdline = widget.modelEntry!.getThirdline(entry: widget.entry);

          return Column(
            children: [
              if (widget.isShared)
                FutureBuilder<CloudUser?>(
                  future: _cloudUserFuture,
                  builder: (context, snapshot) {
                    // Always return default values.
                    return SizedBox(
                      height: 35.0,
                      child: Builder(
                        builder: (context) {
                          // Show loading indication.
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CustomLoadingSpinner();
                          }

                          // Convenience variables.
                          final CloudUser? cloudUser = snapshot.data;

                          // Show failure.
                          final bool failure = cloudUser == null || cloudUser.userId.isEmpty;

                          return InkWell(
                            onTap: failure
                                ? () => _retriggerGetUser()
                                : widget.onPressedUser == null
                                    ? null
                                    : () => widget.onPressedUser!(cloudUser, user),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(12.0),
                              topLeft: Radius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Builder(
                                builder: (context) {
                                  // * Show try again.
                                  if (failure) {
                                    return Row(
                                      children: [
                                        const Icon(
                                          AppIcons.user,
                                        ),
                                        const SizedBox(width: 10.0),
                                        Text('⋅', style: Theme.of(context).textTheme.labelSmall),
                                        const Spacer(),
                                        const Icon(
                                          AppIcons.refresh,
                                        ),
                                        const Spacer(),
                                      ],
                                    );
                                  }

                                  // Access is self.
                                  final bool isSelf = cloudUser.userId == user.userId;
                                  final bool isRootGroupOwner = widget.rootGrouOwner == cloudUser.userId;

                                  return Row(
                                    children: [
                                      Icon(
                                        AppIcons.user,
                                        color: isSelf ? Colors.green[600] : null,
                                      ),
                                      const SizedBox(width: 10.0),
                                      if (isRootGroupOwner)
                                        Padding(
                                          padding: const EdgeInsets.only(right: 10.0),
                                          child: Icon(
                                            AppIcons.rootGroupOwner,
                                            size: 14.0,
                                          ),
                                        ),
                                      Text('⋅', style: Theme.of(context).textTheme.labelSmall),
                                      const SizedBox(width: 10.0),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5.0, right: 30.0),
                                        child: Text(
                                          cloudUser.username,
                                          style: Theme.of(context).textTheme.labelSmall,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ListTile(
                dense: true,
                shape: widget.getCloudUserFuture != null
                    ? RoundedRectangleBorder(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(0.0), // In shared mode get rid of rounded corners.
                          topRight: Radius.circular(0.0), // In shared mode get rid of rounded corners.
                          bottomLeft: Radius.circular(12.0), // * Keep on the bottom.
                          bottomRight: Radius.circular(12.0), // * Keep on the bottom.
                        ),
                      )
                    : null,
                onTap: () => widget.onEntrySelected(widget.entry, widget.modelEntry!),
                title: Text(
                  widget.entry.entryName,
                  style: Theme.of(context).textTheme.titleMedium, 
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // * First Trailing Icon Button.
                    if (widget.firstTrailingIcon != null)
                      IconButton(
                        iconSize: Theme.of(context).primaryIconTheme.size,
                        icon: Icon(
                          widget.firstTrailingIcon,
                          color: widget.firstTrailingIconColor,
                        ),
                        tooltip: widget.firstTrailingIconTooltip,
                        onPressed: widget.onFirstTrailingPressed == null ? () {} : () => widget.onFirstTrailingPressed!(widget.entry, widget.modelEntry!),
                      ),
                    // * Second Trailing Icon Button.
                    if (widget.secondTrailingIcon != null)
                      IconButton(
                        iconSize: Theme.of(context).primaryIconTheme.size,
                        icon: Icon(
                          widget.secondTrailingIcon,
                          color: Theme.of(context).primaryIconTheme.color,
                        ),
                        tooltip: widget.secondTrailingIconTooltip,
                        onPressed: widget.onSecondTrailingPressed == null ? () {} : () => widget.onSecondTrailingPressed!(widget.entry, widget.modelEntry!),
                      ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.displaySmall,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 5),
                    if (thirdline.isNotEmpty)
                      Text(
                        thirdline,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.displaySmall,
                        textAlign: TextAlign.left,
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
