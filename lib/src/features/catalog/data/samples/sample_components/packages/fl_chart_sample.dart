import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class _DailySpending {
  const _DailySpending({required this.label, required this.amount});

  /// The [label].
  final String label;

  /// The [amount].
  final double amount;
}

class _MonthlyTrend {
  const _MonthlyTrend({
    required this.label,
    required this.income,
    required this.expense,
  });

  /// The [label].
  final String label;

  /// The [income].
  final double income;

  /// The [expense].
  final double expense;
}

class _BudgetCategory {
  const _BudgetCategory({
    required this.label,
    required this.percentage,
    required this.color,
  });

  /// The [label].
  final String label;

  /// The [percentage].
  final double percentage;

  /// The [color].
  final Color color;
}

class _AdChannel {
  const _AdChannel({
    required this.name,
    required this.spend,
    required this.conversions,
  });

  /// The [name].
  final String name;

  /// The [spend] in dollars.
  final double spend;

  /// The [conversions] count.
  final double conversions;
}

class _CityMetric {
  const _CityMetric({
    required this.name,
    required this.costOfLiving,
    required this.qualityOfLife,
    required this.population,
    required this.color,
  });

  /// The [name].
  final String name;

  /// The [costOfLiving].
  final double costOfLiving;

  /// The [qualityOfLife].
  final double qualityOfLife;

  /// The [population] in millions, used as the bubble size.
  final double population;

  /// The [color].
  final Color color;
}

const _spending = [
  _DailySpending(label: 'Mon', amount: 42),
  _DailySpending(label: 'Tue', amount: 78),
  _DailySpending(label: 'Wed', amount: 25),
  _DailySpending(label: 'Thu', amount: 96),
  _DailySpending(label: 'Fri', amount: 130),
  _DailySpending(label: 'Sat', amount: 61),
  _DailySpending(label: 'Sun', amount: 18),
];

const _trend = [
  _MonthlyTrend(label: 'Jan', income: 3200, expense: 2400),
  _MonthlyTrend(label: 'Feb', income: 3400, expense: 2100),
  _MonthlyTrend(label: 'Mar', income: 3100, expense: 2800),
  _MonthlyTrend(label: 'Apr', income: 3600, expense: 2500),
  _MonthlyTrend(label: 'May', income: 3900, expense: 3000),
  _MonthlyTrend(label: 'Jun', income: 3700, expense: 2200),
];

const _budget = [
  _BudgetCategory(label: 'Housing', percentage: 35, color: Color(0xFF5B8DEF)),
  _BudgetCategory(label: 'Food', percentage: 25, color: Color(0xFFFFA45B)),
  _BudgetCategory(
    label: 'Transport',
    percentage: 15,
    color: Color(0xFF4CD3A5),
  ),
  _BudgetCategory(label: 'Leisure', percentage: 12, color: Color(0xFFB980F0)),
  _BudgetCategory(label: 'Others', percentage: 13, color: Color(0xFF9AA5B1)),
];

const _adChannels = [
  _AdChannel(name: 'Search', spend: 2, conversions: 48),
  _AdChannel(name: 'Social', spend: 3.5, conversions: 52),
  _AdChannel(name: 'Display', spend: 1.5, conversions: 21),
  _AdChannel(name: 'Video', spend: 4, conversions: 66),
  _AdChannel(name: 'Email', spend: 0.5, conversions: 30),
  _AdChannel(name: 'Affiliate', spend: 2.8, conversions: 39),
  _AdChannel(name: 'Referral', spend: 1.2, conversions: 44),
];

const _skillLabels = ['Speed', 'Strength', 'Stamina', 'Agility', 'Focus'];
const _teamASkills = [80, 60, 70, 90, 75];
const _teamBSkills = [60, 85, 65, 55, 80];

const _quarterLabels = ['Q1', 'Q2', 'Q3', 'Q4'];
const _housingByQuarter = [30.0, 32.0, 31.0, 33.0];
const _foodByQuarter = [18.0, 20.0, 22.0, 19.0];
const _transportByQuarter = [10.0, 9.0, 12.0, 11.0];

