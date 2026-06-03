import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/quote.dart';
import '../theme/app_theme.dart';

/// Post-it note area; hosts [QuoteText] (or another child) and a primary action.
class QuoteWidget extends StatelessWidget {
  final Widget child;

  const QuoteWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.postIt,
      elevation: 4,
      shadowColor: AppColors.coral.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(24),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: child,
      ),
    );
  }
}

class QuoteText extends StatelessWidget {
  const QuoteText({
    super.key,
    required this.quote,
    required this.onPickQuote,
  });

  final QuoteModel? quote;
  final Future<void> Function() onPickQuote;

  @override
  Widget build(BuildContext context) {
    final welcome = FlutterI18n.translate(context, 'states.welcome');
    final hint = FlutterI18n.translate(context, 'home.tap_hint');

    final hasRealQuote =
        quote?.id != null && (quote?.text?.isNotEmpty ?? false);
    final displayGrade = quote?.grade ?? 0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onPickQuote,
            child: Center(
              child: hasRealQuote
                  ? _QuoteContent(
                      quote: quote!,
                      displayGrade: displayGrade,
                    )
                  : _WelcomeText(text: welcome),
            ),
          ),
        ),
        FilledButton.icon(
          onPressed: onPickQuote,
          icon: Image.asset(
            'assets/images/trollface.png',
            height: 26,
            width: 26,
          ),
          label: Text(FlutterI18n.translate(context, 'home.new_note')),
        ),
        const SizedBox(height: 8),
        Text(
          hint,
          textAlign: TextAlign.center,
          style: GoogleFonts.nunito(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.inkMuted,
          ),
        ),
      ],
    );
  }
}

class _QuoteContent extends StatelessWidget {
  const _QuoteContent({
    required this.quote,
    required this.displayGrade,
  });

  final QuoteModel quote;
  final int displayGrade;

  @override
  Widget build(BuildContext context) {
    final source = (quote.source ?? '').trim();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AutoSizeText(
          quote.text ?? '',
          textAlign: TextAlign.center,
          style: GoogleFonts.nunito(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            height: 1.35,
            color: AppColors.ink,
          ),
          minFontSize: 14,
          maxLines: 8,
        ),
        if (source.isNotEmpty) ...[
          const SizedBox(height: 14),
          Align(
            alignment: Alignment.centerRight,
            child: AutoSizeText(
              '— $source',
              style: GoogleFonts.nunito(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.inkMuted,
                fontStyle: FontStyle.italic,
              ),
              minFontSize: 11,
              maxLines: 2,
            ),
          ),
        ],
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            _gradeLabel(displayGrade),
            key: ValueKey<int>(displayGrade),
            style: GoogleFonts.nunito(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.ink,
            ),
          ),
        ),
      ],
    );
  }

  String _gradeLabel(int grade) {
    if (grade > 0) return '👍 $grade';
    if (grade < 0) return '👎 $grade';
    return '🤷 $grade';
  }
}

class _WelcomeText extends StatelessWidget {
  const _WelcomeText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.nunito(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.inkMuted,
        height: 1.4,
      ),
      minFontSize: 14,
      maxLines: 4,
    );
  }
}
