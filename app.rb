require 'sinatra'
require 'powerapi'

require './parser'

get '/' do
  erb :home
end

post '/calc' do
  begin
    student = PowerAPI.authenticate("http://powerschool.example", params[:username], params[:password])
  rescue PowerAPI::Exception => error_message
    return erb :home, locals: { error_message: error_message }
  end

  # Make sure the user is a highschooler before processing their data.
  if student.information["gradeLevel"] < 9
    return erb :home, locals: {
      error_message:
        "Sorry! The Finals Calculator is only available to students in high
        school. It seems you're in grade " +
        student.information["gradeLevel"].to_s + "."
    }
  end

  # Get rid of scheduling sections and other non-academic sections.
  sections = clean_sections(student.sections)

  # Calculate averages.
  averages = calculate_averages(sections)

  # Exemptions.
  exemption_data = calculate_exemptions(sections)

  # Bare Minimums.
  minimums_data = calculate_minimums(sections)

  # Final Targets.
  targets_data = calculate_targets(sections)

  # Here we go!
  erb :calc, locals: {
    student: student,
    section_count: sections.count,
    gpa: averages[:gpa],
    grade_average: averages[:grade],
    exemption_data: exemption_data,
    minimums_data: minimums_data,
    targets_data: targets_data
  }
end
