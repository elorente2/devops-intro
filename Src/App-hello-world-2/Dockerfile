FROM node:7-alpine

ENV PROJECT_DIR=/app
WORKDIR $PROJECT_DIR

COPY package.json $PROJECT_DIR
RUN npm install
COPY server.js $PROJECT_DIR

CMD ["node", "server.js"]
