const mysql = require('mysql');

const con = mysql.createConnection({
    host: process.env.MYSQLHOST || 'localhost',
    user: process.env.MYSQLUSER || 'root',
    password: process.env.MYSQLPASSWORD || '',
    database: process.env.MYSQLDATABASE || 'mydb',
    port: process.env.MYSQLPORT || 3306,
    multipleStatements: true
});

const setupSQL = `
DROP TABLE IF EXISTS installment;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS scheme;
DROP TABLE IF EXISTS user;

CREATE TABLE user (
  user_id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(255) NOT NULL,
  email varchar(255) NOT NULL,
  password varchar(255) NOT NULL,
  PRIMARY KEY (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO user (user_id, name, email, password) VALUES
(1, 'Admin', 'test1@gmail.com', '$2b$10$8EUIb7zL0LZDqKGmhqH0Oe5RlJvL5xJxJxJxJxJxJxJxJxJxJxJxJ');

CREATE TABLE scheme (
  scheme_id int(11) NOT NULL AUTO_INCREMENT,
  scheme_name varchar(255) NOT NULL,
  scheme_amount float NOT NULL,
  scheme_duration int(11) NOT NULL,
  scheme_interest float NOT NULL,
  PRIMARY KEY (scheme_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO scheme (scheme_id, scheme_name, scheme_amount, scheme_duration, scheme_interest) VALUES
(1, 'Housing Loan', 500000, 12, 5),
(2, 'Business Loan', 300000, 6, 7),
(3, 'Education Loan', 150000, 6, 4),
(4, 'Vehicle Loan', 800000, 12, 6);

CREATE TABLE customer (
  cus_id int(11) NOT NULL AUTO_INCREMENT,
  scheme_id int(11) NOT NULL,
  scheme_name varchar(200) NOT NULL,
  scheme_amount float NOT NULL,
  installment_amount float NOT NULL,
  cus_name varchar(255) NOT NULL,
  cus_contact varchar(255) NOT NULL,
  cus_address varchar(255) NOT NULL,
  cus_asset varchar(255) NOT NULL,
  asset_price float NOT NULL,
  img varchar(200) NOT NULL,
  date varchar(255) NOT NULL,
  PRIMARY KEY (cus_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE installment (
  install_id int(11) NOT NULL AUTO_INCREMENT,
  cus_id int(11) NOT NULL,
  amount float NOT NULL,
  date varchar(255) NOT NULL,
  late_fee float NOT NULL DEFAULT 0,
  PRIMARY KEY (install_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
`;

con.connect((err) => {
    if (err) {
        console.error('❌ Connection failed:', err.message);
        process.exit(1);
    }
    
    console.log('✅ Connected to database');
    console.log('📦 Creating tables...');
    
    con.query(setupSQL, (err) => {
        if (err) {
            console.error('❌ Error creating tables:', err.message);
            con.end();
            process.exit(1);
        }
        
        console.log('✅ Database setup complete!');
        console.log('👤 Default user: test1@gmail.com / 12345');
        con.end();
        process.exit(0);
    });
});
