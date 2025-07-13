import 'package:flutter/material.dart';
import '../../app/themes/app_theme.dart';
import '../../core/models/company_user_model.dart';
import '../../core/models/user_model.dart';

class CompanyUserCard extends StatelessWidget {
  final CompanyUser user;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onResetPassword;
  final VoidCallback? onToggleStatus;
  final bool showActions;
  final bool canEdit;
  final bool canDelete;
  final bool canResetPassword;

  const CompanyUserCard({
    super.key,
    required this.user,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.onResetPassword,
    this.onToggleStatus,
    this.showActions = true,
    this.canEdit = true,
    this.canDelete = true,
    this.canResetPassword = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _getRoleColor(user.role),
            child: Text(
              user.initials,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            user.name,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.email),
              const SizedBox(height: 4),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getRoleColor(user.role).withAlpha(26),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      user.role.displayName,
                      style: TextStyle(
                        fontSize: 12,
                        color: _getRoleColor(user.role),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getStatusColor(user.isActive).withAlpha(26),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      user.statusDisplayName,
                      style: TextStyle(
                        fontSize: 12,
                        color: _getStatusColor(user.isActive),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              if (user.phone != null) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      size: 14,
                      color: AppTheme.neutralGray,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      user.phone!,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.neutralGray,
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 14,
                    color: AppTheme.neutralGray,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Criado em ${_formatDate(user.createdAt)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.neutralGray,
                    ),
                  ),
                  if (user.lastLogin != null) ...[
                    const SizedBox(width: 16),
                    Icon(
                      Icons.login,
                      size: 14,
                      color: AppTheme.neutralGray,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Último acesso: ${_formatDate(user.lastLogin!)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.neutralGray,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          trailing: showActions ? _buildActionsMenu(context) : null,
          isThreeLine: true,
        ),
      ),
    );
  }

  Widget _buildActionsMenu(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        switch (value) {
          case 'edit':
            onEdit?.call();
            break;
          case 'reset_password':
            onResetPassword?.call();
            break;
          case 'toggle_status':
            onToggleStatus?.call();
            break;
          case 'delete':
            onDelete?.call();
            break;
        }
      },
      itemBuilder: (context) => [
        if (canEdit)
          const PopupMenuItem(
            value: 'edit',
            child: ListTile(
              leading: Icon(Icons.edit),
              title: Text('Editar'),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        if (canResetPassword)
          const PopupMenuItem(
            value: 'reset_password',
            child: ListTile(
              leading: Icon(Icons.lock_reset),
              title: Text('Redefinir Senha'),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        PopupMenuItem(
          value: 'toggle_status',
          child: ListTile(
            leading: Icon(user.isActive ? Icons.block : Icons.check_circle),
            title: Text(user.isActive ? 'Desativar' : 'Ativar'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        if (canDelete && user.canBeDeleted)
          PopupMenuItem(
            value: 'delete',
            child: ListTile(
              leading: Icon(Icons.delete, color: AppTheme.errorColor),
              title: Text('Excluir', style: TextStyle(color: AppTheme.errorColor)),
              contentPadding: EdgeInsets.zero,
            ),
          ),
      ],
    );
  }

  Color _getRoleColor(UserRole role) {
    return role.when(
      admin: () => AppTheme.errorColor,
      viewer: () => AppTheme.neutralGray,
      companyAdmin: () => AppTheme.primaryColor,
      companyManager: () => Colors.blue,
      companyEmployee: () => Colors.green,
      // Legacy support
      owner: () => AppTheme.primaryColor,
      manager: () => Colors.blue,
      employee: () => Colors.green,
    );
  }

  Color _getStatusColor(bool isActive) {
    return isActive ? AppTheme.successColor : AppTheme.neutralGray;
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}