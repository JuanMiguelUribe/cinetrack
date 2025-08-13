import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflex/presentation/providers/providers.dart';

class ActorDetailsBottomSheet extends ConsumerWidget {
  final String actorId;

  const ActorDetailsBottomSheet({super.key, required this.actorId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actorAsync = ref.watch(actorDetailsProvider(actorId));
    final size = MediaQuery.of(context).size;
    return actorAsync.when(
      data: (actor) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6, // porcentaje de pantalla al abrir
          minChildSize: 0.4,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.only(
                  left: 25,
                  right: 25,
                  bottom: 16,
                  top: 5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //*Linea Superior
                    Center(
                      child: Container(
                        height: 2,
                        width: 150,
                        margin: (EdgeInsets.only(top: 8, bottom: 20)),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade500,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                    //*FOTO DE PERFIL
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              actor.profilePath ?? '',
                              height: 200,
                              width: 150,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  const Icon(Icons.person, size: 100),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(left: 16, right: 8),
                            width: 0.8,
                            height: 200, // altura específica de la línea
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 0),

                        SizedBox(
                          width: size.height * 0.19,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Nombre
                              SizedBox(
                                width: 120, // ajusta según tu diseño
                                child: Text(
                                  actor.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 4),

                              // Departamento
                              SizedBox(
                                width: 120,
                                child: Text(
                                  actor.knownForDepartment ?? 'No especificado',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(color: Colors.grey[600]),
                                ),
                              ),
                              const SizedBox(height: 4),

                              // Fecha de nacimiento
                              SizedBox(
                                width: 120,
                                child: Text(
                                  actor.birthday != null
                                      ? 'Nacido: ${actor.birthday}'
                                      : 'Fecha de nacimiento: N/D',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                              const SizedBox(height: 4),

                              // Género
                              SizedBox(
                                width: 120,
                                child: Text(
                                  () {
                                    switch (actor.gender) {
                                      case 1:
                                        return 'Género: Femenino';
                                      case 2:
                                        return 'Género: Masculino';
                                      case 3:
                                        return 'Género: No binario';
                                      default:
                                        return 'Género: No especificado';
                                    }
                                  }(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                              const SizedBox(height: 4),

                              // Fecha de defunción (si existe)
                              if (actor.deathday != null &&
                                  actor.deathday!.isNotEmpty)
                                SizedBox(
                                  width: 120,
                                  child: Text(
                                    'Falleció: ${actor.deathday}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(color: Colors.red[400]),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),
                    Text(
                      actor.knownForDepartment ?? '',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      actor.biography ?? 'No biography available',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      loading: () => const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (err, _) =>
          SizedBox(height: 200, child: Center(child: Text('Error: $err'))),
    );
  }
}
