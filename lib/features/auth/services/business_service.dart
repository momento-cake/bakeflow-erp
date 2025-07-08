import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../core/models/business_model.dart';

final businessServiceProvider = Provider<BusinessService>((ref) {
  return BusinessService();
});

class BusinessService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Uuid _uuid = const Uuid();

  String generateBusinessId() => _uuid.v4();

  Future<void> createBusiness(Business business) async {
    try {
      await _firestore
          .collection('businesses')
          .doc(business.id)
          .set(business.toJson());
    } catch (e) {
      throw BusinessException(
        message: 'Erro ao criar empresa',
        code: 'create_business_failed',
        details: e.toString(),
      );
    }
  }

  Future<Business> getBusinessById(String businessId) async {
    try {
      final doc = await _firestore
          .collection('businesses')
          .doc(businessId)
          .get();

      if (!doc.exists) {
        throw BusinessException(
          message: 'Empresa não encontrada',
          code: 'business_not_found',
        );
      }

      return Business.fromJson(doc.data()!);
    } catch (e) {
      if (e is BusinessException) rethrow;
      throw BusinessException(
        message: 'Erro ao carregar empresa',
        code: 'get_business_failed',
        details: e.toString(),
      );
    }
  }

  Future<Business?> getBusinessByUserId(String userId) async {
    try {
      final query = await _firestore
          .collection('businesses')
          .where('authorizedUsers', arrayContains: userId)
          .limit(1)
          .get();

      if (query.docs.isEmpty) {
        return null;
      }

      return Business.fromJson(query.docs.first.data());
    } catch (e) {
      throw BusinessException(
        message: 'Erro ao carregar empresa do usuário',
        code: 'get_user_business_failed',
        details: e.toString(),
      );
    }
  }

  Future<List<Business>> getBusinessesByUserId(String userId) async {
    try {
      final query = await _firestore
          .collection('businesses')
          .where('authorizedUsers', arrayContains: userId)
          .get();

      return query.docs
          .map((doc) => Business.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw BusinessException(
        message: 'Erro ao carregar empresas do usuário',
        code: 'get_user_businesses_failed',
        details: e.toString(),
      );
    }
  }

  Future<void> updateBusiness(Business business) async {
    try {
      await _firestore
          .collection('businesses')
          .doc(business.id)
          .update(business.toJson());
    } catch (e) {
      throw BusinessException(
        message: 'Erro ao atualizar empresa',
        code: 'update_business_failed',
        details: e.toString(),
      );
    }
  }

  Future<void> addUserToBusiness(String businessId, String userId) async {
    try {
      await _firestore
          .collection('businesses')
          .doc(businessId)
          .update({
        'authorizedUsers': FieldValue.arrayUnion([userId]),
      });
    } catch (e) {
      throw BusinessException(
        message: 'Erro ao adicionar usuário à empresa',
        code: 'add_user_failed',
        details: e.toString(),
      );
    }
  }

  Future<void> removeUserFromBusiness(String businessId, String userId) async {
    try {
      await _firestore
          .collection('businesses')
          .doc(businessId)
          .update({
        'authorizedUsers': FieldValue.arrayRemove([userId]),
      });
    } catch (e) {
      throw BusinessException(
        message: 'Erro ao remover usuário da empresa',
        code: 'remove_user_failed',
        details: e.toString(),
      );
    }
  }

  Future<void> deactivateBusiness(String businessId) async {
    try {
      await _firestore
          .collection('businesses')
          .doc(businessId)
          .update({'isActive': false});
    } catch (e) {
      throw BusinessException(
        message: 'Erro ao desativar empresa',
        code: 'deactivate_business_failed',
        details: e.toString(),
      );
    }
  }

  Stream<Business> watchBusiness(String businessId) {
    return _firestore
        .collection('businesses')
        .doc(businessId)
        .snapshots()
        .map((doc) {
      if (!doc.exists) {
        throw BusinessException(
          message: 'Empresa não encontrada',
          code: 'business_not_found',
        );
      }
      return Business.fromJson(doc.data()!);
    });
  }
}

class BusinessException implements Exception {
  final String message;
  final String code;
  final String? details;

  BusinessException({
    required this.message,
    required this.code,
    this.details,
  });

  @override
  String toString() => message;
}