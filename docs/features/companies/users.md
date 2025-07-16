# Company Users Feature

This feature is responsible to handle user management on the company level. Company users must have ERP access according to their role set at creation time.
Company users can only be created by ERP admins and also company admins.
It must be possible to list user for the company, delete an user, add an user or update an user.

## Entry Point

This feature must be accessible from the @dashboard_screen.dart, it should only be visible by ERP admins or company admins if the company is of type a regular business, single person companies doesn't need multi access.
If the authenticated user has permission then show the option on the dashboard if not then hide it.

## Examples

UI/UX wise this feature must be exact the same as @admin_users_screen.dart flow from listing to creating a new user on @create_user_screen.dart

## Note

- All files referenced with @ must be injected into this prompt on the first step, prior to actually making anything
- In the same way, once an user is created the creation screen must pop and the list screen reload its content.

## Tasks

- Implement feature access logic on the dashboard screen.
- Implement new list screen decoupled from the @company_details_screen.dart
- Review @create_company_details_screen.dart and create a new one with better name if needed.
- Remove tabs from @company_details_screen.dart, this screen should only have the company info and because users is on its own screen now so tabs are no longer needed.
- Review all user creation logic so that is retained
- Review file nomenclature and folder patterns aiming for long term support and maintainabillity

## Guidelines

- Review all the changes and make sure every request made was properly completed and post on the summary this review.
- IMPORTANT: Review the request and confirm with the USER if the proposed plan based on it meets the criteria, ONLY continue with the work after confirmation from me!!
