[![Shiny_Dashboard_CICD_Check](https://github.com/DavidSolan0/biodiversity_shiny_app/actions/workflows/main.yaml/badge.svg)](https://github.com/DavidSolan0/biodiversity_shiny_app/actions/workflows/main.yaml)

## Repository Structure

This repository is organized into the following key directories and files:

- **`src/`**: Contains the core components of the Shiny application.
  - **`UI.R`**: Defines the user interface of the Shiny app.
  - **`server.R`**: Contains the server logic for the Shiny app.
  - **`app_deployment.R`**: Script for deploying the app to ShinyApps.io. Instructions for creating a token and linking it to your local workspace are provided below.
  - **`modules/`**: Contains Shiny modules required for the app. These are organized as separate R files to modularize the app's functionality.

- **`data/`**: Stores the data files used by the app.
  - **`normalized/`**: Contains the input data in its normalized form, used for processing and analysis within the app.

---

## Accessing the Published App

You can access the published Shiny app at [http://david-solano.shinyapps.io/biodiversity_shiny_app](http://david-solano.shinyapps.io/biodiversity_shiny_app).

---

## Recreating the R Environment

This project uses `renv` for managing R package dependencies. To recreate the environment specified in the `renv.lock` file, follow these steps:

1. **Install `renv` (if not already installed):**

   Open your R console, RStudio, or VSCode and run:
   ```r
   install.packages("renv")
   ```

2. **Clone the repository:**

   If you haven't already cloned the repository, do so by running:
   ```sh
   git clone https://github.com/DavidSolan0/biodiversity_shiny_app.git
   ```

3. **Set up the project:**

   Navigate to the project directory:
   ```sh
   cd biodiversity_shiny_app
   ```

4. **Open the project:**

   - **In RStudio:** Open RStudio and navigate to the project directory using `File > Open Project` or open the `.Rproj` file directly.

   - **In VSCode:** Open VSCode and use `File > Open Folder` to select the project directory. Ensure you have the R extension for VSCode installed to get the best experience.

5. **Restore the environment:**

   - **In RStudio:** Open a new R script or R console within RStudio and run:
     ```r
     renv::restore()
     ```

   - **In VSCode:** Open an R terminal or script and run:
     ```r
     renv::restore()
     ```

   This command will read the `renv.lock` file and install the packages listed to recreate the project's environment.

6. **Verify the setup:**

   Once the restoration is complete, you can check if the environment is correctly set up by running:
   ```r
   renv::status()
   ```
   This will display the status of the project’s packages and indicate if everything is up-to-date.

By following these steps, you’ll ensure that all necessary packages are installed and the environment matches the one used during the development of this project.

---

## Deploying the App to ShinyApps.io

To deploy the Shiny app to ShinyApps.io, follow these steps:

1. **Install the `rsconnect` package (if not already installed):**

   Open your R console or RStudio and run:
   ```r
   install.packages("rsconnect")
   ```

2. **Create a ShinyApps.io token:**

   - Go to [ShinyApps.io](https://www.shinyapps.io/).
   - Log in or sign up for an account.
   - Navigate to your account settings and find the **Tokens** section.
   - Click on **Show Token** to reveal your token, which you'll need for deployment.

3. **Link the token with your local workspace:**

   In your R console or RStudio, run the following command to set up your ShinyApps.io token:
   ```r
   rsconnect::setAccountInfo(name='your-account-name', token='your-token', secret='your-secret')
   ```
   Replace `'your-account-name'`, `'your-token'`, and `'your-secret'` with your actual ShinyApps.io account name and token details. The `secret` is also available on the ShinyApps.io token settings page.

4. **Deploy the app:**

   Navigate to the `src` directory where your app files are located and run:
   ```r
   source("app_deployment.R")
   ```
   This script will use the `rsconnect` package to deploy the app to ShinyApps.io.

By following these steps, you can deploy your Shiny app to ShinyApps.io and share it with others.