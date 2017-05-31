# Django Local Development Environment
This image will setup a vagrant instance with the minimum tools needed for django local development.
### Installation
````bash
git clone git@github.com:semanticmx/django-dev-env.git django-app
cd django-app
vagrant up
```
### Usage
````bash
vagrant ssh
```
To create a demo project just follow the instructions in the MOTD

### Admin UI
You can access the admin UI by running the next commands:
```
workon demo
cd /opt/projects/demo
./manage.py createsuperuser
./manage.py collectstatic
```

Point your browser to `http://localhost:18000/admin` and log in using your credentials above.
