import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:movieflex/config/theme/app_text_styles.dart';
import 'package:movieflex/domain/entities/actor.dart';
import 'package:movieflex/l10n/app_localizations.dart';
import 'package:movieflex/presentation/providers/providers.dart';
import 'package:movieflex/presentation/widgets/widgets.dart';

class ActorDetailsBottomSheet extends ConsumerWidget {
  final String actorId;

  const ActorDetailsBottomSheet({super.key, required this.actorId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actorAsync = ref.watch(actorDetailsProvider(actorId));
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    return actorAsync.when(
      data: (actor) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6, // porcentaje de pantalla al abrir
          minChildSize: 0.4,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: colors.surface,
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
                    _HeaderProfile(size: size, actor: actor),

                    const SizedBox(height: 8),
                    if (actor.alsoKnownAs.isNotEmpty)
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  "${AppLocalizations.of(context)!.alsoKnownAs}: ",
                              style: AppTextStyles.actorDetailsBirthday(context)
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                    color: colors.onSurface.withAlpha(150),
                                  ),
                            ),
                            TextSpan(
                              text: actor.alsoKnownAs.join(", "),
                              style: AppTextStyles.actorDetailsBirthday(context)
                                  .copyWith(
                                    color: colors.onSurface.withAlpha(150),
                                  ),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 16),
                    _BiographyContainer(
                      colors: colors,
                      textStyles: textStyles,
                      actor: actor,
                    ),

                    SizedBox(height: 50),
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

class _BiographyContainer extends StatelessWidget {
  final PersonDetailsEntity actor;
  const _BiographyContainer({
    required this.colors,
    required this.textStyles,
    required this.actor,
  });

  final ColorScheme colors;
  final TextTheme textStyles;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Container(
        //*Decoracion Contenedor del Rating y Overview
        decoration: BoxDecoration(
          color: colors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: colors.surfaceContainerHigh.withAlpha(80),
              blurRadius: 8,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.biography,
                style: textStyles.titleMedium?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 0),
              ExpandableText(
                text: (actor.biography.trim().isNotEmpty)
                    ? actor.biography
                    : AppLocalizations.of(context)!.resultsSearch,
                wordLimit: 65,
                style: textStyles.bodyMedium?.copyWith(color: colors.onSurface),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderProfile extends StatelessWidget {
  final PersonDetailsEntity actor;
  const _HeaderProfile({required this.size, required this.actor});

  final Size size;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              actor.profilePath ?? '',
              height: 220,
              width: 150,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.person, size: 100),
            ),
          ),
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.only(left: 16, right: 8),
            width: 0.8,
            height: 220, // altura específica de la línea
            color: colors.onSurface,
          ),
        ),
        const SizedBox(width: 0),

        SizedBox(
          width: size.height * 0.20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nombre
              SizedBox(
                child: Text(
                  actor.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.titleActorName(context),
                ),
              ),
              const SizedBox(height: 0),

              // Departamento
              SizedBox(
                // width: 120,
                child: Text(
                  actor.knownForDepartment ?? 'No especificado',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.actorDetailsDepartment(context),
                ),
              ),
              const SizedBox(height: 4),
              Text(actor.id.toString()),
              //* Fecha de nacimiento
              SizedBox(
                child: RichText(
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${AppLocalizations.of(context)!.born}: ",
                        style: AppTextStyles.actorDetailsBirthday(
                          context,
                        ).copyWith(fontWeight: FontWeight.w600, fontSize: 17),
                      ),
                      TextSpan(
                        text: actor.birthday != null
                            ? DateFormat(
                                'EEEE, d MMMM y',
                                Localizations.localeOf(context).languageCode,
                              ).format(actor.birthday!)
                            : AppLocalizations.of(context)!.unknownDate,
                        style: AppTextStyles.actorDetailsBirthday(context),
                      ),
                      TextSpan(
                        text: " - ${actor.placeOfBirth}",
                        style: AppTextStyles.actorDetailsBirthday(context),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 4),

              //* Género del actor
              buildGenderText(context, actor.gender!),

              const SizedBox(height: 2),

              //* Fecha de defunción (si existe)
              if (actor.deathday != null)
                SizedBox(
                  child: RichText(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${AppLocalizations.of(context)!.died}: ",
                          style: AppTextStyles.actorDetailsDefunction(
                            context,
                          ).copyWith(fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        TextSpan(
                          text: actor.birthday != null
                              ? DateFormat(
                                  'd MMMM y',
                                  Localizations.localeOf(context).toString(),
                                ).format(actor.deathday!)
                              : AppLocalizations.of(context)!.unknownDate,
                          style: AppTextStyles.actorDetailsDefunction(context),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildGenderText(BuildContext context, int gender) {
  String genderText;
  switch (gender) {
    case 1:
      genderText = AppLocalizations.of(context)!.genderFemale;
      break;
    case 2:
      genderText = AppLocalizations.of(context)!.genderMale;
      break;
    case 3:
      genderText = AppLocalizations.of(context)!.genderNonBinary;
      break;
    default:
      genderText = AppLocalizations.of(context)!.gender_no_specified;
  }

  return RichText(
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    text: TextSpan(
      children: [
        TextSpan(
          text: "${AppLocalizations.of(context)!.gender}: ",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        TextSpan(
          text: genderText,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    ),
  );
}
