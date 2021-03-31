FROM node:14.16


###################################################
#### Fix Debian Layer
###################################################

RUN printf "deb http://archive.debian.org/debian/ jessie main\ndeb-src http://archive.debian.org/debian/ jessie main\ndeb http://security.debian.org jessie/updates main\ndeb-src http://security.debian.org jessie/updates main" > /etc/apt/sources.list



###################################################
#### Dependency packages layer
###################################################


RUN su -c 'apt-get update' && su -c 'apt-get install --force-yes -y sudo'




###################################################
#### Node.JS Application Layer 
###################################################

# Create the app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json ./

RUN sudo npm install

# Bundle app source
COPY . .

RUN sudo npm run build-prod

# Any ports to expose
# EXPOSE 43218:43218


CMD [ "npm", "run-script", "start" ]