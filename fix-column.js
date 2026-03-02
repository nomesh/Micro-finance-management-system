const mysql = require('mysql2');

const con = mysql.createConnection({
    host: process.env.MYSQLHOST || 'localhost',
    user: process.env.MYSQLUSER || 'root',
    password: process.env.MYSQLPASSWORD || '',
    database: process.env.MYSQLDATABASE || 'railway',
    port: process.env.MYSQLPORT || 3306
});

con.connect((err) => {
    if (err) {
        console.error('Connection failed:', err.message);
        process.exit(1);
    }
    
    console.log('Connected. Fixing password column length...');
    
    con.query(
        `ALTER TABLE user MODIFY pass VARCHAR(255)`,
        (err, result) => {
            if (err) {
                console.error('Column modification failed:', err.message);
            } else {
                console.log('✅ Password column extended to 255 characters');
            }
            con.end();
            process.exit(0);
        }
    );
});
