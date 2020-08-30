### Stage 1 - client build ###
FROM node:12-alpine as build-deps
ARG GENERATE_SOURCEMAP=false
WORKDIR /usr/src/client
COPY ./client/package*.json ./
RUN npm install --silent
COPY ./client .
RUN npm run build

### Stage 2 - server environment ###
FROM node:12-alpine as build-srv
WORKDIR /usr/src/server
COPY ./server/package*.json ./
RUN npm install --production
COPY ./server .

### Stage 3 - copy all files ###
FROM node:12-alpine
WORKDIR /usr/src
COPY --from=build-deps /usr/src/client/build ./client/build
COPY --from=build-srv /usr/src/server ./server
WORKDIR /usr/src/server
EXPOSE 8080
CMD npm start