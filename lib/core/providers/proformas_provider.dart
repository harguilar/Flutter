import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:gerente_loja/core/models/proforma.dart';


class ProformasProvider {
  var ref = Firestore.instance.collection("proformas");
  String userId;



  ProformasProvider(){
    //ConstGlobal.getCurrentUser().then((value) => userId=value);
  }

  Future<List<Proforma>> getProformas() async {


    bool connectionState = await DataConnectionChecker().hasConnection;

    List<Proforma> _proformas;

    if (connectionState) {
      await ref.orderBy("date", descending: true).getDocuments().then((querySnap) {
        _proformas = querySnap.documents.map((item) {

          if(item["make"] != null){
            return   Proforma(
              id: item.data['id'],
              date: Timestamp(
                  item.data["date"].seconds, item.data["date"].nanoseconds)
                  .toDate(),
              status: item.data["status"],
              userId: item.data["userId"].toString(),
              year: item.data["year"],
              make: item["make"],
              model: item["model"],
              trim: item["trim"],
              imgUrl: item.data["imgUrl"].toString(),
              peca: item.data["peca"].toString(),
            );

          }


        }).toList();
      });
      _proformas.removeWhere((element) => element==null);
      return _proformas;
    } else {
      return List();
    }
  }

  saveProforma(Proforma proforma) async {
    await ref.document().setData(proforma.toJson());
  }
}
