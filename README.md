# IP Lookup using Apex + Visualforce  
This project retrieves IP Address location information from the public API `http://ip-api.com/xml/` and displays the response on a Visualforce page using a wrapper class.

---

## 🚀 Features
- Calls external REST endpoint using Apex
- Parses XML response with `Dom.Document`
- Uses wrapper class instead of Map
- Displays result in Visualforce UI
- Fully dynamic values based on user IP input

---

## 📁 Project Structure
├── classes/https_ip.cls
├── classes/https_ip.cls-meta.xml
├── pages/ipLookup.page
└── pages/ipLookup.page-meta.xml
