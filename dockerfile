FROM nikolaik/python-nodejs:python3.5-nodejs14 as stage-build

ARG NPM_REGISTRY="https://registry.npm.taobao.org"
ENV NPM_REGISTY=$NPM_REGISTRY
ARG SASS_BINARY_SITE="https://npm.taobao.org/mirrors/node-sass"
ENV SASS_BINARY_SITE=$SASS_BINARY_SITE

WORKDIR /app
RUN npm config set sass_binary_site=${SASS_BINARY_SITE}
RUN npm config set registry ${NPM_REGISTRY}
RUN npm install node-sass

WORKDIR /opt/app
COPY package.json ./
RUN npm install
RUN cp -a /opt/app/node_modules /app/

WORKDIR /app
COPY . /app
RUN npm run build


FROM nginx:1.22

WORKDIR /app
COPY --from=stage-build /app/dist ./
COPY ./index.html /usr/share/nginx/html/index.html
COPY ./static /usr/share/nginx/html/static

EXPOSE 80

# FROM node:18.4.0-slim
# WORKDIR /app
# COPY --from=stage-build /app /app
# EXPOSE 80
# CMD npm start