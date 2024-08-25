# Load the rsconnect package
library(rsconnect)

# Set account info if not already set
# Uncomment and fill in your details if needed
# rsconnect::setAccountInfo(name='your_account_name', token='your_token', secret='your_secret')

# Define the path to the project directory
app_dir <- 'C:/Users/Dsola/OneDrive/Documentos/appsilon/biodiversity_shiny_app'

# Deploy the app
deployApp(
  appDir = app_dir,                   # Directory containing src and data
  appFiles = c(
    'src/UI.R',                       # Main UI file
    'src/server.R',                   # Main server file
    'src/modules',                   # Include the modules folder
    'data'                           # Include the data folder
  ),
  appPrimaryDoc = 'src/UI.R',         # Set the main document (UI file)
  appName = 'biodiversity_shiny_app', # Your app name
  appTitle = 'Biodiversity Dashboard',# Title of your app
  account = 'david-solano'            # Your Shinyapps.io account name
)
