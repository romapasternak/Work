FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /source
COPY MyProgram.sln .
COPY aspnetapp/MyProgram.csproj ./aspnetapp/
RUN dotnet restore
COPY aspnetapp/. ./aspnetapp/
WORKDIR /source/aspnetapp
RUN dotnet publish -c release -o /app --no-restore
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "MyProgram.dll"]
                    