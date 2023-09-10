# Use the SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /app

# Copy the .csproj and restore any dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the source files and build the app
COPY . ./
RUN dotnet publish -c Release -o out

# Use the runtime image for the final application
FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS runtime
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "ItemManager.dll"]
