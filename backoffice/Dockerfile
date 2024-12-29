FROM node:22-alpine AS builder

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm install

COPY . .

RUN npm run build --prod --base-href /backoffice/

FROM node:22-alpine AS runner

WORKDIR /app

COPY --from=build /app/dist/backoffice-app ./dist/backoffice-app
COPY --from=build /app/server.js ./
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/package.json ./

EXPOSE 80
CMD ["node", "server.js"]


