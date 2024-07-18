FROM nginx:alpine 
COPY /dist/aline-member-dashboard /usr/share/nginx/html
# Copy custom Nginx configuration file to the container
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]