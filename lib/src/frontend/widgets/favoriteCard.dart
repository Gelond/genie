import 'package:flutter/material.dart';
import '../../backend/modeles/produit.dart';

class FavoriteCard extends StatelessWidget {
  final Produit produit;
  const FavoriteCard({Key? key, required this.produit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Container(child: Image.asset(produit.image, fit: BoxFit.fill,),
                height: 170.0, width: 110.0,)
          ),
          Container(
            height: 170,
            width: 110,
            decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
          ),
          /* Positioned(
              top: 8.0,
              left: 8.0,
              child: UbeninAvatar(
                img: ecole.logo,
                radius: 20.0,
              )),*/
          Positioned(
            bottom: 0.0,
            width: 110.0,
            height: 80.0,
            //left: 10.0,
            //right: 8.0,
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    produit.nom,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  /*Text(
                    ecole.nom,
                    style: TextStyle(
                        color: Colors.white, fontStyle: FontStyle.italic),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),*/
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
      onTap: () {
        /*Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PageEcole(ecole: ecole)),
        );*/
      },
    );
  }
}