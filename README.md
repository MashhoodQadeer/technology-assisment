# technology-assisment

## Overview

**Project Name**: `technology-assisment`  
**Repository**: [GitHub - MashhoodQadeer/technology-assisment](https://github.com/MashhoodQadeer/technology-assisment)

---

## Project Description

A lightweight iOS application that integrates with the **New York Times Most Popular Articles API** to display a list of trending articles. The project emphasizes clean architecture, modern Combine-based API handling, and reusable components.

---

## Key Features

- **Asynchronous Image Loading** with built-in caching and activity indicator.
- **Secure Environment Configuration** using dynamic pre/post-build bash scripts.
- **Generic and Clean API Layer** utilizing Combine for reactive programming.
- **MVVM Architecture** implemented with Combine for responsive UI binding.
- **Unit Tests** for model parsing and API communication to ensure code reliability.

---

## Project Structure

> **TechnologyAssisment/**  
>
> **Application/**  
> – Contains `AppDelegate` and `SceneDelegate` for app lifecycle management.  
>
> **Assets/**  
> – Holds all image and color assets used across the app.  
>
> **Components/**  
> – Includes reusable components, such as a custom navigation class, for consistent styling and enhanced code reuse using `UINavigationController`.  
>
> **Configurations/**  
> – Dynamic environment variables injected at build and test time via bash scripts.  
> – **Note**: It's requested to create a `.env` file in the project root directory with the required API keys and configurations.

## .env File

The `.env` file should be located in the **root directory** of your Xcode project and contain the following variables:

	```env
	API_BASE_URL=api.nytimes.com/svc/
	API_KEY=YOUR_API_KEY_HERE
	API_VERSION=v2


> **Modules>Landing**  
> – Main screen code and all the list cells are placed in the partial layouts.  

>

> **Networking**  
> – Folder contains the simple service code using URL session with the Future API stream subject and generic response container. It also have the API Router to manage each API route to handle everything related to this route over here like request type and complete skeleton for the API routes.
> Folder also contains the API logger to just print the request in the console. 
> And Error Generator.

> **Utility Class**  
> – Folder contains utility classes to handle the colors through the enum states instead of making static references for the images and colors.

> **TechnologyAssismentTests**  
> – Folder contains unit test cases for the response parsing and for the API testing.
> 

## .Demo View
<video width="50%" controls>
  <source src="https://github.com/MashhoodQadeer/technology-assisment/blob/main/DemoView.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>
