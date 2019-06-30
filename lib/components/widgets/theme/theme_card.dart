import 'package:flutter/material.dart';
import 'package:harpy/components/screens/custom_theme_screen.dart';
import 'package:harpy/components/widgets/shared/harpy_background.dart';
import 'package:harpy/core/misc/harpy_navigator.dart';
import 'package:harpy/core/misc/harpy_theme.dart';
import 'package:harpy/models/settings/theme_settings_model.dart';

/// A [Card] showing a selectable [HarpyTheme] that changes the apps theme when
/// selected.
class ThemeCard extends StatelessWidget {
  const ThemeCard({
    @required this.harpyTheme,
    @required this.id,
  });

  final HarpyTheme harpyTheme;
  final int id;

  bool get isCustomTheme => id >= PredefinedThemes.themes.length;

  Widget _buildThemeName(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        "${harpyTheme.name}",
        overflow: TextOverflow.ellipsis,
        style: harpyTheme.theme.textTheme.subtitle,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildThemeColors() {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 4,
          color: harpyTheme.theme.accentColor,
        ),
      ],
    );
  }

  void _onTap(ThemeSettingsModel themeSettingsModel) {
    // if already selected, edit custom theme
    if (isCustomTheme && themeSettingsModel.selectedThemeId == id) {
      HarpyNavigator.push(
        CustomThemeScreen(
          editingThemeData: themeSettingsModel.getDataFromId(id),
          editingThemeId: id,
        ),
      );
    } else {
      themeSettingsModel.changeSelectedTheme(harpyTheme, id);
    }
  }

  void _onLongPress(ThemeSettingsModel themeSettingsModel) {
    // edit theme on long press if it is not the default theme
    if (isCustomTheme) {
      HarpyNavigator.push(
        CustomThemeScreen(
          editingThemeData: themeSettingsModel.getDataFromId(id),
          editingThemeId: id,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeSettingsModel = ThemeSettingsModel.of(context);

    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(4.0),
      border: themeSettingsModel.selectedThemeId == id
          ? Border.all(
              color: themeSettingsModel.harpyTheme.backgroundComplimentaryColor,
            )
          : null,
    );

    return SizedBox(
      width: 120,
      height: 120,
      child: Theme(
        data: harpyTheme.theme,
        child: Card(
          color: Colors.transparent,
          child: Container(
            decoration: decoration,
            child: HarpyBackground(
              borderRadius: BorderRadius.circular(4.0),
              colors: harpyTheme.backgroundColors,
              child: InkWell(
                borderRadius: BorderRadius.circular(4.0),
                onTap: () => _onTap(themeSettingsModel),
                onLongPress: () => _onLongPress(themeSettingsModel),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    _buildThemeName(context),
                    Expanded(child: _buildThemeColors()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Similar to [ThemeCard] that can be selected to add a new custom theme.
class AddCustomThemeCard extends StatelessWidget {
  void _onTap() {
    // todo
//    showDialog(context: context, builder: (_) => ProFeatureDialog());
    HarpyNavigator.push(CustomThemeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Container(
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            width: 1.0,
            color: Theme.of(context).dividerColor,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(4.0),
          child: InkWell(
            onTap: _onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Custom"),
                Icon(Icons.add),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
