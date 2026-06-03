import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../states.dart';
import '../theme/app_theme.dart';

class HomeActions extends StatelessWidget {
  const HomeActions({super.key});

  @override
  Widget build(BuildContext context) {
    final app = MyStatefulWidget.watch(context);
    final quote = app.quote;
    final hasQuote = quote?.id != null && (quote?.text?.isNotEmpty ?? false);

    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            icon: Icons.thumb_up_rounded,
            label: FlutterI18n.translate(context, 'home.thumb_up_label'),
            color: AppColors.mint,
            enabled: hasQuote,
            onPressed: hasQuote ? () => app.state.bumpQuoteGrade(1) : null,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ActionButton(
            icon: Icons.thumb_down_rounded,
            label: FlutterI18n.translate(context, 'home.thumb_down_label'),
            color: AppColors.lilac,
            enabled: hasQuote,
            onPressed: hasQuote ? () => app.state.bumpQuoteGrade(-1) : null,
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.enabled,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final Color color;
  final bool enabled;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: enabled ? color.withValues(alpha: 0.25) : Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: enabled ? AppColors.ink : AppColors.inkMuted,
                size: 22,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: enabled ? AppColors.ink : AppColors.inkMuted,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
