# DevOps Exam


# Setting Up Development environment
 
```sh
git clone git@github.com:RedberryInternship/devops-exam.git

cp .env.example .env 

> Edit .env with necessary values

php artisan key:generate

> Configure Database

php artisan migrate

php artisan db:seed

npm install

npm run dev

php artisan serve 
```