import 'package:eighty_two/shop/models/shoe.dart';

abstract class ShoeRepository {
  /// Fetches shoes from the repository.
  /// [offset] determines which position it should start with
  /// and [limit] determines the number of shoes to fetch
  Future<List<Shoe>> getShoes({int offset = 0, int limit = 10});

  /// Fetch the details of a specific shoe
  Future<Shoe> getShoe({required Shoe shoe});
}
