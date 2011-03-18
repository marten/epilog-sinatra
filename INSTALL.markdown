# Een Ruby installeren

Je kunt 1.8.7 uit apt gebruiken, maar 1.9.2 staat daar nog niet in en die is
gaver. Sowieso is RVM de shizzle. Dus ga naar http://rvm.beginrescueend.com/ en
installeer RVM

    bash < <( curl http://rvm.beginrescueend.com/releases/rvm-install-head )

Lees de installatieinstructies (je moet iets onderaan je bashrc plakken) en
controleren dat je bashrc nergens een return doet, en evt dat veranderen in een
if-statement.

## Open een nieuwe shell en doe dit:

### Installeer de dependencies voor Ruby, en Ruby 1.9.2 zelf:

    sudo apt-get install build-essential bison openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev
    rvm install 1.9.2
    rvm use --default 1.9.2

### Installeer bundler, de gem manager voor Rails:

    gem install bundler

### Configureer git:

    git config --global user.name "Firstname Lastname"
    git config --global user.email "your_email@youremail.com"

### Epilog:

    git clone git@github.com:marten/epilog.git
    cd epilog

    bundle install

Als je klachten krijgt over mysql, dan moet je even 

    apt-get install libmysqlclient-dev

Zet de Epilog database op. Gaat standaard uit van een locale mysql met user
"root" en blanco password. Anders moet je config/database.yml aanpassen.

	rake db:setup

Maak wat dummy-hostnames aan in je /etc/hosts:

	sudo echo "127.0.0.1 epilogapp.dev admin.epilogapp.dev marten.epilogapp.dev mark.epilogapp.dev" >> /etc/hosts

En start le app:

	rails server
	gnome-open "http://admin.epilogapp.dev:3000/"