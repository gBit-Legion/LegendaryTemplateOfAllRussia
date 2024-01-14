# production environment
FROM nginx:latest

#COPY --from=vue ./Frontend/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/

CMD ["nginx", "-g", "daemon off;"]