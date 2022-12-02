import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../pods/pods_flexfold.dart';
import '../../utils/app_images.dart';

// A demo user profile widget that we use as leading widget on the Flexfold
// menu and rail.
//
// This can also serve as an example on how to make a simple expandable panel
// using the implicit AnimatedCrossFade widget, a ListTile and ExpandIcon.
class LeadingUserProfile extends ConsumerStatefulWidget {
  const LeadingUserProfile({super.key});

  @override
  ConsumerState<LeadingUserProfile> createState() => _LeadingUserProfileState();
}

class _LeadingUserProfileState extends ConsumerState<LeadingUserProfile> {
  late bool isExpanded;
  @override
  void initState() {
    super.initState();
    isExpanded = false;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    const double padding = 5;
    final double width = ref.watch(railWidthPod);
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;

    // The closed ListTile user profile
    final Widget closedProfile = SafeArea(
        top: false,
        bottom: false,
        right: !isRTL,
        left: isRTL,
        child: ListTile(
            visualDensity: VisualDensity.compact,
            contentPadding: const EdgeInsets.symmetric(
                horizontal: padding, vertical: padding),
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            leading: CircleAvatar(
              backgroundColor: theme.colorScheme.primary,
              backgroundImage: const AssetImage(AppImages.profileImage),
              radius: width / 2 - padding,
            ),
            title: Text('Mike Rydstrom',
                style:
                    textTheme.subtitle1!.copyWith(fontWeight: FontWeight.w600)),
            subtitle: const Text('Company Inc'),
            trailing: ExpandIcon(
                isExpanded: isExpanded,
                padding: EdgeInsets.zero,
                onPressed: (_) {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                })));

    // An opened version of the user profile
    final Widget openProfile = Column(
      children: <Widget>[
        // Include the closed version above the opened content
        closedProfile,
        // Add some buttons for the opened state
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Spacer(),
              TextButton(
                  onPressed: () {},
                  // visualDensity: VisualDensity.comfortable,
                  // padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Column(children: <Widget>[
                    const Icon(Icons.person),
                    Text('Profile', style: textTheme.overline),
                  ])),
              const SizedBox(width: 10),
              TextButton(
                  onPressed: () {},
                  // visualDensity: VisualDensity.comfortable,
                  // padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Column(children: <Widget>[
                    const Icon(Icons.account_tree),
                    Text('Organization', style: textTheme.overline),
                  ])),
              const SizedBox(width: 8),
            ],
          ),
          // ),
        ),
      ],
    );
    return AnimatedCrossFade(
      firstChild: closedProfile,
      secondChild: openProfile,
      crossFadeState:
          isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: kThemeAnimationDuration,
    );
  }
}
