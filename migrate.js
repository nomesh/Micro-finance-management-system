const mysql = require('mysql');
const fs = require('fs');
const path = require('path');

// Database connection using Railway environment variables
const con = mysql.createConnection({
    host: process.env.MYSQLHOST || 'localhost',
    user: process.env.MYSQLUSER || 'root',
    password: process.env.MYSQLPASSWORD || '',
    database: process.env.MYSQLDATABASE || 'mydb',
    port: process.env.MYSQLPORT || 3306,
    multipleStatements: true
});

// Read SQL file
const sqlFile = fs.readFileSync(path.join(__dirname, 'database', 'mydb.sql'), 'utf8');

// Connect and execute
con.connect((err) => {
    if (err) {
        console.error('Error connecting to database:', err);
        process.exit(1);
    }
    
    console.log('Connected to database. Importing schema...');
    
    con.query(sqlFile, (err, results) => {
        if (err) {
            console.error('Error importing schema:', err);
            con.end();
            process.exit(1);
        }
        
        console.log('Database schema imported successfully!');
        con.end();
        process.exit(0);
    });
});
