import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:loja_virtual/common/custom_drawer/drawer_tile.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer_header.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Color(0xFFB42827),
            )
          ),
          ListView(
            children: [
              CustomDrawerHeader(),
              DrawerTile(
                iconData: Icons.home,
                title: 'Início',
                page: 0,
              ),
              DrawerTile(
                iconData: Icons.list,
                title: 'Produtos',
                page: 1,
              ),
              DrawerTile(
                iconData: Icons.playlist_add_check,
                title: 'Meus pedidos',
                page: 2,
              ),
              DrawerTile(
                iconData: Icons.location_on_outlined,
                title: 'Lojas',
                page: 3,
              ),
              Consumer<UserManager>(
                builder: (_, userManager, __) {
                  if(userManager.adminEnabled){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [                       
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                          color: Colors.grey[900].withOpacity(.3),
                          child: Text('ADMINISTRAÇÃO'),
                        ),
                        DrawerTile(
                          iconData: Icons.settings,
                          title: 'Usuários',
                          page: 4,
                        ),
                        DrawerTile(
                          iconData: Icons.settings,
                          title: 'Pedidos',
                          page: 5,
                        ),
                      ],
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                }
              )
            ],
          ),
        ],
      ),
    );
  }
}
