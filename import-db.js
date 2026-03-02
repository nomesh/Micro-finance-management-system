const mysql = require('mysql2');
const fs = require('fs');

const con = mysql.createConnection({
    host: process.env.MYSQLHOST || 'localhost',
    user: process.env.MYSQLUSER || 'root',
    password: process.env.MYSQLPASSWORD || '',
    database: process.env.MYSQLDATABASE || 'railway',
    port: process.env.MYSQLPORT || 3306,
    multipleStatements: true
});

console.log('Connecting to database...');
con.connect((err) => {
    if (err) {
        console.error('Connection failed:', err);
        process.exit(1);
    }
    
    console.log('Connected! Reading SQL file...');
    const sql = fs.readFileSync('./database/mydb.sql', 'utf8');
    
    console.log('Importing database schema...');
    con.query(sql, (error, results) => {
        if (error) {
            console.error('Import failed:', error);
            process.exit(1);
        }
        
        console.log('✅ Database imported successfully!');
        con.end();
    });
});
