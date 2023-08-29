import 'package:aa2_mobile/routes/consultas.dart';
import 'package:aa2_mobile/routes/profissionais.dart';
import 'package:flutter/material.dart';

class NavPages extends StatefulWidget {
  const NavPages({super.key});

  @override
  State<NavPages> createState() => _NavPagesState();
}

class _NavPagesState extends State<NavPages> {
  int paginaAtual = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: paginaAtual);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          Profissionais(),
          Consultas(),
        ],
        onPageChanged: setPaginaAtual,
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: paginaAtual,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Consultas'),
          ],
          onTap: (pagina) {
            pageController.animateToPage(
              pagina, 
              duration: Duration(milliseconds: 400), 
              curve: Curves.decelerate,
              );
          },
        ),
    );
  }

  setPaginaAtual(pagina){
    setState(() {
      paginaAtual = pagina;
    });
  }
}