import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Map<String, dynamic> _answers = {};

  // Custom color palette matching dashboard
  final Color backgroundColor1 = const Color(0xFF2F4F2F);
  final Color backgroundColor2 = const Color(0xFF5C4033);
  final Color backgroundColor3 = const Color(0xFF3F513A);
  final Color iconColor = const Color(0xFF4A4A4A);
  final Color textColor = const Color(0xFFFFFFF0); // Ivory
  final Color cardColor = Colors.black54;
  final Color accentColor = const Color(0xFFDCDCDC);

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What is your age?',
      'type': 'number',
      'hint': 'Enter your age',
    },
    {
      'question': 'What is your gender?',
      'type': 'radio',
      'options': ['Male', 'Female', 'Other'],
    },
    {
      'question': 'What is your height?',
      'type': 'measurement',
      'units': ['cm', 'ft/in'],
    },
    {
      'question': 'What is your weight?',
      'type': 'measurement',
      'units': ['kg', 'lbs'],
    },
    {
      'question': 'How active are you?',
      'type': 'radio',
      'options': [
        'Sedentary (little or no exercise)',
        'Lightly active (1–3 days of light exercise)',
        'Moderately active (3–5 days of moderate exercise)',
        'Very active (6–7 days of hard exercise)',
        'Super active (intense training, sports, or physical job)',
      ],
    },
    {
      'question': 'What is your goal?',
      'type': 'radio',
      'options': [
        'Lose weight',
        'Maintain weight',
        'Gain muscle',
      ],
    },
    {
      'question': 'How many hours do you sleep on average per night?',
      'type': 'number',
      'hint': 'Enter hours of sleep',
    },
    {
      'question': 'Do you have any dietary restrictions?',
      'type': 'checkbox',
      'options': [
        'Vegetarian',
        'Vegan',
        'Gluten-free',
        'Dairy-free',
        'Nut allergy',
        'No restrictions',
      ],
    },
    {
      'question': 'How many meals do you prefer to eat in a day?',
      'type': 'radio',
      'options': ['2', '3', '4', '5+'],
    },
    {
      'question': 'How much water do you drink daily?',
      'type': 'measurement',
      'units': ['glasses', 'liters'],
    },
    {
      'question': 'Do you have any medical conditions we should consider?',
      'type': 'text',
      'hint': 'Enter medical conditions (if any)',
    },
    {
      'question':
          'Are you currently following a specific diet or fitness program?',
      'type': 'boolean',
      'followUp': 'text',
      'hint': 'Enter program details',
    },
    {
      'question': 'How intense do you want your workout recommendations to be?',
      'type': 'radio',
      'options': [
        'Light (Walking, Yoga, Stretching)',
        'Moderate (Running, Strength Training)',
        'Intense (HIIT, Weightlifting)',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [backgroundColor1, backgroundColor3, backgroundColor2],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: textColor),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      "Profile Setup",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Progress Indicator
              LinearProgressIndicator(
                value: (_currentPage + 1) / questions.length,
                backgroundColor: cardColor,
                valueColor: AlwaysStoppedAnimation<Color>(accentColor),
              ),

              // Questions
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: questions.length,
                  onPageChanged: (int page) {
                    setState(() => _currentPage = page);
                  },
                  itemBuilder: (context, index) {
                    return _buildQuestionCard(questions[index]);
                  },
                ),
              ),

              // Navigation Buttons
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_currentPage > 0)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: cardColor,
                          foregroundColor: textColor,
                        ),
                        onPressed: _previousPage,
                        child: Text('Previous'),
                      ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cardColor,
                        foregroundColor: textColor,
                      ),
                      onPressed: _nextPage,
                      child: Text(_currentPage == questions.length - 1
                          ? 'Finish'
                          : 'Next'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCard(Map<String, dynamic> question) {
    return Card(
      margin: EdgeInsets.all(20),
      color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question['question'],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            SizedBox(height: 20),
            _buildInputWidget(question),
          ],
        ),
      ),
    );
  }

  Widget _buildInputWidget(Map<String, dynamic> question) {
    switch (question['type']) {
      case 'number':
        return TextField(
          keyboardType: TextInputType.number,
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            hintText: question['hint'],
            hintStyle: TextStyle(color: accentColor.withOpacity(0.5)),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: accentColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: accentColor),
            ),
          ),
          onChanged: (value) {
            _answers[question['question']] = value;
          },
        );

      case 'radio':
        return Column(
          children: question['options'].map<Widget>((option) {
            return RadioListTile(
              title: Text(option, style: TextStyle(color: textColor)),
              value: option,
              groupValue: _answers[question['question']],
              activeColor: accentColor,
              onChanged: (value) {
                setState(() {
                  _answers[question['question']] = value;
                });
              },
            );
          }).toList(),
        );

      case 'checkbox':
        return Column(
          children: question['options'].map<Widget>((option) {
            return CheckboxListTile(
              title: Text(option, style: TextStyle(color: textColor)),
              value: (_answers[question['question']] ?? []).contains(option),
              activeColor: accentColor,
              onChanged: (bool? value) {
                setState(() {
                  if (_answers[question['question']] == null) {
                    _answers[question['question']] = [];
                  }
                  if (value!) {
                    _answers[question['question']].add(option);
                  } else {
                    _answers[question['question']].remove(option);
                  }
                });
              },
            );
          }).toList(),
        );

      case 'measurement':
        return Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                hintText: 'Enter value',
                hintStyle: TextStyle(color: accentColor.withOpacity(0.5)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: accentColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: accentColor),
                ),
              ),
              onChanged: (value) {
                _answers[question['question']] = value;
              },
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: _answers[question['question'] + '_unit'],
              hint: Text('Select unit', style: TextStyle(color: accentColor)),
              items: question['units']
                  .map<DropdownMenuItem<String>>((String unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit, style: TextStyle(color: textColor)),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _answers[question['question'] + '_unit'] = value;
                });
              },
              style: TextStyle(color: textColor),
              dropdownColor: cardColor,
            ),
          ],
        );

      case 'boolean':
        return Column(
          children: [
            SwitchListTile(
              title: Text('Yes/No', style: TextStyle(color: textColor)),
              value: _answers[question['question']] ?? false,
              activeColor: accentColor,
              onChanged: (bool value) {
                setState(() {
                  _answers[question['question']] = value;
                });
              },
            ),
            if ((_answers[question['question']] ?? false) &&
                question['followUp'] == 'text')
              TextField(
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  hintText: question['hint'],
                  hintStyle: TextStyle(color: accentColor.withOpacity(0.5)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: accentColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: accentColor),
                  ),
                ),
                onChanged: (value) {
                  _answers[question['question'] + '_details'] = value;
                },
              ),
          ],
        );

      default:
        return TextField(
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            hintText: question['hint'],
            hintStyle: TextStyle(color: accentColor.withOpacity(0.5)),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: accentColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: accentColor),
            ),
          ),
          onChanged: (value) {
            _answers[question['question']] = value;
          },
        );
    }
  }

  void _nextPage() {
    if (_currentPage < questions.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Handle quiz completion
      print(_answers);
      // You can navigate to the next screen or process the answers here
      Navigator.pop(context, _answers);
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
