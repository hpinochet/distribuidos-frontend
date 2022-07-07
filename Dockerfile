FROM node:16.15 as build
# Work directory 
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
# Generate build 
RUN npm run build

# NGNIX STAGE
FROM nginx:alpine as production-build
# Copy from the stage 1
COPY --from=build /usr/src/app/dist /var/www
# Remove default nginx configuration
RUN rm /etc/nginx/conf.d/default.conf
# Copy nginx configuration from local folder to server
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 3000

ENTRYPOINT ["nginx", "-g", "daemon off;"]