import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:gerente_loja/core/models/proforma.dart';
import 'package:gerente_loja/core/providers/proformas_provider.dart';




class ProformasController extends BlocBase {

  ProformasProvider _provider = ProformasProvider();
  List<Proforma> proformasList = List();
  bool _isDisposed = false;

  StreamController<List<Proforma>> _proformaController = StreamController<
      List<Proforma>>.broadcast();
  StreamController<Proforma> _controllerSaveProforma = StreamController<
      Proforma>();

  //Stream gets the data from this StreamController(output)
  Stream<List<Proforma>> get outProformas => _proformaController.stream;

  //Sink puts data into the StreamController(inPut)
  StreamSink<List<Proforma>> get inProformas => _proformaController.sink;


  StreamSink<Proforma> get saveProforma => _controllerSaveProforma.sink;

  ProformasController() {
    _proformaController.add(proformasList);
    _controllerSaveProforma.stream.listen(_saveProformaData);
  }


  _saveProformaData(Proforma proforma) {
    _provider.saveProforma(proforma);
    proformasList.add(proforma);
    inProformas.add(proformasList);
  }

  Future<void> getProformas() {
    if (_isDisposed) {
      return null;
    }
    return _provider.getProformas().then(
            (dados) {
          if (dados != null) {
            proformasList = dados;
            _proformaController.sink.add(dados);
          }
        }
    );
  }

 /* Future<void> getProformasReplied() {
    if (_isDisposed) {
      return null;
    }
    return _provider.getProformasReplied().then(
            (dados) {
          if (dados != null) {
            proformasList = dados;
            _proformaController.sink.add(dados);
          }
        }
    );
  }
*/


/*
  @override
  void dispose() {
    _proformaController.close();
    _controllerSaveProforma.close();
    _isDisposed = true;
    super.dispose();
  }*/
}