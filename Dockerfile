FROM node:21-slim

WORKDIR /usr/src/app

# Copia package.json do servidor primeiro
COPY package*.json ./

# Instala dependências do servidor
RUN npm install --loglevel=error

# Cria diretório client e copia seus manifests
RUN mkdir -p client
COPY client/package*.json ./client/

# Instala dependências do client
RUN cd client && npm install --loglevel=error

# Copia o restante do código
COPY . .

# Variáveis de build
ENV REACT_APP_API_URL=http://localhost:3001
ENV SKIP_PREFLIGHT_CHECK=true

# Build do React
RUN npm run build --prefix client

EXPOSE 8080

CMD ["npm", "start"]

