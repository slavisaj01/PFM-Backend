# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy solution and project files
COPY *.sln ./
COPY Api/*.csproj ./Api/
COPY Application/*.csproj ./Application/
COPY Domain/*.csproj ./Domain/
COPY Infrastructure/*.csproj ./Infrastructure/

# Restore dependencies
RUN dotnet restore

# Copy source code and build
COPY . .
RUN dotnet publish Api/PFM.Api.csproj -c Release -o out

# Generate HTTPS certificate in build stage
RUN dotnet dev-certs https --clean
RUN mkdir -p /https
RUN dotnet dev-certs https -ep /https/aspnetapp.pfx -p SecurePassword123

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Copy published app and certificate from build stage

COPY --from=build /app/out .
COPY --from=build /https /https

# Expose ports
EXPOSE 80
EXPOSE 443
EXPOSE 7138
EXPOSE 5038

# Set environment variables
ENV ASPNETCORE_Kestrel__Certificates__Default__Path=/https/aspnetapp.pfx
ENV ASPNETCORE_Kestrel__Certificates__Default__Password=SecurePassword123

# Set the entry point
ENTRYPOINT ["dotnet", "PFM.Api.dll"]