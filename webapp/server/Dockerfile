FROM public.ecr.aws/bitnami/node:16

RUN adduser --system --group --no-create-home zenith

RUN mkdir -p /home/node/app/node_modules

WORKDIR /home/node/app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3001

USER zenith

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD wget -q --spider http://localhost:80 || exit 1

CMD [ "npm", "start" ]
