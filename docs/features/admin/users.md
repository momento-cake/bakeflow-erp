## Goal

Admin users must be able to handle the platform users with:

0. Can list all users with a differentiation icon for admin users and with the company name for regular users.
1. Can add, edit and delete other admin users
2. Master admin users can't be deleted by other admin users (this might require a minor change on the setup flow and a new attribute might need to be added the the root user already stored on dynamodb, let me know so I can do that)
3. Can add, edit or delete regular users

## Notes

- Follow same market proof design principles like the ones you used for the dashboard reworks on the UI.
- This list users feature will probable be reused on other places such as company specific users listing and cruding by company managers but some CRUD features must be admin only like managing other admins
- Review firestore security rules so that admin users can work on the users collections

## Guinediles

- IMPORTANT! Review all base guidelines prior to pushing changes
- Adjust roadmap with the features that needs to be worked on

--------------------------------------------------------------------------------

09/07/2025 - 14:12

## Review Notes 1

The app is now broken with the following being printed on the console
lib/features/admin/views/admin_dashboard_screen.dart:21:8: Error: Type 'Business' not found.
  List<Business> _businesses = [];
       ^^^^^^^^
lib/features/admin/views/admin_dashboard_screen.dart:328:29: Error: Type 'Business' not found.
  void_showBusinessDetails(Business business) {
                            ^^^^^^^^
lib/features/admin/views/admin_dashboard_screen.dart:21:8: Error: 'Business' isn't a type.
  List<Business> _businesses = [];
       ^^^^^^^^
lib/features/admin/views/admin_dashboard_screen.dart:40:37: Error: The getter 'adminUserServiceProvider' isn't defined for the class '_AdminDashboardScreenState'.

- '_AdminDashboardScreenState' is from 'package:bakeflow_erp/features/admin/views/admin_dashboard_screen.dart' ('lib/features/admin/views/admin_dashboard_screen.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'adminUserServiceProvider'.
      final adminService = ref.read(adminUserServiceProvider);
                                    ^^^^^^^^^^^^^^^^^^^^^^^^
lib/features/admin/views/admin_dashboard_screen.dart:295:35: Error: The getter 'adminUserServiceProvider' isn't defined for the class '_AdminDashboardScreenState'.
- '_AdminDashboardScreenState' is from 'package:bakeflow_erp/features/admin/views/admin_dashboard_screen.dart' ('lib/features/admin/views/admin_dashboard_screen.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'adminUserServiceProvider'.
    final adminService = ref.read(adminUserServiceProvider);
                                  ^^^^^^^^^^^^^^^^^^^^^^^^
lib/features/admin/views/admin_dashboard_screen.dart:328:29: Error: 'Business' isn't a type.
  void_showBusinessDetails(Business business) {
                            ^^^^^^^^
lib/features/admin/views/admin_dashboard_screen.dart:431:32: Error: The getter 'adminUserServiceProvider' isn't defined for the class '_AdminDashboardScreenState'.
- '_AdminDashboardScreenState' is from 'package:bakeflow_erp/features/admin/views/admin_dashboard_screen.dart' ('lib/features/admin/views/admin_dashboard_screen.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'adminUserServiceProvider'.
                await ref.read(adminUserServiceProvider).updateUserRole(user.uid, selectedRole);
                               ^^^^^^^^^^^^^^^^^^^^^^^^
lib/features/admin/views/admin_dashboard_screen.dart:491:37: Error: The getter 'adminUserServiceProvider' isn't defined for the class '_CreateUserDialogState'.
- '_CreateUserDialogState' is from 'package:bakeflow_erp/features/admin/views/admin_dashboard_screen.dart' ('lib/features/admin/views/admin_dashboard_screen.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'adminUserServiceProvider'.
      final adminService = ref.read(adminUserServiceProvider);
                                    ^^^^^^^^^^^^^^^^^^^^^^^^
lib/features/admin/views/admin_dashboard_screen.dart:519:37: Error: The getter 'adminUserServiceProvider' isn't defined for the class '_CreateUserDialogState'.
- '_CreateUserDialogState' is from 'package:bakeflow_erp/features/admin/views/admin_dashboard_screen.dart' ('lib/features/admin/views/admin_dashboard_screen.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'adminUserServiceProvider'.
      final adminService = ref.read(adminUserServiceProvider);
                                    ^^^^^^^^^^^^^^^^^^^^^^^^
lib/features/admin/views/admin_dashboard_screen.dart:592:34: Error: 'Business' isn't a type.
              FutureBuilder<List<Business>>(
                                 ^^^^^^^^
lib/features/admin/views/admin_dashboard_screen.dart:593:34: Error: The getter 'adminUserServiceProvider' isn't defined for the class '_CreateUserDialogState'.
- '_CreateUserDialogState' is from 'package:bakeflow_erp/features/admin/views/admin_dashboard_screen.dart' ('lib/features/admin/views/admin_dashboard_screen.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'adminUserServiceProvider'.
                future: ref.read(adminUserServiceProvider).getAllBusinesses(),
                                 ^^^^^^^^^^^^^^^^^^^^^^^^
lib/features/admin/views/admin_dashboard_screen.dart:613:24: Error: The argument type 'List<DropdownMenuItem<Object>>' can't be assigned to the parameter type 'List<DropdownMenuItem<String>>?'.
- 'List' is from 'dart:core'.
- 'DropdownMenuItem' is from 'package:flutter/src/material/dropdown.dart' ('../../../../../fvm/versions/stable/packages/flutter/lib/src/material/dropdown.dart').
- 'Object' is from 'dart:core'.
                    }).toList(),
                       ^
lib/features/admin/views/admin_dashboard_screen.dart:722:37: Error: The getter 'adminUserServiceProvider' isn't defined for the class '_CreateBusinessDialogState'.
- '_CreateBusinessDialogState' is from 'package:bakeflow_erp/features/admin/views/admin_dashboard_screen.dart' ('lib/features/admin/views/admin_dashboard_screen.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'adminUserServiceProvider'.
      final adminService = ref.read(adminUserServiceProvider);
                                    ^^^^^^^^^^^^^^^^^^^^^^^^
lib/features/admin/views/admin_dashboard_screen.dart:755:37: Error: The getter 'adminUserServiceProvider' isn't defined for the class '_CreateBusinessDialogState'.
- '_CreateBusinessDialogState' is from 'package:bakeflow_erp/features/admin/views/admin_dashboard_screen.dart' ('lib/features/admin/views/admin_dashboard_screen.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'adminUserServiceProvider'.
      final adminService = ref.read(adminUserServiceProvider);
                                    ^^^^^^^^^^^^^^^^^^^^^^^^
lib/features/admin/views/admin_dashboard_screen.dart:861:36: Error: The getter 'adminUserServiceProvider' isn't defined for the class '_CreateBusinessDialogState'.
- '_CreateBusinessDialogState' is from 'package:bakeflow_erp/features/admin/views/admin_dashboard_screen.dart' ('lib/features/admin/views/admin_dashboard_screen.dart').
Try correcting the name to the name of an existing getter, or defining a getter or field named 'adminUserServiceProvider'.
                  future: ref.read(adminUserServiceProvider).getAllUsers(),

You must always make sure the app is properly running at the end of each request I make.

--------------------------------------------------------------------------------

07/09/25 - 14:40

## Review Notes 2

1. It looks like user metdatada already have the field metadata `isInitialAdmin`
field that can be leveraged instead of creating the new isMasterAdmin field, adjust
all the changes to use this field instead to reduce complexity.
2. The header for the list screen isn't following the dashboard pattern, create
a shared widget for the header the lives across all screens. For mobile this header should only be
present on the dashboard and it must be responsive as well.
3. Single icon buttons aren't super user friendly, try to leverage explicit + Add User text

Important:

- All layouts should follow the same patterns and design system and be responsive in between mobile
and web with conditional variations when needed

--------------------------------------------------------------------------------

07/09/25 - 14:51

## Review Notes 3

1. The + Adicionar usuário button "+" icon is invisible as it has the same bg color as the button
2. The new user form is looking ugly and barely visible with the picked colors (especially the bg),
use standard form screens that are market validated already and keep the same design pattern as in
other screens.
3. The cancel button must be an X at the top, follow community defined patterns don't try to create
new ones.
4. Implement proper user search functionality
5. This list should be paginated as well so we don't load everything on the first load
6. The navigation bar is missing from the mobile, it should be visible on all screens but limited
to navigation related actions such as closing/navigating back while the web is more complete with
menu access, user information and so on (user info and other menu options should also be available
on mobile but only on the dashboard screen)

Important:

- All layouts should follow the same patterns and design system and be responsive in between mobile
and web with conditional variations when needed

--------------------------------------------------------------------------------

07/09/25 - 15:31

## Review Notes 4

1. The nav bar is showing the brand on the users screen but this should only be visible on the
dashboard.
2. The nav bar on the users screen on mobile is showing the title and message but only the title is
needed
3. The nav bar on mobile for non dashboard screens doesn't need to have the user info on the right
side
4. On the nav bar it should allow a set of icon buttons on mobile while the full text versions
should only be available on the web version
5. On the nav bar the back button isn't working as expected, it does nothing when tapped
6. On the users list the initial load isn't displaying all users, only when the filters are tapped
7. The list should be paginated with an option to pick 20, 50 or 100 users listing.
8. Filters should be horizontally placed and scrollable instead of wrapped
9. "Usuários Regulares" should be renamed to "Usuarios" only
10. Search should work by name or email

Important:

- All layouts should follow the same patterns and design system and be responsive in between mobile
and web with conditional variations when needed

--------------------------------------------------------------------------------

07/09/25 - 15:49

## Review Notes 5

1. The nav bar is showing the user menu on screens that aren't the dashboard, it should only
be visible on mobile at the dashboard while for web it should in fact always be visible
2. Add a throttle logic to the search so it isn't triggered on every character typed
3. On the add user screen it isn't following the default design pattern we use on the dashboard or
users scree, even the navbar isn't the default one. Always refer to the same design pattern as
on others screens on the project.
4. On the add user screen the back button / close button isn't working
5. Remove the create button on the top right corner on the nav bar
6. Remove the Novo Usuário heading as it isn't useful

Important:

- All layouts should follow the same patterns and design system and be responsive in between mobile
and web with conditional variations when needed

--------------------------------------------------------------------------------

07/09/25 - 16:01

## Review Notes 6

1. The navigation is broken, when the user is at the add user screen and press the back button
it is being navigated back to the dashboard while it should be navigated back to the users list.
2. The navigation animation is broken, it should follow the opposite direction for the navigate out
than the one used on the navigate in

Important:

- All layouts should follow the same patterns and desigRn system and be responsive in between mobile
and web with conditional variations when needed

--------------------------------------------------------------------------------

07/09/25 - 16:08

## Review Notes 7

1. The navigation animation in and out is broken. For example, when the transition into the screen is
slide up, the animation to navigate out must be slide down. If it is slide right for in, it should
be slide left for out and vice versa.

Important:

- Review best practices for navigation on go router and make sure that animation transitions are
- You don't need to remove the previous screen when navigating into a new one, keep the stack flow.
eg when opening the add user the users list shouldn't leave the screen stack

--------------------------------------------------------------------------------

07/09/25 - 18:50

## Review Notes 8

1. The navigation animation in and out is broken. For example, when the transition into the screen is
slide up, the animation to navigate out must be slide down. If it is slide right for in, it should
be slide left for out and vice versa.

Important:

- Review best practices for navigation on go router and make sure that animation transitions are
- You don't need to remove the previous screen when navigating into a new one, keep the stack flow.
eg when opening the add user the users list shouldn't leave the screen stack
