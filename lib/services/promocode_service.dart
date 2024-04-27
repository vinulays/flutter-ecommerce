import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ecommerce/models/promo_code.dart';

class PromoCodeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addPromoCode(PromoCode promoCode) async {
    try {
      await _firestore.collection('promo_codes').add({
        'codeName': promoCode.codeName,
        'discount': promoCode.discount,
        'usedUserIds': [],
      });
    } catch (e) {
      throw Exception('Failed to add promo code: $e');
    }
  }

  Future<double> getDiscountAmount(String promoCodeName) async {
    try {
      final promoCodeRef = _firestore.collection('promo_codes');

      final querySnapshot =
          await promoCodeRef.where('codeName', isEqualTo: promoCodeName).get();

      final promoCodeDocs = querySnapshot.docs;

      if (promoCodeDocs.isNotEmpty) {
        final promoCodeDoc = promoCodeDocs.first;
        final promoCodeData = promoCodeDoc.data();

        return promoCodeData['discount'] ?? 0;
      } else {
        return 0;
      }
    } catch (e) {
      throw Exception('Failed to fetch promo code discount: $e');
    }
  }

  Future<bool> hasUserUsedPromoCode(String promoCodeName) async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        final querySnapshot = await _firestore
            .collection('promo_codes')
            .where('codeName', isEqualTo: promoCodeName)
            .get();

        final promoCodeDocs = querySnapshot.docs;

        if (promoCodeDocs.isNotEmpty) {
          for (final promoCodeDoc in promoCodeDocs) {
            final promoCodeData = promoCodeDoc.data();
            final usedUserIds =
                List<String>.from(promoCodeData['usedUserIds'] ?? []);
            if (usedUserIds.contains(user.uid)) {
              return true;
            }
          }
        }

        return false;
      }

      return false;
    } catch (e) {
      throw Exception('Failed to check promo code usage: $e');
    }
  }

  Future<void> usePromoCode(String promoCodeName) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        final promoCodeRef = _firestore.collection('promo_codes');
        final querySnapshot = await promoCodeRef
            .where('codeName', isEqualTo: promoCodeName)
            .get();

        final promoCodeDocs = querySnapshot.docs;

        if (promoCodeDocs.isNotEmpty) {
          final promoCodeDoc = promoCodeDocs.first;
          final promoCodeId = promoCodeDoc.id;

          await promoCodeRef.doc(promoCodeId).update({
            'usedUserIds': FieldValue.arrayUnion([user.uid])
          });
        }
      }
    } catch (e) {}
  }
}
