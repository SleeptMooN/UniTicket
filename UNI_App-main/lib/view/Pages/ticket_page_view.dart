import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image/image.dart';
import 'package:uni/model/UniTicket/AcademicServices.dart';
import 'package:uni/view/Pages/general_page_view.dart';
import 'package:uni/view/Widgets/terms_and_conditions.dart';
import 'package:uni/view/Pages/cancel_ticket_page.dart';
import '../../model/UniTicket/Client.dart';
import 'package:uni/main.dart' as academic;

var ticketNumber = null;
var realTicketNumber = null;
var areaChoosen = null;

void setHasTicket(bool value) {
  hasTicket = value;
}

String getTicket() {
  return realTicketNumber.toString();
}

List getArea() {
  var name = null;
  if (areaChoosen == 'A') name = 'Secretaria';
  if (areaChoosen == 'B') name = 'Tesouraria';
  if (areaChoosen == 'C') name = 'Outro Serviço';
  return [areaChoosen, name];
}

//Client client = Client();

class TicketPageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TicketPageViewState();
}

/// Manages the 'ticket' section of the app.
class TicketPageViewState extends GeneralPageViewState {
  AcademicServices academicServices = AcademicServices();
  void _updateServices() {
    setState(() {
      academicServices.getHttpInfo();
    });
  }

  @override
  Widget getBody(BuildContext context) {
    academicServices.getHttpInfo();
    String secA = academicServices.getSecA();
    String secB = academicServices.getSecB();
    String secC = academicServices.getSecC();
    String waitA = academicServices.getWaitA();
    String waitB = academicServices.getWaitB();
    String waitC = academicServices.getWaitC();

    final MediaQueryData queryData = MediaQuery.of(context);
    return ListView(children: <Widget>[
      Container(
          //color: Colors.blueGrey,
          margin: const EdgeInsets.all(15),
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                    child: Text('Senha'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(90, 10, 0, 10),
                    child: Text('Em espera'),
                  ),
                ],
              ),
              makeBoxCard('A', secA, waitA),
              makeBoxCard('B', secB, waitB),
              makeBoxCard('C', secC, waitC),
            ],
          )),

      Ink(
        decoration: ShapeDecoration(
          color: Theme.of(context).accentColor,
          shape: CircleBorder(),
        ),
        child: IconButton(
          icon: Icon(
            Icons.question_mark_rounded,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            helpPopUp(context);
          },
        ),
      ),

      makeBoxInf(),

      //button
      Container(
        margin: EdgeInsets.symmetric(horizontal: 40),
        child: ElevatedButton(
            key: const Key('PedirSenhaButton'),
            child: Text('Pedir Senha', style: TextStyle(fontSize: 20)),
            style: ElevatedButton.styleFrom(
              //shadowColor: Colors.black,
              elevation: 20,
            ),
            onPressed: () => {
                  if (ticketNumber == null && areaChoosen == null)
                    {selectionError(context)}
                  else
                    {showCustomDialog(context)}
                }),
      )
    ]);
  }
//
}

void helpPopUp(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierLabel: "help",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 500),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Container(
          height: 200,
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: DefaultTextStyle(
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              child: Text('A - Secretaria\nB - Tesouraria\nC - Outro Serviço'),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
      } else {
        tween = Tween(begin: Offset(1, 0), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}

void selectionError(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Select",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 500),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Container(
          height: 200,
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: DefaultTextStyle(
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              child: Text('Seleciona uma senha.'),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
      } else {
        tween = Tween(begin: Offset(1, 0), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}

void showCustomDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 500),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Container(
            height: 200,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Container(
                  child: Center(
                    child: DefaultTextStyle(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      child: Text(
                          'Confirmar senha $areaChoosen$realTicketNumber?'),
                    ),
                  ),
                  margin: EdgeInsets.fromLTRB(30, 50, 30, 50),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    margin: EdgeInsets.only(right: 30),
                    child: ElevatedButton(
                      key: const Key('ConfirmarSimButton'), //test
                      child: Text('Sim', style: TextStyle(fontSize: 15)),
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(120, 40)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ))),
                      onPressed: () => {
                        if (!getBlocked())
                          {
                            setHasTicket(true),
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TicketCancelPageView())),
                          }
                        else
                          { 
                            Navigator.pop(context),
                            blockedPopup(context),
                          }
                      },
                    ),
                  ),
                  Container(
                    child: ElevatedButton(
                        child: Text('Não', style: TextStyle(fontSize: 15)),
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(Size(120, 40)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              //side: BorderSide(color: Colors.red)
                            ))),
                        onPressed: () => Navigator.pop(context)),
                  ),
                ]),
              ],
            )),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
      } else {
        tween = Tween(begin: Offset(1, 0), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}

void blockedPopup(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierLabel: "blocked",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 500),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Container(
          height: 200,
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: DefaultTextStyle(
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              child: Text('Estás blockeado até\n${getNextDay()}'),
            ),
          ),
        
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
      } else {
        tween = Tween(begin: Offset(1, 0), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}

Widget makeBoxInf() {
  return Container(
      //color: Colors.blueAccent,
      margin: const EdgeInsets.all(15),
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 320,
            height: 1,
            margin: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
            decoration: BoxDecoration(color: Colors.black, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                blurRadius: 7,
                offset: Offset(0, 4),
              )
            ]),
          ),
          Container(
            child: Text(
              'Horário de atendimento: 11h às 16h .\nEmissão de Senha: 10h30 às 15h30.',
              key: const Key('work_information'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text('Tolerância: 3 Senhas'),
          ),
          Container(
            width: 320,
            height: 1,
            margin: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
            decoration: BoxDecoration(color: Colors.black, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                blurRadius: 7,
                offset: Offset(0, 3),
              )
            ]),
          )
        ],
      ));
}

Widget makeBoxCard(String letra, String numero, String quantidade) {
  return Container(
      child: InkWell(
          onTap: () => {
                realTicketNumber =
                    int.parse(numero) + int.parse(quantidade) + 1,
                ticketNumber = int.parse(numero),
                areaChoosen = letra,
                //print('NUMERO: $ticketNumber\nAREA: $areaChoosen')
              },
          onLongPress: () => {
                realTicketNumber = null,
                ticketNumber = null,
                areaChoosen = null,
                //print('NUMERO: $ticketNumber\nAREA: $areaChoosen')
              },
          child: Container(
              key: const Key('AreaOption'),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[100],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    )
                  ]),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Text(letra),
                    padding: EdgeInsets.fromLTRB(30, 10, 10, 10),
                  ),
                  Container(
                    width: 1,
                    height: 20,
                    color: Colors.black,
                    //padding: EdgeInsets.only(left: 5, right: 20, top: 10, bottom: 10),
                  ),
                  Container(
                    child: Text(numero),
                    padding: EdgeInsets.only(
                        left: 10, right: 20, top: 10, bottom: 10),
                  ),
                  Container(
                    child: Text(quantidade),
                    padding: EdgeInsets.fromLTRB(140, 10, 0, 10),
                  ),
                ],
              ))));
}
