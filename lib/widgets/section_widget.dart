import 'package:flutter/material.dart';

class SectionData {
  final IconData icon;
  final String title;
  final String description;
  final Color backgroundColor;
  final ImageProvider? image;

  SectionData({
    required this.icon,
    required this.title,
    required this.description,
    required this.backgroundColor,
    this.image,
  });
}

class DiagonalSections extends StatelessWidget {
  final List<SectionData> sections;

  const DiagonalSections({super.key, required this.sections});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(sections.length, (index) {
        final section = sections[index];
        final isFirst = index == 0;
        final isLast = index == sections.length - 1;
        final diagonalDirection =
            index % 2 == 0; // true: left->right, false: right->left

        return ClipPath(
          clipper: isLast
              ? (isFirst ? null : TopDiagonalClipper(diagonalDirection))
              : FullDiagonalClipper(diagonalDirection),
          child: Container(
            color: section.backgroundColor,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(section.icon, size: 32, color: Colors.white),
                const SizedBox(height: 12),
                Text(
                  section.title,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  section.description,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 16),
                section.image != null
                    ? Image(
                        image: section.image!,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        height: 150,
                        // color: Colors.white24,
                        alignment: Alignment.center,
                        // child: const Text("No Image",
                        //     style: TextStyle(color: Colors.white70)),
                      ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class FullDiagonalClipper extends CustomClipper<Path> {
  final bool leftToRight;
  FullDiagonalClipper(this.leftToRight);

  @override
  Path getClip(Size size) {
    final path = Path();
    if (leftToRight) {
      path.moveTo(0, 30);
      path.lineTo(0, size.height - 30);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
    } else {
      path.moveTo(0, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height - 30);
      path.lineTo(size.width, 30);
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class TopDiagonalClipper extends CustomClipper<Path> {
  final bool leftToRight;
  TopDiagonalClipper(this.leftToRight);

  @override
  Path getClip(Size size) {
    final path = Path();
    if (leftToRight) {
      path.moveTo(0, 30);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
    } else {
      path.moveTo(0, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 30);
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
