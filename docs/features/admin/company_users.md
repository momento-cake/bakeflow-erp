# Company Users

This feature will be used to do overall company users management. Those users will have access
to bakeflow with context specific to the company they belong to, they must never hace access to
overall erp management features nor other companies features.

## Permissions

The users must have specific roles that will prevent certain actions from within the company
features.

- Admin da Empresa: Responsible to manage overall company features and has full access to
everything around the company it is the manager for.
- Gerente: Has overall access to features of the company but MUST NOT have access to managing users
or overall company configurations.
- Funcionário: Has limited access to features, mostly view permissions and some permissions for
day to day managing features such as making inventory, taking orders, managing clients and so on.

## Business Rules

- Companies of type individual entrepreneurs and MEI can't have multiple users, only one Admin de
Empresa is allowed, so the tab must be hidden for those types of companies.
- Only Admin da Empresa can manage company users (CRUD).
- ERP admin has unlimited access to all company features including users management.

### List

- The company users list must have 2 preset filters Ativo and Inativo to list the users, Ativo must
be the selected by default for the first load.

Known bug:

- The list isn't properly fetching from firestore with the error:
TypeError: Instance of `Timestamp`: type `Timestamp` is not a subtype of type `String`

### Add

- After adding an user it should pop the add user screen back to the users list selected tab.

## Files

Related Files

- company_user_details_screen.dart
- create_company_user_screen.dart
- company_details_screen.dart

Example Files

- admin_users_screen.dart
- create_user_screen.dart

## Review Notes

### Review Notes 1 - 12/07/25 12:48

- You've removed the users tab visibillity if the current user is an overall ERP user admin, user admins
must have complete permissions to do anything on the company level, only users authenticated within
a company that is a solo entrepreneur or MEI can't have access to the users tab within the company.
Keep the feature visible as this feature for company users will be available on the dashboard level
and not inside company details screen.
