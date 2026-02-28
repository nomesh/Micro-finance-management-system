const mysql = require('mysql');

// Database connection using Railway environment variables
const con = mysql.createConnection({
    host: process.env.MYSQLHOST || 'localhost',
    user: process.env.MYSQLUSER || 'root',
    password: process.env.MYSQLPASSWORD || '',
    database: process.env.MYSQLDATABASE || 'mydb',
    port: process.env.MYSQLPORT || 3306
});

console.log('Attempting to connect with:');
console.log('Host:', process.env.MYSQLHOST || 'localhost');
console.log('User:', process.env.MYSQLUSER || 'root');
console.log('Database:', process.env.MYSQLDATABASE || 'mydb');
console.log('Port:', process.env.MYSQLPORT || 3306);

con.connect((err) => {
    if (err) {
        console.error('Connection failed:', err.message);
        process.exit(1);
    }
    
    console.log('Connected successfully!');
    
    // Check if tables exist
    con.query('SHOW TABLES', (err, results) => {
        if (err) {
            console.error('Error checking tables:', err);
        } else {
            console.log('Existing tables:', results);
        }
        con.end();
    });
});
