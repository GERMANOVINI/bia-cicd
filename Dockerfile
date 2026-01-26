FROM node:21-slim

WORKDIR /usr/src/app

# Copia apenas manifests para aproveitar cache
COPY package*.json ./
COPY client/package*.json ./client/

RUN npm install --loglevel=error
RUN cd client && npm install --loglevel=error

# Copia o restante
COPY . .

# Variáveis de build
ENV REACT_APP_API_URL=http://localhost:3001
ENV SKIP_PREFLIGHT_CHECK=true

# Build do React
RUN npm run build --prefix client

EXPOSE 8080

CMD ["npm", "start"]
