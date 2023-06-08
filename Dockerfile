FROM node:20 as base

EXPOSE 3000
WORKDIR /app
COPY . .

#builder
FROM base as build
RUN npm install
RUN npm run build

#prod
FROM nginx as prod
COPY ./.nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html

#dev
FROM base as dev
RUN npm install
CMD [ "npm", "run", "dev" ]