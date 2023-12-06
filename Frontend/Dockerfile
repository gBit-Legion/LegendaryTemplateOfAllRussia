# build environment
FROM node:latest as build
WORKDIR /Frontend
ENV PATH /Frontend/node_modules/.bin:$PATH
COPY package.json ./
COPY package-lock.json ./
RUN npm install -g npm@10.2.4
RUN npm ci --silent
RUN npm install react-scripts -g --silent
COPY . ./
RUN npm run build

