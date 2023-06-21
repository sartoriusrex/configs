# Aliases

## Utilities

alias shortcuts='alias -p'

# Check disk useage

alias check-space='df -ht ext4'

# Python3 default

alias python=python3

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# git aliases
# a complete list of git-specific alias can be found in ~/.gitconfig

alias g='git'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# ================================================================

## Projects

### Start local proxy server with ngrok

alias ngrok-fe='ngrok http 4200 --host-header="localhost:4200"'

### SRK'

#### Starts the dev environment for the SRK migesplus repo
function srk-fetch () {
  address="https://ff90ceb7daadf801c953bb1eb999916e3d4cebe8:x-oauth-basic@github.com/swissredcross/aurora.git#master"

  if [ "$1" ]; then 
    address="https://ff90ceb7daadf801c953bb1eb999916e3d4cebe8:x-oauth-basic@github.com/swissredcross/aurora.git#${1}"
  fi

  yarn aurora:clean && yarn add $address && yarn aurora && yarn dev
}

# ================================================================

### Peerdom

# Navigate to Peerdom directories

alias cd-fe='cd ~/projects/peerdom-frontend'
alias cd-be='cd ~/projects/peerdom-backend'
alias cd-bs='cd ~/projects/peerdom-billing-service'

# Start peerdom BE

alias reset-be='make clean-all && make migrate && make load-data && make serve'

alias start-be-clean='cd-be && source ./config/env.sh && nvm use;
if (systemctl is-active --quiet postgresql && echo "stop postgresql service with sudo first, then clean and load data"); then 
sudo service postgresql stop && make clean-all && make migrate && make load-data
fi; echo "data loaded...serving app" && make serve'

alias start-be='cd-be && source ./config/env.sh && nvm use;
if (systemctl is-active --quiet postgresql && echo "stop postgresql service with sudo first, then simply serve with current pg data"); then 
sudo service postgresql stop
fi; echo "data loaded...serving app" && make serve'

# Start peerdom FE

alias start-fe='cd-fe && nvm use && npm start'

# Start PBS

alias start-pbs='cd-bs && source env.sh && flask run --debug'

# Install new dependencies and start PBS

alias start-install-pbs='python -m venv venv && source venv/bin/activate && pip install -e .[develop] && start-pbs'

# ================================================================

## Database Management in Peerdom

# Connect to Google Cloude Postgres instances: production and staging

alias start-gcloud-psql-production='cloud_sql_proxy -instances=peerdom-production:europe-west6:peerdom-1ad5551d=tcp:5432'

alias start-gcloud-psql-staging='cloud_sql_proxy -instances=peerdom-staging:europe-west6:peerdom-a03f49ce=tcp:5432'


# Connect to Peerdom DB: production and staging

alias start-prod-psql='psql -d "postgres://peerdom:QCRRgWgGEC8bgvq6p7T0yDI0hNqeYmqP@127.0.0.1:5432/peerdom"'

alias start-staging-psql='psql -d "postgres://peerdom:D6QroN5rZ8LOOCv1iDXHmeJzl6C4r2i0@10.7.0.2:5432/peerdom"'


# Dump DB: production and staging

alias dump-prod='pg_dump --clean --if-exists --no-owner --no-acl -Fc "postgres://peerdom:QCRRgWgGEC8bgvq6p7T0yDI0hNqeYmqP@127.0.0.1:5432/peerdom" > prod-db.pgsql'

alias dump-staging='pg_dump --clean --if-exists --no-owner --no-acl -Fc "postgres://peerdom:D6QroN5rZ8LOOCv1iDXHmeJzl6C4r2i0@127.0.0.1:5432/peerdom" > staging-db.pgsql'

alias dump-local='pg_dump --clean --if-exists --no-owner --no-acl -Fc "postgres://peerdom:peerdom@127.0.0.1:5432/peerdom" > local-db.pgsql'


# Import DB Dump: production and staging

alias load-prod-to-staging='pg_restore -Fc --no-owner --no-acl --clean -d "postgres://peerdom:D6QroN5rZ8LOOCv1iDXHmeJzl6C4r2i0@127.0.0.1:5432/peerdom" < prod-db.pgsql'

alias load-staging-to-local='pg_restore -Fc --no-owner --no-acl --clean -d "postgres://peerdom:peerdom@127.0.0.1:5432/peerdom" < ~/staging-db.pgsql'

alias load-local-to-local='pg_restore -Fc --no-owner --no-acl --clean -d "postgres://peerdom:peerdom@127.0.0.1:5432/peerdom" < ~/local-db.pgsql'