const _activeUsersDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const _activeUsers = [12.0, 18.0, 15.0, 24.0, 30.0, 26.0, 34.0];

const _cities = [
  _CityMetric(
    name: 'São Paulo',
    costOfLiving: 55,
    qualityOfLife: 62,
    population: 12.3,
    color: Color(0xFF5B8DEF),
  ),
  _CityMetric(
    name: 'Lisbon',
    costOfLiving: 62,
    qualityOfLife: 78,
    population: 0.5,
    color: Color(0xFFFFA45B),
  ),
  _CityMetric(
    name: 'Tokyo',
    costOfLiving: 80,
    qualityOfLife: 85,
    population: 14,
    color: Color(0xFF4CD3A5),
  ),
  _CityMetric(
    name: 'Berlin',
    costOfLiving: 68,
    qualityOfLife: 82,
    population: 3.7,
    color: Color(0xFFB980F0),
  ),
  _CityMetric(
    name: 'Austin',
    costOfLiving: 70,
    qualityOfLife: 75,
    population: 1,
    color: Color(0xFFE0607E),
  ),
];

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlChartSample(),
    ),
  );
}

/// Sample demonstrating `FlChartSample`.
class FlChartSample extends StatelessWidget {
  /// Creates a [FlChartSample].
  const FlChartSample({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 8,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Material(
                child: TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  tabs: [
                    Tab(text: 'Spending'),
                    Tab(text: 'Cash flow'),
                    Tab(text: 'Budget'),
                    Tab(text: 'Marketing'),
                    Tab(text: 'Team skills'),
                    Tab(text: 'Quarterly'),
                    Tab(text: 'Active users'),
                    Tab(text: 'Markets'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _BarChartTab(),
                    _LineChartTab(),
                    _PieChartTab(),
                    _ScatterChartTab(),
                    _RadarChartTab(),
                    _StackedBarChartTab(),
                    _AreaChartTab(),
                    _BubbleChartTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Header shown above every chart, describing what it represents.
class _ChartHeader extends StatelessWidget {
  const _ChartHeader({required this.title, required this.subtitle});

  /// The [title].
  final String title;

  /// The [subtitle].
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: theme.textTheme.titleMedium),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

/// A colored swatch with a label, optionally followed by a value.
class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label, this.value});

  /// The [color].
  final Color color;

  /// The [label].
  final String label;

  /// The optional trailing [value].
  final String? value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: theme.textTheme.bodySmall),
        if (value != null) ...[
          const SizedBox(width: 4),
          Text(
            value!,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ],
    );
  }
}

class _BarChartTab extends StatefulWidget {
  const _BarChartTab();

  @override
  State<_BarChartTab> createState() => _BarChartTabState();
}

class _BarChartTabState extends State<_BarChartTab> {
  int? _touchedIndex;

  double get _total => _spending.fold(0, (sum, day) => sum + day.amount);

