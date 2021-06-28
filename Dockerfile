FROM node:alpine as buildstage
WORKDIR '/app'
COPY package*.json ./
RUN npm install
COPY ./ .
RUN npm run build

FROM nginx as prod-stage
RUN mkdir /app
EXPOSE 80
COPY --from=buildstage /app/dist /app
COPY nginx.conf /etc/nginx/nginx.conf
