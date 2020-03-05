# 1. set build process
FROM node:12.2.0-alpine as build
WORKDIR /usr/src/app
COPY package.json yarn.lock ./
COPY . ./
RUN yarn build

# 2. deploy app
FROM nginx:1.16.0-alpine
COPY --from=build /usr/src/app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]