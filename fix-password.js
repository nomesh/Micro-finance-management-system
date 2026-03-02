const mysql = require('mysql2');
const bcrypt = require('bcrypt');

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
    
    console.log('Connected. Generating password hash...');
    
    bcrypt.hash('12345', 10, (err, hash) => {
        if (err) {
            console.error('Hash generation failed:', err);
            con.end();
            process.exit(1);
        }
        
        console.log('Hash generated:', hash);
        console.log('Updating user password...');
        
        con.query(
            `UPDATE user SET pass = ? WHERE email = 'test1@gmail.com'`,
            [hash],
            (err, result) => {
                if (err) {
                    console.error('Update failed:', err.message);
                } else {
                    console.log('✅ Password updated successfully!');
                    console.log('You can now login with: test1@gmail.com / 12345');
                }
                con.end();
                process.exit(0);
            }
        );
    });
});
