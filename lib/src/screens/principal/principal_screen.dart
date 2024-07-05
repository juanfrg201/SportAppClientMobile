import 'package:flutter/material.dart';
import 'package:sport_app/src/components/principal/new_rutine.dart';
import 'package:sport_app/src/components/principal/profile_screen.dart';
import 'package:sport_app/src/components/principal/rutine.dart';

class PrincipalScreen extends StatelessWidget {
  const PrincipalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 300.0,
                floating: false,
                pinned: true,
                stretch: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    collapseMode: CollapseMode.parallax,
                    background: Image.network(
                      "https://img.freepik.com/fotos-premium/gimnasio-oscuro-luces-rojas-fondo-negro_876956-1224.jpg",
                      fit: BoxFit.cover,
                    )),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: color.primary,
                    unselectedLabelColor: Colors.grey,
                    tabs: _tabs,
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              Rutine(),
              NewRutine(),
              ProfileScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

const _tabs = [
  Tab(icon: Icon(Icons.home_rounded), text: "Rutina de hoy"),
  Tab(icon: Icon(Icons.shopping_bag_rounded), text: "Crea tu rutina"),
  Tab(icon: Icon(Icons.person), text: "Perfil"),
];

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _tabBar;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}


