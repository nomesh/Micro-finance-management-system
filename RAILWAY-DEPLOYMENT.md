# Railway Deployment Guide

Complete guide to deploy the Microfinance Management System on Railway.app

## Prerequisites

- GitHub account
- Railway account (sign up at [railway.app](https://railway.app))
- Repository pushed to GitHub

## Deployment Steps

### Step 1: Create Railway Project

1. Go to [railway.app](https://railway.app)
2. Click **Sign in with GitHub**
3. Authorize Railway to access your repositories
4. Click **New Project**
5. Select **Deploy from GitHub repo**
6. Choose `nomesh/Micro-finance-management-system` from the list
7. Click **Deploy Now**

Railway will automatically detect the Node.js application and start building.

### Step 2: Add MySQL Database

1. In your Railway project dashboard, click **New**
2. Select **Database**
3. Choose **Add MySQL**
4. Railway will provision a MySQL database instance

The database service will appear as a new card in your project.

### Step 3: Import Database Schema

1. Click on the **MySQL** service card
2. Navigate to the **Data** tab
3. Click **Query** button
4. Open `database/mydb.sql` from your local repository
5. Copy the entire SQL content
6. Paste into the Railway query editor
7. Click **Run Query** to execute

This creates all necessary tables and inserts default data.

### Step 4: Verify Environment Variables

Railway automatically connects your app to MySQL by setting these variables:

- `MYSQLHOST` - Database hostname
- `MYSQLUSER` - Database username
- `MYSQLPASSWORD` - Database password
- `MYSQLDATABASE` - Database name
- `MYSQLPORT` - Database port (usually 3306)
- `PORT` - Application port

To verify:
1. Click on your **app service** (not the database)
2. Go to **Variables** tab
3. Confirm all MySQL variables are present

### Step 5: Generate Public Domain

1. Click on your **app service**
2. Go to **Settings** tab
3. Scroll to **Networking** section
4. Click **Generate Domain**
5. Railway will provide a public URL (e.g., `your-app.up.railway.app`)

### Step 6: Access Your Application

1. Click the generated domain URL or copy it to your browser
2. The application should load
3. Login with default credentials:
   - **Email**: `test1@gmail.com`
   - **Password**: `12345`

## Troubleshooting

### Build Fails

- Check **Deployments** tab for error logs
- Ensure `package.json` has correct start script
- Verify all dependencies are listed

### Database Connection Error

- Confirm MySQL service is running (green status)
- Check that environment variables are set
- Verify `server.js` reads Railway's environment variables

### Application Won't Start

- Check **Logs** in the deployment
- Ensure `PORT` environment variable is used in `server.js`
- Verify Node.js version compatibility

## Post-Deployment

### Change Default Password

1. Login with default credentials
2. Navigate to user settings
3. Update password immediately

### Monitor Application

- Use Railway **Metrics** tab to monitor:
  - CPU usage
  - Memory usage
  - Request volume
- Check **Logs** for errors

### Update Application

1. Push changes to GitHub repository
2. Railway automatically detects and redeploys
3. Monitor deployment in Railway dashboard

## Cost

- Railway offers a free tier with usage limits
- Monitor usage in **Account Settings** → **Usage**
- Upgrade to paid plan if needed

## Support

- Railway Documentation: [docs.railway.app](https://docs.railway.app)
- Railway Discord: [discord.gg/railway](https://discord.gg/railway)
- Project Issues: [GitHub Issues](https://github.com/nomesh/Micro-finance-management-system/issues)
