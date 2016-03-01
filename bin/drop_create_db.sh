#!/bin/bash
# drops the ``seed`` DB, then creates it. Add a super_user

# IMPORTANT: Make sure to set SEED_DB_USERNAME and SEED_DB_PASS env variables before running this.

echo "Dropping db..."
sudo -H -u postgres bash -c 'dropdb seed-deploy'

echo "Creating db..."
sudo -H -u postgres bash -c 'createdb seed-deploy'

echo "Granting privileges..."
sudo -H -u postgres bash -c 'psql -c "GRANT ALL PRIVILEGES ON DATABASE \"seed-deploy\" to dev_db_user;"'

echo "Move to seed folder"
cd ~/seed

echo "Migrating db..."
python manage.py migrate

echo "Creating default user"
python manage.py create_default_user --username=$SEED_DB_USERNAME --password=$SEED_DB_PASS
