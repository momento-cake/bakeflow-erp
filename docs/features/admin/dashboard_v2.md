# Dashboard V2

Break all admin related features from the @dashboard_screen.dart into a separate @admin_dashboard_screen.dart.

The admin dashboard will have some admin specific information while the regular dashboard will be
scoped to company features.

## Features

### Admin Dashboard

- Usuarios (overall ERP users CRUD)
- Empresas (overall ERP companies CRUD)

### Company Dashboard

- Vendas (WIP)
- Clientes (WIP)
- Usuários (Only visible by Admin de empresa and Gerente de empresa for companies of type regular business entity)
- Produtos (WIP)
- Settings (Company details and settings page, also Only visible by Admin de empresa and Gerente de empresa for companies of type regular business entity)

## Notes

- On login, depending if the authenticated user is an company member it must be taken directly into the company dashboard and if it is an erp user it must be taken to the admin dashboard
- On the admin companies list when a list is selected, instead of opening the company details it should open the company dashboard where the authenticated user has the same level of permissions as the company admin.

## Tasks

- Break down the 2 dashboards
- Adjust routing and base routing post login and on load if user is already authenticated
- Adjust routing when erp users click on the admin companies list to open the company dashboard instead of company details
- Implement proper feature access based on the documented above
- IMPORTANT: The design principles and system must be the same for both dashboards, only the feature cards will be available depending on the authenticated user permission role level for the ERP and also for the company user.
