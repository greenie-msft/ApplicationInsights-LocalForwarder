# build : docker build -t [dockerhub_id]/dapr-localforwarder:v0.7.0 .
# push image: docker push [dockerhub_id]/dapr-localforwarder:v0.7.0

FROM mcr.microsoft.com/dotnet/core/sdk:2.1 AS build-env

COPY . /app
WORKDIR /app/src/ConsoleHost
RUN dotnet publish -c Release -o /app/out
RUN ls 

FROM mcr.microsoft.com/dotnet/core/runtime:2.1
RUN mkdir /lf
WORKDIR /lf
COPY --from=build-env /app/out /lf
RUN ls -l /lf

EXPOSE 55678
ENTRYPOINT ["dotnet", "/lf/Microsoft.LocalForwarder.ConsoleHost.dll", "noninteractive"]