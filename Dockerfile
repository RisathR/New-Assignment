FROM node:16.0.0

WORKDIR /home/ubuntu

COPY ["package.json", "package-lock.json*", "./"]

RUN npm install

COPY . .

CMD [ "node", "server.js" ]
