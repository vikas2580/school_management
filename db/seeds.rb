User.create!(
  email: 'admin2@example.com',
  password: 'password',
  role: :admin
)

User.create!(
  email: 'school_admin@example.com',
  password: 'password',
  role: :school_admin
)

User.create!(
  email: 'student2@example.com',
  password: 'password',
  role: :student
)
