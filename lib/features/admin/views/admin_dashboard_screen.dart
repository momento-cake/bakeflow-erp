import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/themes/app_theme.dart';
import '../../../core/models/user_model.dart';
import '../../../core/models/business_model.dart';
import '../services/admin_user_service.dart';
import '../../auth/services/auth_service.dart';

class AdminDashboardScreen extends ConsumerStatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  ConsumerState<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends ConsumerState<AdminDashboardScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<UserModel> _users = [];
  List<Business> _businesses = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final adminService = ref.read(adminUserServiceProvider);
      final users = await adminService.getAllUsers();
      final businesses = await adminService.getAllBusinesses();
      
      setState(() {
        _users = users;
        _businesses = businesses;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar dados: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider).value;
    
    // Check if user is admin
    final isAdmin = currentUser?.role.when(
      admin: () => true,
      owner: () => false,
      manager: () => false,
      employee: () => false,
      viewer: () => false,
    ) ?? false;
    
    if (!isAdmin) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Acesso Negado'),
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.block,
                size: 64,
                color: AppTheme.errorColor,
              ),
              SizedBox(height: 16),
              Text(
                'Você não tem permissão para acessar esta área',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel Administrativo'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authServiceProvider).signOut();
              if (mounted) {
                context.go('/login');
              }
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Usuários', icon: Icon(Icons.people)),
            Tab(text: 'Empresas', icon: Icon(Icons.business)),
            Tab(text: 'Criar', icon: Icon(Icons.add)),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildUsersTab(),
                _buildBusinessesTab(),
                _buildCreateTab(),
              ],
            ),
    );
  }

  Widget _buildUsersTab() {
    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: user.isActive ? AppTheme.successColor : AppTheme.errorColor,
                child: Text(
                  user.displayName?.substring(0, 1).toUpperCase() ?? 'U',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(user.displayName ?? 'Sem nome'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.email),
                  Text(
                    'Função: ${user.role.displayName}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  if (!user.isActive)
                    const Text(
                      'INATIVO',
                      style: TextStyle(
                        color: AppTheme.errorColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'reset_password',
                    child: Text('Redefinir Senha'),
                  ),
                  PopupMenuItem(
                    value: user.isActive ? 'deactivate' : 'activate',
                    child: Text(user.isActive ? 'Desativar' : 'Ativar'),
                  ),
                  const PopupMenuItem(
                    value: 'edit_role',
                    child: Text('Alterar Função'),
                  ),
                ],
                onSelected: (value) => _handleUserAction(user, value.toString()),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBusinessesTab() {
    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _businesses.length,
        itemBuilder: (context, index) {
          final business = _businesses[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: AppTheme.primaryColor,
                child: Icon(Icons.business, color: Colors.white),
              ),
              title: Text(business.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (business.email?.isNotEmpty == true)
                    Text(business.email!),
                  if (business.cnpj.isNotEmpty)
                    Text('CNPJ: ${business.cnpj}'),
                  Text(
                    'Usuários: ${business.authorizedUsers.length}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.info),
                onPressed: () => _showBusinessDetails(business),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCreateTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.person_add, color: AppTheme.primaryColor),
              title: const Text('Criar Usuário'),
              subtitle: const Text('Adicionar novo usuário ao sistema'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => _showCreateUserDialog(),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.business, color: AppTheme.primaryColor),
              title: const Text('Criar Empresa'),
              subtitle: const Text('Adicionar nova empresa ao sistema'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => _showCreateBusinessDialog(),
            ),
          ),
        ],
      ),
    );
  }

  void _handleUserAction(UserModel user, String action) async {
    final adminService = ref.read(adminUserServiceProvider);
    
    try {
      switch (action) {
        case 'reset_password':
          await adminService.resetUserPassword(user.email);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Email de redefinição de senha enviado')),
            );
          }
          break;
        case 'deactivate':
          await adminService.deactivateUser(user.uid);
          _loadData();
          break;
        case 'activate':
          await adminService.activateUser(user.uid);
          _loadData();
          break;
        case 'edit_role':
          _showEditRoleDialog(user);
          break;
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: ${e.toString()}')),
        );
      }
    }
  }

  void _showBusinessDetails(Business business) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(business.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('CNPJ: ${business.cnpj}'),
            if (business.email?.isNotEmpty == true)
              Text('Email: ${business.email}'),
            if (business.phone?.isNotEmpty == true)
              Text('Telefone: ${business.phone}'),
            if (business.address?.isNotEmpty == true)
              Text('Endereço: ${business.address}'),
            Text('Criada em: ${business.createdAt.day}/${business.createdAt.month}/${business.createdAt.year}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  void _showCreateUserDialog() {
    // This will be implemented in the next step
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Função em desenvolvimento')),
    );
  }

  void _showCreateBusinessDialog() {
    // This will be implemented in the next step
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Função em desenvolvimento')),
    );
  }

  void _showEditRoleDialog(UserModel user) {
    UserRole selectedRole = user.role;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alterar função de ${user.displayName}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<UserRole>(
              title: const Text('Administrador'),
              value: const UserRole.admin(),
              groupValue: selectedRole,
              onChanged: (value) => selectedRole = value!,
            ),
            RadioListTile<UserRole>(
              title: const Text('Proprietário'),
              value: const UserRole.owner(),
              groupValue: selectedRole,
              onChanged: (value) => selectedRole = value!,
            ),
            RadioListTile<UserRole>(
              title: const Text('Gerente'),
              value: const UserRole.manager(),
              groupValue: selectedRole,
              onChanged: (value) => selectedRole = value!,
            ),
            RadioListTile<UserRole>(
              title: const Text('Funcionário'),
              value: const UserRole.employee(),
              groupValue: selectedRole,
              onChanged: (value) => selectedRole = value!,
            ),
            RadioListTile<UserRole>(
              title: const Text('Visualizador'),
              value: const UserRole.viewer(),
              groupValue: selectedRole,
              onChanged: (value) => selectedRole = value!,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await ref.read(adminUserServiceProvider).updateUserRole(user.uid, selectedRole);
                if (mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Função atualizada com sucesso')),
                  );
                  _loadData();
                }
              } catch (e) {
                if (mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erro: ${e.toString()}')),
                  );
                }
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }
}