FROM python:3.11-slim AS python-base
WORKDIR /app
COPY src/worker/requirements.txt .
RUN pip install -r requirements.txt
COPY src/worker /app/worker

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
COPY --from=python-base /app /app
COPY src/backend/Novalab.Server /app/Novalab.Server
COPY scripts/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 80
ENV ASPNETCORE_URLS=http://+:80
ENTRYPOINT ["/entrypoint.sh"]
