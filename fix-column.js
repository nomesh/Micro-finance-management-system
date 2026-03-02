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
    
    console.log('Connected. Checking table structure...');
    
    con.query('DESCRIBE user', (err, result) => {
        if (err) {
            console.error('Failed to describe table:', err.message);
            con.end();
            process.exit(1);
        }
        
        console.log('Table columns:', result);
        const passwordColumn = result.find(col => col.Field.toLowerCase().includes('pass'));
        
        if (passwordColumn) {
            console.log('Password column found:', passwordColumn.Field);
            console.log('Column type:', passwordColumn.Type);
            
            // Fix column length if needed
            if (passwordColumn.Type.includes('varchar') && !passwordColumn.Type.includes('255')) {
                console.log('Extending password column...');
                con.query(
                    `ALTER TABLE user MODIFY ${passwordColumn.Field} VARCHAR(255)`,
                    (err) => {
                        if (err) {
                            console.error('Column modification failed:', err.message);
                        } else {
                            console.log('✅ Password column extended to 255 characters');
                        }
                        con.end();
                        process.exit(0);
                    }
                );
            } else {
                console.log('✅ Password column length is OK');
                con.end();
                process.exit(0);
            }
        } else {
            console.error('❌ No password column found!');
            con.end();
            process.exit(1);
        }
    });
});
