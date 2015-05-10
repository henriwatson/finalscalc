def clean_sections(raw_sections)
  sections = []

  raw_sections.each do |section|
    if section.name == "Advisory" || section.final_grades == nil || !section.final_grades.has_key?('Q1') || !section.final_grades.has_key?('Q2')
      next
    end

    sections << section
  end

  sections
end

def calculate_averages(raw_sections)
  averages = {:gpa => 0, :grade => 0}

  raw_sections.each do |section|
    grade = ((section.final_grades['Q1'] + section.final_grades['Q2'])/2).round
    averages[:gpa] += determine_GPA_value(grade)
    averages[:grade] += grade
  end

  averages[:gpa] = (averages[:gpa] / raw_sections.count).round(2)
  averages[:grade] = (averages[:grade] / raw_sections.count).round(2)

  averages
end

def calculate_exemptions(raw_sections)
  exemption_data = []

  raw_sections.each do |section|
    banned_sections = ['English', 'Algebra', 'Geometry', 'Calculus', 'Physical Education', 'Computer Explorations', 'Art', 'Choir', 'Music', 'Literature', 'Journalism', 'Yearbook', 'Advisory', 'Electricity', 'Health', 'Math', 'Media']
    if banned_sections.any? { |s| section.name.include?(s) }
      next
    end

    if section.final_grades == nil
      next
    end

    current = {}
    current['name'] = section.name
    current['final_grades'] = section.final_grades
    current['final_grades']['S1'] = ((current['final_grades']['Q1'] + current['final_grades']['Q2'])/2).round()

    if current['final_grades']['S1'] >= 90
      current['exemptable'] = true
    else
      current['exemptable'] = false
      current['exempt_needed'] = (((89.5-(current['final_grades']['Q1']/2))*2)-current['final_grades']['Q2'])
    end

    exemption_data.push(current)
  end

  exemption_data
end

def calculate_minimums(raw_sections)
  minimums_data = []

  raw_sections.each do |section|
    banned_sections = ['Physical Education', 'Computer Explorations', 'Art', 'Choir', 'Music', 'Journalism', 'Yearbook', 'Advisory', 'Electricity', 'Health', 'Media']
    if banned_sections.any? { |s| section.name.include?(s) }
      next
    end

    if section.final_grades == nil
      next
    end

    current = {}
    current['name'] = section.name
    current['zerofinal'] = (((section.final_grades['Q1'] + section.final_grades['Q2'])/2)*0.8).round(1)
    current['pelao'] = determine_minimum(section.final_grades['Q1'], section.final_grades['Q2'], 70, false, false)

    minimums_data.push(current)
  end

  minimums_data
end

def calculate_targets(raw_sections)
  targets_data = []

  raw_sections.each do |section|
    banned_sections = ['Physical Education', 'Computer Explorations', 'Art', 'Choir', 'Music', 'Journalism', 'Yearbook', 'Advisory', 'Electricity', 'Health', 'Media']
    if banned_sections.any? { |s| section.name.include?(s) }
      next
    end

    if section.final_grades == nil
      next
    end

    current = {}
    current['name'] = section.name
    current['target'] = {}
    current['target'][70] = determine_minimum(section.final_grades['Q1'], section.final_grades['Q2'], 70)
    current['target'][75] = determine_minimum(section.final_grades['Q1'], section.final_grades['Q2'], 75)
    current['target'][80] = determine_minimum(section.final_grades['Q1'], section.final_grades['Q2'], 80)
    current['target'][85] = determine_minimum(section.final_grades['Q1'], section.final_grades['Q2'], 85)
    current['target'][90] = determine_minimum(section.final_grades['Q1'], section.final_grades['Q2'], 90)
    current['target'][95] = determine_minimum(section.final_grades['Q1'], section.final_grades['Q2'], 95)
    current['target'][100] = determine_minimum(section.final_grades['Q1'], section.final_grades['Q2'], 100)

    targets_data.push(current)
  end

  targets_data
end

def determine_minimum(term1, term2, target = 70, use_blanks = true, show_percent = true)
  c = ((target - (((term1+term2)/2)*0.8))/0.2)


  if c <= 0 && use_blanks
    return ""
  elsif c > 100 && use_blanks
    return ""
  else
    if show_percent
      return c.round(1).to_s + "%"
    else
      return c.round(1)
    end
  end
end


def determine_GPA_value(grade)
  if grade >= 95 && grade <= 100
    return 4.0
  elsif grade >= 90 && grade <= 94
    return 3.7
  elsif grade >= 87 && grade <= 89
    return 3.35
  elsif grade >= 83 && grade <= 86
    return 3.0
  elsif grade >= 80 && grade <= 82
    return 2.7
  elsif grade >= 77 && grade <= 79
    return 2.35
  elsif grade >= 74 && grade <= 76
    return 2.0
  elsif grade >= 70 && grade <= 73
    return 1.7
  else
    return 0
  end
end
