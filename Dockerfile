FROM node:22-alpine

WORKDIR /app

RUN npm i -g serve

RUN yarn install --frozen-lockfile

COPY . .

RUN yarn build

EXPOSE 3000

CMD ["serve", "-s", "dist", "-p", "3000"]