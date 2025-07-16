import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/models/business_model.dart';
import '../../../../../core/models/company_user_model.dart';
import '../../data/repositories/companies_repository.dart';
import '../../data/services/companies_service.dart';

part 'companies_providers.g.dart';

// Service and repository providers
final companiesServiceProvider = Provider<CompaniesService>((ref) {
  return CompaniesService();
});

final companiesRepositoryProvider = Provider<CompaniesRepository>((ref) {
  return CompaniesRepository(ref.read(companiesServiceProvider));
});

// Data providers
final allBusinessesProvider = StreamProvider<List<Business>>((ref) {
  return ref.read(companiesRepositoryProvider).getAllBusinesses();
});

final businessProvider = FutureProvider.family<Business?, String>((ref, businessId) {
  return ref.read(companiesRepositoryProvider).getBusinessById(businessId);
});

final companyUsersProvider = StreamProvider.family<List<CompanyUser>, String>((ref, businessId) {
  return ref.read(companiesRepositoryProvider).getCompanyUsers(businessId);
});

final companyUserProvider =
    FutureProvider.family<CompanyUser?, ({String businessId, String userId})>((ref, params) {
  return ref.read(companiesRepositoryProvider).getCompanyUserById(params.businessId, params.userId);
});

// Search providers
final businessSearchProvider = StreamProvider.family<List<Business>, String>((ref, query) {
  return ref.read(companiesRepositoryProvider).searchBusinesses(query);
});

final companyUsersSearchProvider =
    StreamProvider.family<List<CompanyUser>, ({String businessId, String query})>((ref, params) {
  return ref.read(companiesRepositoryProvider).searchCompanyUsers(params.businessId, params.query);
});

// Filter providers
final businessesByTypeProvider = StreamProvider.family<List<Business>, BusinessType>((ref, type) {
  return ref.read(companiesRepositoryProvider).getBusinessesByType(type);
});

final businessesByStatusProvider =
    StreamProvider.family<List<Business>, BusinessStatus>((ref, status) {
  return ref.read(companiesRepositoryProvider).getBusinessesByStatus(status);
});

// State management for forms and UI
@riverpod
class CompaniesState extends _$CompaniesState {
  @override
  CompaniesStateModel build() {
    return const CompaniesStateModel();
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void setSelectedFilter(String filter) {
    state = state.copyWith(selectedFilter: filter);
  }

  void setPageSize(int pageSize) {
    state = state.copyWith(pageSize: pageSize, currentPage: 0);
  }

  void setCurrentPage(int page) {
    state = state.copyWith(currentPage: page);
  }

  void resetFilters() {
    state = const CompaniesStateModel();
  }
}

@riverpod
class CreateBusinessForm extends _$CreateBusinessForm {
  @override
  CreateBusinessFormState build() {
    return const CreateBusinessFormState();
  }

  void updateName(String name) {
    state = state.copyWith(name: name);
  }

  void updateBusinessType(BusinessType type) {
    state = state.copyWith(
      businessType: type,
      // Clear CNPJ if switching to solo entrepreneur
      cnpj: type.requiresCnpj ? state.cnpj : null,
    );
  }

  void updateCnpj(String? cnpj) {
    state = state.copyWith(cnpj: cnpj);
  }

  void updateFantasyName(String? fantasyName) {
    state = state.copyWith(fantasyName: fantasyName);
  }

  void updateAddress(String address) {
    state = state.copyWith(address: address);
  }

  void updateCity(String city) {
    state = state.copyWith(city: city);
  }

  void updateState(String stateCode) {
    state = state.copyWith(state: stateCode);
  }

  void updateZipCode(String zipCode) {
    state = state.copyWith(zipCode: zipCode);
  }

  void updatePhone(String phone) {
    state = state.copyWith(phone: phone);
  }

  void updateEmail(String? email) {
    state = state.copyWith(email: email);
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void setError(String? error) {
    state = state.copyWith(error: error);
  }

  Future<Business?> createBusiness() async {
    try {
      setLoading(true);
      setError(null);

      final business = Business(
        id: '', // Will be set by Firestore
        name: state.name,
        cnpj: state.cnpj,
        fantasyName: state.fantasyName,
        address: state.address,
        city: state.city,
        state: state.state,
        zipCode: state.zipCode,
        phone: state.phone,
        email: state.email,
        type: state.businessType,
        status: const BusinessStatus.active(),
        authorizedUsers: [],
        createdAt: DateTime.now(),
        createdBy: '', // Will be set by service
      );

      final result = await ref.read(companiesRepositoryProvider).createBusiness(business);
      return result;
    } catch (e) {
      setError(e.toString());
      return null;
    } finally {
      setLoading(false);
    }
  }

  void reset() {
    state = const CreateBusinessFormState();
  }
}

// State models
class CompaniesStateModel {
  final String searchQuery;
  final String selectedFilter;
  final int pageSize;
  final int currentPage;

  const CompaniesStateModel({
    this.searchQuery = '',
    this.selectedFilter = 'todos',
    this.pageSize = 20,
    this.currentPage = 0,
  });

  CompaniesStateModel copyWith({
    String? searchQuery,
    String? selectedFilter,
    int? pageSize,
    int? currentPage,
  }) {
    return CompaniesStateModel(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      pageSize: pageSize ?? this.pageSize,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class CreateBusinessFormState {
  final String name;
  final BusinessType businessType;
  final String? cnpj;
  final String? fantasyName;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final String phone;
  final String? email;
  final bool isLoading;
  final String? error;

  const CreateBusinessFormState({
    this.name = '',
    this.businessType = const BusinessType.soloEntrepreneur(),
    this.cnpj,
    this.fantasyName,
    this.address = '',
    this.city = '',
    this.state = '',
    this.zipCode = '',
    this.phone = '',
    this.email,
    this.isLoading = false,
    this.error,
  });

  CreateBusinessFormState copyWith({
    String? name,
    BusinessType? businessType,
    String? cnpj,
    String? fantasyName,
    String? address,
    String? city,
    String? state,
    String? zipCode,
    String? phone,
    String? email,
    bool? isLoading,
    String? error,
  }) {
    return CreateBusinessFormState(
      name: name ?? this.name,
      businessType: businessType ?? this.businessType,
      cnpj: cnpj ?? this.cnpj,
      fantasyName: fantasyName ?? this.fantasyName,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  bool get isValid {
    return name.isNotEmpty &&
        address.isNotEmpty &&
        city.isNotEmpty &&
        state.isNotEmpty &&
        zipCode.isNotEmpty &&
        phone.isNotEmpty &&
        (businessType.requiresCnpj ? (cnpj?.isNotEmpty ?? false) : true);
  }
}
