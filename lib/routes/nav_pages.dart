import 'package:aa2_mobile/routes/consultas.dart';
import 'package:aa2_mobile/routes/profissionais.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: Image.asset(
          "images/Logotipo.png",
          width: 140,
        ),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: setPaginaAtual,
        children: [
          const Profissionais(),
          Consultas(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        items:  [
          BottomNavigationBarItem(icon: const Icon(Icons.home), label: AppLocalizations.of(context)!.home),
          BottomNavigationBarItem(
              icon: const Icon(Icons.calendar_month), label: AppLocalizations.of(context)!.consultas),
        ],
        onTap: (pagina) {
          pageController.animateToPage(
            pagina,
            duration: const Duration(milliseconds: 400),
            curve: Curves.decelerate,
          );
        },
      ),
    );
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }
}
