FROM node:lts-alpine as vue

# устанавливаем простой HTTP-сервер для статики
#RUN npm install -g http-server

# делаем каталог 'app' текущим рабочим каталогом
WORKDIR /Frontend

# копируем оба 'package.json' и 'package-lock.json' (если есть)
COPY package*.json ./

# устанавливаем зависимости проекта
RUN npm install

# копируем файлы и каталоги проекта в текущий рабочий каталог (т.е. в каталог 'app')
COPY . .

# собираем приложение для production с минификацией
RUN npm run build

EXPOSE 8080
#CMD [ "http-server", "dist" ]

# production environment
FROM nginx:latest

COPY --from=vue ./Frontend/dist /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
