import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WhiteCard extends StatelessWidget {
  final String? title;
  final Widget child;
  final Widget acciones;
  final double? width;

  const WhiteCard(
      {Key? key,
      this.title,
      required this.child,
      this.width,
      required this.acciones})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      decoration: buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Row(
              children: [
                FittedBox(
                  fit: BoxFit.contain,
                  child: Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: Text(
                      title!,
                      style: GoogleFonts.roboto(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const Spacer(),
                acciones
              ],
            ),
            const Divider()
          ],
          child
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)
          ]);
}
