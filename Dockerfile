# syntax=docker/dockerfile:1
FROM node:12.18.1
WORKDIR /service

COPY . .

RUN npm install

CMD [ "npm", "run", "start"]