  double get _average => _total / _spending.length;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxAmount =
        _spending.map((day) => day.amount).reduce((a, b) => a > b ? a : b);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _ChartHeader(
            title: 'Weekly spending',
            subtitle: 'How much you spent on each day this week',
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 0,
            color: theme.colorScheme.surfaceContainerHighest,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        '\$${_total.toStringAsFixed(2)}',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Daily average',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        '\$${_average.toStringAsFixed(2)}',
                        style: theme.textTheme.titleMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: maxAmount * 1.2,
                gridData: FlGridData(
                  drawVerticalLine: false,
                  horizontalInterval: maxAmount / 3,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: theme.dividerColor.withValues(alpha: 0.4),
                      strokeWidth: 1,
                    );
                  },
                ),
                borderData: FlBorderData(show: false),
                extraLinesData: ExtraLinesData(
                  horizontalLines: [
                    HorizontalLine(
                      y: _average,
                      color: theme.colorScheme.error.withValues(alpha: 0.6),
                      strokeWidth: 1.5,
                      dashArray: [6, 4],
                      label: HorizontalLineLabel(
                        show: true,
                        alignment: Alignment.topRight,
                        style: TextStyle(
                          color: theme.colorScheme.error,
                          fontSize: 10,
                        ),
                        labelResolver: (line) => 'avg',
                      ),
                    ),
                  ],
                ),
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final day = _spending[group.x];
                      return BarTooltipItem(
                        '${day.label}\n\$${day.amount.toStringAsFixed(2)}',
                        const TextStyle(color: Colors.white),
                      );
                    },
                  ),
                  touchCallback: (event, response) {
                    setState(() {
                      _touchedIndex = response?.spot?.touchedBarGroup.x;
                    });
                  },
                ),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(),
                  topTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= _spending.length) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            _spending[index].label,
                            style: theme.textTheme.bodySmall,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                barGroups: [
                  for (var i = 0; i < _spending.length; i++)
                    BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: _spending[i].amount,
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: i == _touchedIndex
                                ? [
                                    theme.colorScheme.tertiary,
                                    theme.colorScheme.tertiary
                                        .withValues(alpha: 0.6),
                                  ]
                                : [
                                    theme.colorScheme.primary,
                                    theme.colorScheme.primary
                                        .withValues(alpha: 0.6),
                                  ],
                          ),
                          width: 20,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LineChartTab extends StatelessWidget {
  const _LineChartTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lastMonth = _trend.last;
    final saved = lastMonth.income - lastMonth.expense;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _ChartHeader(
            title: 'Cash flow',
            subtitle: 'Income vs. expenses over the last 6 months',
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const _LegendItem(color: Colors.green, label: 'Income'),
              const SizedBox(width: 20),
              const _LegendItem(color: Colors.redAccent, label: 'Expense'),
              const SizedBox(width: 20),
              _LegendItem(
                color: theme.colorScheme.primary,
                label: 'Saved in Jun',
                value: '\$${saved.toStringAsFixed(0)}',
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: theme.dividerColor.withValues(alpha: 0.4),
                      strokeWidth: 1,
                    );
                  },
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(),
                  topTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= _trend.length) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            _trend[index].label,
                            style: theme.textTheme.bodySmall,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        return LineTooltipItem(
                          '\$${spot.y.toStringAsFixed(0)}',
                          const TextStyle(color: Colors.white),
                        );
                      }).toList();
                    },
                  ),
                ),
                lineBarsData: [
                  _buildLine(
                    color: Colors.green,
                    values: [for (final month in _trend) month.income],
                  ),
                  _buildLine(
                    color: Colors.redAccent,
                    values: [for (final month in _trend) month.expense],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  LineChartBarData _buildLine({
    required Color color,
    required List<double> values,
  }) {
    return LineChartBarData(
      isCurved: true,
      color: color,
      barWidth: 3,
      dotData: FlDotData(
        checkToShowDot: (spot, barData) => spot.x == values.length - 1,
      ),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color.withValues(alpha: 0.18),
            color.withValues(alpha: 0),
          ],
        ),
      ),
      spots: [
        for (var i = 0; i < values.length; i++) FlSpot(i.toDouble(), values[i]),
      ],
    );
  }
}

class _PieChartTab extends StatefulWidget {
  const _PieChartTab();

  @override
  State<_PieChartTab> createState() => _PieChartTabState();
}

