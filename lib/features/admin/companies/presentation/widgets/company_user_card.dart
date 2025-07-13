import 'package:flutter/material.dart';

import '../../../../../app/themes/app_theme.dart';
import '../../../../../core/models/company_user_model.dart';
import '../../../../../core/models/user_model.dart';

class CompanyUserCard extends StatelessWidget {
  final CompanyUser user;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const CompanyUserCard({
    super.key,
    required this.user,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 24,
                backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.1),
                child: Text(
                  _getInitials(user.name),
                  style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              
              const SizedBox(width: 16),
              
              // User Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user.email,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.neutralGray,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        // Role Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getRoleColor(user.role).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: _getRoleColor(user.role).withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            user.role.displayName,
                            style: TextStyle(
                              color: _getRoleColor(user.role),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        
                        const SizedBox(width: 12),
                        
                        // Status Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: user.isActive 
                                ? AppTheme.successColor.withValues(alpha: 0.1)
                                : AppTheme.neutralGray.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: user.isActive 
                                  ? AppTheme.successColor.withValues(alpha: 0.3)
                                  : AppTheme.neutralGray.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            user.isActive ? 'Ativo' : 'Inativo',
                            style: TextStyle(
                              color: user.isActive 
                                  ? AppTheme.successColor
                                  : AppTheme.neutralGray,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Actions
              Column(
                children: [
                  // Last Login (if available)
                  if (user.lastLogin != null) ...[
                    Text(
                      'Último acesso',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.neutralGray,
                      ),
                    ),
                    Text(
                      _formatLastLogin(user.lastLogin!),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.neutralGray,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  
                  // Action Buttons
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // View/Edit Button
                      IconButton(
                        onPressed: onTap,
                        icon: const Icon(Icons.visibility),
                        tooltip: 'Ver detalhes',
                        color: AppTheme.primaryColor,
                      ),
                      
                      // Delete Button (if allowed)
                      if (onDelete != null) ...[
                        IconButton(
                          onPressed: onDelete,
                          icon: const Icon(Icons.delete_outline),
                          tooltip: 'Excluir usuário',
                          color: AppTheme.errorColor,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    } else if (parts.isNotEmpty) {
      return parts.first.substring(0, 1).toUpperCase();
    }
    return '?';
  }

  Color _getRoleColor(UserRole role) {
    switch (role) {
      case UserRole.companyAdmin:
        return AppTheme.errorColor;
      case UserRole.companyManager:
        return AppTheme.warningColor;
      case UserRole.companyEmployee:
        return AppTheme.primaryColor;
      default:
        return AppTheme.neutralGray;
    }
  }

  String _formatLastLogin(DateTime lastLogin) {
    final now = DateTime.now();
    final difference = now.difference(lastLogin);

    if (difference.inDays > 0) {
      return '${difference.inDays}d atrás';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h atrás';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m atrás';
    } else {
      return 'Agora';
    }
  }
}