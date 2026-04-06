Table Professor {
  professor_id int [pk]
  professor_name varchar(30)
  department varchar(100)
  salary numeric
  salary_level numeric
  hire_date date
}

Table Student {
  student_id int [pk]
  student_name varchar(100)
  major varchar(100)
}

Table Course {
  course_id int
  section_id int
  professor_id int
  course_name varchar(100)

  indexes {
    (course_id, section_id) [pk]
  }
}

Table Enrollment {
  student_id int
  course_id int
  grade varchar(2)
  points numeric
  enrolled_at date

  indexes {
    (student_id, course_id) [pk]
  }
}

Ref: Enrollment.student_id > Student.student_id
Ref: Course.professor_id > Professor.professor_id