class _PieChartTabState extends State<_PieChartTab> {
  int? _touchedIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sorted = [..._budget]
      ..sort((a, b) => b.percentage.compareTo(a.percentage));

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _ChartHeader(
            title: 'Budget breakdown',
            subtitle: "Where this month's budget is going",
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PieChart(
                        PieChartData(
                          sectionsSpace: 3,
                          centerSpaceRadius: 52,
                          pieTouchData: PieTouchData(
                            touchCallback: (event, response) {
                              setState(() {
                                _touchedIndex = response
                                    ?.touchedSection?.touchedSectionIndex;
                              });
                            },
                          ),
                          sections: [
                            for (var i = 0; i < _budget.length; i++)
                              PieChartSectionData(
                                value: _budget[i].percentage,
                                color: _budget[i].color,
                                radius: i == _touchedIndex ? 64 : 56,
                                showTitle: false,
                              ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Total',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          Text(
                            r'$2,850',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (final category in sorted)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: _LegendItem(
                          color: category.color,
                          label: category.label,
                          value: '${category.percentage.toInt()}%',
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ScatterChartTab extends StatelessWidget {
  const _ScatterChartTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _ChartHeader(
            title: 'Marketing performance',
            subtitle: r'Ad spend (in $K) vs. conversions, by channel',
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ScatterChart(
              ScatterChartData(
                gridData: FlGridData(
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: theme.dividerColor.withValues(alpha: 0.4),
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: theme.dividerColor.withValues(alpha: 0.4),
                      strokeWidth: 1,
                    );
                  },
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: theme.textTheme.bodySmall,
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            '\$${value.toInt()}K',
                            style: theme.textTheme.bodySmall,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                scatterTouchData: ScatterTouchData(
                  touchTooltipData: ScatterTouchTooltipData(
                    getTooltipItems: (spot) {
                      final channel = _adChannels.firstWhere(
                        (channel) =>
                            channel.spend == spot.x &&
                            channel.conversions == spot.y,
                      );
                      return ScatterTooltipItem(
                        '${channel.name}\n${channel.conversions.toInt()} '
                        'conversions',
                        textStyle: const TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ),
                scatterSpots: [
                  for (final channel in _adChannels)
                    ScatterSpot(
                      channel.spend,
                      channel.conversions,
                      dotPainter: FlDotCirclePainter(
                        color: theme.colorScheme.primary,
                        radius: 7,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RadarChartTab extends StatelessWidget {
  const _RadarChartTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _ChartHeader(
            title: 'Team skill comparison',
            subtitle: 'Latest performance review, team A vs. team B',
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _LegendItem(color: theme.colorScheme.primary, label: 'Team A'),
              const SizedBox(width: 24),
              _LegendItem(
                color: theme.colorScheme.tertiary,
                label: 'Team B',
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: RadarChart(
              RadarChartData(
                radarShape: RadarShape.polygon,
                tickCount: 4,
                ticksTextStyle: const TextStyle(
                  color: Colors.transparent,
                  fontSize: 0,
                ),
                radarBorderData: const BorderSide(color: Colors.transparent),
                gridBorderData: BorderSide(
                  color: theme.dividerColor.withValues(alpha: 0.6),
                ),
                titleTextStyle: theme.textTheme.bodySmall,
                titlePositionPercentageOffset: 0.15,
                getTitle: (index, angle) {
                  return RadarChartTitle(text: _skillLabels[index]);
                },
                dataSets: [
                  RadarDataSet(
                    fillColor: theme.colorScheme.primary.withValues(
                      alpha: 0.2,
                    ),
                    borderColor: theme.colorScheme.primary,
                    borderWidth: 2,
                    entryRadius: 3,
                    dataEntries: [
                      for (final value in _teamASkills)
                        RadarEntry(value: value.toDouble()),
                    ],
                  ),
                  RadarDataSet(
                    fillColor: theme.colorScheme.tertiary.withValues(
                      alpha: 0.2,
                    ),
                    borderColor: theme.colorScheme.tertiary,
                    borderWidth: 2,
                    entryRadius: 3,
                    dataEntries: [
                      for (final value in _teamBSkills)
                        RadarEntry(value: value.toDouble()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StackedBarChartTab extends StatelessWidget {
  const _StackedBarChartTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _ChartHeader(
            title: 'Quarterly expenses',
            subtitle: 'Spending by category, broken down per quarter',
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _LegendItem(color: Color(0xFF5B8DEF), label: 'Housing'),
              SizedBox(width: 16),
              _LegendItem(color: Color(0xFFFFA45B), label: 'Food'),
              SizedBox(width: 16),
              _LegendItem(color: Color(0xFF4CD3A5), label: 'Transport'),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                gridData: FlGridData(
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: theme.dividerColor.withValues(alpha: 0.4),
                      strokeWidth: 1,
                    );
                  },
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(),
                  topTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= _quarterLabels.length) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            _quarterLabels[index],
                            style: theme.textTheme.bodySmall,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                barGroups: [
                  for (var i = 0; i < _quarterLabels.length; i++)
                    BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: _housingByQuarter[i] +
                              _foodByQuarter[i] +
                              _transportByQuarter[i],
                          width: 26,
                          borderRadius: BorderRadius.circular(6),
                          rodStackItems: [
                            BarChartRodStackItem(
                              0,
                              _housingByQuarter[i],
                              const Color(0xFF5B8DEF),
                            ),
                            BarChartRodStackItem(
                              _housingByQuarter[i],
                              _housingByQuarter[i] + _foodByQuarter[i],
                              const Color(0xFFFFA45B),
                            ),
                            BarChartRodStackItem(
                              _housingByQuarter[i] + _foodByQuarter[i],
                              _housingByQuarter[i] +
                                  _foodByQuarter[i] +
                                  _transportByQuarter[i],
                              const Color(0xFF4CD3A5),
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AreaChartTab extends StatelessWidget {
  const _AreaChartTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final peakDay = _activeUsersDays[_activeUsers.indexOf(
      _activeUsers.reduce((a, b) => a > b ? a : b),
    )];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ChartHeader(
            title: 'Active users',
            subtitle: 'Daily active users this week · peak on $peakDay',
          ),
          const SizedBox(height: 24),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: theme.dividerColor.withValues(alpha: 0.4),
                      strokeWidth: 1,
                    );
                  },
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(),
                  topTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= _activeUsersDays.length) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            _activeUsersDays[index],
                            style: theme.textTheme.bodySmall,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        return LineTooltipItem(
                          '${spot.y.toInt()}k users',
                          const TextStyle(color: Colors.white),
                        );
                      }).toList();
                    },
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    color: theme.colorScheme.primary,
                    barWidth: 3,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          theme.colorScheme.primary.withValues(alpha: 0.35),
                          theme.colorScheme.primary.withValues(alpha: 0),
                        ],
                      ),
                    ),
                    spots: [
                      for (var i = 0; i < _activeUsers.length; i++)
                        FlSpot(i.toDouble(), _activeUsers[i]),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BubbleChartTab extends StatelessWidget {
  const _BubbleChartTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _ChartHeader(
            title: 'Where to relocate?',
            subtitle: 'Cost of living vs. quality of life · size = population',
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ScatterChart(
              ScatterChartData(
                minX: 40,
                maxX: 95,
                minY: 50,
                maxY: 95,
                gridData: FlGridData(
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: theme.dividerColor.withValues(alpha: 0.4),
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: theme.dividerColor.withValues(alpha: 0.4),
                      strokeWidth: 1,
                    );
                  },
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    axisNameWidget: Text(
                      'Quality of life',
                      style: theme.textTheme.bodySmall,
                    ),
                    axisNameSize: 20,
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      interval: 15,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: theme.textTheme.bodySmall,
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                  bottomTitles: AxisTitles(
                    axisNameWidget: Text(
                      'Cost of living',
                      style: theme.textTheme.bodySmall,
                    ),
                    axisNameSize: 20,
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      interval: 15,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            value.toInt().toString(),
                            style: theme.textTheme.bodySmall,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                scatterTouchData: ScatterTouchData(
                  touchTooltipData: ScatterTouchTooltipData(
                    getTooltipItems: (spot) {
                      final city = _cities.firstWhere(
                        (city) =>
                            city.costOfLiving == spot.x &&
                            city.qualityOfLife == spot.y,
                      );
                      return ScatterTooltipItem(
                        '${city.name}\n${city.population} M people',
                        textStyle: const TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ),
                scatterSpots: [
                  for (final city in _cities)
                    ScatterSpot(
                      city.costOfLiving,
                      city.qualityOfLife,
                      dotPainter: FlDotCirclePainter(
                        color: city.color.withValues(alpha: 0.75),
                        radius: city.population * 1.2 + 10,
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 4,
            children: [
              for (final city in _cities)
                _LegendItem(color: city.color, label: city.name),
            ],
          ),
        ],
      ),
    );
  }
}
