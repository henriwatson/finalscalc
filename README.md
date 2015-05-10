The Finals Calculator
======================
The Finals Calculator is a Sinatra web application that allows users to quickly
predict their final semester grades as well as quickly discover important information
about their final exams.

Your High School
-----------------
The Finals Calculator uses [PowerAPI-ruby](https://github.com/powerapi/powerapi-ruby)
to connect to a PowerSchool installation and download grade information. Your school
must run PowerSchool 7 or newer and must support Mobile Services.

Set your high school's PowerSchool install URL on line 12 of `app.rb`. Do not
include anything after the domain name (for example: https://powerschool.example
is acceptable).

This git repository contains a version of TFC that is built with assumptions based
off of the author's high school.

Unweighed GPA is calculated using the following table.

Min Score | Max Score | GPA Value
----------|-----------|-----------
95        | 100       | 4.0
90        | 94        | 3.70
87        | 89        | 3.35
83        | 86        | 3.00
80        | 82        | 2.70
77        | 79        | 2.35
74        | 76        | 2.00
70        | 73        | 1.70
0         | 69        | 0.00

TFC assumes your semester grades are broken into three pieces.

Piece      | % of Semester
-----------|---------------
Quarter 1  | 40%
Quarter 2  | 40%
Final Exam | 20%

TFC also assumes that final exams can be exempted if the averages of the first
and second quarters equal or exceed 90%.

Thank You
-----------
The Finals Calculator is a project I ran at my high school from my freshman year
in 2011 until my senior year in 2015. Originally written in PHP, then Python, and
finally Ruby. TFC also spun off a sister project, PowerAPI, which is still the only
way for students to access their own data from PowerSchool installs. I want to thank
all my classmates for their endless support and willingness to put up with the
occasional bug.

> Wait, hang on. A freshman made this?!
