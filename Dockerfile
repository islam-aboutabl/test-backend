FROM node:16.18.0-bullseye-slim
RUN apt update && apt install dumb-init -y && apt clean
USER node
WORKDIR /home/node
COPY package.json package-lock.json ./
RUN npm ci --only production && npm cache clean --force
COPY . .
ENTRYPOINT [ "dumb-init" ]
CMD [ "node", "index.js", "--max-old-space-size=450" ]