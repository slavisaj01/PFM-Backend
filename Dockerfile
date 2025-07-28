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

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Install dotnet dev-certs tool (hack for runtime)
RUN apt-get update && apt-get install -y wget
RUN wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-get update && apt-get install -y dotnet-sdk-8.0

# Generate HTTPS certificate
RUN dotnet dev-certs https --clean
RUN mkdir -p /https
RUN dotnet dev-certs https -ep /https/aspnetapp.pfx -p SecurePassword123

# Copy published app
COPY --from=build /app/out .

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