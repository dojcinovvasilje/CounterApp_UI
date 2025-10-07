#Builder faza
FROM node:22-alpine as builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

#Runtime faza
#NGNX je web server za prikaz statickog sadrzaja i manji je i brzi od serve,
#dist je interpretiran kao staticki sadrzaj
#ne treba WORKDIR /app jer NGNX ima fiksnu strukturu
FROM nginx:alpine as runtime

COPY --from=builder /app/dist /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]