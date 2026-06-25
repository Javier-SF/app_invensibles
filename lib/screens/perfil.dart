import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),

                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 54,
                        backgroundColor: Colors.yellowAccent.shade700,
                      ),
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: const Color(0xFF1F222A),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            50,
                          ), // Debe ser igual al radio
                          child: Image.asset(
                            'assets/images/leonardo_ventura.jpeg',
                            width: 100, // Diámetro total (radius * 2)
                            height: 100, // Diámetro total (radius * 2)
                            fit: BoxFit
                                .cover, // Evita que la foto se deforme si no es perfectamente cuadrada
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                const Text(
                  'Leonardo Alexander Ventura Díaz',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),

                Text(
                  'Mobile Developer',
                  style: TextStyle(
                    color: Colors.yellowAccent.shade700,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 24),

                _buildSectionCard(
                  title: 'Sobre mí',
                  icon: Icons.info_outline_rounded,
                  child: const Text(
                    'Desarrollador apasionado por crear aplicaciones móviles y experiencias digitales únicas. Fan número uno de Invincible y siempre listo para nuevos proyectos desafiantes. Disponible para colaborar en lo que necesites.',
                    style: TextStyle(
                      color: Color(0xFFE2E8F0),
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                _buildSectionCard(
                  title: 'Habilidades',
                  icon: Icons.bolt_rounded,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildSkillChip('Flutter'),
                      _buildSkillChip('Dart'),
                      _buildSkillChip('Git / GitHub'),
                      _buildSkillChip('Mobile UI Design'),
                      _buildSkillChip('Android SDK'),
                      _buildSkillChip('API Integration'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                _buildSectionCard(
                  title: 'Contacto',
                  icon: Icons.contacts_outlined,
                  child: Column(
                    children: [
                      _buildContactRow(
                        Icons.email_outlined,
                        'Email',
                        '20230548@itla.edu.do',
                      ),
                      const Divider(color: Colors.white10, height: 20),
                      _buildContactRow(
                        Icons.phone_android_rounded,
                        'Teléfono',
                        '809-714-6638',
                      ),
                      const Divider(color: Colors.white10, height: 20),
                      _buildContactRow(
                        Icons.link_rounded,
                        'LinkedIn',
                        'linkedin.com/in/leonardo-alexander...',
                      ),
                      const Divider(color: Colors.white10, height: 20),
                      _buildContactRow(
                        Icons.code_rounded,
                        'GitHub',
                        'github.com/elfhotel24',
                      ),
                      const Divider(color: Colors.white10, height: 20),
                      _buildContactRow(
                        Icons.location_on_outlined,
                        'Ubicación',
                        'Santo Domingo, RD',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Estructura base para las secciones del perfil
  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1F222A).withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.yellowAccent.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.yellowAccent.shade700, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(color: Colors.white12, thickness: 1),
          ),
          child,
        ],
      ),
    );
  }

  // Widget para las etiquetas de habilidades
  Widget _buildSkillChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white10),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white70, fontSize: 13),
      ),
    );
  }

  // Estructura limpia para filas de información de contacto
  Widget _buildContactRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 20),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 11),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
