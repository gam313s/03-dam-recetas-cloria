import 'package:flutter/material.dart';
import 'package:recetasapp/models/recetas.dart';
import 'package:recetasapp/services/recipe_service.dart';
import 'package:recetasapp/widgets/receta_cart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Recetas>> _recetas;

  @override
  void initState() {
    super.initState();
    _recetas = RecipeService().obtenerRecetas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recetas del Mayab')),
      body: FutureBuilder<List<Recetas>>(
        future: _recetas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final recetas = snapshot.data!;
          return ListView.builder(
            itemCount: recetas.length,
            itemBuilder: (context, i) => RecetasCard(
              recetas: recetas[i],
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}