FROM node:22-bookworm AS builder

WORKDIR /app

COPY package*.json package-lock.json ./

RUN npm install && npm install -g @angular/cli

COPY . .

RUN ng build --configuration=production

FROM nginx:latest AS runner

WORKDIR /usr/share/nginx/html

COPY --from=builder /app/dist/backoffice/browser /usr/share/nginx/html

COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80


