FROM node:7-alpine

ENV http_proxy http://10.110.8.42:8080
ENV https_proxy http://10.110.8.42:8080


RUN npm install connect serve-static express

ADD monitor-server /app/monitor-server
WORKDIR /app/monitor-server

ENV http_proxy ""
ENV https_proxy ""

EXPOSE 8000
CMD [ "node", "monitor_server.js" ]
