import 'package:hasura_connect/hasura_connect.dart';
import 'package:myfeed/app/api/hasura_info.dart';
import 'package:myfeed/app/interfaces/services/hasura_service_interface.dart';

class HasuraService implements IHasuraService {
  HasuraConnect hasuraConnect;

  HasuraService({required this.hasuraConnect});

  @override
  Future mutation({required String query}) async {
    return await hasuraConnect.mutation(query, headers: {
      'x-hasura-admin-secret' : adminSecret
    });
  }

  @override
  Future query({required String query}) async {
    return await hasuraConnect.query(query, headers: {
      'x-hasura-admin-secret' : adminSecret,
    });
  }
}
