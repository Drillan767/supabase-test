FROM node:22-alpine

WORKDIR /app

COPY . .

RUN npm i -g serve && \
    yarn install --frozen-lockfile

RUN yarn build

EXPOSE 3000

CMD ["serve", "-s", "dist", "-p", "3000"]