import 'package:flutter/material.dart';

import '../models/details_show_model.dart';

class AppBarWidget extends StatelessWidget {
  final Show? show;

  const AppBarWidget(
    this.show, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Hero(
          tag: "${show?.id}",
          child: Container(
            height: MediaQuery.of(context).size.width / 1,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  show?.image.original ?? "",
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 0.0,
          top: 0.0,
          right: 0.0,
          child: Container(
            width: MediaQuery.of(context).size.width / 1.13,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF0E3311).withOpacity(0.5),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
          ),
        ),
        Positioned(
          left: 20,
          top: 15,
          right: 20,
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Row(
              children: <Widget>[
                const Icon(
                  Icons.arrow_back_ios,
                  size: 25.0,
                  color: Colors.white,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Text(
                    show?.name ?? "",
                    maxLines: 1,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
