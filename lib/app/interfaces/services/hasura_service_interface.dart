
abstract class IHasuraService{
  Future<dynamic> query({required String query});
  Future<dynamic> mutation({required String query});
}