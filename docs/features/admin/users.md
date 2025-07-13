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

--------------------------------------------------------------------------------

07/09/25 - 21:14

## Review Notes 9

When adding users:

1. When the user hits enter on the keyboard it should trigger the button press to create user
2. Once user is created it must add to firestore and the screen should pop, taking the user back to
the users list screen where it will reload the user list to potentially show the newly added user
on the list.
3. When user is created by admin the authenticated user should not reload the whole app showhing
a different home, this should not happen.
4. A success message popup should appear if the new user was sucessfully saved
5. When a new user is added with the temporary password we should enforce password change on the fist
login

Important:

- Keep guidelines from CLAUDE.md and linked docs in memory to improve results

--------------------------------------------------------------------------------

10/09/25 - 10:06

## Review Notes 10

When adding users:

1. When admins create accounts it can only have 2 roles, admin or viewer. The reason why is
because when admin create accounts it is for overall system management, those other existing roles
will be usefull once company admins manage their users who will have access only to company related
features.
2. When trying to add a user it is only being added to firebase auth and not to firestore also

Important:

- Keep guidelines from CLAUDE.md and linked docs in memory to improve results

--------------------------------------------------------------------------------

10/09/25 - 10:07

## Review Notes 11

When adding users:

1. When a new user is created the session is being resetted to the newly created user. The expected
result after creating a new user is to pop out of the user creation screen and reload the users list.
The current user session must be kept, the user is only creating new users and it should not replace
the current session! This is probably happening by some flows from the firebase auth user creation
methods

Important:

- Keep guidelines from CLAUDE.md and linked docs in memory to improve results

--------------------------------------------------------------------------------

10/09/25 - 10:24

## Review Notes 12

When adding users:

1. The icon on the Create User button is hidden because it has the same color as the button bg
2. There in an exception when trying to save on firestore
Erro ao criar usuário: Exception: Erro inesperado ao criar usuário: [cloud_firestore/invalid-argument] Function setDoc() called with invalid data. Unsupported field value: a custom $36ViewerImpl object (found in field role in document users/kzSHaapAxyZvFNTqOL8AamHp08L2)

Important:

- Keep guidelines from CLAUDE.md and linked docs in memory to improve results

--------------------------------------------------------------------------------

10/09/25 - 10:24

## Review Notes 13

When adding users:

1. When user is succesfully added no confirmation popup appears nor the user creation screen is popped

Important:

- Keep guidelines from CLAUDE.md and linked docs in memory to improve results

--------------------------------------------------------------------------------

10/09/25 - 10:44

## Review Notes 14

When adding users:

1. The confirmation popup is super uggly and doesn't follow the current app design patterns nor
components. Fix it to follow the same design structure especially the background colors.
2. The popup should auto close after 5 seconds and add user screen should be popped

Important:

- Keep guidelines from CLAUDE.md and linked docs in memory to improve results

--------------------------------------------------------------------------------

10/09/25 - 11:05

## Review Notes 15

When adding users:

1. The confirmation popup is using colors that aren't from the project color patterns, review and
replace.
2. When the popup auto closes it isn't also closing the add user screen, the auto close should behave
the same as when manually closing it.

Important:

- Keep guidelines from CLAUDE.md and linked docs in memory to improve results

--------------------------------------------------------------------------------

10/09/25 - 11:11

## Review Notes 16

When adding users:

1. Use project colors for the confirmation popup progress bar and success icon.
2. Use a background color that maker the information section within the success popup text more
visible, right now because of the yellowy background color it is hard ro read

Important:

- Keep guidelines from CLAUDE.md and linked docs in memory to improve results

--------------------------------------------------------------------------------

11/07/25 - 15:R

## Review Notes 17

Implement user deletion on the @admin_users_screen.dart, this action must delete
 from firebase auth and also from firestore, there is no need to soft delete users.
 When handling the firebase_auth you might need to create a new firebase app and once
 it is deleted from the firebase auth you can close the firebase app and perform the
 firestore action on the main one. This is done similarly on createUser from @admin_user_service.dart

--------------------------------------------------------------------------------

11/07/25 - 16:52

## Review Notes 18

When trying to delete an user the error for permission on firestore is being thrown
 you must review the security sules and push changes. You can also remove the disable
 option from the menu as it will not be used.

--------------------------------------------------------------------------------

11/07/25 - 18:28

## Review Notes 19

When trying to delete an user the error the loading indicator for the list spins indefinetely
 and also when I reload the page and opens the list again the deleted user is still there. The user
 wasn't deleted from firestore nor firebase auth.

--------------------------------------------------------------------------------

11/07/25 - 18:53

## Review Notes 20

You aren't properly trying to delete an user from firebase auth, the authenticated user does have
 proper permissions. In order to delete from firebase auth you can use the same approach as for
 creation where a new firebase instance is spawned and then the deletion happens there. The logs
 aren't appearing on the web browser debug console.

--------------------------------------------------------------------------------

11/07/25 - 19:01

## Review Notes 21

Since it isn't possible to delete an account on firebase auth let's proceed with the soft deletion
 instead of deleting from firestore we soft delete there and also disable on firebase auth. Note
 that you will need to change the @admin_users_screen.dart to show a disabled status and filter.
 Also you must prevent login if the account is disabled.

--------------------------------------------------------------------------------

11/07/25 - 19:11

## Review Notes 22

The message just appeared when trying to disable an user, review all firestore security rules.
AdminUserService: Firebase error during disabling: permission-denied - Missing or insufficient permissions

As we can't even disable other users from within the flutter sdk only do the soft delete on the firestore
layer. Yous must make sure no user can login if it was soft deleted.

 --------------------------------------------------------------------------------

11/07/25 - 19:22

## Review Notes 23 (cleared)

You are working on fixing some bugs for the users list feature. The bugs are:

- When trying to delete an user an missing firestore permission error is being thrown. This is
most probably happening due to invalid security rules that you need to review and fix using
the firebase cli.

Files you are working with:

- @firestore.rules
- @admin_users_screen.dart
- @admin_user_service.dart
- potentially other files related to those linked 

--------------------------------------------------------------------------------

11/07/25 - 19:36

## Review Notes 24

You are working on fixing some bugs for the users list feature. The bugs are:

- After deleting an user the loading state spins indefinetely.
- After reloading the page after having deleted one user the user is still displaying as active
but if you try to disable again an error message will popup telling the user has been deleted already