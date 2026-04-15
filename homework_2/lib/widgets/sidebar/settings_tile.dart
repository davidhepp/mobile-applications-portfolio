import 'package:flutter/material.dart';

class SettingsTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;
  final Widget? trailing;
  final List<Widget>? children;

  const SettingsTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconColor,
    this.trailing,
    this.children,
  });

  @override
  State<SettingsTile> createState() => _SettingsTileState();
}

class _SettingsTileState extends State<SettingsTile> {
  bool _isActive = false;
  bool _isExpanded = false;

  void _handleTap() {
    if (widget.children != null && widget.children!.isNotEmpty) {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    } else {
      widget.onTap();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color iconColor =
        widget.iconColor ?? (_isActive ? Colors.deepPurple : Colors.black54);
    final Color textColor = _isActive
        ? Colors.deepPurple.shade700
        : Colors.black87;

    final tile = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _handleTap,
        onHighlightChanged: (isHighlighted) {
          setState(() {
            _isActive = isHighlighted;
          });
        },
        onHover: (isHovering) {
          setState(() {
            _isActive = isHovering;
          });
        },
        borderRadius: BorderRadius.circular(12),
        hoverColor: Colors.orange.withOpacity(0.1),
        splashColor: Colors.orange.withOpacity(0.1),
        highlightColor: Colors.deepPurple.withOpacity(0.05),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(widget.icon, color: iconColor, size: 22),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (widget.children != null && widget.children!.isNotEmpty)
                AnimatedRotation(
                  turns: _isExpanded ? 0.25 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(
                    Icons.chevron_right,
                    color: Colors.black38,
                    size: 20,
                  ),
                )
              else
                widget.trailing ??
                    const Icon(
                      Icons.chevron_right,
                      color: Colors.black38,
                      size: 20,
                    ),
            ],
          ),
        ),
      ),
    );

    if (widget.children == null || widget.children!.isEmpty) {
      return tile;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        tile,
        if (_isExpanded)
          Padding(
            padding: const EdgeInsets.only(
              left: 48,
              top: 4,
              bottom: 8,
              right: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: widget.children!,
            ),
          ),
      ],
    );
  }
}
