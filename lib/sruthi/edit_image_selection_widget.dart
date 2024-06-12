import 'package:flutter/material.dart';

import '../view/constant/sizes/constant.dart';
import '../view/home/undermaintance/under_maintance.dart';

class CircleAvatharImageSelectionWidget extends StatelessWidget {
 final ImageProvider<Object>? backgroundImage;
  const CircleAvatharImageSelectionWidget({
    this.backgroundImage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: const NetworkImage(netWorkImagePathPerson),
          radius: 60,
          child: Stack(
            children: [
              InkWell(
                onTap: () async {},
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor:
                        // ignore: prefer_const_constructors
                        Color.fromARGB(255, 52, 50, 50),
                    child: Center(
                      child: IconButton(
                        icon: const Icon(Icons.edit),
                        color: Colors.white,
                        onPressed: () async {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const UnderMaintanceScreen(text: '',);
                  },));
                          // Get.off(() => const UnderMaintanceScreen(
                          //       text: '',
                          //     ));
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
