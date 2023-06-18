# build stage
FROM public.ecr.aws/bitnami/node:16 as build-stage

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# production stage
#FROM public.ecr.aws/nginx/nginx:latest as production-stage
FROM public.ecr.aws/nginx/nginx:1-alpine-perl as production-stage

RUN adduser --system --group --no-create-home zenith

COPY --from=build-stage /app/dist /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

USER zenith

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD wget -q --spider http://localhost:80 || exit 1

CMD ["nginx", "-g", "daemon off;"]
