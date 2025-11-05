# Yellowfin-Delphi-REST
Implementation of the YellowfinBI REST API with classes and methods for use in RAD Studio and Delphi.

# Getting Started
To get started, please visit https://sandbox.yellowfinbi.com/ and follow the link to register. 
You will then receive an email with credentials to the developer sandbox so you can start playing with pulling the demo content into your RAD Studio / Delphi / C++Builder applications. 

The best place to start is using Single Sign-on to provide a quick link between your application and Yellowfin. 

# Yellowfin-Delphi-REST

The **Yellowfin Delphi REST** repo provides a Delphi and RAD Studio–ready wrapper for the **Yellowfin BI REST API (v4)** — designed for Yellowfin **9.15 and later**.  
It makes it simple to integrate Yellowfin analytics features directly into your Delphi or C++Builder applications using clean, interface-based code.

---

## 📦 Project Structure

### **Source**
Contains the near-complete wrapper for the Yellowfin REST API.  
Each logical section of the API is broken down into three files for clarity and flexibility:

| File | Purpose |
|------|----------|
| `yellowfinbi.api.<section>` | Contains the actual methods used to call the Yellowfin API endpoints. |
| `yellowfinbi.api.<section>.intf` | Defines the interface structure for the API section. |
| `yellowfinbi.api.<section>.classes` | Provides the default class implementations for those interfaces. |

This modular structure, based on Interfaces allows you to **extend or override any class** without modifying the core code structure.

---

### **Example**
Includes a simple **command-line demonstration** showing how to:
- Authenticate against Yellowfin via the REST API.  
- Run a **Single Sign-On (SSO)** request to generate and return a valid **login token** for a specific user.  

This example is a great starting point to understand how to connect your application with Yellowfin BI.

---

## 🧩 Key Concepts
- **Authentication**  
  The Yellowfin API uses 3 different tokens. Refresh, Access and Login. These are explained in the online documentation for the API - https://developers.yellowfinbi.com/dev/api-docs/current/
  To start coding, use the Token Manager interfaces and classes from yellowfinbi.api.security.tokenManager

- **Transport Classes**  
  Each of the API calls uses TYFTransport from yellowfinbi.api.transport. This wraps up all the needed security headers to make it super easy to call the REST API. The response object (IYFTransportResponse) provides the status of the call and the returned raw JSON should you ever want to access that. 

- **Fully Interface-Based Design**  
  Every API endpoint is defined and implemented using Delphi interfaces. This promotes strong separation of concerns, code reuse, and easy mocking for testing. It also makes memory management super simple. The objects returned from the API calls provide a rich response without the need to constantly manage memory. 

- **Extensible via Class Factory**  
  Any default implementation can be replaced with your own class by registering it in the **class factory**.  
  See: `yellowfinbi.api.classfactory.pas` or look at the bottom of any .classes unit.
