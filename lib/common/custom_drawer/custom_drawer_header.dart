import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:loja_virtual/models/page_manager.dart';
import 'package:provider/provider.dart';

class CustomDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.fromLTRB(32, 24, 16, 6),
        margin: const EdgeInsets.only(bottom: 20),
        color: Color(0xFFB42827),
        height: MediaQuery.of(context).size.height -
            (MediaQuery.of(context).size.height / 1.8 - 90.0) -
            190.0,
        child: Consumer<UserManager>(builder: (_, userManager, __) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    margin: EdgeInsets.zero,
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Container(
                      width: 80.0,
                      height: 80.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/no_image.jpg',
                          image:
                              '${userManager.user?.avatar ?? 'https://firebasestorage.googleapis.com/v0/b/loja-virtual-5fa68.appspot.com/o/no_image.jpg?alt=media&token=3b296c2b-844f-412b-8785-96571cedf794'}',
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                        onTap: () {
                          if (userManager.isLogged) {
                            context.read<PageManager>().setPage(0);
                            userManager.signOut();
                          } else {
                            Navigator.of(context).pushNamed('/login');
                          }
                        },
                        child: userManager.isLogged
                            ? Row(
                                children: [
                                  Icon(
                                    Icons.exit_to_app_outlined,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Sair',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Icon(
                                    Icons.person_add_alt,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Entre ou cadastre-se',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )),
                  ),
                ],
              ),
              SizedBox(
                height: 9.0,
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Olá, ${userManager.user?.name ?? ''}',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Container(
                    width: 12.0,
                    height: 12.0,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        CupertinoIcons.play_arrow_solid,
                        size: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 6.0,
              ),
              Text(
                '${userManager.user?.email ?? ''}',
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.white.withOpacity(0.6)),
              ),
            ],
          );
        }),
      ),
    );
  }
}
