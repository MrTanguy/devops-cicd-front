# Étape 1 : Build React App
FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

RUN npm run build


# Étape 2 : Serve via NGINX
FROM nginx:alpine

# Nettoyer les fichiers par défaut de nginx
RUN rm -rf /usr/share/nginx/html/*

# Copier le build dans le dossier nginx
COPY --from=builder /app/dist /usr/share/nginx/html

# (optionnel) pour une SPA (React Router)
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
