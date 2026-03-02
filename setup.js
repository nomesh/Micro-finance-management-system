const mysql = require('mysql2/promise');
const fs = require('fs');

async function setupDatabase() {
    const connection = await mysql.createConnection({
        host: process.env.MYSQLHOST || 'localhost',
        user: process.env.MYSQLUSER || 'root',
        password: process.env.MYSQLPASSWORD || '',
        database: process.env.MYSQLDATABASE || 'railway',
        port: process.env.MYSQLPORT || 3306,
        multipleStatements: true
    });

    console.log('Connected to database');

    // Check if tables exist
    const [tables] = await connection.query("SHOW TABLES LIKE 'user'");
    
    if (tables.length === 0) {
        console.log('Tables not found. Importing schema...');
        const sql = fs.readFileSync('./database/mydb.sql', 'utf8');
        await connection.query(sql);
        console.log('✅ Database schema imported successfully!');
    } else {
        console.log('✅ Database tables already exist');
    }

    await connection.end();
    
    // Start the main server
    require('./server.js');
}

setupDatabase().catch(err => {
    console.error('Setup failed:', err);
    process.exit(1);
});
