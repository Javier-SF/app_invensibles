// ignore_for_file: deprecated_member_use

import 'package:app_invensibles/screens/perfil.dart';
import 'package:app_invensibles/screens/game_screen.dart';
import 'package:app_invensibles/screens/momentos.dart';
import 'package:app_invensibles/screens/personajes_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_invensibles/screens/presentacion_screens.dart';

class MedaiaDetailScreen extends StatefulWidget {
  const MedaiaDetailScreen({super.key});

  @override
  State<MedaiaDetailScreen> createState() => _MedaiaDetailScreenState();
}

class _MedaiaDetailScreenState extends State<MedaiaDetailScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      Presentacion(currentTab: currentPageIndex),
      CharacterCarouselScreen(),
      MemoryGamePage(),
      InvincibleMomentsPage(),
      ProfilePage(),
    ];
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          navigationBarTheme: NavigationBarThemeData(
            labelTextStyle: WidgetStateProperty.all(
              const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
        child: SizedBox(
          height: 105,
          child: NavigationBar(
            backgroundColor: Colors.black.withOpacity(1.0),
            indicatorColor: const Color(0xFF0055FF),
            selectedIndex: currentPageIndex,
            onDestinationSelected: (int index) {
              // Cambiamos el estado directamente de forma inmediata
              setState(() {
                currentPageIndex = index;
              });
            },
            destinations: [
              NavigationDestination(
                selectedIcon: Image.asset(
                  'assets/images/Viltrimite_logo_black.png',
                  height: 30,
                  width: 30,
                ),
                icon: Image.asset(
                  'assets/images/Viltrumite_logo_red.png',
                  height: 30,
                  width: 30,
                ),
                label: 'Historia',
              ),
              const NavigationDestination(
                selectedIcon: Icon(Icons.person, color: Colors.white),
                icon: Icon(Icons.person_outline, color: Colors.white),
                label: 'Personajes',
              ),
              const NavigationDestination(
                selectedIcon: Icon(Icons.gamepad, color: Colors.white),
                icon: Icon(Icons.gamepad_outlined, color: Colors.white),
                label: 'Juego',
              ),
              const NavigationDestination(
                selectedIcon: Icon(Icons.newspaper, color: Colors.white),
                icon: Icon(Icons.newspaper_outlined, color: Colors.white),
                label: 'Momentos',
              ),
              const NavigationDestination(
                selectedIcon: Icon(
                  Icons.contact_phone_rounded,
                  color: Colors.white,
                ),
                icon: Icon(Icons.contact_phone_outlined, color: Colors.white),
                label: 'Contactame',
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          // Capa de fondo fija
          Positioned.fill(
            child: Opacity(
              opacity: 0.25,
              child: Image.asset(
                'assets/images/3122a6e4-769a-46e3-9512-ce4cc5f64dce.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            // CAMBIO CLAVE AQUÍ: IndexedStack mantiene las páginas vivas
            child: IndexedStack(index: currentPageIndex, children: pages),
          ),
        ],
      ),
    );
  }
}
