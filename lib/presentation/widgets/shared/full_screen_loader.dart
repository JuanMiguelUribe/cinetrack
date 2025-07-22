import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    const messages = <String>[
      "Cargando cartelera...",
      "Por favor, espere mientras desenrollamos la cinta 🎞️",
      "Ajustando el proyector 📽️",
      "Buscando las mejores palomitas 🍿",
      "Viendo los trailers... sin spoilers 😎",
      "Esto esta tardando mas que una película de tres horas",
      "Limpiando los asientos de la sala 🎟️",
      "Subiendo el volumen del sonido envolvente 🔊",
      "Rebobinando la peli... sí, eso aún existe",
      "Sacando al crítico de cine interno 🎬",
      "Cargando... aún no empieza la función",
      "Censurando escenas... nah, mentira",
      "Evadiendo spoilers como un ninja 🥷",
      "Esperando a que llegue el protagonista...",
      "Renderizando efectos especiales 💥",
      "Escapando de los comerciales 🕵️‍♂️",
      "Acomodando los subtítulos 📝",
      "Llenando tu combo gigante 🍔🥤",
      "Verificando si esta peli ganó algún Oscar 🏆",
      "Trayendo el soundtrack épico 🎼",
      "Leyendo críticas para ignorarlas igual 🤷‍♂️",
      "Reservando la mejor butaca del cine 💺",
      "Programando el final sorpresa... o no 👀",
      "Cargando los créditos... del que hizo la app 😁",
    ];
    return Stream.periodic(
      const Duration(milliseconds: 4000),
      (step) => messages[step],
    ).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Espere por favor..."),
          const SizedBox(height: 20),
          const CircularProgressIndicator(),
          const SizedBox(height: 20),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text("Cargando ... ");

              return Text(snapshot.data!);
            },
          ),
        ],
      ),
    );
  }
}
