import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

const _antDesignIcons = <IconData>[
  AntDesign.gitlab_fill,
  AntDesign.sketch_outline,
  AntDesign.alibaba_outline,
];

const _bootstrapIcons = <IconData>[
  Bootstrap.google,
  Bootstrap.bootstrap,
  Bootstrap.github,
];

const _boxIcons = <IconData>[
  BoxIcons.bxl_apple,
  BoxIcons.bx_git_branch,
  BoxIcons.bxs_cookie,
];

const _brandIcons = <String>[
  Brands.icons8,
  Brands.the_big_bang_theory,
  Brands.android_studio,
];

const _clarityIcons = <IconData>[
  Clarity.map_outline_badged,
  Clarity.application_solid,
  Clarity.camera_line,
];

const _evaIcons = <IconData>[
  EvaIcons.clipboard,
  EvaIcons.flash,
  EvaIcons.clipboard_outline,
];

const _flagIcons = <String>[
  Flags.india,
  Flags.united_kingdom,
  Flags.united_states_of_america,
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IconsPlusSample(),
    ),
  );
}

class IconsPlusSample extends StatelessWidget {
  const IconsPlusSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 60.0,
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(_antDesignIcons.length, (index) {
                    return Icon(
                      _antDesignIcons[index],
                      size: 32.0,
                    );
                  }),
                ),
                const SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(_bootstrapIcons.length, (index) {
                    return Icon(
                      _bootstrapIcons[index],
                      size: 26.0,
                    );
                  }),
                ),
                const SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(_boxIcons.length, (index) {
                    return Icon(
                      _boxIcons[index],
                      size: 26.0,
                    );
                  }),
                ),
                const SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(_brandIcons.length, (index) {
                    return Brand(
                      _brandIcons[index],
                      size: 26.0,
                    );
                  }),
                ),
                const SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(_clarityIcons.length, (index) {
                    return Icon(
                      _clarityIcons[index],
                      size: 26.0,
                    );
                  }),
                ),
                const SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(_evaIcons.length, (index) {
                    return Icon(
                      _evaIcons[index],
                      size: 26.0,
                    );
                  }),
                ),
                const SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(_flagIcons.length, (index) {
                    return Flag(
                      _flagIcons[index],
                      size: 26.0,
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
