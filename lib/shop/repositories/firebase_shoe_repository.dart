import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eighty_two/shop/models/shoe.dart';
import 'package:eighty_two/shop/repositories/repositories.dart';

class FirebaseShoeRepository implements ShoeRepository {
  FirebaseShoeRepository({FirebaseFirestore? firestoreInstance})
      : firestore = firestoreInstance ?? FirebaseFirestore.instance;

  FirebaseFirestore firestore;

  @override
  Future<Shoe> getShoe({required Shoe shoe}) {
    throw UnimplementedError();
  }

  @override
  Future<List<Shoe>> getShoes({int offset = 0, int limit = 10}) async {
    try {
      final shoes = <Shoe>[];
      final querySnapshot =
          await firestore.collection('shoes').limit(limit).get();
      final docs = querySnapshot.docs;

      for (final doc in docs) {
        shoes.add(
          Shoe(
            id: doc.id,
            name: doc.data()['name'],
            imagePath: doc.data()['imagePath'],
            color: doc.data()['color'],
            price: doc.data()['price'] as double,
            size: doc.data()['size'] as double
          ),
        );
      }
      
      return shoes;
    } catch (exception) {
      rethrow;
    }
  }
}
