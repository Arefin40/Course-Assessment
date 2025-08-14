% course(ID, Name, Duration, Price, OrganizationID)
course('C1', 'Complete Web Development', 24, 15000, 'ORG1').
course('C2', 'Next Level Web Development', 16, 10000, 'ORG1').

% instructor(Id, Name, Contact, Email)
instructor('I1', 'Rahman', '+880170000001', 'rahman@uap.edu').
instructor('I2', 'Karim',  '+880170000002', 'karim@uap.edu').
instructor('I3', 'Hassan', '+880170000003', 'hassan@uap.edu').

% student(ID, Name, Contact, Email)
student('S1', 'Arefin', '+880180000001', 'arefin@uap.edu').
student('S2', 'Arman',  '+880180000002', 'arman@uap.edu').
student('S3', 'Arafat', '+880180000003', 'arafat@uap.edu').
student('S4', 'Ayman',  '+880180000004', 'ayman@uap.edu').

% enrollment(StudentID, CourseID)
enrollment('S1', 'C1').
enrollment('S2', 'C1').
enrollment('S3', 'C1').
enrollment('S4', 'C2').

% conducts(InstructorID, CourseID)
conducts('I1', 'C1').
conducts('I2', 'C1').
conducts('I3', 'C2').

% milestone(ID, Name, Published_on, CourseID)
milestone('M1',  'HTML & CSS',         '2024-01-15', 'C1').
milestone('M2',  'Flex-box & Grid',    '2024-01-22', 'C1').
milestone('M3',  'Responsive Design',  '2024-01-29', 'C1').
milestone('M4',  'JavaScript',         '2024-02-05', 'C1').
milestone('M5',  'ReactJS',            '2024-02-12', 'C1').
milestone('M6',  'MongoDB',            '2024-02-19', 'C1').
milestone('M7',  'Authentication',     '2024-02-26', 'C1').
milestone('M8',  'Backend API',        '2024-03-04', 'C1').
milestone('M9',  'Backend Security',   '2024-03-11', 'C1').
milestone('M10', 'NextJS',             '2024-03-18', 'C1').
milestone('M11', 'Final Project - 1',  '2024-03-25', 'C1').
milestone('M12', 'Final Project - 2',  '2024-04-01', 'C1').

% assignment(Id, Title, Date, Total_Marks, MilestoneID)
assignment('A1',  'HTML-CSS',           '2024-01-15', 60, 'M1').
assignment('A2',  'Flex-box & Grid',    '2024-01-22', 60, 'M2').
assignment('A3',  'Responsive Design',  '2024-01-29', 60, 'M3').
assignment('A4',  'Javascript',         '2024-02-05', 60, 'M4').
assignment('A5',  'ReactJS',            '2024-02-12', 60, 'M5').
assignment('A6',  'MongoDB',            '2024-02-19', 60, 'M6').
assignment('A7',  'Authentication',     '2024-02-26', 60, 'M7').
assignment('A8',  'Backend API',        '2024-03-04', 60, 'M8').
assignment('A9',  'Backend Security',   '2024-03-11', 60, 'M9').
assignment('A10', 'NextJS',             '2024-03-18', 60, 'M10').
assignment('A11', 'Final Project-1',    '2024-03-25', 60, 'M11').
assignment('A12', 'Final Project-2',    '2024-04-01', 60, 'M12').

% submission(StudentId, AssignmentId, Status, Marks)
submission('S1', 'A1',  'on-time', 58).
submission('S1', 'A2',  'on-time', 53).
submission('S1', 'A3',  'on-time', 47).
submission('S1', 'A4',  'on-time', 60).
submission('S1', 'A5',  'on-time', 55).
submission('S1', 'A6',  'late-1', 40).
submission('S1', 'A7',  'on-time', 49).
submission('S1', 'A8',  'on-time', 57).
submission('S1', 'A9',  'on-time', 58).
submission('S1', 'A10', 'on-time', 52).
submission('S1', 'A11', 'on-time', 50).
submission('S1', 'A12', 'on-time', 59).
% =======================================
submission('S2', 'A1',  'on-time', 54).
submission('S2', 'A2',  'on-time', 49).
submission('S2', 'A3',  'on-time', 57).
submission('S2', 'A4',  'on-time', 45).
submission('S2', 'A5',  'on-time', 60).
submission('S2', 'A6',  'late-2', 26).
submission('S2', 'A7',  'late-1', 50).
submission('S2', 'A8',  'on-time', 47).
submission('S2', 'A9',  'late-1', 46).
submission('S2', 'A10', 'on-time', 60).
submission('S2', 'A11', 'on-time', 59).
submission('S2', 'A12', 'on-time', 47).
% =======================================
submission('S3', 'A1', 'on-time', 48).
submission('S3', 'A2', 'late-1',  40).
submission('S3', 'A3', 'on-time', 55).
submission('S3', 'A4', 'on-time', 51).
submission('S3', 'A5', 'on-time', 46).

% ================= Rules =================
all_assignments_marks(S, Marks) :-
   student(S, _, _, _),
   findall(Mark, submission(S, _, _, Mark), Marks).


submitted_all_assignments(S) :-
   all_assignments_marks(S, Marks),
   length(Marks, Count),
   Count =:= 12.

toFixed(Num, Decimals, Result) :-
   Result is round(Num * 10^Decimals) / 10^Decimals.

avg_list(List, Avg) :-
   sum_list(List, Total),
   length(List, Count),
   (Count =:= 0 -> AvgF = 0.0 ; AvgF is Total / Count),
   toFixed(AvgF, 2, Avg).

average_marks(S) :-
   all_assignments_marks(S, Marks),
   avg_list(Marks, Avg),
   write('Average: '), writeln(Avg).

percentage(S, A, Percentage) :-
   student(S, _, _, _),
   submission(S, A, Time, Marks),
   ( Time == 'on-time' -> P is (Marks / 60) * 100
   ; Time == 'late-1' -> P is (Marks / 50) * 100
   ; Time == 'late-2' -> P is (Marks / 30) * 100
   ; P = 0 ),
   toFixed(P, 2, Percentage).

scic_eligible(S) :-
   all_assignments_marks(S, Marks),
   sum_list(Marks, Total_Marks),
   Total_Marks >= 600,
   avg_list(Marks, Avg_marks),
   Avg_marks >= 50,
   forall(submission(S, A, _, _), (percentage(S, A, P), P >= 50)).

all_scic_eligible_students(Students) :-
   findall(S, (student(S,_,_,_), scic_eligible(S)), Students).

black_belt(S) :-
   scic_eligible(S),
   percentage(S, 'A11', P11), P11 >= 80,
   percentage(S, 'A12', P12), P12 >= 80.

all_black_belt_students(Students) :-
   findall(S, (student(S,_,_,_), black_belt(S)), Students).


max_total([], none, 0).
max_total([S|Rest], TopStudent, MaxMark) :-
   all_assignments_marks(S, Marks),
   sum_list(Marks, TotalMarks),
   max_total(Rest, CurrTop, CurrMax),
   (TotalMarks > CurrMax -> TopStudent = S, MaxMark = TotalMarks ; TopStudent = CurrTop, MaxMark = CurrMax).

best_student(Top, Max) :-
   findall(S, student(S, _, _, _), Students),
   max_total(Students, Top, Max).