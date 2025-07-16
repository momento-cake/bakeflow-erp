import 'package:flutter/material.dart';

import '../../app/themes/app_theme.dart';
import '../../core/models/business_model.dart';

class CompanyCard extends StatelessWidget {
  final Business business;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool showActions;
  final bool canEdit;
  final bool canDelete;

  const CompanyCard({
    super.key,
    required this.business,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.showActions = true,
    this.canEdit = true,
    this.canDelete = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with company name and status
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          business.name,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        if (business.fantasyName != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            business.fantasyName!,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppTheme.neutralGray,
                                  fontStyle: FontStyle.italic,
                                ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  _buildStatusChip(),
                  if (showActions) ...[
                    const SizedBox(width: 8),
                    _buildActionsMenu(context),
                  ],
                ],
              ),

              const SizedBox(height: 12),

              // Company details
              _buildDetailRow(
                icon: Icons.business,
                label: business.type.displayName,
                color: _getTypeColor(business.type),
              ),

              if (business.cnpj != null) ...[
                const SizedBox(height: 8),
                _buildDetailRow(
                  icon: Icons.numbers,
                  label: 'CNPJ: ${business.cnpj}',
                ),
              ],

              const SizedBox(height: 8),
              _buildDetailRow(
                icon: Icons.location_on,
                label: '${business.city}, ${business.state}',
              ),

              const SizedBox(height: 8),
              _buildDetailRow(
                icon: Icons.phone,
                label: business.phone,
              ),

              if (business.email != null) ...[
                const SizedBox(height: 8),
                _buildDetailRow(
                  icon: Icons.email,
                  label: business.email!,
                ),
              ],

              const SizedBox(height: 12),

              // Footer with creation date
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 14,
                    color: AppTheme.neutralGray,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Criado em ${_formatDate(business.createdAt)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.neutralGray,
                        ),
                  ),
                  const Spacer(),
                  Text(
                    '${business.authorizedUsers.length} usuários',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.neutralGray,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getStatusColor(business.status).withAlpha(26),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        business.status.displayName,
        style: TextStyle(
          fontSize: 12,
          color: _getStatusColor(business.status),
          fontWeight: FontWeight.w600,
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
        if (canDelete)
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

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    Color? color,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: color ?? AppTheme.neutralGray,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: color ?? AppTheme.neutralGray,
            ),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(BusinessStatus status) {
    return status.when(
      active: () => AppTheme.successColor,
      inactive: () => AppTheme.neutralGray,
      suspended: () => AppTheme.errorColor,
    );
  }

  Color _getTypeColor(BusinessType type) {
    return type.when(
      formalCompany: () => AppTheme.primaryColor,
      soloEntrepreneur: () => AppTheme.accentColor,
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}
