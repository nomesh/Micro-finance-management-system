const mysql = require('mysql2/promise');
const bcrypt = require('bcrypt');

async function setup() {
    const connection = await mysql.createConnection({
        host: process.env.MYSQLHOST || 'localhost',
        user: process.env.MYSQLUSER || 'root',
        password: process.env.MYSQLPASSWORD || '',
        database: process.env.MYSQLDATABASE || 'railway',
        port: process.env.MYSQLPORT || 3306
    });

    console.log('=== DATABASE SETUP START ===');
    
    // Step 1: Check user table structure
    console.log('Step 1: Checking user table structure...');
    const [userColumns] = await connection.query('DESCRIBE user');
    console.log('User columns found:', userColumns.map(c => c.Field).join(', '));
    
    const passwordColumn = userColumns.find(col => col.Field.toLowerCase().includes('pass'));
    
    if (!passwordColumn) {
        console.error('❌ No password column found!');
        process.exit(1);
    }
    
    const colName = passwordColumn.Field;
    console.log(`✅ Password column: ${colName} (${passwordColumn.Type})`);
    
    // Step 2: Fix column length if needed
    if (passwordColumn.Type.includes('varchar') && !passwordColumn.Type.includes('255')) {
        console.log('Step 2: Extending password column to 255 chars...');
        await connection.query(`ALTER TABLE user MODIFY ${colName} VARCHAR(255)`);
        console.log('✅ Column extended');
    } else {
        console.log('Step 2: Column length OK');
    }
    
    // Step 3: Set password
    console.log('Step 3: Setting password...');
    const hash = await bcrypt.hash('12345', 10);
    console.log('Hash generated:', hash);
    
    await connection.query(
        `UPDATE user SET ${colName} = ? WHERE email = 'test1@gmail.com'`,
        [hash]
    );
    console.log('✅ Password updated for test1@gmail.com');
    
    // Step 4: Check and fix scheme table structure
    console.log('Step 4: Checking scheme table structure...');
    const [schemeColumns] = await connection.query('DESCRIBE scheme');
    console.log('Scheme columns found:', schemeColumns.map(c => `${c.Field} (${c.Type})`).join(', '));
    
    const requiredColumns = [
        { name: 'r_asset', type: 'FLOAT' },
        { name: 'no_installment', type: 'INT(11)' },
        { name: 'Install_amount', type: 'FLOAT' },
        { name: 'date', type: 'VARCHAR(20)' }
    ];
    
    for (const col of requiredColumns) {
        const exists = schemeColumns.find(c => c.Field === col.name);
        if (!exists) {
            console.log(`Adding missing column: ${col.name}`);
            await connection.query(`ALTER TABLE scheme ADD ${col.name} ${col.type}`);
            console.log(`✅ Added ${col.name}`);
        }
    }
    console.log('✅ Scheme table structure OK');
    
    await connection.end();
    console.log('=== DATABASE SETUP COMPLETE ===\n');
    
    // Step 5: Start server
    require('./server.js');
}

setup().catch(err => {
    console.error('Setup failed:', err);
    process.exit(1);
});
