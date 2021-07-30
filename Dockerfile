FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env
WORKDIR /app

#EXPOSE 5000
##EXPOSE 5001

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
COPY --from=build-env /app/out .
#ENV ASPNETCORE_URLS http://+:5000;https://+:5001
ENTRYPOINT ["dotnet", "teste.dll"]