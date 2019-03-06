FROM microsoft/dotnet:2.2-aspnetcore-runtime-stretch-slim AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM microsoft/dotnet:2.2-sdk-stretch AS build
WORKDIR /src
COPY ["Authentication.Service/Authentication.Service.csproj", "Authentication.Service/"]
RUN dotnet restore "Authentication.Service/Authentication.Service.csproj"
COPY . .
WORKDIR "/src/Authentication.Service"
RUN dotnet build "Authentication.Service.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "Authentication.Service.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "Authentication.Service.dll"]
