# production environment
FROM nginx:latest

COPY --from=vue ./Frontend/build /usr/share/nginx/html
# new
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
