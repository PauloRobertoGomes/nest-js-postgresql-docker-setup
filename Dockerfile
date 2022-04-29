FROM node:alpine as development
RUN apk --update add postgresql-client

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install glob rimraf

RUN npm install

COPY . .

RUN npm run build

FROM node:alpine as production
RUN apk --update add postgresql-client

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install glob rimraf

RUN npm install --production

COPY . .

COPY --from=development /usr/src/dist ./dist

CMD ["node", "dist/main"]