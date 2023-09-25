import 'package:flutter/material.dart';

class ProfessionContainer extends StatelessWidget {
  const ProfessionContainer({
    super.key,
    required this.width,
    required this.text,
    required this.img,
    required this.ontap,
    required this.select,
  });

  final double width;
  final String text, img;
  final void Function() ontap;
  final bool select;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: width * 0.4,
        decoration: BoxDecoration(boxShadow: [
          select == true
              ? BoxShadow(
                  blurRadius: 5, color: Colors.white, offset: Offset(-5, 0))
              : BoxShadow(),
          select == true
              ? BoxShadow(
                  blurRadius: 5, color: Colors.white, offset: Offset(5, 0))
              : BoxShadow()
        ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: Stack(
                  children: [
                    Image.asset(
                      img,
                      fit: BoxFit.cover,
                      height: 130,
                      width: width * 0.4,
                    ),
                    select == true
                        ? Positioned(
                            right: 5,
                            top: 4,
                            child: Image.asset(
                              "assets/images/tick.png",
                              height: 30,
                              width: 30,
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 12, bottom: 12),
              child: Center(
                child: Text(
                  text,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
