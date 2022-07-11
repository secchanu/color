import 'dart:ui';
import 'dart:math' as math;

class ColorUtil {
  Color _color = const Color(0xFF000000);

  String get hex => _color.value.toRadixString(16).substring(2);

  int get r => _color.red;
  int get g => _color.green;
  int get b => _color.blue;

  int get c => (toCMYK()[0] * 100).round();
  int get m => (toCMYK()[1] * 100).round();
  int get y => (toCMYK()[2] * 100).round();
  int get k => (toCMYK()[3] * 100).round();

  int get vh => toHSV()[0] as int;
  int get vs => (toHSV()[1] * 100).round();
  int get vv => (toHSV()[2] * 100).round();

  int get lh => toHSL()[0] as int;
  int get ls => (toHSL()[1] * 100).round();
  int get ll => (toHSL()[2] * 100).round();

  String getString(String template) {
    final RegExp reg = RegExp(r'\${(.+?)}');
    return template.replaceAllMapped(reg, (match) {
      return (() {
        switch (match[1]) {
          case 'hex':
            return hex;
          case 'HEX':
            return hex.toUpperCase();

          case 'r':
            return r.toString();
          case 'g':
            return g.toString();
          case 'b':
            return b.toString();
          case 'rr':
            return r.toRadixString(16).padLeft(2, '0');
          case 'gg':
            return g.toRadixString(16).padLeft(2, '0');
          case 'bb':
            return b.toRadixString(16).padLeft(2, '0');
          case 'RR':
            return r.toRadixString(16).padLeft(2, '0').toUpperCase();
          case 'GG':
            return g.toRadixString(16).padLeft(2, '0').toUpperCase();
          case 'BB':
            return b.toRadixString(16).padLeft(2, '0').toUpperCase();

          case 'c':
            return c.toString();
          case 'm':
            return m.toString();
          case 'y':
            return y.toString();
          case 'k':
            return k.toString();
          case '.c':
            return (c / 100).toString();
          case '.m':
            return (m / 100).toString();
          case '.y':
            return (y / 100).toString();
          case '.k':
            return (k / 100).toString();

          case 'vh':
            return vh.toString();
          case 'vs':
            return vs.toString();
          case 'vv':
            return vv.toString();
          case '.vs':
            return (vs / 100).toString();
          case '.vv':
            return (vv / 100).toString();

          case 'lh':
            return lh.toString();
          case 'ls':
            return ls.toString();
          case 'll':
            return ll.toString();
          case '.ls':
            return (ls / 100).toString();
          case '.ll':
            return (ll / 100).toString();

          default:
            return match[0].toString();
        }
      })();
    });
  }

  ColorUtil fromColor(Color color) {
    _color = color;
    return this;
  }

  Color toColor() {
    return _color;
  }

  ColorUtil fromHex(String hex) {
    final int tryCode = int.tryParse(hex.toUpperCase(), radix: 16) ?? 0;
    final int code = 0xFF000000 | tryCode;
    _color = Color(code);
    return this;
  }

  String toHex() {
    return hex;
  }

  ColorUtil fromRGB(int r, int g, int b) {
    _color = Color.fromRGBO(r, g, b, 1);
    return this;
  }

  List<int> toRGB() {
    return [r, g, b];
  }

  ColorUtil fromCMYK(double c, double m, double y, double k) {
    final double ik = 1 - k;
    final int r = (255 * (1 - c) * ik).round();
    final int g = (255 * (1 - m) * ik).round();
    final int b = (255 * (1 - y) * ik).round();
    _color = Color.fromRGBO(r, g, b, 1);
    return this;
  }

  List<double> toCMYK() {
    final double r = this.r / 255;
    final double g = this.g / 255;
    final double b = this.b / 255;
    final double max = math.max(r, math.max(g, b));
    final double k = 1 - max;
    final double c = 1 - (r / max);
    final double m = 1 - (g / max);
    final double y = 1 - (b / max);
    return [c, m, y, k];
  }

  ColorUtil fromHSV(int h, double s, double v) {
    final double c = v * s;
    final double x = c * (1 - ((h / 60) % 2 - 1).abs());
    final double m = v - c;
    List<double> rgb = [];
    if (h < 60) {
      rgb = [c, x, 0];
    } else if (h < 120) {
      rgb = [x, c, 0];
    } else if (h < 180) {
      rgb = [0, c, x];
    } else if (h < 240) {
      rgb = [0, x, c];
    } else if (h < 300) {
      rgb = [x, 0, c];
    } else {
      rgb = [c, 0, x];
    }
    final int r = (255 * (rgb[0] + m)).round();
    final int g = (255 * (rgb[1] + m)).round();
    final int b = (255 * (rgb[2] + m)).round();
    _color = Color.fromRGBO(r, g, b, 1);
    return this;
  }

  List<num> toHSV() {
    final double r = this.r / 255;
    final double g = this.g / 255;
    final double b = this.b / 255;
    final double max = math.max(r, math.max(g, b));
    final double min = math.min(r, math.min(g, b));
    final double range = max - min;
    final int h = range == 0
        ? 0
        : (60 *
                (r > math.max(g, b)
                    ? ((g - b) / range) % 6
                    : g > b
                        ? ((b - r) / range) + 2
                        : ((r - g) / range) + 4))
            .round();
    final double s = max == 0 ? 0 : range / max;
    final double v = max.toDouble();
    return [h, s, v];
  }

  ColorUtil fromHSL(int h, double s, double l) {
    final double max = 255 * (l + s * (l < 50 ? l : 1 - l));
    final double min = 255 * (l - s * (l < 50 ? l : 1 - l));
    final double range = max - min;
    List<double> rgb = [];
    if (h < 60) {
      rgb = [max, (h / 60) * range + min, min];
    } else if (h < 120) {
      rgb = [((120 - h) / 60) * range + min, max, min];
    } else if (h < 180) {
      rgb = [min, max, ((h - 120) / 60) * range + min];
    } else if (h < 240) {
      rgb = [min, ((240 - h) / 60) * range + min, max];
    } else if (h < 300) {
      rgb = [((h - 240) / 60) * range + min, min, max];
    } else {
      rgb = [max, min, ((360 - h) / 60) * range + min];
    }
    final int r = rgb[0].round();
    final int g = rgb[1].round();
    final int b = rgb[2].round();
    _color = Color.fromRGBO(r, g, b, 1);
    return this;
  }

  List<num> toHSL() {
    final double r = this.r / 255;
    final double g = this.g / 255;
    final double b = this.b / 255;
    final double max = math.max(r, math.max(g, b));
    final double min = math.min(r, math.min(g, b));
    final double range = max - min;
    final int h = range == 0
        ? 0
        : (60 *
                (max == r
                    ? ((g - b) / range) % 6
                    : max == g
                        ? ((b - r) / range) + 2
                        : ((r - g) / range) + 4))
            .round();
    final double l = (max + min) / 2;
    final double s = l <= 127 ? range / (max + min) : range / (510 - max - min);
    return [h, s, l];
  }
}
