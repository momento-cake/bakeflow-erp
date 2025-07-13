import '../../../../../core/models/business_model.dart';
import '../../../../../core/models/company_user_model.dart';
import '../services/companies_service.dart';

class CompaniesRepository {
  final CompaniesService _companiesService;

  CompaniesRepository(this._companiesService);

  // Companies operations
  Stream<List<Business>> getAllBusinesses() => _companiesService.getAllBusinesses();

  Future<Business?> getBusinessById(String businessId) =>
      _companiesService.getBusinessById(businessId);

  Future<Business> createBusiness(Business business) =>
      _companiesService.createBusiness(business);

  Future<Business> updateBusiness(Business business) =>
      _companiesService.updateBusiness(business);

  Future<void> deleteBusiness(String businessId) =>
      _companiesService.deleteBusiness(businessId);

  Stream<List<Business>> searchBusinesses(String query) =>
      _companiesService.searchBusinesses(query);

  Stream<List<Business>> getBusinessesByType(BusinessType type) =>
      _companiesService.getBusinessesByType(type);

  Stream<List<Business>> getBusinessesByStatus(BusinessStatus status) =>
      _companiesService.getBusinessesByStatus(status);

  // Company users operations
  Stream<List<CompanyUser>> getCompanyUsers(String businessId) =>
      _companiesService.getCompanyUsers(businessId);

  Future<CompanyUser?> getCompanyUserById(String businessId, String userId) =>
      _companiesService.getCompanyUserById(businessId, userId);

  Future<CompanyUser> createCompanyUser({
    required String businessId,
    required CompanyUser user,
    required String password,
  }) =>
      _companiesService.createCompanyUser(
        businessId: businessId,
        user: user,
        password: password,
      );

  Future<CompanyUser> updateCompanyUser(String businessId, CompanyUser user) =>
      _companiesService.updateCompanyUser(businessId, user);

  Future<void> resetCompanyUserPassword(String email) =>
      _companiesService.resetCompanyUserPassword(email);

  Future<void> deleteCompanyUser(String businessId, String userId) =>
      _companiesService.deleteCompanyUser(businessId, userId);

  Future<void> toggleUserActiveStatus(String businessId, String userId, bool isActive) =>
      _companiesService.toggleUserActiveStatus(businessId, userId, isActive);

  Stream<List<CompanyUser>> searchCompanyUsers(String businessId, String query) =>
      _companiesService.searchCompanyUsers(businessId, query);
}