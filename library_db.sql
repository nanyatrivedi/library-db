CREATE TABLE categories (
  category_id   SERIAL PRIMARY KEY,
  category_name VARCHAR(50) NOT NULL UNIQUE,
  shelf_section VARCHAR(10),
  max_loan_days INTEGER NOT NULL DEFAULT 14 CHECK (max_loan_days > 0)
);
CREATE TABLE members (
  member_id       SERIAL PRIMARY KEY,
  full_name       VARCHAR(80) NOT NULL,
  email           VARCHAR(120) UNIQUE,
  phone           VARCHAR(20),
  membership_type VARCHAR(20) DEFAULT 'standard',
  joined_on       DATE DEFAULT CURRENT_DATE,
  is_active       BOOLEAN DEFAULT TRUE
);
CREATE TABLE books (
  book_id          SERIAL PRIMARY KEY,
  title            VARCHAR(120) NOT NULL,
  author           VARCHAR(80) NOT NULL,
  isbn             VARCHAR(20) NOT NULL UNIQUE,
  category_id      INTEGER REFERENCES categories(category_id),
  total_copies     INTEGER NOT NULL CHECK (total_copies >= 0),
  available_copies INTEGER DEFAULT 0 CHECK (available_copies >= 0),
  price            NUMERIC(8,2) CHECK (price >= 0)
);
CREATE TABLE borrowing_records (
  record_id   SERIAL PRIMARY KEY,
  member_id   INTEGER NOT NULL REFERENCES members(member_id),
  book_id     INTEGER NOT NULL REFERENCES books(book_id),
  borrowed_on DATE NOT NULL DEFAULT CURRENT_DATE,
  due_on      DATE NOT NULL,
  returned_on DATE,
  status      VARCHAR(20) DEFAULT 'borrowed'
);
CREATE TABLE reservations (
  reservation_id SERIAL PRIMARY KEY,
  member_id      INTEGER NOT NULL REFERENCES members(member_id),
  book_id        INTEGER NOT NULL REFERENCES books(book_id),
  reserved_on    DATE DEFAULT CURRENT_DATE,
  status         VARCHAR(20) DEFAULT 'pending'
);
CREATE TABLE fines (
  fine_id   SERIAL PRIMARY KEY,
  record_id INTEGER NOT NULL REFERENCES borrowing_records(record_id),
  amount    NUMERIC(8,2) NOT NULL CHECK (amount >= 0),
  paid      BOOLEAN DEFAULT FALSE,
  issued_on DATE DEFAULT CURRENT_DATE
);

INSERT INTO categories (category_name, shelf_section, max_loan_days) VALUES
  ('Fiction','FIC',14),('Science','SCI',21),('History','HIS',21),
  ('Children','CHD',7),('Technology','TEC',14);

INSERT INTO members (full_name, email, phone, membership_type, joined_on, is_active) VALUES
  ('Aarav Shah','aarav@gmail.com','555-0101','standard','2026-02-01',TRUE),
  ('Bela Roy','bela@outlook.com','555-0102','premium','2025-09-15',TRUE),
  ('Chen Wu','chen@gmail.com','555-0103','standard','2026-03-10',TRUE),
  ('Diya Nair','diya@gmail.com',NULL,'premium','2025-11-20',TRUE),
  ('Evan Park','evan@yahoo.com','555-0105','standard','2026-01-05',TRUE),
  ('Farah Khan','farah@gmail.com','555-0106','standard','2026-04-22',TRUE),
  ('Gita Rao',NULL,NULL,'standard','2025-12-12',FALSE),
  ('Hugo Lima','hugo@outlook.com','555-0108','premium','2026-05-01',TRUE);

INSERT INTO books (title, author, isbn, category_id, total_copies, available_copies, price) VALUES
  ('The Silent Tide','M. Okafor','978-1000000001',1,4,2,12.50),
  ('Deep Space Primer','R. Castellano','978-1000000002',2,3,0,24.00),
  ('A Short History of Maps','L. Berger','978-1000000003',3,2,1,18.75),
  ('The Little Explorer','P. Mendes','978-1000000004',4,6,6,8.00),
  ('Clean Database Design','S. Nair','978-1000000005',5,5,3,32.00),
  ('The Glass Forest','M. Okafor','978-1000000006',1,3,1,14.20),
  ('Quantum For Everyone','R. Castellano','978-1000000007',2,2,2,27.50),
  ('Empires And Ash','L. Berger','978-1000000008',3,4,0,21.00),
  ('The Clever Robot','P. Mendes','978-1000000009',4,5,5,9.50),
  ('SQL In Practice','S. Nair','978-1000000010',5,3,1,29.00);

INSERT INTO borrowing_records (member_id, book_id, borrowed_on, due_on, returned_on, status) VALUES
  (1,1,'2026-05-02','2026-05-16','2026-05-10','returned'),
  (1,5,'2026-06-01','2026-06-15',NULL,'borrowed'),
  (2,2,'2026-05-20','2026-06-10',NULL,'borrowed'),
  (2,8,'2026-04-18','2026-05-09','2026-05-05','returned'),
  (3,6,'2026-06-03','2026-06-17',NULL,'borrowed'),
  (3,10,'2026-05-12','2026-05-26','2026-05-24','returned'),
  (4,2,'2026-06-05','2026-06-26',NULL,'borrowed'),
  (4,3,'2026-05-01','2026-05-22','2026-05-20','returned'),
  (5,8,'2026-06-10','2026-07-01',NULL,'borrowed'),
  (6,1,'2026-05-25','2026-06-08','2026-06-02','returned'),
  (6,5,'2026-06-12','2026-06-26',NULL,'borrowed'),
  (1,3,'2026-06-14','2026-07-05',NULL,'borrowed');

INSERT INTO reservations (member_id, book_id, reserved_on, status) VALUES
  (5,2,'2026-06-11','pending'),(3,8,'2026-06-12','pending'),(1,2,'2026-06-13','ready');

INSERT INTO fines (record_id, amount, paid, issued_on) VALUES
  (1,2.50,TRUE,'2026-05-11'),(4,1.00,FALSE,'2026-05-10'),(6,0.75,FALSE,'2026-05-25');
