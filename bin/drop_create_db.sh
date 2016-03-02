#!/bin/bash
# drops the ``seed`` DB, then creates it. Add a super_user

# IMPORTANT: Make sure to set env vars for SEED_DB_USERNAME, SEED_DEFAULTUSER and SEED_DEFAULTUSER_PASS

echo "Dropping db..."
sudo -H -u postgres bash -c 'dropdb seed-deploy'

echo "Creating db..."
sudo -H -u postgres bash -c 'createdb seed-deploy'

echo "Granting privileges..."
psql_command="psql -c \"GRANT ALL PRIVILEGES ON DATABASE \"seed-deploy\" to $SEED_DBUSER;\""
sudo -H -u postgres bash -c '$psql_command'

echo "Move to seed folder"
cd ~/seed

echo "Migrating db..."
python manage.py migrate

echo "Creating default user"
python manage.py create_default_user --username=$SEED_DEFAULTUSER --password=$SEED_DEFAULTUSER_PASS
