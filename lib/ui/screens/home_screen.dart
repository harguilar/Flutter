import 'package:flutter/material.dart';
import 'package:gerente_loja/blocs/home_bloc.dart';
import 'package:gerente_loja/blocs/orders_bloc.dart';
import 'package:gerente_loja/blocs/quote_bloc.dart';
import 'package:gerente_loja/ui/tabs/orders_tab.dart';
import 'package:gerente_loja/ui/tabs/profile_tab.dart';
import 'package:gerente_loja/ui/tabs/quotes_tab.dart';
import 'package:provider/provider.dart';

import 'chat_screen.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  PageController _pageController;
  int _page = 0;

  QuoteBloc _quoteBloc;
  OrdersBloc _ordersBloc;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    _quoteBloc = QuoteBloc();
    _ordersBloc = OrdersBloc();
  }


  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color.fromRGBO(58, 66, 86, 1.0),
          primaryColor: Colors.amber,
          textTheme: Theme.of(context).textTheme.copyWith(
            caption: TextStyle(color: Colors.white54)
          )
        ),
        child: BottomNavigationBar(
          unselectedItemColor: Colors.amber,
          currentIndex: _page,
          selectedItemColor: Colors.amber,
          onTap: (p){
            _pageController.animateToPage(
                p,
                duration: Duration(milliseconds: 500),
                curve: Curves.ease
            );
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.collections),
              title: Text("Proformas")
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                title: Text("Pedidos")
            ),
           /* BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                title: Text("Mensagens")
            ),*/
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                title: Text("Perfil")
            ),
          ]
        ),
      ),
      body: SafeArea(

        child: MultiProvider(
           providers: [
             Provider<HomeBloc>(
               create: (_) =>HomeBloc() ,
               dispose: (context, value) => value.dispose(),

             ),
           /*  Provider<OrdersBloc>(
               create: (_) =>OrdersBloc() ,
               dispose: (context, value) => value.dispose(),

             )
*/
           ],
          child: PageView(
          controller: _pageController,
          onPageChanged: (p){
            setState(() {
              _page = p;
            });
          },
          children: <Widget>[
            QuotesTab(),
            OrdersTab(),
           // ChatScreen(),
            ProfileTab(),
          ],
        ),

        )


      ),
      //floatingActionButton: _buildFloating(),
    );
  }

/*  Widget _buildFloating(){
    switch(_page){
      case 0:
        return null;
      case 1:
        return SpeedDial(
          child: Icon(Icons.sort),
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          overlayOpacity: 0.4,
          overlayColor: Colors.black,
          children: [
            SpeedDialChild(
              child: Icon(Icons.arrow_downward, color: Color.fromRGBO(58, 66, 86, 1.0),),
              backgroundColor: Colors.white,
              label: "Concluídos Abaixo",
              labelStyle: TextStyle(fontSize: 14),
              onTap: (){
                _ordersBloc.setOrderCriteria(SortCriteria.READY_LAST);
              }
            ),
            SpeedDialChild(
              child: Icon(Icons.arrow_upward, color: Color.fromRGBO(58, 66, 86, 1.0),),
              backgroundColor: Colors.white,
              label: "Concluídos Acima",
              labelStyle: TextStyle(fontSize: 14),
              onTap: (){
                _ordersBloc.setOrderCriteria(SortCriteria.READY_FIRST);
              }
            )
          ],
        );
      case 2:
        return FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          onPressed: (){
            showDialog(context: context,
                builder: (context) => EditCategoryDialog()
            );
          },
        );
    }
  }*/
}
