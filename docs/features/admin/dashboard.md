## Goal

When an User admin logs in he should be redirected into a admin dashboard configuration where he will
have access to admin features such as creating companies and adding new users to it.

## Notes

- Follow Firebase Authentication best practices for when an user is created by an admin user.
Does the user receives an account creation or login link? Does the admin sets an temporary password
that the user needs to update on the first login?

## Guinediles

- Make sure to review all base guidelines prior to pushing changes

-------------------------------------------------------------------------------

07/09/25 - 13:15

## Review Notes 1

The UI is a bit odd, it will not scale if we add more features in the future.

- Convert the current features to a Square grid (each item with same width and height) where each item
 is a feature, you can even use only one dashboard screen combined for admins and non admin users
 but the features are visible or not based on the user's role.
- The header is super simple, doesn't even have the information about the current user nor about
the platform such as name, review it making it look more professional taking in condiretaion market
best practices.

### Notes

- Review best practices for dashboard UIs so we follow those standards that are
user validated already and doesn't look super simple with basic material designs

-------------------------------------------------------------------------------

07/09/25 - 13:26

## Review Notes 2

The UI is looking much better, now do the following:

1. Adjust roadmap documentation with the new features you added on this last interaction
such as search, logout, change profile, notifications, quick summary
2. There is exception being thrown on the first load with the following stack
Assertion failed:
js_primitives.dart:28 file:///Users/gabrielaraujo/.pub-cache/hosted/pub.dev/go_router-14.8.1/lib/src/parser.dart:110:18
js_primitives.dart:28 !matchList.last.route.redirectOnly
js_primitives.dart:28 "A redirect-only route must redirect to location different from itself.\n The offending route:
js_primitives.dart:28 GoRoute#cb070(name: null, path: \"/\", Redirect Only)"
js_primitives.dart:28
js_primitives.dart:28 The relevant error-causing widget was:
js_primitives.dart:28   MaterialApp
js_primitives.dart:28   MaterialApp:file:///Users/gabrielaraujo/projects/momentocake/ai/mc-erp/bakeflow-erp/lib/main.dart:33:24
3. The features cards are look super big on the web, review its dimensioning so that is follows
good practices for larger and smaller window dimensions. Right now it is looking unecessarily big
while the summary cards are looking sharp.

### Notes

- Always leverage responsive layouts with variations if needed to look good on mobile and also web

-------------------------------------------------------------------------------

07/09/25 - 15:26

## Review Notes 3

1. The bottom text on each feature card is overflowing on mobile, remove it for mobile only and make
the main text adjustable.
2. Remove the search textfield from the view and also from the backlog, it is not needed.
3. Remove the greeting message and sub message and those are not needed
4. Summary horizontal scroll is respecting the side safe area when it should ignore it and the content
to be visible until both left and right edges instead of on the safe area padding

-------------------------------------------------------------------------------

11/09/25 - 15:48

## Review Notes 4

1. On non mobile screens the title from the feature card is cropping on the height as you can see on
 the attached image. The same doesn't happen on mobile.
