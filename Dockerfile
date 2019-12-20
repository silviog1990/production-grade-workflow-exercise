# multi-step build si fa avendo più clausole FROM
# qui mi serve perché devo compilare il prog con npm run build, quindi ho bisogno
# prima di un'immagine contenente node e poi di nginx
FROM node:alpine as builder
WORKDIR /app
COPY frontend/package.json .
RUN npm install
COPY frontend .
RUN npm run build

FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html