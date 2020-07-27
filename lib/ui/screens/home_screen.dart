import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/blocs/home_bloc.dart';
import 'package:gerente_loja/blocs/orders_bloc.dart';
import 'package:gerente_loja/blocs/quote_bloc.dart';
import 'package:gerente_loja/core/controllers/orders_controller.dart';
import 'package:gerente_loja/core/controllers/proformas_controller.dart';
import 'package:gerente_loja/core/controllers/user_controller.dart';
import 'package:gerente_loja/helpers/const_global.dart';
import 'package:gerente_loja/ui/tabs/buyer_proforma_tab.dart';
import 'package:gerente_loja/ui/tabs/orders_tab.dart';
import 'package:gerente_loja/ui/tabs/profile_tab.dart';
import 'package:gerente_loja/ui/tabs/buyer_proforma_request_tab.dart';
import 'package:gerente_loja/ui/tabs/vendor_proforma_history_tab.dart';
import 'package:gerente_loja/ui/tabs/vendor_proforma_tab.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController;
  int _page = 0;

  bool isVendor;

  @override
  void initState ()
  {
    super.initState();
    _pageController = PageController();

  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      bottomNavigationBar: Theme(

        data: Theme.of(context).copyWith(

            canvasColor: Color.fromRGBO(58, 66, 86, 1.0),

            primaryColor: Colors.amber,

            textTheme: Theme.of(context)

                .textTheme

                .copyWith(caption: TextStyle(color: Colors.white54))),

        child: FutureBuilder(
          future: ConstGlobal.isVendor(),
          builder: (BuildContext context, snapshot) {
            if (!snapshot.hasData)
              return Container();
            else {
              isVendor = snapshot.data;

              return BottomNavigationBar
                (
                    unselectedItemColor: Colors.amber,
                    currentIndex: _page,
                    selectedItemColor: Colors.amber,
                    onTap: (p) {
                      _pageController.animateToPage(p,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease);
                  },
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), title: Text("Início")),
                    isVendor
                        ? BottomNavigationBarItem(
                            icon: Icon(Icons.collections),
                            title: Text("Histórico de Proformas"))
                        : BottomNavigationBarItem(
                            icon: Icon(Icons.collections),
                            title: Text("Proformas")),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.shopping_cart),
                        title: Text("Pedidos")),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person_outline),
                        title: Text("Perfil")),
                  ]);
            }
          },
        ),
      ),
      body: SafeArea(
          child: PageView(
            controller: _pageController,
            onPageChanged: (p) {
              setState(() {
                _page = p;
              });
            },
            children: <Widget>[
              FutureBuilder(
                future: ConstGlobal.isVendor(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData)
                    return Container();
                  else if (snapshot.data)
                    return VendorProformaTab();
                  else
                    return BuyerProformaRequestTab();
                },
              ),
              FutureBuilder(
                future: ConstGlobal.isVendor(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData)
                    return CircularProgressIndicator();
                  else if (snapshot.data){

                    return VendorProformaHistTab();
                  }

                  else
                    return BuyerProformaTab();
                },
              ),
              OrdersTab(),
              ProfileTab(),
            ],
          ),
      ),
      floatingActionButton: _buildFloating(),
    );
  }

  Widget _buildFloating() {
    return FloatingActionButton(
      child: Icon(Icons.chat),
      backgroundColor: Colors.green,
      onPressed: () {},
    );
  }
}
