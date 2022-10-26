
sudo apt-get update && sudo apt-get upgrade -y

sudo apt-get install php8.1-mysql php8.1-cli php8.1-mbstring php8.1-fpm php8.1-xml php8.1-curl \
    php8.1-dom nginx mysql-server composer -y

curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - && sudo apt-get install -y nodejs

sudo rm -f /etc/nginx/sites-enabled/*

sudo mv nginx-vhost.conf /etc/nginx/sites-available

sudo ln -s /etc/nginx/sites-available/nginx-vhost.conf /etc/nginx/sites-enabled/nginx-vhost.conf

sudo systemctl reload nginx

sudo mysql <<EOF
create database if not exists devops_exam;
create user if not exists devops_exam identified by '12345678';
grant all on devops_exam.* to devops_exam;
flush privileges;
EOF

git clone git@github.com:RedberryInternship/devops-exam-tmarg.git || (cd devops-exam-tmarg && git pull)

cd devops-exam-tmarg

cp .env.example .env

composer install

sed -Ei 's/^DB_DATABASE=(.)*/DB_DATABASE=devops_exam/' ".env"
sed -Ei 's/^DB_USERNAME=(.)*/DB_USERNAME=devops_exams/' ".env"
sed -Ei 's/^DB_PASSWORD=(.)*/DB_PASSWORD="12345678"/' ".env"

php artisan migrate
php artisan db:seed
php artisan storage:link || true

npm install
npm run build
