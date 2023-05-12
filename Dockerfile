FROM node:18-alpine3.17

WORKDIR /workspace

COPY package*.json ./
RUN npm install
COPY . .

CMD [ "npm", "start" ]